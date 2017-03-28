package kabam.rotmg.account.kongregate.view {
import kabam.rotmg.account.core.signals.RegisterAccountSignal;
import kabam.rotmg.account.core.view.RegisterWebAccountDialog;
import kabam.rotmg.account.web.model.AccountData;

import robotlegs.bender.bundles.mvcs.Mediator;

public class KongregateRegisterWebAccountMediator extends Mediator {

    [Inject]
    public var view:RegisterWebAccountDialog;
    [Inject]
    public var register:RegisterAccountSignal;


    override public function initialize():void {
        this.view.register.add(this.onRegister);
    }

    override public function destroy():void {
        this.view.register.remove(this.onRegister);
    }

    private function onRegister(_arg_1:AccountData):void {
        this.register.dispatch(_arg_1);
    }


}
}//package kabam.rotmg.account.kongregate.view
