const { Amaz, Bach, BaseSystem } = require("./bach");
const { BCE } = require("./bce");
const cv = Amaz.JSWrapCV;

class MainSystem extends BaseSystem {
    constructor() {
        super();
    }

    doInit(alg) {
        this.doBaseInit(alg);
        alg.addOutputType(1, Amaz.AlgorithmResultType.SCRIPT);
        let engine = this.computeEngine;
        let model_key = alg.getParam("model_key");
        this.model = null;

        this.bceEngine = new BCE.Engine();

        this.modelConfigs = {};
        if (this.gpu_mode) {
            this.inferencePipeline = null;
            this.inferenceTextures = null;
        } else {
            this.inferenceEngine = null;
            this.inferenceTensors = null;
        }

        this.model_key = model_key;
        console.log(`[doInit]: loading model ${model_key}`);
        alg.loadAlgorithmModel(model_key);
        if (this.use_bce && this.bceEngine.valid()) {
            console.log(`[doInit]: run bce mode`);
            this.gpu_mode = false;
        } else {
            if (this.use_bce) {
                console.log(`[doinit]: load bce model failed, try old mode`);
                this.use_bce = false;
                alg.loadAlgorithmModel(model_key);
            }

            if (this.gpu_mode && this.inferencePipeline == null) {
                console.log(`[doInit]: load gpu model failed, try cpu mode`);
                this.gpu_mode = false;
                alg.loadAlgorithmModel(model_key);
            }
        }

        if (this.gpu_mode) {
            this.model = {
                pipeline: this.inferencePipeline,
                textures: this.inferenceTextures,
                gamma: this.gamma,
            };
            this.loader = new Bach.Compute.DataLoaderGpu(
                this.coreml_mode,
                engine,
            );
            if (this.gamma != null) {
                this.head = new Bach.Compute.FlowGanHeadGpu(
                    this,
                    this.coreml_mode,
                );
            } else {
                this.head = new Bach.Compute.GanHeadGpu(this, this.coreml_mode);
            }
        } else {
            if (!this.use_bce) {
                this.model = {
                    engine: this.inferenceEngine,
                    tensors: this.inferenceTensors,
                    gamma: this.gamma,
                };
                this.loader = new Bach.Compute.DataLoaderCpu(this.coreml_mode);
                if (this.gamma != null) {
                    this.head = new Bach.Compute.FlowGanHeadCpu(this);
                } else {
                    this.head = new Bach.Compute.GanHeadCpu(this);
                }
            }
        }
        this.fullTextureNum = 0;
    }

    loadBceModel(model, modelConfig, modelName) {
        console.log(`loading bce model ${modelName}`);
        if (this.bceEngine) {
            return this.bceEngine.init(this.MainSystemAlg, model, modelConfig);
        }
        return 0x100;
    }

    doDestroy() {
        console.log("doDestroy");
        if (this.bceEngine) {
            this.bceEngine.destroy();
        }
    }

    doApply(dirtyParams) {
        let filterKeySet = new Set([""]);
        let keySet = dirtyParams.getVectorKeys();
        for (let i = 0; i < keySet.size(); ++i) {
            let theKey = keySet.get(i);
            if (!filterKeySet.has(theKey)) continue;
            let theValue = dirtyParams.get(theKey);
            if (this.params[theKey] != theValue) {
                console.log(`[doApply]: ${theKey} changed`);
                this.params[theKey] = theValue;
            }
        }
    }

    getValidFaceCount(input, graphName) {
        let nhFaceCount = input.getNHImageTfmCount(
            graphName,
            this.faceAlignNode,
        );
        console.log(`[quzhou getValidFaceCount]: facecount: ${nhFaceCount}`);

        if (nhFaceCount == 0) return 0;
        return Math.min(nhFaceCount, this.params.face_count);
    }

    doExecute(nodeContext) {
        if (this.use_bce) {
            return this.doExecuteBce(nodeContext);
        }

        if (this.gpu_mode) {
            return this.doExecuteGpu(nodeContext);
        } else {
            return this.doExecuteCpu(nodeContext);
        }
    }

    doExecuteCpu(nodeContext) {
        if (this.inferenceEngine == null || !this.inferenceEngine.isReady()) {
            console.log(`[doExecuteCpu]: inference engine is not ready`);
            return 0x100;
        }
        const DefaultGraph = nodeContext.graphName;
        let input = nodeContext.getInputResult();
        let faceCount = this.getValidFaceCount(input, DefaultGraph);
        if (faceCount == 0) return 0x81;

        let blitImage = input.getBlitImage(DefaultGraph, this.blitNode);
        let cameraImage = cv.Mat(blitImage);

        for (let i = 0; i < faceCount; ++i) {
            let infInTensors = this.inferenceTensors.inputs;
            let tfmInfo = input.getNHImageTfmInfo(
                DefaultGraph,
                this.faceAlignNode,
                i,
            );
            this.loader.process(cameraImage, infInTensors[0], tfmInfo);
            this.inferenceEngine.setInputTensors(infInTensors);
            let errCode = this.inferenceEngine.inference();
            if (errCode != 0) {
                console.error(`[doExecuteCpu]: inference failed: ${errCode}`);
                return;
            }

            let infOutTensors = this.inferenceEngine.getOutputTensors();
            this.head.process(
                nodeContext,
                infOutTensors,
                i,
                this.fullTextureNum,
                this.gamma,
            );
        }
        this.fillScriptInfo(nodeContext, faceCount);
    }

    doExecuteGpu(nodeContext) {
        if (this.inferencePipeline == null) return 0x100;
        const DefaultGraph = nodeContext.graphName;
        let engine = this.computeEngine;

        let cameraTex = nodeContext.getInputGPUTexture(
            engine,
            this.inputTextureNode,
        );
        let input = nodeContext.getInputResult();
        let faceCount = this.getValidFaceCount(input, DefaultGraph);
        if (faceCount == 0) return 0x81;

        let blitImage = input.getBlitImage(DefaultGraph, this.blitNode);

        this.resizeInferenceTextures(faceCount);

        for (let i = 0; i < faceCount; ++i) {
            let infTexes = this.inferenceTextures[i];
            let infInTex0 = infTexes.inputs[0].texture;

            let tfmInfo = input.getNHImageTfmInfo(
                DefaultGraph,
                this.faceAlignNode,
                i,
            );
            let dstSize = [blitImage.width - 0.5, blitImage.height - 0.5];
            this.loader.process(cameraTex, infInTex0, tfmInfo, dstSize);
            Bach.Compute.applyInferenceTextures(
                this.inferencePipeline,
                infTexes,
            );
            if (this.checkSyncBeforeInference()) {
                infInTex0.syncToCPU();
            }
            let errCode = this.inferencePipeline.dispatch();
            if (errCode != 0) {
                console.error(`[doExecuteGpu]: inference failed: ${errCode}`);
                return;
            }

            let infOutTexes = infTexes.outputs;
            this.head.process(
                nodeContext,
                infOutTexes,
                i,
                this.fullTextureNum,
                this.gamma,
            );
        }
        this.fillScriptInfo(nodeContext, faceCount);
    }

    doExecuteBce(nodeContext) {
        if (! this.bceEngine.valid()) return 0x100;
        const DefaultGraph = nodeContext.graphName;
        let engine = this.computeEngine;

        let cameraTex = nodeContext.getInputGPUTexture(engine, this.inputTextureNode);
        let input = nodeContext.getInputResult();
        let faceCount = this.getValidFaceCount(input, DefaultGraph);
        if (faceCount == 0) { return 0x81; }
		
        let blitImage = input.getBlitImage(DefaultGraph, this.blitNode);
		let outputMap = nodeContext.getOutputMap();
        outputMap.clear();
        for (let i = 0; i < faceCount; ++i) {
			outputMap.set(`gan${i}`, 1);
            let tfmInfo = input.getNHImageTfmInfo(DefaultGraph, this.faceAlignNode, i);
            let affineMatrix = Bach.Compute.normalizeAffine(
                tfmInfo.affine,
                [blitImage.width - 0.5, blitImage.height - 0.5],
                [BCE.GetInputSize()[0], BCE.GetInputSize()[1]]
            );
            this.bceEngine.execute(nodeContext, this.computeEngine, cameraTex, affineMatrix, 1, i);
        }
        this.fillScriptInfo(nodeContext, faceCount);

    }

    fillScriptInfo(nodeContext, faceNum) {
        let scriptInfo = nodeContext.getOutputMap();
        scriptInfo.set(
            Bach.AlgorithmResultKey.algoType,
            Bach.ScriptAlgoType.GAN,
        );
        scriptInfo.set(
            Bach.AlgorithmResultKey.subAlgoType,
            Bach.ScriptSubAlgoType.GAN.NORMAL_OR_FLOW_GAN,
        );
        scriptInfo.set(Bach.AlgorithmResultKey.isOutputTextures, true);
        if (this.gamma == null) {
            scriptInfo.set(
                Bach.AlgorithmResultKey.groupTexNumList,
                Amaz.AmazingUtil.arrayToUInt32Vector(
                    new Array(faceNum).fill(1),
                ),
            );
        } else {
            scriptInfo.set(
                Bach.AlgorithmResultKey.groupTexNumList,
                Amaz.AmazingUtil.arrayToUInt32Vector(
                    new Array(faceNum).fill(2),
                ),
            );
        }
        scriptInfo.set(
            Bach.AlgorithmResultKey.globalTexNum,
            this.fullTextureNum,
        );
        scriptInfo.set(Bach.AlgorithmResultKey.groupNum, faceNum);
    }
}

exports.MainSystem = MainSystem;
