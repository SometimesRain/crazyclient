package com.company.assembleegameclient.ui.dialogs {
import flash.events.Event;

import org.osflash.signals.Signal;

public class CloseDialogComponent {

    private const closeSignal:Signal = new Signal();

    private var dialog:DialogCloser;
    private var types:Vector.<String>;

    public function CloseDialogComponent() {
        this.types = new Vector.<String>();
        super();
    }

    public function add(_arg_1:DialogCloser, _arg_2:String):void {
        this.dialog = _arg_1;
        this.types.push(_arg_2);
        _arg_1.addEventListener(_arg_2, this.onButtonType);
    }

    private function onButtonType(_arg_1:Event):void {
        var _local_2:String;
        for each (_local_2 in this.types) {
            this.dialog.removeEventListener(_local_2, this.onButtonType);
        }
        this.dialog.getCloseSignal().dispatch();
    }

    public function getCloseSignal():Signal {
        return (this.closeSignal);
    }


}
}//package com.company.assembleegameclient.ui.dialogs
