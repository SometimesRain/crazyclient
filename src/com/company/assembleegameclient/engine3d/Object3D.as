package com.company.assembleegameclient.engine3d {
import com.company.assembleegameclient.map.Camera;

import flash.display.BitmapData;
import flash.display.IGraphicsData;
import flash.geom.Matrix3D;
import flash.geom.Utils3D;
import flash.geom.Vector3D;

public class Object3D {

    public var model_:Model3D = null;
    public var vL_:Vector.<Number>;
    public var uvts_:Vector.<Number>;
    public var faces_:Vector.<ObjectFace3D>;
    public var vS_:Vector.<Number>;
    public var vW_:Vector.<Number>;
    public var lToW_:Matrix3D;

    public function Object3D(_arg_1:Model3D = null) {
        var _local_2:ModelFace3D;
        this.faces_ = new Vector.<ObjectFace3D>();
        this.vS_ = new Vector.<Number>();
        this.vW_ = new Vector.<Number>();
        this.lToW_ = new Matrix3D();
        super();
        if (_arg_1 != null) {
            this.model_ = _arg_1;
            this.vL_ = this.model_.vL_;
            this.uvts_ = this.model_.uvts_.concat();
            for each (_local_2 in this.model_.faces_) {
                this.faces_.push(new ObjectFace3D(this, _local_2.indicies_, _local_2.useTexture_));
            }
        }
        else {
            this.vL_ = new Vector.<Number>();
            this.uvts_ = new Vector.<Number>();
        }
        this.setPosition(0, 0, 0, 0);
    }

    public static function getObject(_arg_1:String):Object3D {
        var _local_2:Model3D = Model3D.getModel(_arg_1);
        return (new Object3D(_local_2));
    }


    public function dispose():void {
        var _local_1:ObjectFace3D;
        this.vL_ = null;
        this.uvts_ = null;
        for each (_local_1 in this.faces_) {
            _local_1.dispose();
        }
        this.faces_.length = 0;
        this.faces_ = null;
        this.vS_ = null;
        this.vW_ = null;
        this.lToW_ = null;
    }

    public function setPosition(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):void {
        var _local_5:ObjectFace3D;
        this.lToW_.identity();
        this.lToW_.appendRotation(_arg_4, Vector3D.Z_AXIS);
        this.lToW_.appendTranslation(_arg_1, _arg_2, _arg_3);
        this.lToW_.transformVectors(this.vL_, this.vW_);
        for each (_local_5 in this.faces_) {
            _local_5.computeLighting();
        }
    }

    public function getVecW(_arg_1:int):Vector3D {
        var _local_2:int = (_arg_1 * 3);
        if (_local_2 >= this.vW_.length) {
            return (null);
        }
        return (new Vector3D(this.vW_[_local_2], this.vW_[(_local_2 + 1)], this.vW_[(_local_2 + 2)]));
    }

    public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:uint, _arg_4:BitmapData):void {
        var _local_5:ObjectFace3D;
        Utils3D.projectVectors(_arg_2.wToS_, this.vW_, this.vS_, this.uvts_);
        for each (_local_5 in this.faces_) {
            _local_5.draw(_arg_1, _arg_3, _arg_4);
        }
    }


}
}//package com.company.assembleegameclient.engine3d
