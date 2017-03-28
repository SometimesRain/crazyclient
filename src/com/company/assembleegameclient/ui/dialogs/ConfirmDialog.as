package com.company.assembleegameclient.ui.dialogs {
import flash.events.Event;

import kabam.rotmg.core.StaticInjectorContext;

import kabam.rotmg.dialogs.control.CloseDialogsSignal;

public class ConfirmDialog extends StaticDialog {

    private var _callback:Function;

    public function ConfirmDialog(_arg_1:String, _arg_2:String, _arg_3:Function)
    {
        this._callback = _arg_3;
        super(_arg_1, _arg_2, "Cancel", "OK");
        addEventListener(Dialog.LEFT_BUTTON,this.onCancel);
        addEventListener(Dialog.RIGHT_BUTTON,this.onConfirm);
    }

    private function onConfirm(_arg_1:Event):void
    {
        this._callback();
        var __local_2:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
        __local_2.dispatch();
    }

    private function onCancel(_arg_1:Event):void
    {
        var __local_2:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
        __local_2.dispatch();
    }

}
}
