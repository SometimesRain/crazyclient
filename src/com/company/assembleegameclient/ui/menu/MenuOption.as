package com.company.assembleegameclient.ui.menu {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.CachingColorTransformer;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class MenuOption extends Sprite {

    protected static const mouseOverCT:ColorTransform = new ColorTransform(1, (220 / 0xFF), (133 / 0xFF));

    protected var origIconBitmapData_:BitmapData;
    protected var iconBitmapData_:BitmapData;
    protected var icon_:Bitmap;
    protected var text_:TextFieldDisplayConcrete;
    protected var ct_:ColorTransform = null;

    public function MenuOption(_arg_1:BitmapData, _arg_2:uint, _arg_3:String) {
        this.origIconBitmapData_ = _arg_1;
        this.iconBitmapData_ = TextureRedrawer.redraw(_arg_1, this.redrawSize(), true, 0);
        this.icon_ = new Bitmap(this.iconBitmapData_);
        this.icon_.filters = [new DropShadowFilter(0, 0, 0)];
        this.icon_.x = -12;
        this.icon_.y = -15;
        addChild(this.icon_);
        this.text_ = new TextFieldDisplayConcrete().setSize(18).setColor(_arg_2);
        this.text_.setBold(true);
        this.text_.setStringBuilder(new LineBuilder().setParams(_arg_3));
        this.text_.filters = [new DropShadowFilter(0, 0, 0)];
        this.text_.x = 20;
        this.text_.y = -6;
        addChild(this.text_);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    public function setColorTransform(_arg_1:ColorTransform):void {
        var _local_2:BitmapData;
        if (_arg_1 == this.ct_) {
            return;
        }
        this.ct_ = _arg_1;
        if (this.ct_ == null) {
            this.icon_.bitmapData = this.iconBitmapData_;
            this.text_.transform.colorTransform = MoreColorUtil.identity;
        }
        else {
            _local_2 = CachingColorTransformer.transformBitmapData(this.origIconBitmapData_, this.ct_);
            _local_2 = TextureRedrawer.redraw(_local_2, this.redrawSize(), true, 0);
            this.icon_.bitmapData = _local_2;
            this.text_.transform.colorTransform = this.ct_;
        }
    }

    protected function onMouseOver(_arg_1:MouseEvent):void {
        this.setColorTransform(mouseOverCT);
    }

    protected function onMouseOut(_arg_1:MouseEvent):void {
        this.setColorTransform(null);
    }

    protected function redrawSize():int {
        return ((40 / (this.origIconBitmapData_.width / 8)));
    }


}
}//package com.company.assembleegameclient.ui.menu
