package kabam.rotmg.ui.view {
import kabam.rotmg.account.core.signals.OpenAccountInfoSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CharacterSlotRegisterMediator extends Mediator {

    [Inject]
    public var view:CharacterSlotRegisterDialog;
    [Inject]
    public var openAccountManagement:OpenAccountInfoSignal;
    [Inject]
    public var close:CloseDialogsSignal;


    override public function initialize():void {
        this.view.cancel.add(this.onCancel);
        this.view.register.add(this.onRegister);
    }

    override public function destroy():void {
        this.view.cancel.remove(this.onCancel);
        this.view.register.remove(this.onRegister);
    }

    private function onRegister():void {
        this.openAccountManagement.dispatch();
    }

    private function onCancel():void {
        this.close.dispatch();
    }


}
}//package kabam.rotmg.ui.view
