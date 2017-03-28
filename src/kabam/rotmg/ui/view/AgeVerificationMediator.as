package kabam.rotmg.ui.view {
import kabam.rotmg.account.core.signals.VerifyAgeSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class AgeVerificationMediator extends Mediator {

    [Inject]
    public var view:AgeVerificationDialog;
    [Inject]
    public var verifyAge:VerifyAgeSignal;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;


    override public function initialize():void {
        this.view.response.add(this.onResponse);
    }

    override public function destroy():void {
        this.view.response.remove(this.onResponse);
    }

    private function onResponse(_arg_1:Boolean):void {
        if (_arg_1) {
            this.handleAccepted();
        }
        else {
            this.handleRejected();
        }
    }

    private function handleAccepted():void {
        this.verifyAge.dispatch();
        this.closeDialogs.dispatch();
    }

    private function handleRejected():void {
        this.closeDialogs.dispatch();
    }


}
}//package kabam.rotmg.ui.view
