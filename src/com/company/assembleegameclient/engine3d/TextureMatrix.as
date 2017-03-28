package com.company.assembleegameclient.engine3d {
import flash.display.BitmapData;
import flash.geom.Matrix;

public class TextureMatrix {

    public var texture_:BitmapData = null;
    public var tToS_:Matrix;
    private var uvMatrix_:Matrix = null;
    private var tempMatrix_:Matrix;

    public function TextureMatrix(_arg_1:BitmapData, _arg_2:Vector.<Number>) {
        this.tToS_ = new Matrix();
        this.tempMatrix_ = new Matrix();
        super();
        this.texture_ = _arg_1;
        this.calculateUVMatrix(_arg_2);
    }

    public function setUVT(_arg_1:Vector.<Number>):void {
        this.calculateUVMatrix(_arg_1);
    }

    public function setVOut(_arg_1:Vector.<Number>):void {
        this.calculateTextureMatrix(_arg_1);
    }

    public function calculateTextureMatrix(_arg_1:Vector.<Number>):void {
        this.tToS_.a = this.uvMatrix_.a;
        this.tToS_.b = this.uvMatrix_.b;
        this.tToS_.c = this.uvMatrix_.c;
        this.tToS_.d = this.uvMatrix_.d;
        this.tToS_.tx = this.uvMatrix_.tx;
        this.tToS_.ty = this.uvMatrix_.ty;
        var _local_2:int = (_arg_1.length - 2);
        var _local_3:int = (_local_2 + 1);
        this.tempMatrix_.a = (_arg_1[2] - _arg_1[0]);
        this.tempMatrix_.b = (_arg_1[3] - _arg_1[1]);
        this.tempMatrix_.c = (_arg_1[_local_2] - _arg_1[0]);
        this.tempMatrix_.d = (_arg_1[_local_3] - _arg_1[1]);
        this.tempMatrix_.tx = _arg_1[0];
        this.tempMatrix_.ty = _arg_1[1];
        this.tToS_.concat(this.tempMatrix_);
    }

    public function calculateUVMatrix(_arg_1:Vector.<Number>):void {
        if (this.texture_ == null) {
            this.uvMatrix_ = null;
            return;
        }
        var _local_2:int = (_arg_1.length - 3);
        var _local_3:Number = (_arg_1[0] * this.texture_.width);
        var _local_4:Number = (_arg_1[1] * this.texture_.height);
        var _local_5:Number = (_arg_1[3] * this.texture_.width);
        var _local_6:Number = (_arg_1[4] * this.texture_.height);
        var _local_7:Number = (_arg_1[_local_2] * this.texture_.width);
        var _local_8:Number = (_arg_1[(_local_2 + 1)] * this.texture_.height);
        var _local_9:Number = (_local_5 - _local_3);
        var _local_10:Number = (_local_6 - _local_4);
        var _local_11:Number = (_local_7 - _local_3);
        var _local_12:Number = (_local_8 - _local_4);
        this.uvMatrix_ = new Matrix(_local_9, _local_10, _local_11, _local_12, _local_3, _local_4);
        this.uvMatrix_.invert();
    }


}
}//package com.company.assembleegameclient.engine3d
