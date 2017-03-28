package kabam.rotmg.stage3D {
import com.adobe.utils.AGALMiniAssembler;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsGradientFill;
import flash.display.IGraphicsData;
import flash.display.Stage3D;
import flash.display.StageScaleMode;
import flash.display3D.Context3D;
import flash.display3D.Context3DProgramType;
import flash.display3D.Context3DTextureFormat;
import flash.display3D.Context3DTriangleFace;
import flash.display3D.Context3DVertexBufferFormat;
import flash.display3D.IndexBuffer3D;
import flash.display3D.Program3D;
import flash.display3D.VertexBuffer3D;
import flash.display3D.textures.Texture;
import flash.geom.Matrix3D;
import flash.geom.Vector3D;
import flash.utils.ByteArray;

import kabam.rotmg.stage3D.Object3D.Object3DStage3D;
import kabam.rotmg.stage3D.Object3D.Util;
import kabam.rotmg.stage3D.graphic3D.Graphic3D;
import kabam.rotmg.stage3D.graphic3D.TextureFactory;
import kabam.rotmg.stage3D.proxies.Context3DProxy;

import org.swiftsuspenders.Injector;

public class Renderer {

    public static const STAGE3D_FILTER_PAUSE:uint = 1;
    public static const STAGE3D_FILTER_BLIND:uint = 2;
    public static const STAGE3D_FILTER_DRUNK:uint = 3;
    public static var inGame:Boolean;
    private static const POST_FILTER_VERTEX_CONSTANTS:Vector.<Number> = new <Number>[1, 2, 0, 0];
    private static const GRAYSCALE_FRAGMENT_CONSTANTS:Vector.<Number> = new <Number>[0.3, 0.59, 0.11, 0];
    private static const BLIND_FRAGMENT_CONSTANTS:Vector.<Number> = new <Number>[0.05, 0.05, 0.05, 0];
    private static const POST_FILTER_POSITIONS:Vector.<Number> = new <Number>[-1, 1, 0, 0, 1, 1, 1, 0, 1, -1, 1, 1, -1, -1, 0, 1];
    private static const POST_FILTER_TRIS:Vector.<uint> = new <uint>[0, 2, 3, 0, 1, 2];

    [Inject]
    public var context3D:Context3DProxy;
    [Inject]
    public var textureFactory:TextureFactory;
    [Inject]
    public var injector:Injector;
    private var tX:Number;
    private var tY:Number;
    public var program2:Program3D;
    private var postProcessingProgram_:Program3D;
    private var blurPostProcessing_:Program3D;
    private var shadowProgram_:Program3D;
    private var graphic3D_:Graphic3D;
    protected var _projection:Matrix3D;
    protected var cameraMatrix_:Matrix3D;
    private var p_:Vector3D;
    private var f_:Vector3D;
    private var u_:Vector3D;
    private var r_:Vector3D;
    private var rd_:Vector.<Number>;
    protected var widthOffset_:Number;
    protected var heightOffset_:Number;
    private var stageWidth:Number = 600;
    private var stageHeight:Number = 600;
    private var sceneTexture_:Texture;
    private var blurFactor:Number = 0.01;
    private var postFilterVertexBuffer_:VertexBuffer3D;
    private var postFilterIndexBuffer_:IndexBuffer3D;
    protected var _vertexShader:String;
    protected var _fragmentShader:String;
    protected var blurFragmentConstants_:Vector.<Number>;

    public function Renderer(_arg_1:Render3D) {
        this.cameraMatrix_ = new Matrix3D();
        this.p_ = new Vector3D();
        this.f_ = new Vector3D();
        this.u_ = new Vector3D();
        this.r_ = new Vector3D();
        this.rd_ = new Vector.<Number>(16, true);
        this._vertexShader = ["m44 op, va0, vc0", "m44 v0, va0, vc8", "m44 v1, va1, vc8", "mov v2, va2"].join("\n");
        this._fragmentShader = ["tex oc, v2, fs0 <2d,clamp>"].join("\n");
        this.blurFragmentConstants_ = Vector.<Number>([0.4, 0.6, 0.4, 1.5]);
        super();
        Renderer.inGame = false;
        this.setTranslationToTitle();
        _arg_1.add(this.onRender);
    }

    public function init(_arg_1:Context3D):void {
        this._projection = Util.perspectiveProjection(56, 1, 0.1, 0x0800);
        var _local_2:AGALMiniAssembler = new AGALMiniAssembler();
        _local_2.assemble(Context3DProgramType.VERTEX, this._vertexShader);
        var _local_3:AGALMiniAssembler = new AGALMiniAssembler();
        _local_3.assemble(Context3DProgramType.FRAGMENT, this._fragmentShader);
        this.program2 = _arg_1.createProgram();
        this.program2.upload(_local_2.agalcode, _local_3.agalcode);
        var _local_4:String = (((("tex ft0, v0, fs0 <2d,clamp,linear>\n" + "dp3 ft0.x, ft0, fc0\n") + "mov ft0.y, ft0.x\n") + "mov ft0.z, ft0.x\n") + "mov oc, ft0\n");
        var _local_5:String = (((("mov op, va0\n" + "add vt0, vc0.xxxx, va0\n") + "div vt0, vt0, vc0.yyyy\n") + "sub vt0.y, vc0.x, vt0.y\n") + "mov v0, vt0\n");
        var _local_6:AGALMiniAssembler = new AGALMiniAssembler();
        _local_6.assemble(Context3DProgramType.VERTEX, _local_5);
        var _local_7:ByteArray = _local_6.agalcode;
        _local_6.assemble(Context3DProgramType.FRAGMENT, _local_4);
        var _local_8:ByteArray = _local_6.agalcode;
        this.postProcessingProgram_ = _arg_1.createProgram();
        this.postProcessingProgram_.upload(_local_7, _local_8);
        var _local_9:String = ((((((((("sub ft0, v0, fc0\n" + "sub ft0.zw, ft0.zw, ft0.zw\n") + "dp3 ft1, ft0, ft0\n") + "sqt ft1, ft1\n") + "div ft1.xy, ft1.xy, fc0.zz\n") + "pow ft1.x, ft1.x, fc0.w\n") + "mul ft0.xy, ft0.xy, ft1.xx\n") + "div ft0.xy, ft0.xy, ft1.yy\n") + "add ft0.xy, ft0.xy, fc0.xy\n") + "tex oc, ft0, fs0<2d,clamp>\n");
        var _local_10:String = ("m44 op, va0, vc0\n" + "mov v0, va1\n");
        _local_6.assemble(Context3DProgramType.VERTEX, _local_10);
        var _local_11:ByteArray = _local_6.agalcode;
        _local_6.assemble(Context3DProgramType.FRAGMENT, _local_9);
        var _local_12:ByteArray = _local_6.agalcode;
        this.blurPostProcessing_ = _arg_1.createProgram();
        this.blurPostProcessing_.upload(_local_11, _local_12);
        var _local_13:String = (("m44 op, va0, vc0\n" + "mov v0, va1\n") + "mov v1, va2\n");
        _local_6.assemble(Context3DProgramType.VERTEX, _local_13);
        var _local_14:ByteArray = _local_6.agalcode;
        var _local_15:String = (((("sub ft0.xy, v1.xy, fc4.xx\n" + "mul ft0.xy, ft0.xy, ft0.xy\n") + "add ft0.x, ft0.x, ft0.y\n") + "slt ft0.y, ft0.x, fc4.y\n") + "mul oc, v0, ft0.yyyy\n");
        _local_6.assemble(Context3DProgramType.FRAGMENT, _local_15);
        var _local_16:ByteArray = _local_6.agalcode;
        this.shadowProgram_ = _arg_1.createProgram();
        this.shadowProgram_.upload(_local_14, _local_16);
        this.sceneTexture_ = _arg_1.createTexture(0x0400, 0x0400, Context3DTextureFormat.BGRA, true);
        this.postFilterVertexBuffer_ = _arg_1.createVertexBuffer(4, 4);
        this.postFilterVertexBuffer_.uploadFromVector(POST_FILTER_POSITIONS, 0, 4);
        this.postFilterIndexBuffer_ = _arg_1.createIndexBuffer(6);
        this.postFilterIndexBuffer_.uploadFromVector(POST_FILTER_TRIS, 0, 6);
        this.graphic3D_ = this.injector.getInstance(Graphic3D);
    }

    private function UpdateCameraMatrix(_arg_1:Camera):void {
        var _local_2:Number = -(_arg_1.angleRad_);
        this.f_.x = 0;
        this.f_.y = 0;
        this.f_.z = -1;
        this.p_.x = -((_arg_1.x_ + this.widthOffset_));
        this.p_.y = (_arg_1.y_ - this.heightOffset_);
        this.p_.z = -(_arg_1.z_);
        this.r_.x = Math.cos(_local_2);
        this.r_.y = Math.sin(_local_2);
        this.r_.z = 0;
        this.u_.x = Math.cos((_local_2 + (Math.PI / 2)));
        this.u_.y = Math.sin((_local_2 + (Math.PI / 2)));
        this.u_.z = 0;
        this.rd_[0] = this.r_.x;
        this.rd_[1] = this.u_.x;
        this.rd_[2] = this.f_.x;
        this.rd_[3] = 0;
        this.rd_[4] = this.r_.y;
        this.rd_[5] = this.u_.y;
        this.rd_[6] = this.f_.y;
        this.rd_[7] = 0;
        this.rd_[8] = this.r_.z;
        this.rd_[9] = 1;
        this.rd_[10] = -(this.f_.z);
        this.rd_[11] = 0;
        this.rd_[12] = this.p_.dotProduct(this.r_);
        this.rd_[13] = this.p_.dotProduct(this.u_);
        this.rd_[14] = -(this.p_.dotProduct(this.f_));
        this.rd_[15] = 1;
        var _local_3:Matrix3D = new Matrix3D();
        _local_3.rawData = this.rd_;
        this.cameraMatrix_.identity();
        this.cameraMatrix_.append(_local_3);
    }

    private function onRender(_arg_1:Vector.<IGraphicsData>, _arg_2:Vector.<Object3DStage3D>, _arg_3:Number, _arg_4:Number, _arg_5:Camera, _arg_6:uint):void {
        WebMain.STAGE.scaleMode = StageScaleMode.NO_SCALE;
        if (((!((((WebMain.STAGE.stageWidth * 3) / 4) == this.stageWidth))) || (!((WebMain.STAGE.stageHeight == this.stageHeight))))) {
            this.resizeStage3DBackBuffer();
        }
        if (Renderer.inGame == true) {
            this.setTranslationToGame();
        }
        else {
            this.setTranslationToTitle();
        }
        if (_arg_6 > 0) {
            this.renderWithPostEffect(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }
        else {
            this.renderScene(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }
        this.context3D.present();
        WebMain.STAGE.scaleMode = StageScaleMode.EXACT_FIT;
    }

    private function resizeStage3DBackBuffer():void {
        if ((((((WebMain.STAGE.stageWidth * 3) / 4) < 1)) || ((WebMain.STAGE.stageHeight < 1)))) {
            return;
        }
        var _local_1:Stage3D = WebMain.STAGE.stage3Ds[0];
        _local_1.context3D.configureBackBuffer(((WebMain.STAGE.stageWidth * 3) / 4), WebMain.STAGE.stageHeight, 2, false);
        this.stageWidth = ((WebMain.STAGE.stageWidth * 3) / 4);
        this.stageHeight = WebMain.STAGE.stageHeight;
    }

    private function renderWithPostEffect(_arg_1:Vector.<IGraphicsData>, _arg_2:Vector.<Object3DStage3D>, _arg_3:Number, _arg_4:Number, _arg_5:Camera, _arg_6:uint):void {
        this.context3D.GetContext3D().setRenderToTexture(this.sceneTexture_, true);
        this.renderScene(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        this.context3D.GetContext3D().setRenderToBackBuffer();
        switch (_arg_6) {
            case STAGE3D_FILTER_PAUSE:
            case STAGE3D_FILTER_BLIND:
                this.context3D.GetContext3D().setProgram(this.postProcessingProgram_);
                this.context3D.GetContext3D().setTextureAt(0, this.sceneTexture_);
                this.context3D.GetContext3D().clear(0.5, 0.5, 0.5);
                this.context3D.GetContext3D().setVertexBufferAt(0, this.postFilterVertexBuffer_, 0, Context3DVertexBufferFormat.FLOAT_2);
                this.context3D.GetContext3D().setVertexBufferAt(1, null);
                break;
            case STAGE3D_FILTER_DRUNK:
                this.context3D.GetContext3D().setProgram(this.blurPostProcessing_);
                this.context3D.GetContext3D().setTextureAt(0, this.sceneTexture_);
                this.context3D.GetContext3D().clear(0.5, 0.5, 0.5);
                this.context3D.GetContext3D().setVertexBufferAt(0, this.postFilterVertexBuffer_, 0, Context3DVertexBufferFormat.FLOAT_2);
                this.context3D.GetContext3D().setVertexBufferAt(1, this.postFilterVertexBuffer_, 2, Context3DVertexBufferFormat.FLOAT_2);
                break;
        }
        this.context3D.GetContext3D().setVertexBufferAt(2, null);
        switch (_arg_6) {
            case STAGE3D_FILTER_PAUSE:
                this.context3D.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 0, POST_FILTER_VERTEX_CONSTANTS);
                this.context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, GRAYSCALE_FRAGMENT_CONSTANTS);
                break;
            case STAGE3D_FILTER_BLIND:
                this.context3D.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 0, POST_FILTER_VERTEX_CONSTANTS);
                this.context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, BLIND_FRAGMENT_CONSTANTS);
                break;
            case STAGE3D_FILTER_DRUNK:
                if ((((this.blurFragmentConstants_[3] <= 0.2)) || ((this.blurFragmentConstants_[3] >= 1.8)))) {
                    this.blurFactor = (this.blurFactor * -1);
                }
                this.blurFragmentConstants_[3] = (this.blurFragmentConstants_[3] + this.blurFactor);
                this.context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, new Matrix3D());
                this.context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, this.blurFragmentConstants_, (this.blurFragmentConstants_.length / 4));
                break;
        }
        this.context3D.GetContext3D().clear(0, 0, 0, 1);
        this.context3D.GetContext3D().drawTriangles(this.postFilterIndexBuffer_);
    }

    private function renderScene(graphicsDatas:Vector.<IGraphicsData>, grahpicsData3d:Vector.<Object3DStage3D>, mapWidth:Number, mapHeight:Number, camera:Camera):void {
        var test:int;
        var graphicsData:IGraphicsData;
        this.context3D.clear();
        var finalTransform:Matrix3D = new Matrix3D();
        var index3d:uint;
        this.widthOffset_ = (-(mapWidth) / 2);
        this.heightOffset_ = (mapHeight / 2);
        this.UpdateCameraMatrix(camera);
        for each (graphicsData in graphicsDatas) {
            this.context3D.GetContext3D().setCulling(Context3DTriangleFace.NONE);
            if ((((graphicsData is GraphicsBitmapFill)) && (!(GraphicsFillExtra.isSoftwareDraw(GraphicsBitmapFill(graphicsData)))))) {
                try {
                    test = GraphicsBitmapFill(graphicsData).bitmapData.width;
                }
                catch (e:Error) {
                    continue;
                }
                this.graphic3D_.setGraphic(GraphicsBitmapFill(graphicsData), this.context3D);
                finalTransform.identity();
                finalTransform.append(this.graphic3D_.getMatrix3D());
                finalTransform.appendScale((1 / Stage3DConfig.HALF_WIDTH), (1 / Stage3DConfig.HALF_HEIGHT), 1);
                finalTransform.appendTranslation((this.tX / Stage3DConfig.WIDTH), (this.tY / Stage3DConfig.HEIGHT), 0);
                this.context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, finalTransform, true);
                this.graphic3D_.render(this.context3D);
            }
            if ((graphicsData is GraphicsGradientFill)) {
                this.context3D.GetContext3D().setProgram(this.shadowProgram_);
                this.graphic3D_.setGradientFill(GraphicsGradientFill(graphicsData), this.context3D, Stage3DConfig.HALF_WIDTH, Stage3DConfig.HALF_HEIGHT);
                finalTransform.identity();
                finalTransform.append(this.graphic3D_.getMatrix3D());
                finalTransform.appendTranslation((this.tX / Stage3DConfig.WIDTH), (this.tY / Stage3DConfig.HEIGHT), 0);
                this.context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, finalTransform, true);
                this.context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 4, Vector.<Number>([0.5, 0.25, 0, 0]));
                this.graphic3D_.renderShadow(this.context3D);
            }
            if ((((graphicsData == null)) && (!((grahpicsData3d.length == 0))))) {
                try {
                    this.context3D.GetContext3D().setProgram(this.program2);
                    this.context3D.GetContext3D().setCulling(Context3DTriangleFace.BACK);
                    grahpicsData3d[index3d].UpdateModelMatrix(this.widthOffset_, this.heightOffset_);
                    finalTransform.identity();
                    finalTransform.append(grahpicsData3d[index3d].GetModelMatrix());
                    finalTransform.append(this.cameraMatrix_);
                    finalTransform.append(this._projection);
                    finalTransform.appendTranslation((this.tX / Stage3DConfig.WIDTH), ((this.tY / Stage3DConfig.HEIGHT) * 11.5), 0);
                    this.context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, finalTransform, true);
                    this.context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 8, grahpicsData3d[index3d].GetModelMatrix(), true);
                    grahpicsData3d[index3d].draw(this.context3D.GetContext3D());
                    index3d++;
                }
                catch (e:Error) {
                }
            }
        }
    }

    private function setTranslationToGame():void {
        this.tX = 0;
        this.tY = ((Parameters.data_.centerOnPlayer) ? -50 : ((Camera.OFFSET_SCREEN_RECT.y + (Camera.CENTER_SCREEN_RECT.height / 2)) * 2));
    }

    private function setTranslationToTitle():void {
        this.tX = (this.tY = 0);
    }


}
}//package kabam.rotmg.stage3D
