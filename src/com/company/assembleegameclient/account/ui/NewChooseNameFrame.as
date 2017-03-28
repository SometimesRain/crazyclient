package com.company.assembleegameclient.account.ui {
import flash.events.MouseEvent;

import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class NewChooseNameFrame extends Frame {

    public const choose:Signal = new Signal();
    public const cancel:Signal = new Signal();

    private var name_:TextInputField;

    public function NewChooseNameFrame() {
        super(TextKey.CHOOSE_NAME_TITLE, TextKey.FRAME_CANCEL, TextKey.CHOOSE_NAME_CHOOSE);
        this.name_ = new TextInputField(TextKey.NEWCHOOSENAMEFRAME_NAME, false);
        this.name_.inputText_.restrict = "A-Za-z";
        var _local_1:int = 10;
        this.name_.inputText_.maxChars = _local_1;
        addTextInputField(this.name_);
        addPlainText(TextKey.FRAME_MAX_CHAR, {"maxChars": _local_1});
        addPlainText(TextKey.FRAME_RESTRICT_CHAR);
        addPlainText(TextKey.CHOOSE_NAME_WARNING);
        leftButton_.addEventListener(MouseEvent.CLICK, this.onCancel);
        rightButton_.addEventListener(MouseEvent.CLICK, this.onChoose);
    }

    private function onChoose(_arg_1:MouseEvent):void {
        this.choose.dispatch(this.name_.text());
    }

    private function onCancel(_arg_1:MouseEvent):void {
        this.cancel.dispatch();
    }

    public function setError(_arg_1:String):void {
        this.name_.setError(_arg_1);
    }


}
}//package com.company.assembleegameclient.account.ui
