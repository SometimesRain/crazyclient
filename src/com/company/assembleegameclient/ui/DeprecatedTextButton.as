package com.company.assembleegameclient.ui {
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;

public class DeprecatedTextButton extends TextButtonBase {

    public const textChanged:Signal = new Signal();

    public function DeprecatedTextButton(_arg_1:int, _arg_2:String, _arg_3:int = 0, _arg_4:Boolean = false) {
        super(_arg_3);
        addText(_arg_1);
        if (_arg_4) {
            text_.setStringBuilder(new StaticStringBuilder(_arg_2));
        }
        else {
            text_.setStringBuilder(new LineBuilder().setParams(_arg_2));
        }
        text_.textChanged.addOnce(this.onTextChanged);
    }

    protected function onTextChanged():void {
        initText();
        this.textChanged.dispatch();
    }


}
}//package com.company.assembleegameclient.ui
