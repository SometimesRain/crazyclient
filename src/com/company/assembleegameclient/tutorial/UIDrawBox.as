package com.company.assembleegameclient.tutorial {
import com.company.util.ConversionUtil;

import flash.display.Graphics;
import flash.geom.Point;
import flash.geom.Rectangle;

public class UIDrawBox {

    public const ANIMATION_MS:int = 500;
    public const ORIGIN:Point = new Point(250, 200);

    public var rect_:Rectangle;
    public var color_:uint;

    public function UIDrawBox(_arg_1:XML) {
        this.rect_ = ConversionUtil.toRectangle(_arg_1);
        this.color_ = uint(_arg_1.@color);
    }

    public function draw(_arg_1:int, _arg_2:Graphics, _arg_3:int):void {
        var _local_4:Number;
        var _local_5:Number;
        var _local_6:Number = (this.rect_.width - _arg_1);
        var _local_7:Number = (this.rect_.height - _arg_1);
        if (_arg_3 < this.ANIMATION_MS) {
            _local_4 = (this.ORIGIN.x + (((this.rect_.x - this.ORIGIN.x) * _arg_3) / this.ANIMATION_MS));
            _local_5 = (this.ORIGIN.y + (((this.rect_.y - this.ORIGIN.y) * _arg_3) / this.ANIMATION_MS));
            _local_6 = (_local_6 * (_arg_3 / this.ANIMATION_MS));
            _local_7 = (_local_7 * (_arg_3 / this.ANIMATION_MS));
        }
        else {
            _local_4 = (this.rect_.x + (_arg_1 / 2));
            _local_5 = (this.rect_.y + (_arg_1 / 2));
        }
        _arg_2.lineStyle(_arg_1, this.color_);
        _arg_2.drawRect(_local_4, _local_5, _local_6, _local_7);
    }


}
}//package com.company.assembleegameclient.tutorial
