package com.company.assembleegameclient.ui.dialogs {
import flash.events.Event;

import kabam.rotmg.text.model.TextKey;

public class NotEnoughFameDialog extends Dialog {

    public function NotEnoughFameDialog() {
        super(TextKey.NOT_ENOUGH_FAME_DIALOG_TITLE, TextKey.NOT_ENOUGH_FAME_DIALOG_TEXT, TextKey.NOT_ENOUGH_FAME_DIALOG_LEFTBUTTON, null, "/notEnoughFame");
        addEventListener(LEFT_BUTTON, this.onOk);
    }

    public function onOk(_arg_1:Event):void {
        parent.removeChild(this);
    }


}
}//package com.company.assembleegameclient.ui.dialogs
