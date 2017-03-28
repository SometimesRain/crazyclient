package com.company.assembleegameclient.account.ui.components {
import com.company.assembleegameclient.account.ui.CreateGuildFrame;

import kabam.rotmg.dialogs.control.CloseDialogsSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CreateGuildFrameMediator extends Mediator {

    [Inject]
    public var view:CreateGuildFrame;
    [Inject]
    public var closeDialog:CloseDialogsSignal;


    override public function initialize():void {
        this.view.close.add(this.onClose);
    }

    override public function destroy():void {
        this.view.close.remove(this.onClose);
    }

    private function onClose():void {
        this.closeDialog.dispatch();
    }


}
}//package com.company.assembleegameclient.account.ui.components
