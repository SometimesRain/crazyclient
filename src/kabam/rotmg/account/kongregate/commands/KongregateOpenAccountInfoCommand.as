package kabam.rotmg.account.kongregate.commands {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.kongregate.view.KongregateAccountDetailDialog;
import kabam.rotmg.account.kongregate.view.KongregateApi;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class KongregateOpenAccountInfoCommand {

    [Inject]
    public var account:Account;
    [Inject]
    public var api:KongregateApi;
    [Inject]
    public var openDialog:OpenDialogSignal;


    public function execute():void {
        if (this.account.isRegistered()) {
            this.openDialog.dispatch(new KongregateAccountDetailDialog());
        }
        else {
            this.api.showRegistrationDialog();
        }
    }


}
}//package kabam.rotmg.account.kongregate.commands
