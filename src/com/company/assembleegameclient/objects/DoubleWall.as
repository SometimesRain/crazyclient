package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.engine3d.Face3D;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;
import com.company.util.BitmapUtil;

import flash.display.BitmapData;
import flash.display.IGraphicsData;

public class DoubleWall extends GameObject {

    private static const UVT:Vector.<Number> = new <Number>[0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0];
    private static const UVTHEIGHT:Vector.<Number> = new <Number>[0, 0, 0, 1, 0, 0, 1, 2, 0, 0, 2, 0];
    private static const sqX:Vector.<int> = new <int>[0, 1, 0, -1];
    private static const sqY:Vector.<int> = new <int>[-1, 0, 1, 0];

    public var faces_:Vector.<Face3D>;
    private var topFace_:Face3D = null;
    private var topTexture_:BitmapData = null;

    public function DoubleWall(_arg_1:XML) {
        this.faces_ = new Vector.<Face3D>();
        super(_arg_1);
        hasShadow_ = false;
        var _local_2:TextureData = ObjectLibrary.typeToTopTextureData_[objectType_];
        this.topTexture_ = _local_2.getTexture(0);
    }

    override public function setObjectId(_arg_1:int):void {
        super.setObjectId(_arg_1);
        var _local_2:TextureData = ObjectLibrary.typeToTopTextureData_[objectType_];
        this.topTexture_ = _local_2.getTexture(_arg_1);
    }

    override public function getColor():uint {
        return (BitmapUtil.mostCommonColor(this.topTexture_));
    }

    override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        var _local_6:BitmapData;
        var _local_7:Face3D;
        var _local_8:Square;
        if (texture_ == null) {
            return;
        }
        if (this.faces_.length == 0) {
            this.rebuild3D();
        }
        var _local_4:BitmapData = texture_;
        if (animations_ != null) {
            _local_6 = animations_.getTexture(_arg_3);
            if (_local_6 != null) {
                _local_4 = _local_6;
            }
        }
        var _local_5:int;
        while (_local_5 < this.faces_.length) {
            _local_7 = this.faces_[_local_5];
            _local_8 = map_.lookupSquare((x_ + sqX[_local_5]), (y_ + sqY[_local_5]));
            if ((((((_local_8 == null)) || ((_local_8.texture_ == null)))) || (((((!((_local_8 == null))) && ((_local_8.obj_ is DoubleWall)))) && (!(_local_8.obj_.dead_)))))) {
                _local_7.blackOut_ = true;
            }
            else {
                _local_7.blackOut_ = false;
                if (animations_ != null) {
                    _local_7.setTexture(_local_4);
                }
            }
            _local_7.draw(_arg_1, _arg_2);
            _local_5++;
        }
        this.topFace_.draw(_arg_1, _arg_2);
    }

    public function rebuild3D():void {
        this.faces_.length = 0;
        var _local_1:int = x_;
        var _local_2:int = y_;
        var _local_3:Vector.<Number> = new <Number>[_local_1, _local_2, 2, (_local_1 + 1), _local_2, 2, (_local_1 + 1), (_local_2 + 1), 2, _local_1, (_local_2 + 1), 2];
        this.topFace_ = new Face3D(this.topTexture_, _local_3, UVT, false, true);
        this.topFace_.bitmapFill_.repeat = true;
        this.addWall(_local_1, _local_2, 2, (_local_1 + 1), _local_2, 2);
        this.addWall((_local_1 + 1), _local_2, 2, (_local_1 + 1), (_local_2 + 1), 2);
        this.addWall((_local_1 + 1), (_local_2 + 1), 2, _local_1, (_local_2 + 1), 2);
        this.addWall(_local_1, (_local_2 + 1), 2, _local_1, _local_2, 2);
    }

    private function addWall(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number):void {
        var _local_7:Vector.<Number> = new <Number>[_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_4, _arg_5, (_arg_6 - 2), _arg_1, _arg_2, (_arg_3 - 2)];
        var _local_8:Face3D = new Face3D(texture_, _local_7, UVTHEIGHT, true, true);
        _local_8.bitmapFill_.repeat = true;
        this.faces_.push(_local_8);
    }


}
}//package com.company.assembleegameclient.objects
