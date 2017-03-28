package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.engine3d.ObjectFace3D;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;
import flash.geom.Vector3D;

import kabam.rotmg.stage3D.GraphicsFillExtra;

public class ConnectedWall extends ConnectedObject {

    protected var objectXML_:XML;
    protected var bI_:Number = 0.5;
    protected var tI_:Number = 0.25;
    protected var h_:Number = 1;
    protected var wallRepeat_:Boolean;
    protected var topRepeat_:Boolean;

    public function ConnectedWall(_arg_1:XML) {
        super(_arg_1);
        this.objectXML_ = _arg_1;
        if (_arg_1.hasOwnProperty("BaseIndent")) {
            this.bI_ = (0.5 - Number(_arg_1.BaseIndent));
        }
        if (_arg_1.hasOwnProperty("TopIndent")) {
            this.tI_ = (0.5 - Number(_arg_1.TopIndent));
        }
        if (_arg_1.hasOwnProperty("Height")) {
            this.h_ = Number(_arg_1.Height);
        }
        this.wallRepeat_ = !(_arg_1.hasOwnProperty("NoWallTextureRepeat"));
        this.topRepeat_ = !(_arg_1.hasOwnProperty("NoTopTextureRepeat"));
    }

    override protected function buildDot():void {
        var _local_1:Vector3D = new Vector3D(-(this.bI_), -(this.bI_), 0);
        var _local_2:Vector3D = new Vector3D(this.bI_, -(this.bI_), 0);
        var _local_3:Vector3D = new Vector3D(this.bI_, this.bI_, 0);
        var _local_4:Vector3D = new Vector3D(-(this.bI_), this.bI_, 0);
        var _local_5:Vector3D = new Vector3D(-(this.tI_), -(this.tI_), this.h_);
        var _local_6:Vector3D = new Vector3D(this.tI_, -(this.tI_), this.h_);
        var _local_7:Vector3D = new Vector3D(this.tI_, this.tI_, this.h_);
        var _local_8:Vector3D = new Vector3D(-(this.tI_), this.tI_, this.h_);
        this.addQuad(_local_6, _local_5, _local_1, _local_2, texture_, true, true);
        this.addQuad(_local_7, _local_6, _local_2, _local_3, texture_, true, true);
        this.addQuad(_local_5, _local_8, _local_4, _local_1, texture_, true, true);
        this.addQuad(_local_8, _local_7, _local_3, _local_4, texture_, true, true);
        var _local_9:BitmapData = texture_;
        if (this.objectXML_.hasOwnProperty("DotTexture")) {
            _local_9 = AssetLibrary.getImageFromSet(String(this.objectXML_.DotTexture.File), int(this.objectXML_.DotTexture.Index));
        }
        this.addTop([_local_5, _local_6, _local_7, _local_8], new <Number>[0.25, 0.25, 0.75, 0.25, 0.25, 0.75], _local_9);
    }

    override protected function buildShortLine():void {
        var _local_1:Vector3D = new Vector3D(-(this.bI_), -0.5, 0);
        var _local_2:Vector3D = new Vector3D(this.bI_, -0.5, 0);
        var _local_3:Vector3D = new Vector3D(this.bI_, this.bI_, 0);
        var _local_4:Vector3D = new Vector3D(-(this.bI_), this.bI_, 0);
        var _local_5:Vector3D = new Vector3D(-(this.tI_), -0.5, this.h_);
        var _local_6:Vector3D = new Vector3D(this.tI_, -0.5, this.h_);
        var _local_7:Vector3D = new Vector3D(this.tI_, this.tI_, this.h_);
        var _local_8:Vector3D = new Vector3D(-(this.tI_), this.tI_, this.h_);
        this.addQuad(_local_7, _local_6, _local_2, _local_3, texture_, true, false);
        this.addQuad(_local_5, _local_8, _local_4, _local_1, texture_, false, true);
        this.addQuad(_local_8, _local_7, _local_3, _local_4, texture_, true, true);
        var _local_9:BitmapData = texture_;
        if (this.objectXML_.hasOwnProperty("ShortLineTexture")) {
            _local_9 = AssetLibrary.getImageFromSet(String(this.objectXML_.ShortLineTexture.File), int(this.objectXML_.ShortLineTexture.Index));
        }
        this.addTop([_local_5, _local_6, _local_7, _local_8], new <Number>[0.25, 0, 0.75, 0, 0.25, 0.75], _local_9);
    }

    override protected function buildL():void {
        var _local_1:Vector3D = new Vector3D(-(this.bI_), -0.5, 0);
        var _local_2:Vector3D = new Vector3D(this.bI_, -0.5, 0);
        var _local_3:Vector3D = new Vector3D(this.bI_, -(this.bI_), 0);
        var _local_4:Vector3D = new Vector3D(0.5, -(this.bI_), 0);
        var _local_5:Vector3D = new Vector3D(0.5, this.bI_, 0);
        var _local_6:Vector3D = new Vector3D(-(this.bI_), this.bI_, 0);
        var _local_7:Vector3D = new Vector3D(-(this.tI_), -0.5, this.h_);
        var _local_8:Vector3D = new Vector3D(this.tI_, -0.5, this.h_);
        var _local_9:Vector3D = new Vector3D(this.tI_, -(this.tI_), this.h_);
        var _local_10:Vector3D = new Vector3D(0.5, -(this.tI_), this.h_);
        var _local_11:Vector3D = new Vector3D(0.5, this.tI_, this.h_);
        var _local_12:Vector3D = new Vector3D(-(this.tI_), this.tI_, this.h_);
        this.addBit(_local_9, _local_8, _local_2, _local_3, texture_, N2, true, true, true);
        this.addBit(_local_10, _local_9, _local_3, _local_4, texture_, N2, false, true, false);
        this.addQuad(_local_12, _local_11, _local_5, _local_6, texture_, true, false);
        this.addQuad(_local_7, _local_12, _local_6, _local_1, texture_, false, true);
        var _local_13:BitmapData = texture_;
        if (this.objectXML_.hasOwnProperty("LTexture")) {
            _local_13 = AssetLibrary.getImageFromSet(String(this.objectXML_.LTexture.File), int(this.objectXML_.LTexture.Index));
        }
        this.addTop([_local_7, _local_8, _local_9, _local_10, _local_11, _local_12], new <Number>[0.25, 0, 0.75, 0, 0.25, 0.75], _local_13);
    }

    override protected function buildLine():void {
        var _local_1:Vector3D = new Vector3D(-(this.bI_), -0.5, 0);
        var _local_2:Vector3D = new Vector3D(this.bI_, -0.5, 0);
        var _local_3:Vector3D = new Vector3D(this.bI_, 0.5, 0);
        var _local_4:Vector3D = new Vector3D(-(this.bI_), 0.5, 0);
        var _local_5:Vector3D = new Vector3D(-(this.tI_), -0.5, this.h_);
        var _local_6:Vector3D = new Vector3D(this.tI_, -0.5, this.h_);
        var _local_7:Vector3D = new Vector3D(this.tI_, 0.5, this.h_);
        var _local_8:Vector3D = new Vector3D(-(this.tI_), 0.5, this.h_);
        this.addQuad(_local_7, _local_6, _local_2, _local_3, texture_, false, false);
        this.addQuad(_local_5, _local_8, _local_4, _local_1, texture_, false, false);
        var _local_9:BitmapData = texture_;
        if (this.objectXML_.hasOwnProperty("LineTexture")) {
            _local_9 = AssetLibrary.getImageFromSet(String(this.objectXML_.LineTexture.File), int(this.objectXML_.LineTexture.Index));
        }
        this.addTop([_local_5, _local_6, _local_7, _local_8], new <Number>[0.25, 0, 0.75, 0, 0.25, 1], _local_9);
    }

    override protected function buildT():void {
        var _local_1:Vector3D = new Vector3D(-(this.bI_), -0.5, 0);
        var _local_2:Vector3D = new Vector3D(this.bI_, -0.5, 0);
        var _local_3:Vector3D = new Vector3D(this.bI_, -(this.bI_), 0);
        var _local_4:Vector3D = new Vector3D(0.5, -(this.bI_), 0);
        var _local_5:Vector3D = new Vector3D(0.5, this.bI_, 0);
        var _local_6:Vector3D = new Vector3D(-0.5, this.bI_, 0);
        var _local_7:Vector3D = new Vector3D(-0.5, -(this.bI_), 0);
        var _local_8:Vector3D = new Vector3D(-(this.bI_), -(this.bI_), 0);
        var _local_9:Vector3D = new Vector3D(-(this.tI_), -0.5, this.h_);
        var _local_10:Vector3D = new Vector3D(this.tI_, -0.5, this.h_);
        var _local_11:Vector3D = new Vector3D(this.tI_, -(this.tI_), this.h_);
        var _local_12:Vector3D = new Vector3D(0.5, -(this.tI_), this.h_);
        var _local_13:Vector3D = new Vector3D(0.5, this.tI_, this.h_);
        var _local_14:Vector3D = new Vector3D(-0.5, this.tI_, this.h_);
        var _local_15:Vector3D = new Vector3D(-0.5, -(this.tI_), this.h_);
        var _local_16:Vector3D = new Vector3D(-(this.tI_), -(this.tI_), this.h_);
        this.addBit(_local_11, _local_10, _local_2, _local_3, texture_, N2, true);
        this.addBit(_local_12, _local_11, _local_3, _local_4, texture_, N2, false);
        this.addQuad(_local_14, _local_13, _local_5, _local_6, texture_, false, false);
        this.addBit(_local_16, _local_15, _local_7, _local_8, texture_, N0, true);
        this.addBit(_local_9, _local_16, _local_8, _local_1, texture_, N0, false);
        var _local_17:BitmapData = texture_;
        if (this.objectXML_.hasOwnProperty("TTexture")) {
            _local_17 = AssetLibrary.getImageFromSet(String(this.objectXML_.TTexture.File), int(this.objectXML_.TTexture.Index));
        }
        this.addTop([_local_9, _local_10, _local_11, _local_12, _local_13, _local_14, _local_15, _local_16], new <Number>[0.25, 0, 0.75, 0, 0.25, 0.25], _local_17);
    }

    override protected function buildCross():void {
        var _local_1:Vector3D = new Vector3D(-(this.bI_), -0.5, 0);
        var _local_2:Vector3D = new Vector3D(this.bI_, -0.5, 0);
        var _local_3:Vector3D = new Vector3D(this.bI_, -(this.bI_), 0);
        var _local_4:Vector3D = new Vector3D(0.5, -(this.bI_), 0);
        var _local_5:Vector3D = new Vector3D(0.5, this.bI_, 0);
        var _local_6:Vector3D = new Vector3D(this.bI_, this.bI_, 0);
        var _local_7:Vector3D = new Vector3D(this.bI_, 0.5, 0);
        var _local_8:Vector3D = new Vector3D(-(this.bI_), 0.5, 0);
        var _local_9:Vector3D = new Vector3D(-(this.bI_), this.bI_, 0);
        var _local_10:Vector3D = new Vector3D(-0.5, this.bI_, 0);
        var _local_11:Vector3D = new Vector3D(-0.5, -(this.bI_), 0);
        var _local_12:Vector3D = new Vector3D(-(this.bI_), -(this.bI_), 0);
        var _local_13:Vector3D = new Vector3D(-(this.tI_), -0.5, this.h_);
        var _local_14:Vector3D = new Vector3D(this.tI_, -0.5, this.h_);
        var _local_15:Vector3D = new Vector3D(this.tI_, -(this.tI_), this.h_);
        var _local_16:Vector3D = new Vector3D(0.5, -(this.tI_), this.h_);
        var _local_17:Vector3D = new Vector3D(0.5, this.tI_, this.h_);
        var _local_18:Vector3D = new Vector3D(this.tI_, this.tI_, this.h_);
        var _local_19:Vector3D = new Vector3D(this.tI_, 0.5, this.h_);
        var _local_20:Vector3D = new Vector3D(-(this.tI_), 0.5, this.h_);
        var _local_21:Vector3D = new Vector3D(-(this.tI_), this.tI_, this.h_);
        var _local_22:Vector3D = new Vector3D(-0.5, this.tI_, this.h_);
        var _local_23:Vector3D = new Vector3D(-0.5, -(this.tI_), this.h_);
        var _local_24:Vector3D = new Vector3D(-(this.tI_), -(this.tI_), this.h_);
        this.addBit(_local_15, _local_14, _local_2, _local_3, texture_, N2, true);
        this.addBit(_local_16, _local_15, _local_3, _local_4, texture_, N2, false);
        this.addBit(_local_18, _local_17, _local_5, _local_6, texture_, N4, true);
        this.addBit(_local_19, _local_18, _local_6, _local_7, texture_, N4, false);
        this.addBit(_local_21, _local_20, _local_8, _local_9, texture_, N6, true);
        this.addBit(_local_22, _local_21, _local_9, _local_10, texture_, N6, false);
        this.addBit(_local_24, _local_23, _local_11, _local_12, texture_, N0, true);
        this.addBit(_local_13, _local_24, _local_12, _local_1, texture_, N0, false);
        var _local_25:BitmapData = texture_;
        if (this.objectXML_.hasOwnProperty("CrossTexture")) {
            _local_25 = AssetLibrary.getImageFromSet(String(this.objectXML_.CrossTexture.File), int(this.objectXML_.CrossTexture.Index));
        }
        this.addTop([_local_13, _local_14, _local_15, _local_16, _local_17, _local_18, _local_19, _local_20, _local_21, _local_22, _local_23, _local_24], new <Number>[0.25, 0, 0.75, 0, 0.25, 0.25], _local_25);
    }

    protected function addQuad(_arg_1:Vector3D, _arg_2:Vector3D, _arg_3:Vector3D, _arg_4:Vector3D, _arg_5:BitmapData, _arg_6:Boolean, _arg_7:Boolean):void {
        var _local_11:Number;
        var _local_12:Number;
        var _local_13:Vector.<Number>;
        var _local_8:int = (obj3D_.vL_.length / 3);
        obj3D_.vL_.push(_arg_1.x, _arg_1.y, _arg_1.z, _arg_2.x, _arg_2.y, _arg_2.z, _arg_3.x, _arg_3.y, _arg_3.z, _arg_4.x, _arg_4.y, _arg_4.z);
        var _local_9:Number = ((_arg_6) ? (-((this.bI_ - this.tI_)) / ((1 - (this.bI_ - this.tI_)) - ((_arg_7) ? (this.bI_ - this.tI_) : 0))) : 0);
        obj3D_.uvts_.push(0, 0, 0, 1, 0, 0, 1, 1, 0, _local_9, 1, 0);
        var _local_10:ObjectFace3D = new ObjectFace3D(obj3D_, new <int>[_local_8, (_local_8 + 1), (_local_8 + 2), (_local_8 + 3)]);
        _local_10.texture_ = _arg_5;
        _local_10.bitmapFill_.repeat = this.wallRepeat_;
        obj3D_.faces_.push(_local_10);
        if ((((GraphicsFillExtra.getVertexBuffer(_local_10.bitmapFill_) == null)) && (Parameters.isGpuRender()))) {
            _local_11 = 0;
            _local_12 = 0;
            if (_arg_6) {
                _local_11 = _local_9;
            }
            if (_arg_7) {
                _local_12 = -(_local_9);
            }
            if ((((((((_local_12 == 0)) && ((_local_11 == 0)))) && (_arg_7))) && ((_arg_4.x == -0.5)))) {
                _local_12 = 0.34;
            }
            _local_13 = Vector.<Number>([-0.5, 0.5, 0, 0, 0, 0.5, 0.5, 0, 1, 0, (-0.5 + _local_11), -0.5, 0, 0, 1, (0.5 + _local_12), -0.5, 0, 1, 1]);
            GraphicsFillExtra.setVertexBuffer(_local_10.bitmapFill_, _local_13);
        }
    }

    protected function addBit(_arg_1:Vector3D, _arg_2:Vector3D, _arg_3:Vector3D, _arg_4:Vector3D, _arg_5:BitmapData, _arg_6:Vector3D, _arg_7:Boolean, _arg_8:Boolean = false, _arg_9:Boolean = false):void {
        var _local_12:Vector.<Number>;
        var _local_10:int = (obj3D_.vL_.length / 3);
        obj3D_.vL_.push(_arg_1.x, _arg_1.y, _arg_1.z, _arg_2.x, _arg_2.y, _arg_2.z, _arg_3.x, _arg_3.y, _arg_3.z, _arg_4.x, _arg_4.y, _arg_4.z);
        if (_arg_7) {
            obj3D_.uvts_.push((-0.5 + this.tI_), 0, 0, 0, 0, 0, 0, 0, 0, (-0.5 + this.bI_), 1, 0);
        }
        else {
            obj3D_.uvts_.push(1, 0, 0, (1.5 - this.tI_), 0, 0, 0, 0, 0, 1, 1, 0);
        }
        var _local_11:ObjectFace3D = new ObjectFace3D(obj3D_, new <int>[_local_10, (_local_10 + 1), (_local_10 + 2), (_local_10 + 3)]);
        _local_11.texture_ = _arg_5;
        _local_11.bitmapFill_.repeat = this.wallRepeat_;
        _local_11.normalL_ = _arg_6;
        if (((!(Parameters.isGpuRender())) && (!(_arg_8)))) {
            obj3D_.faces_.push(_local_11);
        }
        else {
            if (_arg_8) {
                if (_arg_9) {
                    _local_12 = Vector.<Number>([-0.75, 0.5, 0, 0, 0, -0.5, 0.5, 0, 1, 0, -0.75, -0.5, 0, 0, 1, -0.5, -0.5, 0, 1, 1]);
                }
                else {
                    _local_12 = Vector.<Number>([0.5, 0.5, 0, 0, 0, 0.75, 0.5, 0, 1, 0, 0.5, -0.5, 0, 0, 1, 0.75, -0.5, 0, 1, 1]);
                }
                GraphicsFillExtra.setVertexBuffer(_local_11.bitmapFill_, _local_12);
                obj3D_.faces_.push(_local_11);
            }
        }
    }

    protected function addTop(_arg_1:Array, _arg_2:Vector.<Number>, _arg_3:BitmapData):void {
        var _local_8:ObjectFace3D;
        var _local_10:Vector.<Number>;
        var _local_11:int;
        var _local_12:Array;
        var _local_13:Array;
        var _local_14:Array;
        var _local_15:int;
        var _local_16:int;
        var _local_17:int;
        var _local_4:int = (obj3D_.vL_.length / 3);
        var _local_5:Vector.<int> = new Vector.<int>();
        var _local_6:uint;
        while (_local_6 < _arg_1.length) {
            obj3D_.vL_.push(_arg_1[_local_6].x, _arg_1[_local_6].y, _arg_1[_local_6].z);
            _local_5.push((_local_4 + _local_6));
            if (_local_6 == 0) {
                obj3D_.uvts_.push(_arg_2[0], _arg_2[1], 0);
            }
            else {
                if (_local_6 == 1) {
                    obj3D_.uvts_.push(_arg_2[2], _arg_2[3], 0);
                }
                else {
                    if (_local_6 == (_arg_1.length - 1)) {
                        obj3D_.uvts_.push(_arg_2[4], _arg_2[5], 0);
                    }
                    else {
                        obj3D_.uvts_.push(0, 0, 0);
                    }
                }
            }
            _local_6++;
        }
        var _local_7:ObjectFace3D = new ObjectFace3D(obj3D_, _local_5);
        _local_7.texture_ = _arg_3;
        _local_7.bitmapFill_.repeat = this.topRepeat_;
        obj3D_.faces_.push(_local_7);
        if ((((_local_5.length == 6)) && (Parameters.isGpuRender()))) {
            _local_8 = new ObjectFace3D(obj3D_, _local_5);
            _local_8.texture_ = _arg_3;
            _local_8.bitmapFill_.repeat = this.topRepeat_;
            obj3D_.faces_.push(_local_8);
        }
        var _local_9:int;
        if ((((((_local_5.length == 4)) && ((GraphicsFillExtra.getVertexBuffer(_local_7.bitmapFill_) == null)))) && (Parameters.isGpuRender()))) {
            _local_10 = new Vector.<Number>();
            _local_9 = 0;
            while (_local_9 < _local_5.length) {
                if (_local_9 == 3) {
                    _local_11 = 2;
                }
                else {
                    if (_local_9 == 2) {
                        _local_11 = 3;
                    }
                    else {
                        _local_11 = _local_9;
                    }
                }
                _local_10.push(obj3D_.vL_[(_local_5[_local_11] * 3)], (obj3D_.vL_[((_local_5[_local_11] * 3) + 1)] * -1), obj3D_.vL_[((_local_5[_local_11] * 3) + 2)], obj3D_.uvts_[(_local_5[(((_local_11) != 2) ? _local_11 : (_local_11 - 1))] * 3)], obj3D_.uvts_[((_local_5[(((_local_11) != 2) ? _local_11 : (_local_11 + 1))] * 3) + 1)]);
                _local_9++;
            }
            GraphicsFillExtra.setVertexBuffer(_local_7.bitmapFill_, _local_10);
        }
        else {
            if ((((((_local_5.length == 6)) && ((GraphicsFillExtra.getVertexBuffer(_local_7.bitmapFill_) == null)))) && (Parameters.isGpuRender()))) {
                _local_12 = [0, 1, 5, 2];
                _local_13 = [2, 3, 5, 4];
                _local_14 = [5, 0, 2, 1];
                _local_15 = 0;
                while (_local_15 < 2) {
                    if (_local_15 == 1) {
                        _local_12 = _local_13;
                    }
                    _local_10 = new Vector.<Number>();
                    _local_16 = 0;
                    _local_17 = 0;
                    for each (_local_9 in _local_12) {
                        if (_local_15 == 1) {
                            _local_17 = _local_14[_local_16];
                        }
                        else {
                            _local_17 = _local_9;
                        }
                        _local_10.push(obj3D_.vL_[(_local_5[_local_9] * 3)], (obj3D_.vL_[((_local_5[_local_9] * 3) + 1)] * -1), obj3D_.vL_[((_local_5[_local_9] * 3) + 2)], obj3D_.uvts_[(_local_5[(((_local_17) != 2) ? _local_17 : (_local_17 - 1))] * 3)], obj3D_.uvts_[((_local_5[(((_local_17) != 2) ? _local_17 : (_local_17 + 1))] * 3) + 1)]);
                        _local_16++;
                    }
                    if (_local_15 == 1) {
                        GraphicsFillExtra.setVertexBuffer(_local_8.bitmapFill_, _local_10);
                    }
                    else {
                        GraphicsFillExtra.setVertexBuffer(_local_7.bitmapFill_, _local_10);
                    }
                    _local_15++;
                }
            }
        }
    }


}
}//package com.company.assembleegameclient.objects
