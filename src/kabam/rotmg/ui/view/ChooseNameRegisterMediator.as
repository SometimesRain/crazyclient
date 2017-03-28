package kabam.rotmg.ui.view {
import kabam.rotmg.account.core.signals.OpenAccountInfoSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ChooseNameRegisterMediator extends Mediator {

    [Inject]
    public var view:ChooseNameRegisterDialog;
    [Inject]
    public var openAccountManagement:OpenAccountInfoSignal;


    override public function initialize():void {
        this.view.register.add(this.onRegister);
        this.view.cancel.add(this.onCancel);
    }

    override public function destroy():void {
        this.view.register.remove(this.onRegister);
        this.view.cancel.remove(this.onCancel);
    }

    private function onRegister():void {
        this.onCancel();
        this.openAccountManagement.dispatch();
    }

    private function onCancel():void {
        this.view.parent.removeChild(this.view);
    }


}
}//package kabam.rotmg.ui.view
