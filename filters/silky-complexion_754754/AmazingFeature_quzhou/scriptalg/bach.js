const Amaz = effect.Bach;
const VERSION = Amaz.VERSION
const ByteNN = {};
const SCRIPT_VERSION = "17.4.0"
ByteNN.DataFormat = {
    NCHW: 0,
    NHWC: 1,
};

ByteNN.DataType = {
    U8: 0,
    Int8: 1,
    Int16: 2,
    Uint16: 3,
    Float: 4,
    Fp16: 5,
    Double: 6,
};

ByteNN.ErrorCode = {
    SUCCESS: 0,
    ERR_MEMORY_ALLOC: 1,
    NOT_IMPLEMENTED: 2,
    ERR_UNEXPECTED: 3,
    ERR_DATANOMATCH: 4,
    INPUT_DATA_ERROR: 5,
    CALL_BACK_STOP: 6,
    BACKEND_FALLBACK: 7,
    NULL_POINTER: 8,
    INVALID_POINTER: 9,
    INVALID_MODEL: 10,
    INFER_SIZE_ERROR: 11,
    NOT_SUPPORT: 12,
    DESTROYED_ERROR: 13,
    WRONG_LICENSE: 14,
    BROKEN_MODEL: 15,
    EARLY_STOP: 16,
};

ByteNN.ForwardType = {
    CPU: 0, // Android, iOS, Mac, Windows and Linux
    GPU: 1, // Android, iOS, Mac, Windows
    DSP: 2, // Android, iOS
    NPU: 3, // Android
    Auto: 4, // Android, iOS, Mac, Windows and Linux
    METAL: 5, // iOS
    OPENCL: 6, // Android, Mac, Windows
    OPENGL: 7,
    VULKAN: 8,
    CUDA: 9, // Windows, Linux
    CoreML: 10, // iOS and Mac
};

ByteNN.DeviceIOType = {
    CPUBuffer: 0,
    GLTexture: 1,
    CLImage: 2,
    CLBuffer: 3,
    CVPixelBuffer: 4,
    MTLTexture: 5,
    MTLBuffer: 6,
    CUDABuffer: 7,
    AhardwareBuffer: 8,
    IONBuffer: 9,
    ExtendedBuffer: 10,
};

const MobileCV2 = {};

MobileCV2.ColorConversionCodes = {
    COLOR_BGR2BGRA: 0,
    COLOR_RGB2RGBA: 0,
    COLOR_BGRA2BGR: 1,
    COLOR_RGBA2RGB: 1,
    COLOR_BGR2RGBA: 2,
    COLOR_RGB2BGRA: 2,
    COLOR_RGBA2BGR: 3,
    COLOR_BGRA2RGB: 3,
    COLOR_BGR2RGB: 4,
    COLOR_RGB2BGR: 4,
    COLOR_BGRA2RGBA: 5,
    COLOR_RGBA2BGRA: 5,
    COLOR_BGR2GRAY: 6,
    COLOR_RGB2GRAY: 7,
    COLOR_GRAY2BGR: 8,
    COLOR_GRAY2RGB: 8,
    COLOR_GRAY2BGRA: 9,
    COLOR_GRAY2RGBA: 9,
    COLOR_BGRA2GRAY: 10,
    COLOR_RGBA2GRAY: 11,
    COLOR_BGR2BGR565: 12,
    COLOR_RGB2BGR565: 13,
    COLOR_BGR5652BGR: 14,
    COLOR_BGR5652RGB: 15,
    COLOR_BGRA2BGR565: 16,
    COLOR_RGBA2BGR565: 17,
    COLOR_BGR5652BGRA: 18,
    COLOR_BGR5652RGBA: 19,
    COLOR_GRAY2BGR565: 20,
    COLOR_BGR5652GRAY: 21,
    COLOR_BGR2BGR555: 22,
    COLOR_RGB2BGR555: 23,
    COLOR_BGR5552BGR: 24,
    COLOR_BGR5552RGB: 25,
    COLOR_BGRA2BGR555: 26,
    COLOR_RGBA2BGR555: 27,
    COLOR_BGR5552BGRA: 28,
    COLOR_BGR5552RGBA: 29,
    COLOR_GRAY2BGR555: 30,
    COLOR_BGR5552GRAY: 31,
    COLOR_BGR2XYZ: 32,
    COLOR_RGB2XYZ: 33,
    COLOR_XYZ2BGR: 34,
    COLOR_XYZ2RGB: 35,
    COLOR_BGR2YCrCb: 36,
    COLOR_RGB2YCrCb: 37,
    COLOR_YCrCb2BGR: 38,
    COLOR_YCrCb2RGB: 39,
    COLOR_BGR2HSV: 40,
    COLOR_RGB2HSV: 41,
    COLOR_BGR2Lab: 44,
    COLOR_RGB2Lab: 45,
    COLOR_BGR2Luv: 50,
    COLOR_RGB2Luv: 51,
    COLOR_BGR2HLS: 52,
    COLOR_RGB2HLS: 53,
    COLOR_HSV2BGR: 54,
    COLOR_HSV2RGB: 55,
    COLOR_Lab2BGR: 56,
    COLOR_Lab2RGB: 57,
    COLOR_Luv2BGR: 58,
    COLOR_Luv2RGB: 59,
    COLOR_HLS2BGR: 60,
    COLOR_HLS2RGB: 61,
    COLOR_BGR2HSV_FULL: 66,
    COLOR_RGB2HSV_FULL: 67,
    COLOR_BGR2HLS_FULL: 68,
    COLOR_RGB2HLS_FULL: 69,
    COLOR_HSV2BGR_FULL: 70,
    COLOR_HSV2RGB_FULL: 71,
    COLOR_HLS2BGR_FULL: 72,
    COLOR_HLS2RGB_FULL: 73,
    COLOR_LBGR2Lab: 74,
    COLOR_LRGB2Lab: 75,
    COLOR_LBGR2Luv: 76,
    COLOR_LRGB2Luv: 77,
    COLOR_Lab2LBGR: 78,
    COLOR_Lab2LRGB: 79,
    COLOR_Luv2LBGR: 80,
    COLOR_Luv2LRGB: 81,
    COLOR_BGR2YUV: 82,
    COLOR_RGB2YUV: 83,
    COLOR_YUV2BGR: 84,
    COLOR_YUV2RGB: 85,
    COLOR_YUV2RGB_NV12: 90,
    COLOR_YUV2BGR_NV12: 91,
    COLOR_YUV2RGB_NV21: 92,
    COLOR_YUV2BGR_NV21: 93,
    COLOR_YUV420sp2RGB: 92,
    COLOR_YUV420sp2BGR: 93,
    COLOR_YUV2RGBA_NV12: 94,
    COLOR_YUV2BGRA_NV12: 95,
    COLOR_YUV2RGBA_NV21: 96,
    COLOR_YUV2BGRA_NV21: 97,
    COLOR_YUV420sp2RGBA: 96,
    COLOR_YUV420sp2BGRA: 97,
    COLOR_YUV2RGB_YV12: 98,
    COLOR_YUV2BGR_YV12: 99,
    COLOR_YUV2RGB_IYUV: 100,
    COLOR_YUV2BGR_IYUV: 101,
    COLOR_YUV2RGB_I420: 100,
    COLOR_YUV2BGR_I420: 101,
    COLOR_YUV420p2RGB: 98,
    COLOR_YUV420p2BGR: 99,
    COLOR_YUV2RGBA_YV12: 102,
    COLOR_YUV2BGRA_YV12: 103,
    COLOR_YUV2RGBA_IYUV: 104,
    COLOR_YUV2BGRA_IYUV: 105,
    COLOR_YUV2RGBA_I420: 104,
    COLOR_YUV2BGRA_I420: 105,
    COLOR_YUV420p2RGBA: 102,
    COLOR_YUV420p2BGRA: 103,
    COLOR_YUV2GRAY_420: 106,
    COLOR_YUV2GRAY_NV21: 106,
    COLOR_YUV2GRAY_NV12: 106,
    COLOR_YUV2GRAY_YV12: 106,
    COLOR_YUV2GRAY_IYUV: 106,
    COLOR_YUV2GRAY_I420: 106,
    COLOR_YUV420sp2GRAY: 106,
    COLOR_YUV420p2GRAY: 106,
    COLOR_YUV2RGB_UYVY: 107,
    COLOR_YUV2BGR_UYVY: 108,
    COLOR_YUV2RGB_Y422: 107,
    COLOR_YUV2BGR_Y422: 108,
    COLOR_YUV2RGB_UYNV: 107,
    COLOR_YUV2BGR_UYNV: 108,
    COLOR_YUV2RGBA_UYVY: 111,
    COLOR_YUV2BGRA_UYVY: 112,
    COLOR_YUV2RGBA_Y422: 111,
    COLOR_YUV2BGRA_Y422: 112,
    COLOR_YUV2RGBA_UYNV: 111,
    COLOR_YUV2BGRA_UYNV: 112,
    COLOR_YUV2RGB_YUY2: 115,
    COLOR_YUV2BGR_YUY2: 116,
    COLOR_YUV2RGB_YVYU: 117,
    COLOR_YUV2BGR_YVYU: 118,
    COLOR_YUV2RGB_YUYV: 115,
    COLOR_YUV2BGR_YUYV: 116,
    COLOR_YUV2RGB_YUNV: 115,
    COLOR_YUV2BGR_YUNV: 116,
    COLOR_YUV2RGBA_YUY2: 119,
    COLOR_YUV2BGRA_YUY2: 120,
    COLOR_YUV2RGBA_YVYU: 121,
    COLOR_YUV2BGRA_YVYU: 122,
    COLOR_YUV2RGBA_YUYV: 119,
    COLOR_YUV2BGRA_YUYV: 120,
    COLOR_YUV2RGBA_YUNV: 119,
    COLOR_YUV2BGRA_YUNV: 120,
    COLOR_YUV2GRAY_UYVY: 123,
    COLOR_YUV2GRAY_YUY2: 124,
    COLOR_YUV2GRAY_Y422: 123,
    COLOR_YUV2GRAY_UYNV: 123,
    COLOR_YUV2GRAY_YVYU: 124,
    COLOR_YUV2GRAY_YUYV: 124,
    COLOR_YUV2GRAY_YUNV: 124,
    COLOR_RGBA2mRGBA: 125,
    COLOR_mRGBA2RGBA: 126,
    COLOR_RGB2YUV_I420: 127,
    COLOR_BGR2YUV_I420: 128,
    COLOR_RGB2YUV_IYUV: 127,
    COLOR_BGR2YUV_IYUV: 128,
    COLOR_RGBA2YUV_I420: 129,
    COLOR_BGRA2YUV_I420: 130,
    COLOR_RGBA2YUV_IYUV: 129,
    COLOR_BGRA2YUV_IYUV: 130,
    COLOR_RGB2YUV_YV12: 131,
    COLOR_BGR2YUV_YV12: 132,
    COLOR_RGBA2YUV_YV12: 133,
    COLOR_BGRA2YUV_YV12: 134,
    COLOR_BayerBG2BGR: 46,
    COLOR_BayerGB2BGR: 47,
    COLOR_BayerRG2BGR: 48,
    COLOR_BayerGR2BGR: 49,
    COLOR_BayerBG2RGB: 48,
    COLOR_BayerGB2RGB: 49,
    COLOR_BayerRG2RGB: 46,
    COLOR_BayerGR2RGB: 47,
    COLOR_BayerBG2GRAY: 86,
    COLOR_BayerGB2GRAY: 87,
    COLOR_BayerRG2GRAY: 88,
    COLOR_BayerGR2GRAY: 89,
    COLOR_BayerBG2BGR_VNG: 62,
    COLOR_BayerGB2BGR_VNG: 63,
    COLOR_BayerRG2BGR_VNG: 64,
    COLOR_BayerGR2BGR_VNG: 65,
    COLOR_BayerBG2RGB_VNG: 64,
    COLOR_BayerGB2RGB_VNG: 65,
    COLOR_BayerRG2RGB_VNG: 62,
    COLOR_BayerGR2RGB_VNG: 63,
    COLOR_BayerBG2BGR_EA: 135,
    COLOR_BayerGB2BGR_EA: 136,
    COLOR_BayerRG2BGR_EA: 137,
    COLOR_BayerGR2BGR_EA: 138,
    COLOR_BayerBG2RGB_EA: 137,
    COLOR_BayerGB2RGB_EA: 138,
    COLOR_BayerRG2RGB_EA: 135,
    COLOR_BayerGR2RGB_EA: 136,
    COLOR_BayerBG2BGRA: 139,
    COLOR_BayerGB2BGRA: 140,
    COLOR_BayerRG2BGRA: 141,
    COLOR_BayerGR2BGRA: 142,
    COLOR_BayerBG2RGBA: 141,
    COLOR_BayerGB2RGBA: 142,
    COLOR_BayerRG2RGBA: 139,
    COLOR_BayerGR2RGBA: 140,
    COLOR_BGRA2YCbCr: 143,
    COLOR_RGBA2YCbCr: 144,
    COLOR_YCbCr2BGRA: 145,
    COLOR_YCbCr2RGBA: 146,
    COLOR_BGBA2YCbCr_nv12: 147,
    COLOR_RGBA2YUV: 148,
    COLOR_YUV2RGBA: 149,
    COLOR_COLORCVT_MAX: 150,
    COLOR_RGBA2YUV_NV12: 151,
};

MobileCV2.ShapeMatchModes = {
    CONTOURS_MATCH_I1: 1,
    CONTOURS_MATCH_I2: 2,
    CONTOURS_MATCH_I3: 3,
};

MobileCV2.CovarFlags = {
    COVAR_SCRAMBLED: 0,
    COVAR_NORMAL: 1,
    COVAR_USE_AVG: 2,
    COVAR_SCALE: 4,
    COVAR_ROWS: 8,
    COVAR_COLS: 16,
};

MobileCV2.DataType = {
    CV_8U: 0,
    CV_8UC1: 0,
    CV_8UC2: 8,
    CV_8UC3: 16,
    CV_8UC4: 24,
    CV_8S: 1,
    CV_8SC1: 1,
    CV_8SC2: 9,
    CV_8SC3: 17,
    CV_8SC4: 25,
    CV_16U: 2,
    CV_16UC1: 2,
    CV_16UC2: 10,
    CV_16UC3: 18,
    CV_16UC4: 26,
    CV_16S: 3,
    CV_16SC1: 3,
    CV_16SC2: 11,
    CV_16SC3: 19,
    CV_16SC4: 27,
    CV_32S: 4,
    CV_32SC1: 4,
    CV_32SC2: 12,
    CV_32SC3: 20,
    CV_32SC4: 28,
    CV_32F: 5,
    CV_32FC1: 5,
    CV_32FC2: 13,
    CV_32FC3: 21,
    CV_32FC4: 29,
    CV_64F: 6,
    CV_64FC1: 6,
    CV_64FC2: 14,
    CV_64FC3: 22,
    CV_64FC4: 30,
};

const Bach = {};

Bach.AEPixelFormat = {
    INVALID: -1,
    RGBA8UNORM: 0,
    BGRA8UNORM: 1,
    BGR8UNORM: 2,
    RGB8UNORM: 3,
    GRAY8: 4,
    YUV420P: 5,
    NV12: 6,
    NV21: 7,
    RG8UNORM: 8,
    RGBA16SFLOAT: 9,
    RGBA32SFLOAT: 10,
};

Bach.Compute = {};

Bach.Compute.OperatorType = {
    CUSTOM: 0,
    AFFINE_WARP: 1,
    ALPHA_BLEND: 2,
    INFERENCE: 3,
    INVALID: 4,
};

Bach.Compute.BackendType = {
    CPU: 0,
    GLES30: 1,
    GLES31: 2,
    METAL: 3,
    COREML: 4,
    GPU_AUTO: 5,
    INVALID: 6,
};

const vertexShader = `precision lowp float;
attribute vec3 inPosition;
attribute vec2 inTexCoord;
varying vec2 fragTexCoord;
void main() {
    gl_Position = vec4(inPosition, 1.0);
    fragTexCoord = inTexCoord;
}
`;

const alphaBlendFragmentShader = `precision lowp float;
uniform sampler2D _MainTex;
uniform vec4 convert_alpha;
uniform vec4 convert_beta;
varying vec2 fragTexCoord;
void main()
{
    gl_FragColor = texture2D(_MainTex, fragTexCoord) * convert_alpha + convert_beta;
}
`;

const affineWarpFragmentShader = `precision lowp float;
uniform sampler2D _MainTex;
uniform mat3 invTransMatrix;
uniform vec4 convert_alpha;
uniform vec4 convert_beta;
varying vec2 fragTexCoord;

void main()
{
    vec3 uv = invTransMatrix * vec3(fragTexCoord.xy, 1.0);
    gl_FragColor = texture2D(_MainTex, uv.xy) * convert_alpha + convert_beta;
}
`;
const concatFragmentShader = `precision lowp float;
uniform sampler2D inputTex0;
uniform sampler2D inputTex1;
varying vec2 fragTexCoord;
void main()
{
    vec4 color0 = texture2D(inputTex0, fragTexCoord);
    vec4 color1 = texture2D(inputTex1, fragTexCoord);
    gl_FragColor.rgb = color0.rgb;
    gl_FragColor.a = color1.r;
}
`;

const singleInputconcatFragmentShader = `precision lowp float;
uniform sampler2D inputTex0;
varying vec2 fragTexCoord;
void main()
{
    vec4 color0 = texture2D(inputTex0, fragTexCoord);
    gl_FragColor.rgb = color0.rgb;
    gl_FragColor.a = 1.0;
}
`;

const flowPostFragmentShader = `precision lowp float;
uniform sampler2D inputTex0;
uniform sampler2D inputTex1;
uniform vec4 convert_alpha;
varying vec2 fragTexCoord;
void main()
{
    vec4 color1 = texture2D(inputTex1, fragTexCoord);
    gl_FragColor.rg = (color1.gb - 0.5) * convert_alpha.rg + 0.5;
}
`;

const BLACKLIST_IOS = [
    "iPhone4,1",
    "iPhone5,1",
    "iPhone5,2",
    "iPhone5,3",
    "iPhone5,4",
    "iPhone6,1",
    "iPhone6,2",
    "iPhone7,1",
    "iPhone7,2",
    "iPad4,1",
    "iPad4,2",
    "iPad4,3",
    "iPad4,4",
    "iPad4,5",
    "iPad4,6",
    "iPad4,7",
    "iPad4,8",
    "iPad4,9"
]
const SUPPORTED_GPU_TYPE = [
    "mali-g5",
    "mali-g6",
    "mali-g7",
    "mali-g8",
    "mali-g9",
    "male",
    "adreno(tm) 5",
    "adreno(tm) 6",
    "adreno(tm) 7",
    "adreno(tm) 8"
]

Bach.Compute.Shaders = {
    vertexShader,
    affineWarpFragmentShader,
    alphaBlendFragmentShader,
    concatFragmentShader,
    flowPostFragmentShader,
    singleInputconcatFragmentShader,
};

Bach.ScriptAlgoType = {
    GAN : 0,
    DENSE_ESTIMATION : 1,
    SERVER : 2,
};

Bach.ScriptSubAlgoType = {
  GAN: {
    NORMAL_OR_FLOW_GAN : 0 ,
    FLOW_EXTRA_GAN : 1,
    NORMAL_OR_FLOW_GAN_WITH_CONDITION_INPUT : 2,
    NORMAL_OR_FLOW_GAN_WITH_IMAGE_INPUT : 3
  },
  DENSE_ESTIMATION: {
    DEPTH : 0,
    SCENE_NORMAL : 1
  },
  SERVER: {
    SERVER_SINGLE_IMAGE : 0,
    SERVER_MULTI_IMAGE : 1,
  },
};

Bach.AlgorithmResultKey = {
    algoType: "algoType",
    subAlgoType: "subAlgoType",
    isOutputTextures: "isOutputTextures",
    image : "image",
    mvpMatrix: "mvpMatrix",
    groupTexNumList: "groupTexNumList",
    globalTexNum: "globalTexNum",
    groupNum: "groupNum",
    statusCode: "statusCode",
    message: "message",
    logId: "logId",
    success: "success",
    rpcStatusCode: "rpcStatusCode",
    rpcStatusMsg: "rpcStatusMsg",
    respJson: "respJson",
    videoPath: "videoPath",
    taskId: "taskId",
    waitListLength: "waitListLength",
    estimateWaitTime: "estimateWaitTime",
};

class Pipeline {
    constructor(pipeline) {
        this.pipeline = pipeline;
        this.textures = {};
    }
    setProperty(key, value) {
        return this.pipeline.setProperty(key, value);
    }
    dispatch() {
        const ExecStatus = {
            NOT_INITIALIZED: 0,
            SUCCESS: 1,
            FAIL: 2,
        };
        let errCode = this.pipeline.dispatch();
        switch (errCode) {
            default:
                return errCode;
            case ExecStatus.SUCCESS:
                return 0;
            case ExecStatus.FAIL:
                return -1;
            case ExecStatus.NOT_INITIALIZED:
                return -2;
        }
    }
    setInputBuffer(name, texture) {
        return this.pipeline.setInputBuffer(name, texture);
    }
    setOutputBuffer(name, texture) {
        return this.pipeline.setOutputBuffer(name, texture);
    }
    // only for inference pipeline
    loadModel(model, oclKernelBinPath, runtimeLibLoadingPath) {
        return this.pipeline.loadModel(
            model,
            oclKernelBinPath,
            runtimeLibLoadingPath
        );
    }
    // only for affine/blend pipeline
    setConvertAlpha(vec) {
        let value = new Amaz.Vector4f(vec[0], vec[1], vec[2], vec[3]);
        return this.setProperty("convert_alpha", value);
    }
    setConvertBeta(vec) {
        let value = new Amaz.Vector4f(vec[0], vec[1], vec[2], vec[3]);
        return this.setProperty("convert_beta", value);
    }
    // only for affine pipeline
    setTransformMatrix(vec) {
        let value = new Amaz.Matrix3x3f(
            vec[0],
            vec[1],
            vec[2],
            vec[3],
            vec[4],
            vec[5],
            vec[6],
            vec[7],
            vec[8]
        );
        return this.setProperty("invTransMatrix", value);
    }
}
Bach.Compute.Pipeline = Pipeline;

Bach.Compute.createTexture = (engine, width, height, format) => {
    return engine.createTex(width, height, format);
};

Bach.Compute.createPipeline = (engine, type, backendType) => {
    return new Pipeline(engine.createPipeline(type, backendType));
};

Bach.Compute.createCustomPipeline = (engine, vertexShader, fragmentShader) => {
    return new Pipeline(
        engine.createPipeline(
            Bach.Compute.OperatorType.CUSTOM,
            Bach.Compute.BackendType.GLES30,
            { vert: vertexShader, frag: fragmentShader }
        )
    );
};

/* model's format
model = {
    name: "sample",
    forwardType: 1,
    inputs: [
        { name: "data1", size: [512, 512], format: 10 },
        { name: "data2", size: [512, 512], format: 10 },
    ],
    outputs: [
        { name: "Tanh_1", size: [512, 512], format: 10 },
        { name: "Tanh_2", size: [512, 512], format: 10 },
    ],
};
*/

Bach.Compute.createInferenceTextures = (engine, model) => {
    const createTextures = (infos) => {
        let textures = [];
        for (let info of infos) {
            let name = info.name;
            let size = info.size;
            let format = info.format;
            let texture = Bach.Compute.createTexture(
                engine,
                size[0],
                size[1],
                format
            );
            textures.push({ name, size, format, texture });
        }
        return textures;
    };
    let inputs = createTextures(model.inputs);
    let outputs = createTextures(model.outputs);
    return { inputs, outputs };
};

Bach.Compute.copyInferenceTextures = (engine, textures) => {
    return Bach.Compute.createInferenceTextures(engine, textures);
};

Bach.Compute.applyInferenceTextures = (pipeline, textures) => {
    for (let texture of textures.inputs) {
        pipeline.setInputBuffer(texture.name, texture.texture);
    }
    for (let texture of textures.outputs) {
        pipeline.setOutputBuffer(texture.name, texture.texture);
    }
};

Bach.Compute.createInferencePipeline = (engine, model, modelName) => {
    let forwardType = model.forwardType;
    let backendType = null;
    if (forwardType == ByteNN.ForwardType.CoreML) {
        backendType = Bach.Compute.BackendType.COREML;
    } else {
        backendType = Bach.Compute.BackendType.GPU_AUTO;
    }
    let pipeline = Bach.Compute.createPipeline(
        engine,
        Bach.Compute.OperatorType.INFERENCE,
        backendType
    );
    pipeline.setProperty("type", forwardType);
    let textures = Bach.Compute.createInferenceTextures(engine, model);
    pipeline.textures = textures;
    const createTextureNames = (textures) => {
        let names = new Amaz.StringVector();
        for (let texture of textures) {
            names.pushBack(texture.name);
        }
        return names;
    };
    let inputNames = createTextureNames(textures.inputs);
    let outputNames = createTextureNames(textures.outputs);
    pipeline.setProperty("inputNames", inputNames);
    pipeline.setProperty("outputNames", outputNames);
    pipeline.setProperty("modelName", modelName)
    Bach.Compute.applyInferenceTextures(pipeline, textures);
    return pipeline;
};

Bach.Compute.createAffineWarpPipeline = (engine) => {
    let pipeline = Bach.Compute.createCustomPipeline(
        engine,
        Bach.Compute.Shaders.vertexShader,
        Bach.Compute.Shaders.affineWarpFragmentShader
    );
    pipeline.setConvertAlpha([1, 1, 1, 1]);
    pipeline.setConvertBeta([0, 0, 0, 0]);
    return pipeline;
};

Bach.Compute.createAlphaBlendPipeline = (engine) => {
    let pipeline = Bach.Compute.createCustomPipeline(
        engine,
        Bach.Compute.Shaders.vertexShader,
        Bach.Compute.Shaders.alphaBlendFragmentShader
    );
    pipeline.setConvertAlpha([1, 1, 1, 1]);
    pipeline.setConvertBeta([0, 0, 0, 0]);
    return pipeline;
};

Bach.Compute.normalizeAffine = (affine, srcSize, dstSize) => {
    let xs = srcSize[0];
    let ys = srcSize[1];
    let xd = dstSize[0];
    let yd = dstSize[1];
    return new Amaz.Matrix3x3f(
        affine.get(0, 0) * (xd / xs),
        affine.get(1, 0) * (xd / ys),
        affine.get(2, 0) * xd,
        affine.get(0, 1) * (yd / xs),
        affine.get(1, 1) * (yd / ys),
        affine.get(2, 1) * yd,
        affine.get(0, 2) * (1 / xs),
        affine.get(1, 2) * (1 / ys),
        affine.get(2, 2) * 1
    );
};

Bach.Compute.warpAffine = (affine, srcImage, dstImage, dstSize) => {
    let affineData = new Float32Array([
        affine.get(0, 0),
        affine.get(0, 1),
        affine.get(0, 2),
        affine.get(1, 0),
        affine.get(1, 1),
        affine.get(1, 2),
    ]);
    let affineMat = Amaz.JSWrapCV.Mat(2, 3, MobileCV2.DataType.CV_32F, affineData.buffer);
    let invertMat = Amaz.JSWrapCV.Mat();
    Amaz.JSWrapCV.invertAffineTransform(affineMat, invertMat);
    Amaz.JSWrapCV.warpAffine(srcImage, dstImage, invertMat, [dstSize[0], dstSize[1]]);
};

class Engine {
    constructor() {
        this.engine = null;
        this.config = {};
        this.tensors = {};
        this.ready = false;
    }
    setProperties(properties) {
        for (let key in properties) {
            this.config[key] = properties[key];
        }
    }
    setInputTensors(tensors) {
        return this.engine.SetInput(tensors);
    }
    getOutputTensors() {
        let tensors = [];
        this.engine.GetOutput(tensors);
        this.tensors.outputs = tensors;
        return tensors;
    }
    release() {
        return this.engine.Release();
    }
    inference() {
        return this.engine.Inference();
    }
    isReady() {
        if (!this.ready) {
            return false;
        }
        if (this.tensors.inputs == null) {
            let inputTensors = [];
            let outputTensors = [];
            this.engine.GetInputConfig(inputTensors);
            this.engine.GetOutput(outputTensors);
            this.tensors.inputs = inputTensors;
            this.tensors.outputs = outputTensors;
        }
        return true;
    }
    loadModel(model, oclKernelBinPath, runtimeLibLoadingPath) {
        let config = new Amaz.JSWrapByteNNConfig();
        config.oclKernelBinPath = oclKernelBinPath;
        config.runtimeLibLoadingPath = runtimeLibLoadingPath;
        config.modelBuffer = model.pData;
        config.modelBufferSize = model.length;
        const setConfig = (keys) => {
            for (let key of keys) {
                let value = this.config[key];
                if (value != null) {
                    config[key] = value;
                }
            }
        };
        setConfig([
            "type",
            "doModelValidation",
            "numThread",
            "inputNames",
            "outputNames",
            "modelName",
        ]);
        let engine = new Amaz.JSWrapByteNNEngine();
        let errCode = 0x100;
        let asyncLoad = Boolean(this.config.asyncLoad) && versionCompare(VERSION, "13.8.0") >= 0; //asyncLoad at least 1380
        if (asyncLoad) {
            console.log("[InferenceEngine]: async load model");
            this.engineConfig = config;
            const callback = (result) => {
                if (result.code == 0) {
                    this.ready = true;
                    console.log("[InferenceEngine]: load model success");
                } else {
                    this.ready = false;
                    console.log("[InferenceEngine]: load model failed");
                }
            };
            let alg = this.config.alg;
            if(versionCompare(VERSION, "14.9.0") >= 0) {
                errCode = engine.Init(config, callback);  //use bytenn impl
            }
            else if(alg != null) {
                errCode = engine.Init(config, callback, alg); //use bach impl
            }
        } else {
            this.ready = true;
            errCode = engine.Init(config);
        }
        if (errCode != 0) {
            this.ready = false;
            return errCode;
        }
        this.engine = engine;
        this.isReady();
        return 0;
    }
}
Bach.Compute.Engine = Engine;

Bach.Compute.createInferenceEngine = (model, modelName) => {
    let engine = new Bach.Compute.Engine();
    let properties = {};
    properties.type = model.forwardType;
    properties.modelName = modelName;
    properties.doModelValidation = model.doModelValidation;
    properties.numThread = model.numThread;
    const getTensorNames = (tensors) => {
        let names = [];
        for (let tensor of tensors) {
            names.push(tensor.name);
        }
        return names;
    };
    properties.inputNames = getTensorNames(model.inputs);
    properties.outputNames = getTensorNames(model.outputs);
    engine.setProperties(properties);
    return engine;
};

function versionCompare(first, second) {
    if(first == "" || second == "") return 1
    let first_version = first.split(".")
    let second_version = second.split(".")
    let length = Math.max(first_version.length, second_version.length)
    for(let i = 0; i < length; i++) {
        const n1 = Number(first_version[i] || 0)
        const n2 = Number(second_version[i] || 0)
        if(n1 > n2) return 1
        if(n1 < n2) return -1
    }
    return 0;
}

class BaseSystem
{
    constructor() {
        this.name = "MainSystem";
        this.params = {};
        this.params.face_count = 1;
    }
    doBaseInit(alg) {
        console.log(`[doInit], sdk version: ${VERSION}, script version: ${SCRIPT_VERSION}`);
        alg.addOutputType(0, Amaz.AlgorithmResultType.SCRIPT);
        this.MainSystemAlg = alg;
        let app = this.MainSystemAlg.app;
        let bceSettingString = '{}';
        if (versionCompare(VERSION, "14.4.0") >= 0) {
            bceSettingString = app.getABConfig("bce_setting", 3);
        }
        try{
            this.bceSetting = JSON.parse(bceSettingString);
        } catch(e) { // in case bceSettingString is invalid and error from Json.parse interrupts the following process
            this.bceSetting = {}
        }
        let engine = alg.app.engine;
        this.computeEngine = engine;

        let cpu_mode = alg.getParam("cpu_mode");
        this.gpu_mode = cpu_mode != 1;
        this.use_bce = true;
        let use_bce_param = alg.getParam("use_bce");
        if (use_bce_param != null) {
            this.use_bce = use_bce_param == 1 ? true : false;
        }

        let async_load = alg.getParam("async_load");
        this.async_load = async_load == 1;
        this.coreml_mode = false;
        this.blitNode = "blit_0";
        let blit_node = alg.getParam("blit_node");
        if (blit_node != null) {
            this.blitNode = blit_node;
        }
        this.inputTextureNode = "src_data_0";
        let input_texture_node = alg.getParam("input_texture_node");
        if (input_texture_node != null) {
            this.inputTextureNode = input_texture_node;
        }
        this.faceAlignNode = "FaceAlign";
        let face_align_node = alg.getParam("face_align_node");
        if (face_align_node != null) {
            this.faceAlignNode = face_align_node;
        }
        this.syncBeforeInference = false
        let sync_before_inference = alg.getParam("sync_before_inference")
        if (sync_before_inference) {
            this.syncBeforeInference = true
        }
        let face_count = alg.getParam("face_count");
        if (face_count != null) {
            this.params.face_count = face_count;
        }

        this.platform = Amaz.Platform.name();
        console.log(`[doInit]: platform: ${this.platform}`);
        if(this.gpu_mode && versionCompare(VERSION, "13.8.0") >= 0) {  // before 1380, must configure cpu & gpu mode JS model in model dispatcher
            this.gpu_mode = this.supportTextureIO();
        }
        this.head = null

        if (this.use_bce) {
            if (this.platform == "Windows" && versionCompare(VERSION, "17.0.0") < 0) {
                console.log(`bce support on windows: >= 17.0.0`);
                this.use_bce = false;
            }
            if (this.platform == "Mac") {
                this.use_bce  = false;
                if (versionCompare(VERSION, "17.3.0") < 0) {
                    console.log(`bce support on mac: >= 17.3.0`);
                }
                else {
                    console.log(`effect render not consum cvpixelbuffer from bce results, there need another blit operation.`);
                }
            }
            if (this.platform == "Android" && versionCompare(VERSION, "17.4.0") < 0) {
                console.log(`bce support on android: >= 17.4.0`);
                this.use_bce = false;
            }
            if (this.platform == "iOS" && versionCompare(VERSION, "17.4.0") < 0) {
                console.log(`bce support on ios: >= 17.4.0`);
                this.use_bce = false;
            }
        }
    }

    checkAsyncLoad() {
        if (versionCompare(VERSION, "15.0.0") < 0) {
            return false;
        }
        if ("async_load" in this.bceSetting) {
            return this.bceSetting["async_load"] && this.async_load;
        }
        return this.async_load;
    }

    checkSyncBeforeInference() {
        if (this.platform != "Android") return false;
        if (this.syncBeforeInference) return true;
        if (this.bceSetting["sync_before_inference"]) return true;
        if (this.params["script_force_detect"]) return true;
        return false;
    }

    loadCpuModel(model, modelConfig, modelName) {
        console.log(`[loadCpuModel]: loading model ${model.name}`);
        if (
            modelConfig.forwardType == ByteNN.ForwardType.NPU &&
            this.platform != "Android"
        ) {
            console.log(
                `[loadCpuModel]: use auto instead of npu on non-android platform`
            );
            modelConfig.forwardType = ByteNN.ForwardType.Auto;
        }
        this.coreml_mode = modelConfig.forwardType == ByteNN.ForwardType.CoreML;
        let engine = Bach.Compute.createInferenceEngine(modelConfig, modelName); 
        if (this.checkAsyncLoad()) {
            engine.setProperties({
                asyncLoad: true,
                alg: this.MainSystemAlg,
            });
        }
        let cacheDir = this.MainSystemAlg.getCacheDir();
        let errCode = engine.loadModel(model, cacheDir, cacheDir);
        if (errCode != 0) {
            console.log(`[loadCpuModel]: bytenn init failed: ${errCode}`);
            return 0x100;
        }
        this.gamma = modelConfig.gamma;
        this.inferenceEngine = engine;
        this.inferenceTensors = engine.tensors;
        return 0;
    }

    loadGpuModel(model, modelConfig, modelName) {
        console.log(`[loadGpuModel]: loading model ${model.name}`);
        if (modelConfig.forwardType == ByteNN.ForwardType.NPU) {
            console.log(
                `[loadGpuModel]: npu model should be loaded using cpu mode`
            );
            return 0x100;
        }
        this.coreml_mode = modelConfig.forwardType == ByteNN.ForwardType.CoreML;
        let pipeline = Bach.Compute.createInferencePipeline(
            this.computeEngine,
            modelConfig,
            modelName
        );
        if (this.checkAsyncLoad()) {
            pipeline.setProperty("asyncModelLoad", 1);
        }
        let cacheDir = this.MainSystemAlg.getCacheDir();
        let errCode = pipeline.loadModel(model, cacheDir, cacheDir);
        if (errCode != 0) {
            console.log(`[loadGpuModel]: bytenn init failed: ${errCode}`);
            return 0x100;
        }
        this.gamma = modelConfig.gamma;
        this.inferencePipeline = pipeline;
        if (this.inferenceTextures == null) {
            this.inferenceTextures = [pipeline.textures];
        }
        return 0;
    }
    
    // empty implementation
    loadBceModel(model, modelConfig, modelName) {
        return 0;
    }

    parseModelConfig(modelName) {
        let configStr = this.MainSystemAlg.getParam("model_config");
        if (configStr == null) {
            console.error(`[parseModelConfig]: param model_config not found`);
            return null;
        }
        console.log(`[parseModelConfig]: parsing ${configStr}`);
       
        let modelConfigs = null;
        try {
            modelConfigs = JSON.parse(configStr);
        } catch (error) {
            console.error(`[parseModelConfig]: parse ${configStr} failed`);
            return null;
        }
    
        for (let key in modelConfigs) {
            this.modelConfigs[key] = modelConfigs[key];
        }
        return this.modelConfigs[modelName]
    }

    checkConfig(config)
    {
        let type = config.type;
        try {
            if (type != null) type = type.toLowerCase();
        } catch (error) {}
        if (type == null) {
        } else if (type == "coreml") {
            config.forwardType = ByteNN.ForwardType.CoreML; 
        } else if (type == "npu") {
            config.forwardType = ByteNN.ForwardType.NPU;
            this.gpu_mode = false
        }
        if (config.forwardType == null)
        {
            if (type == "gpu")
            {
                config.forwardType = ByteNN.ForwardType.GPU;
            }
            else if (type == "cpu")
            {
                config.forwardType = ByteNN.ForwardType.CPU;
            }
            else 
            {
                config.forwardType = ByteNN.ForwardType.Auto;
            }
        }
        if(this.gpu_mode) {
            let mode = config.mode;
            try {
                if (mode != null) mode = mode.toLowerCase();
            } catch (error) {}
            if(mode == "cpu") this.gpu_mode = false
        }
        if(this.gpu_mode) {
            let cpu_mode = this.MainSystemAlg.getParam("cpu_mode");
            if(cpu_mode == 1) this.gpu_mode = false;
        }
        let async_load = this.MainSystemAlg.getParam("async_load");
        this.async_load = async_load == 1;
        return 0
    }

    doLoadModel(model) {
        if (model.name == "dummy") return 0;
        let modelConfig = this.parseModelConfig(model.name);
        if (modelConfig == null) return 0x100;
        let error = this.checkConfig(modelConfig)
        if(error != 0) {
            console.log(`[doLoadModel]: model config error`);
            return 0x100;
        }

        if (!this.gpu_mode && this.use_bce && this.platform != "Windows") {
            console.log(`bce script not support cpu mode.`);
            this.use_bce = false;
        }
        if (modelConfig.forwardType == ByteNN.ForwardType.CoreML && this.use_bce)
        {
            console.log(`use old mode when running coreml model.`);
            this.use_bce = false;
        }

        if (this.use_bce) {
            return this.loadBceModel(model, modelConfig, this.model_key);
        }

        if (this.gpu_mode) {
            return this.loadGpuModel(model, modelConfig, this.model_key);
        } else {
            return this.loadCpuModel(model, modelConfig, this.model_key);
        }
    }

    resizeInferenceTextures(length) {
        if (length <= this.inferenceTextures.length) return;
        let currentLength = this.inferenceTextures.length;
        let textures = this.inferenceTextures[0];
        for (let i = currentLength; i < length; ++i) {
            this.inferenceTextures.push(
                Bach.Compute.copyInferenceTextures(this.computeEngine, textures)
            );
        }
    }
    /*

    */
    dumpResults(success) {
        let cacheDir = this.MainSystemAlg.getCacheDir();
        let contents = success ? "1" : "0"
        console.log("[supportTextureIO] dump contents:", contents)
        fs.writeFileSync(cacheDir + "/supportTextureIO.txt", contents)
        return success;
    }
    supportTextureIO()
    {
        if (this.platform == "Android") {
            let cacheDir = this.MainSystemAlg.getCacheDir();
            let contentsBuffer = fs.readFileSync(cacheDir + "/supportTextureIO.txt")
            if(contentsBuffer.byteLength > 0) {
                let contents = String.fromCharCode.apply(null, new Uint8Array(contentsBuffer))
                console.log("[supportTextureIO] get contents:", contents)
                return contents == "1";
            }
            //  gpu type
            let types = Amaz.JSWrapByteNNEngine.GetDeviceInfo("GPU")
            if (types == null || types.length == 0)  {
                console.log("[supportTextureIO] failed to GetDeviceInfo")
                return this.dumpResults(false);
            }
            let gpu_type = types[0].toLowerCase();
            console.log("[supportTextureIO] GetDeviceInfo:", gpu_type);
            let support = SUPPORTED_GPU_TYPE.reduce((prev, cur) => prev || gpu_type.includes(cur), false)
            if(!support) return this.dumpResults(false);
            // os version
            let version = Amaz.Platform.getOsVersion()
            console.log("[supportTextureIO] getOsVersion:", version)
            if(version - 27 <= 0) return this.dumpResults(false);
            //relu test
            let success = this.computeEngine.compatibilityCheck()  //available 1380
            return this.dumpResults(success);
        } else if (this.platform == "iOS") {
            if(versionCompare(VERSION, "14.7.0") >= 0) {
                let deviceName = Amaz.Platform.getDeviceName()  // available 1470
                console.log("[supportTextureIO] getDeviceName:", deviceName)
                let index = BLACKLIST_IOS.indexOf(deviceName)
                if (index != -1) return false
                let version = Amaz.Platform.getOsVersion()
                console.log("[supportTextureIO] getOsVersion:", version)
                return versionCompare(version.trim(), "11.0") >= 0;
            } 
            else {
                return this.computeEngine.compatibilityCheck();
            }
        } else if(this.platform == "Mac") {
            if (versionCompare(VERSION, "14.8.0") >= 0) {
                let version = Amaz.Platform.getOsVersion();
                console.log("[supportTextureIO] getOsVersion:", version)
                return versionCompare(version.trim(), "10.13") >= 0;
            }
            return versionCompare(VERSION, "13.9.0") >= 0;
        } else if(this.platform == "Windows") {
            return false;
        }
        else if (this.platform == "Linux") {
            return versionCompare(VERSION, "14.8.0") >= 0;
        }
    }
}

class FlowGanHeadCpu {
    constructor(system) {
        this.owner = system
        this.ganImageF32 = Amaz.JSWrapCV.Mat();
        this.ganImageU8 = Amaz.JSWrapCV.Mat();   
        this.flowImageF32 = Amaz.JSWrapCV.Mat();
        this.flowImageU8 = Amaz.JSWrapCV.Mat();
        this.memory_optimize = versionCompare(VERSION, "14.2.0") >= 0;
    }

    /**
    * postprocess tensor to image & flow
    * @param {JSWrapNodeContext} nodeContext
    * @param {Array<JSWrapByteNNTensor>} infOutTensors
    * @param {number} index
    * @param {number} offset
    * @param {number} gamma
    */
    process(nodeContext, infOutTensors, index, offset, gamma) {
        let infOutTensor0 = infOutTensors[0];
        if (infOutTensor0.channel == 6) {
            let outImage = Amaz.JSWrapCV.Mat(infOutTensor0);
            let splitted = [];
            Amaz.JSWrapCV.split(outImage, splitted);
            Amaz.JSWrapCV.merge(
                [splitted[0], splitted[1], splitted[2], splitted[3]],
                this.ganImageF32
            );
            Amaz.JSWrapCV.merge(
                [splitted[4], splitted[5], splitted[4], splitted[5]],
                this.flowImageF32
            );
            if(this.memory_optimize){
                for(let m of splitted){
                    m.releaseMat()
                }
            }
        } else {
            let infOutTensor1 = null;
            if (infOutTensor0.channel == 2) {
                infOutTensor0 = infOutTensors[1];
                infOutTensor1 = infOutTensors[0];
            } else {
                infOutTensor1 = infOutTensors[1];
            }
            this.ganImageF32 = Amaz.JSWrapCV.Mat(infOutTensor0);
            let flowImageF32Half = Amaz.JSWrapCV.Mat(infOutTensor1);
            Amaz.JSWrapCV.merge(
                [flowImageF32Half, flowImageF32Half],
                this.flowImageF32
            );
        }

        this.ganImageF32.convertTo(
            this.ganImageU8,
            MobileCV2.DataType.CV_8UC4,
            255 / 2,
            255 / 2
        );

        this.flowImageF32.convertTo(
            this.flowImageU8,
            MobileCV2.DataType.CV_8UC4,
            (255 / 2) * gamma * 4,
            255 / 2
        );
        let engine = this.owner.computeEngine
        let ganTex = nodeContext.getOutputGPUTexture(
            engine,
            this.ganImageU8.cols,
            this.ganImageU8.rows,
            Bach.AEPixelFormat.RGBA8UNORM,
            index * 2 + offset,
            1
        );
        ganTex.loadCPUData(this.ganImageU8.data);
        let flowTex = nodeContext.getOutputGPUTexture(
            engine,
            this.flowImageU8.cols,
            this.flowImageU8.rows,
            Bach.AEPixelFormat.RGBA8UNORM,
            index * 2 + 1 + offset,
            1
        );
        flowTex.loadCPUData(this.flowImageU8.data);
    }
}

class FlowGanHeadGpu {
    constructor(system, coreml_mode) {
        this.owner = system
        this.coreml_mode = coreml_mode
        if(coreml_mode) {
            this.ganPostPipeline = Bach.Compute.createCustomPipeline(
                system.computeEngine,
                Bach.Compute.Shaders.vertexShader,
                Bach.Compute.Shaders.concatFragmentShader
            );
            
            this.flowPostPipeline = Bach.Compute.createCustomPipeline(
                system.computeEngine,
                Bach.Compute.Shaders.vertexShader,
                Bach.Compute.Shaders.flowPostFragmentShader
            );
        } else {
            this.alphaBlendPipeline =
                Bach.Compute.createAlphaBlendPipeline(system.computeEngine);
        }
    }
    /**
    * postprocess tensor to image & flow
    * @param {JSWrapNodeContext} nodeContext
    * @param {Array<{.name, .size, .format, .texture}>} infOutTexes
    * @param {number} index
    * @param {number} offset 
    * @param {number} gamma
    */
    process(nodeContext, infOutTexes, index, offset, gamma) {
        let infOutTex0 = infOutTexes[0].texture;
        let infOutTex1 = infOutTexes[1].texture;
        let ganTex = nodeContext.getOutputGPUTexture(
            this.owner.computeEngine,
            infOutTex0.width,
            infOutTex0.height,
            Bach.AEPixelFormat.RGBA8UNORM,
            index * 2 + offset,
            1
        );
        if (this.coreml_mode) {
            this.ganPostPipeline.setInputBuffer("inputTex0", infOutTex0);
            this.ganPostPipeline.setInputBuffer("inputTex1", infOutTex1);
            this.ganPostPipeline.setOutputBuffer("output", ganTex);
            this.ganPostPipeline.dispatch();
        } else {
            this.alphaBlendPipeline.setConvertAlpha([0.5, 0.5, 0.5, 0.5]);
            this.alphaBlendPipeline.setConvertBeta([0.5, 0.5, 0.5, 0.5]);
            this.alphaBlendPipeline.setInputBuffer("_MainTex", infOutTex0);
            this.alphaBlendPipeline.setOutputBuffer("output", ganTex);
            this.alphaBlendPipeline.dispatch();
        }

        let flowTex = nodeContext.getOutputGPUTexture(
            this.owner.computeEngine,
            infOutTex1.width,
            infOutTex1.height,
            Bach.AEPixelFormat.RGBA8UNORM,
            index * 2 + 1 + offset,
            1
        );

        if (this.coreml_mode) {
            let v = gamma * 4;
            this.flowPostPipeline.setInputBuffer("inputTex0", infOutTex0);
            this.flowPostPipeline.setInputBuffer("inputTex1", infOutTex1);
            this.flowPostPipeline.setConvertAlpha([v, v, v, v]);
            this.flowPostPipeline.setOutputBuffer("output", flowTex);
            this.flowPostPipeline.dispatch();
        } else {
            let v = 0.5 * gamma * 4;
            this.alphaBlendPipeline.setInputBuffer("_MainTex", infOutTex1);
            this.alphaBlendPipeline.setOutputBuffer("output", flowTex);
            this.alphaBlendPipeline.setConvertAlpha([v, v, v, v]);
            this.alphaBlendPipeline.setConvertBeta([0.5, 0.5, 0.5, 0.5]);
            this.alphaBlendPipeline.dispatch();
        }
    }
}
class GanHeadCpu {
    constructor(system) {
        this.owner = system
        this.ganImageF32 = Amaz.JSWrapCV.Mat();
        this.ganImageU8 = Amaz.JSWrapCV.Mat();
    }
    /**
    * postprocess tensor to image
    * @param {JSWrapNodeContext} nodeContext
    * @param {Array<JSWrapByteNNTensor>} infOutTensors
    * @param {number} index
    * @param {number} offset 
    */
    process(nodeContext, infOutTensors, index, offset) {
        let infOutTensor0 = infOutTensors[0];
        this.ganImageF32 = Amaz.JSWrapCV.Mat(infOutTensor0);
        this.ganImageF32.convertTo(
            this.ganImageU8,
            MobileCV2.DataType.CV_8UC4,
            255 / 2,
            255 / 2
        );
        let engine = this.owner.computeEngine
        let ganTex = nodeContext.getOutputGPUTexture(
                engine,
                infOutTensor0.width,
                infOutTensor0.height,
                Bach.AEPixelFormat.RGBA8UNORM,
                index + offset,
                1
            );
        ganTex.loadCPUData(this.ganImageU8.data);
    }
}

class GanHeadGpu {
    constructor(system, coreml_mode) {
        this.owner = system
        this.coreml_mode = coreml_mode
        if(coreml_mode) {
            this.ganPostPipeline = Bach.Compute.createCustomPipeline(
                system.computeEngine,
                Bach.Compute.Shaders.vertexShader,
                Bach.Compute.Shaders.concatFragmentShader
            );
        } else {
            this.ganPostPipeline =
                Bach.Compute.createAlphaBlendPipeline(system.computeEngine);
        }
        
    }
    /**
    * postprocess tensor to image
    * @param {JSWrapNodeContext} nodeContext
    * @param {Array<{.name, .size, .format, .texture}>} infOutTexes
    * @param {number} index
    * @param {number} offset 
    */
    process(nodeContext, infOutTexes, index, offset) {
        let infOutTex0 = infOutTexes[0].texture;
        let ganTex = nodeContext.getOutputGPUTexture(
            this.owner.computeEngine,
            infOutTex0.width,
            infOutTex0.height,
            Bach.AEPixelFormat.RGBA8UNORM,
            index + offset,
            1
        );
        if (this.coreml_mode) {
            if (infOutTexes[1]) {
                let infOutTex1 = infOutTexes[1].texture;
                this.ganPostPipeline.setInputBuffer("inputTex0", infOutTex0);
                this.ganPostPipeline.setInputBuffer("inputTex1", infOutTex1);
                this.ganPostPipeline.setOutputBuffer("output", ganTex);
                this.ganPostPipeline.dispatch();
            }
            else {
                this.ganPostPipeline = Bach.Compute.createCustomPipeline(
                    this.owner.computeEngine,
                    Bach.Compute.Shaders.vertexShader,
                    Bach.Compute.Shaders.singleInputconcatFragmentShader
                );
                this.ganPostPipeline.setInputBuffer("inputTex0", infOutTex0);
                this.ganPostPipeline.setOutputBuffer("output", ganTex);
                this.ganPostPipeline.dispatch();
            }
        } else {
            this.ganPostPipeline.setConvertAlpha([0.5, 0.5, 0.5, 0.5]);
            this.ganPostPipeline.setConvertBeta([0.5, 0.5, 0.5, 0.5]);
            this.ganPostPipeline.setInputBuffer("_MainTex", infOutTex0);
            this.ganPostPipeline.setOutputBuffer("output", ganTex);
            this.ganPostPipeline.dispatch();
        }
    }
}

class DataLoaderCpu {
    constructor(coreml_mode) {
        this.cropImage = Amaz.JSWrapCV.Mat();
        this.cropImageU8 = Amaz.JSWrapCV.Mat();
        this.coreml_mode = coreml_mode;
        this.cropImageF32 = Amaz.JSWrapCV.Mat();
    }
    /**
    * preprocess image to tensor
    * @param {JSWrapCVMat} cameraImage
    * @param {JSWrapByteNNTensor} infInTensor0
    * @param {NHImageTransformInterface} tfmInfo
    */
    process(cameraImage, infInTensor0, tfmInfo) {
        Bach.Compute.warpAffine(
            tfmInfo.affine,
            cameraImage,
            this.cropImage,
            [infInTensor0.width, infInTensor0.height]
        );
        Amaz.JSWrapCV.cvtColor(
            this.cropImage,
            this.cropImageU8,
            MobileCV2.ColorConversionCodes.COLOR_RGBA2RGB
        );
        if(!this.coreml_mode) this.cropImageF32 = Amaz.JSWrapCV.Mat(infInTensor0)
        this.cropImageU8.convertTo(
            this.cropImageF32,
            MobileCV2.DataType.CV_32FC3,
            2 / 255,
            -1
        );
        if(this.coreml_mode) infInTensor0.raw_data = this.cropImageF32.data;
        infInTensor0.format = ByteNN.DataFormat.NHWC;
    }
}
class DataLoaderGpu {
    constructor(coreml_mode, engine) {
        this.coreml_mode = coreml_mode
        this.affineWarpPipeline =
                Bach.Compute.createAffineWarpPipeline(engine);

    }
    /**
    * preprocess image to tensor
    * @param {JSWrapTexture} cameraTex
    * @param {infInTex0} infInTex0
    * @param {NHImageTransformInterface} tfmInfo
    * @param {[number, number]} dstSize
    */
    process(cameraTex, infInTex0, tfmInfo, dstSize, alpha, beta) {
        let affine = Bach.Compute.normalizeAffine(
            tfmInfo.affine,
            dstSize,
            [infInTex0.width, infInTex0.height]
        );
        if (this.coreml_mode) {
            if (alpha == null) alpha = [1, 1, 1, 1];
            if (beta == null) beta = [0, 0, 0, 0];
        } else {
            if (alpha == null) alpha = [2, 2, 2, 2];
            if (beta == null) beta = [-1, -1, -1, -1];
        }
        this.affineWarpPipeline.setConvertAlpha(alpha);
        this.affineWarpPipeline.setConvertBeta(beta);
        this.affineWarpPipeline.setProperty("invTransMatrix", affine);
        this.affineWarpPipeline.setInputBuffer("_MainTex", cameraTex);
        this.affineWarpPipeline.setOutputBuffer("output", infInTex0);
        this.affineWarpPipeline.dispatch();
    }
}

class SrcLoaderGpu {
    constructor(engine) {
        this.blitPipeline = Bach.Compute.createAlphaBlendPipeline(engine);
    }
    /**
    * preprocess image to tensor
    * @param {JSWrapTexture} cameraTex
    * @param {infInTex0} infInTex0
    * @param {NHImageTransformInterface} tfmInfo
    * @param {[number, number]} dstSize
    */
    process(cameraTex, infInTex0) {
        this.blitPipeline.setInputBuffer("_MainTex", cameraTex);
        this.blitPipeline.setOutputBuffer("output", infInTex0);
        this.blitPipeline.dispatch();
    }
}

class FullGanHeadGpu {
    constructor(system, coreml_mode) {
        this.owner = system
        this.coreml_mode = coreml_mode
        if(coreml_mode) {
            this.ganPostPipeline = Bach.Compute.createCustomPipeline(
                system.computeEngine,
                Bach.Compute.Shaders.vertexShader,
                Bach.Compute.Shaders.concatFragmentShader
            );
        } else {
            this.ganPostPipeline =
                Bach.Compute.createAlphaBlendPipeline(system.computeEngine);
        }
    }
    /**
    * postprocess tensor to image
    * @param {JSWrapNodeContext} nodeContext
    * @param {Array<{.name, .size, .format, .texture}>} infOutTexes
    * @param {number} index
    * @param {number} offset 
    */
    process(nodeContext, infOutTexes, index) {
        let infOutTex0 = infOutTexes[0].texture;
        let ganTex = nodeContext.getOutputGPUTexture(
            this.owner.computeEngine,
            infOutTex0.width,
            infOutTex0.height,
            Bach.AEPixelFormat.RGBA8UNORM,
            index,
            1
        );
        if (this.coreml_mode) {
            let infOutTex1 = infOutTexes[1].texture;
            this.ganPostPipeline.setInputBuffer("inputTex0", infOutTex0);
            this.ganPostPipeline.setInputBuffer("inputTex1", infOutTex1);
            this.ganPostPipeline.setOutputBuffer("output", ganTex);
            this.ganPostPipeline.dispatch();
        } else {
            this.ganPostPipeline.setConvertAlpha([0.5, 0.5, 0.5, 0.5]);
            this.ganPostPipeline.setConvertBeta([0.5, 0.5, 0.5, 0.5]);
            this.ganPostPipeline.setInputBuffer("_MainTex", infOutTex0);
            this.ganPostPipeline.setOutputBuffer("output", ganTex);
            this.ganPostPipeline.dispatch();
        }
    }
}

class  FullFlowGanHeadGpu {
    constructor(system, coreml_mode) {
        this.owner = system
        this.coreml_mode = coreml_mode
        if(coreml_mode) {
            this.ganPostPipeline = Bach.Compute.createCustomPipeline(
                system.computeEngine,
                Bach.Compute.Shaders.vertexShader,
                Bach.Compute.Shaders.concatFragmentShader
            );
            
            this.flowPostPipeline = Bach.Compute.createCustomPipeline(
                system.computeEngine,
                Bach.Compute.Shaders.vertexShader,
                Bach.Compute.Shaders.flowPostFragmentShader
            );
        } else {
            this.alphaBlendPipeline =
                Bach.Compute.createAlphaBlendPipeline(system.computeEngine);
        }
    }
    /**
    * postprocess tensor to image & flow
    * @param {JSWrapNodeContext} nodeContext
    * @param {Array<{.name, .size, .format, .texture}>} infOutTexes
    * @param {number} index
    * @param {number} gamma
    */
    process(nodeContext, infOutTexes, index, gamma) {
        let infOutTex0 = infOutTexes[0].texture;
        let infOutTex1 = infOutTexes[1].texture;
        let ganTex = nodeContext.getOutputGPUTexture(
            this.owner.computeEngine,
            infOutTex0.width,
            infOutTex0.height,
            Bach.AEPixelFormat.RGBA8UNORM,
            index,
            1
        );
        if (this.coreml_mode) {
            this.ganPostPipeline.setInputBuffer("inputTex0", infOutTex0);
            this.ganPostPipeline.setInputBuffer("inputTex1", infOutTex1);
            this.ganPostPipeline.setOutputBuffer("output", ganTex);
            this.ganPostPipeline.dispatch();
        } else {
            this.alphaBlendPipeline.setConvertAlpha([0.5, 0.5, 0.5, 0.5]);
            this.alphaBlendPipeline.setConvertBeta([0.5, 0.5, 0.5, 0.5]);
            this.alphaBlendPipeline.setInputBuffer("_MainTex", infOutTex0);
            this.alphaBlendPipeline.setOutputBuffer("output", ganTex);
            this.alphaBlendPipeline.dispatch();
        }

        let flowTex = nodeContext.getOutputGPUTexture(
            this.owner.computeEngine,
            infOutTex1.width,
            infOutTex1.height,
            Bach.AEPixelFormat.RGBA8UNORM,
            index,
            1
        );

        if (this.coreml_mode) {
            let v = gamma * 4;
            this.flowPostPipeline.setInputBuffer("inputTex0", infOutTex0);
            this.flowPostPipeline.setInputBuffer("inputTex1", infOutTex1);
            this.flowPostPipeline.setConvertAlpha([v, v, v, v]);
            this.flowPostPipeline.setOutputBuffer("output", flowTex);
            this.flowPostPipeline.dispatch();
        } else {
            let v = 0.5 * gamma * 4;
            this.alphaBlendPipeline.setInputBuffer("_MainTex", infOutTex1);
            this.alphaBlendPipeline.setOutputBuffer("output", flowTex);
            this.alphaBlendPipeline.setConvertAlpha([v, v, v, v]);
            this.alphaBlendPipeline.setConvertBeta([0.5, 0.5, 0.5, 0.5]);
            this.alphaBlendPipeline.dispatch();
        }
    }
}

Bach.Compute.FlowGanHeadCpu = FlowGanHeadCpu
Bach.Compute.FlowGanHeadGpu = FlowGanHeadGpu
Bach.Compute.GanHeadCpu = GanHeadCpu
Bach.Compute.GanHeadGpu = GanHeadGpu
Bach.Compute.DataLoaderGpu = DataLoaderGpu
Bach.Compute.DataLoaderCpu = DataLoaderCpu
Bach.Compute.SrcLoaderGpu = SrcLoaderGpu
Bach.Compute.FullFlowGanHeadGpu = FullFlowGanHeadGpu
Bach.Compute.FullGanHeadGpu = FullGanHeadGpu
exports.BaseSystem = BaseSystem
exports.ByteNN = ByteNN;
exports.MobileCV2 = MobileCV2;
exports.Bach = Bach;
exports.Amaz = Amaz;
