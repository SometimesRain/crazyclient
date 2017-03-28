package kabam.rotmg.account.core.control {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.view.RegisterPromptDialog;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

import robotlegs.bender.framework.api.IGuard;

public class IsAccountRegisteredGuard implements IGuard {

    [Inject]
    public var account:Account;
    [Inject]
    public var openDialog:OpenDialogSignal;


    public function approve():Boolean {
        var _local_1:Boolean = this.account.isRegistered();
        ((_local_1) || (this.enterRegisterFlow()));
        return (_local_1);
    }

    protected function getString():String {
        return ("");
    }

    private function enterRegisterFlow():void {
        this.openDialog.dispatch(new RegisterPromptDialog(this.getString()));
    }


}
}//package kabam.rotmg.account.core.control
