package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.sound.SoundEffectLibrary;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class ClickableTextBase extends Sprite {

    public var text_:TextFieldDisplayConcrete;
    public var defaultColor_:uint = 0xFFFFFF;

    public function ClickableTextBase(_arg_1:int, _arg_2:Boolean, _arg_3:String) {
        this.text_ = this.makeText().setSize(_arg_1).setColor(0xFFFFFF);
        this.text_.setBold(_arg_2);
        this.text_.setStringBuilder(new LineBuilder().setParams(_arg_3));
        addChild(this.text_);
        this.text_.filters = [new DropShadowFilter(0, 0, 0)];
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        addEventListener(MouseEvent.CLICK, this.onMouseClick);
    }

    public function removeOnHoverEvents():void {
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    protected function makeText():TextFieldDisplayConcrete {
        return (new TextFieldDisplayConcrete());
    }

    public function setAutoSize(_arg_1:String):void {
        this.text_.setAutoSize(_arg_1);
    }

    public function makeStatic(_arg_1:String):void {
        this.text_.setStringBuilder(new LineBuilder().setParams(_arg_1));
        this.setDefaultColor(0xB3B3B3);
        mouseEnabled = false;
        mouseChildren = false;
    }

    public function setColor(_arg_1:uint):void {
        this.text_.setColor(_arg_1);
    }

    public function setDefaultColor(_arg_1:uint):void {
        this.defaultColor_ = _arg_1;
        this.setColor(this.defaultColor_);
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.setColor(16768133);
    }

    private function onMouseOut(_arg_1:MouseEvent):void {
        this.setColor(this.defaultColor_);
    }

    private function onMouseClick(_arg_1:MouseEvent):void {
        SoundEffectLibrary.play("button_click");
    }


}
}//package com.company.assembleegameclient.ui
