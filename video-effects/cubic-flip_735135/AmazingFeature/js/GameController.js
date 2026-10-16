const Amaz = effect.Amaz;
const cv = Amaz.JSWrapCV;
const SCRIPT_NAME = 'GameController';
/**
 * System script is NOT recommended to be used anymore.
 * Avoid using system script unless you really have to.
 */
class GameController {
    constructor() {
        this.name = SCRIPT_NAME;
        this.dis = 7
    }

    /** onInit is called before onStart(). */
    onInit() {}



        /** onUpdate is called once every frame. */
    onUpdate(deltaTime) {
        // let bgMask = this.bgMask;
        // let algo = Amaz.AmazingManager.getSingleton('Algorithm').getAEAlgorithmResult();
        // let mattingInfo = algo.getBgInfo();
        // if (mattingInfo) {
        //     bgMask = mattingInfo.bgMask;
        // }
        // let mat = cv.Mat(bgMask);

        // let contours = new Array();
        // cv.findContours(mat, contours, 0, 1);
        // let vec2vec = this.jsArrayToAmzVec(contours);
        // this.dataTable.set("contours", vec2vec)
        // this.dataTable.set("image_Height", mat.rows)
        // this.dataTable.set("image_Width", mat.cols)
        //     // this.dataTable.set("mask", newBgMask)
    }

    /** onLateUpdate is called once every frame after onUpdate(). */
    onLateUpdate(deltaTime) {}

    /** onEvent is called when an event arrives. */
    onEvent(event) {
            // if (event.args.get(0) == 'segMask') {
            //     this.bgMask = event.args.get(1)
            // }
            // if (event.args.get(0) == 'effects_adjust_distance') {
            //     this.dis = 5+24*event.args.get(1)
            // }
        }
        /** onDestroy is called when this script instance is destroyed. */
    onDestroy() {}

}

exports.GameController = GameController;