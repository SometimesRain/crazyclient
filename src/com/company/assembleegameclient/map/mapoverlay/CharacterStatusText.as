package com.company.assembleegameclient.map.mapoverlay {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.objects.GameObject;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.geom.Point;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class CharacterStatusText extends Sprite implements IMapOverlayElement {

    public const MAX_DRIFT:int = 40;

    public var go_:GameObject;
    public var offset_:Point;
    public var color_:uint;
    public var lifetime_:int;
    public var offsetTime_:int;
    private var startTime_:int = 0;
    private var textDisplay:TextFieldDisplayConcrete;

    public function CharacterStatusText(_arg_1:GameObject, _arg_2:uint, _arg_3:int, _arg_4:int = 0) {
        this.go_ = _arg_1;
        this.offset_ = new Point(0, (((-(_arg_1.texture_.height) * (_arg_1.size_ / 100)) * 5) - 20));
        this.color_ = _arg_2;
        this.lifetime_ = _arg_3;
        this.offsetTime_ = _arg_4;
        this.textDisplay = new TextFieldDisplayConcrete().setSize(24).setColor(_arg_2).setBold(true);
        this.textDisplay.filters = [new GlowFilter(0, 1, 4, 4, 2, 1)];
        addChild(this.textDisplay);
        visible = false;
    }

    public function draw(_arg_1:Camera, _arg_2:int):Boolean {
        if (this.startTime_ == 0) {
            this.startTime_ = (_arg_2 + this.offsetTime_);
        }
        if (_arg_2 < this.startTime_) {
            visible = false;
            return (true);
        }
        var _local_3:int = (_arg_2 - this.startTime_);
        if ((((_local_3 > this.lifetime_)) || (((!((this.go_ == null))) && ((this.go_.map_ == null)))))) {
            return (false);
        }
        if ((((this.go_ == null)) || (!(this.go_.drawn_)))) {
            visible = false;
            return (true);
        }
        visible = true;
        x = ((((this.go_) != null) ? this.go_.posS_[0] : 0) + (((this.offset_) != null) ? this.offset_.x : 0));
        var _local_4:Number = ((_local_3 / this.lifetime_) * this.MAX_DRIFT);
        y = (((((this.go_) != null) ? this.go_.posS_[1] : 0) + (((this.offset_) != null) ? this.offset_.y : 0)) - _local_4);
        return (true);
    }

    public function getGameObject():GameObject {
        return (this.go_);
    }

    public function dispose():void {
        parent.removeChild(this);
    }

    public function setStringBuilder(_arg_1:StringBuilder):void {
        this.textDisplay.textChanged.add(this.onTextChanged);
        this.textDisplay.setStringBuilder(_arg_1);
    }

    private function onTextChanged():void {
        var _local_2:Bitmap;
        var _local_1:BitmapData = new BitmapData(this.textDisplay.width, this.textDisplay.height, true, 0);
        _local_2 = new Bitmap(_local_1);
        _local_1.draw(this.textDisplay, new Matrix());
        _local_2.x = (_local_2.x - (_local_2.width * 0.5));
        _local_2.y = (_local_2.y - (_local_2.height * 0.5));
        addChild(_local_2);
        removeChild(this.textDisplay);
        this.textDisplay = null;
    }


}
}//package com.company.assembleegameclient.map.mapoverlay
