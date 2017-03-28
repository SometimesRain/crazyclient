package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.account.ui.components.Selectable;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.components.RadioButton;

import org.osflash.signals.Signal;

public class PaymentMethodRadioButton extends Sprite implements Selectable {

    public static const HEIGHT:int = 28;

    public const textSet:Signal = new Signal();

    private var label:String;
    private var text:TextFieldDisplayConcrete;
    private var button:RadioButton;

    public function PaymentMethodRadioButton(_arg_1:String) {
        this.label = _arg_1;
        this.makeRadioButton();
        this.makeLabelText();
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
        this.text.textChanged.add(this.onTextChanged);
    }

    private function onTextChanged():void {
        this.text.y = ((this.button.height / 2) - (this.text.height / 2));
        this.textSet.dispatch();
    }

    public function getValue():String {
        return (this.label);
    }

    private function makeRadioButton():void {
        this.button = new RadioButton();
        addChild(this.button);
    }

    private function makeLabelText():void {
        this.text = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setBold(true);
        this.text.setStringBuilder(new LineBuilder().setParams(this.label));
        this.text.filters = [new DropShadowFilter(0, 0, 0)];
        this.text.x = (HEIGHT + 8);
        addChild(this.text);
    }

    public function setSelected(_arg_1:Boolean):void {
        this.button.setSelected(_arg_1);
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.text.setColor(16768133);
    }

    private function onRollOut(_arg_1:MouseEvent):void {
        this.text.setColor(0xFFFFFF);
    }


}
}//package com.company.assembleegameclient.account.ui
