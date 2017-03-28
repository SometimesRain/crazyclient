package com.company.assembleegameclient.ui.options {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class OptionsTabTitle extends Sprite {

    private static const TEXT_SIZE:int = 16;

    public var text_:String;
    protected var textText_:TextFieldDisplayConcrete;
    protected var selected_:Boolean;

    public function OptionsTabTitle(_arg_1:String) {
        this.text_ = _arg_1;
        this.textText_ = new TextFieldDisplayConcrete().setSize(TEXT_SIZE).setColor(0xB3B3B3);
        this.textText_.setBold(true);
        this.textText_.setStringBuilder(new LineBuilder().setParams(_arg_1));
        this.textText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        addChild(this.textText_);
        this.selected_ = false;
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
    }

    public function setSelected(_arg_1:Boolean):void {
        this.selected_ = _arg_1;
        this.redraw(false);
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.redraw(true);
    }

    private function onRollOut(_arg_1:MouseEvent):void {
        this.redraw(false);
    }

    private function redraw(_arg_1:Boolean):void {
        this.textText_.setSize(TEXT_SIZE);
        this.textText_.setColor(this.getColor(_arg_1));
    }

    private function getColor(_arg_1:Boolean):uint {
        if (this.selected_) {
            return (0xFFC800);
        }
        return (((_arg_1) ? 0xFFFFFF : 0xB3B3B3));
    }


}
}//package com.company.assembleegameclient.ui.options
