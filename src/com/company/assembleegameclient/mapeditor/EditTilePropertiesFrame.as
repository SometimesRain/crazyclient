package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.TextInputField;

import flash.events.Event;
import flash.events.MouseEvent;

public class EditTilePropertiesFrame extends Frame {

    public var objectName_:TextInputField;

    public function EditTilePropertiesFrame(_arg_1:String) {
        super("Tile properties", "Cancel", "Save");
        this.objectName_ = new TextInputField("Object Name", false);
        if (_arg_1 != null) {
            this.objectName_.inputText_.text = _arg_1;
        }
        addTextInputField(this.objectName_);
        leftButton_.addEventListener(MouseEvent.CLICK, this.onCancel);
        rightButton_.addEventListener(MouseEvent.CLICK, this.onDone);
    }

    private function onCancel(_arg_1:MouseEvent):void {
        dispatchEvent(new Event(Event.CANCEL));
    }

    private function onDone(_arg_1:MouseEvent):void {
        dispatchEvent(new Event(Event.COMPLETE));
    }


}
}//package com.company.assembleegameclient.mapeditor
