package com.company.assembleegameclient.ui.dialogs {
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

import org.osflash.signals.Signal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DialogCloserMediator extends Mediator {

    [Inject]
    public var dialog:DialogCloser;
    [Inject]
    public var closeDialogsSignal:CloseDialogsSignal;
    private var closeSignal:Signal;


    override public function initialize():void {
        this.closeSignal = this.dialog.getCloseSignal();
        this.closeSignal.add(this.onClose);
    }

    private function onClose():void {
        this.closeDialogsSignal.dispatch();
    }

    override public function destroy():void {
        this.closeSignal.remove(this.onClose);
    }


}
}//package com.company.assembleegameclient.ui.dialogs
