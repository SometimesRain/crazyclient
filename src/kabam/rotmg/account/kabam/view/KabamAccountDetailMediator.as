package kabam.rotmg.account.kabam.view {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class KabamAccountDetailMediator extends Mediator {

    [Inject]
    public var account:Account;
    [Inject]
    public var view:KabamAccountDetailDialog;
    [Inject]
    public var closeDialog:CloseDialogsSignal;


    override public function initialize():void {
        this.view.done.add(this.onDone);
        this.view.setInfo(this.account.getUserName());
    }

    override public function destroy():void {
        this.view.done.remove(this.onDone);
    }

    private function onDone():void {
        this.closeDialog.dispatch();
    }


}
}//package kabam.rotmg.account.kabam.view
