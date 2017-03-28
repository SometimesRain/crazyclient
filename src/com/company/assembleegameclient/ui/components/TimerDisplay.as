package com.company.assembleegameclient.ui.components {
import flash.display.Sprite;

import kabam.lib.util.TimeWriter;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class TimerDisplay extends Sprite {

    private var _textField:TextFieldDisplayConcrete;
    private var stringifier:TimeWriter;

    public function TimerDisplay(_arg_1:TextFieldDisplayConcrete) {
        this.stringifier = new TimeWriter();
        super();
        this.initTextField(_arg_1);
    }

    private function initTextField(_arg_1:TextFieldDisplayConcrete):void {
        addChild((this._textField = _arg_1));
    }

    public function update(_arg_1:Number):void {
        this._textField.setStringBuilder(new StaticStringBuilder(this.stringifier.parseTime(_arg_1)));
    }


}
}//package com.company.assembleegameclient.ui.components
