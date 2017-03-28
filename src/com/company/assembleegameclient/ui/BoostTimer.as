package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.ui.components.TimerDisplay;

import flash.display.Sprite;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

import org.osflash.signals.Signal;

public class BoostTimer extends Sprite {

    private var labelTextField:TextFieldDisplayConcrete;
    private var timerDisplay:TimerDisplay;
    public var textChanged:Signal;

    public function BoostTimer() {
        this.createLabelTextField();
        this.textChanged = this.labelTextField.textChanged;
        this.labelTextField.x = 0;
        this.labelTextField.y = 0;
        var _local_1:TextFieldDisplayConcrete = this.returnTimerTextField();
        this.timerDisplay = new TimerDisplay(_local_1);
        this.timerDisplay.x = 0;
        this.timerDisplay.y = 20;
        addChild(this.timerDisplay);
        addChild(this.labelTextField);
    }

    private function returnTimerTextField():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete;
        _local_1 = new TextFieldDisplayConcrete().setSize(16).setColor(16777103);
        _local_1.setBold(true);
        _local_1.setMultiLine(true);
        _local_1.mouseEnabled = true;
        _local_1.filters = [new DropShadowFilter(0, 0, 0)];
        return (_local_1);
    }

    private function createLabelTextField():void {
        this.labelTextField = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF);
        this.labelTextField.setMultiLine(true);
        this.labelTextField.mouseEnabled = true;
        this.labelTextField.filters = [new DropShadowFilter(0, 0, 0)];
    }

    public function setLabelBuilder(_arg_1:StringBuilder):void {
        this.labelTextField.setStringBuilder(_arg_1);
    }

    public function setTime(_arg_1:Number):void {
        this.timerDisplay.update(_arg_1);
    }


}
}//package com.company.assembleegameclient.ui
