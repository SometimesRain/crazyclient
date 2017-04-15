package com.company.assembleegameclient.ui.icons {
import com.company.util.KeyCodes;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

public class SimpleIconButton extends Sprite {

    protected static const mouseOverCT:ColorTransform = new ColorTransform(1, (220 / 0xFF), (133 / 0xFF));
    protected static const disableCT:ColorTransform = new ColorTransform(0.6, 0.6, 0.6, 1);

    public var iconBitmapData_:BitmapData;
    protected var icon_:Bitmap;
    protected var ct_:ColorTransform;

    public function SimpleIconButton(_arg_1:BitmapData) {
        this.iconBitmapData_ = _arg_1;
        this.icon_ = new Bitmap(this.iconBitmapData_);
        addChild(this.icon_);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    public function destroy():void {
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        this.iconBitmapData_ = null;
        this.icon_ = null;
    }
	
	public function changeIcon(_arg_1:BitmapData):void {
		removeChild(icon_);
        iconBitmapData_ = _arg_1;
        icon_ = new Bitmap(this.iconBitmapData_);
        addChild(icon_);
	}

    public function setColorTransform(_arg_1:ColorTransform):void {
        if (_arg_1 == this.ct_) {
            return;
        }
        this.ct_ = _arg_1;
        if (this.ct_ == null) {
            transform.colorTransform = MoreColorUtil.identity;
        }
        else {
            transform.colorTransform = this.ct_;
        }
    }

    protected function onMouseOver(_arg_1:MouseEvent):void {
        this.setColorTransform(mouseOverCT);
    }

    protected function onMouseOut(_arg_1:MouseEvent):void {
        this.setColorTransform(null);
    }

}
}//package com.company.assembleegameclient.ui.icons