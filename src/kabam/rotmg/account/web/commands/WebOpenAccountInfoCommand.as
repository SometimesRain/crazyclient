package kabam.rotmg.account.web.commands {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.web.view.WebAccountDetailDialog;
import kabam.rotmg.account.web.view.WebRegisterDialog;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class WebOpenAccountInfoCommand {

    [Inject]
    public var account:Account;
    [Inject]
    public var openDialog:OpenDialogSignal;


    public function execute():void {
        if (this.account.isRegistered()) {
            this.openDialog.dispatch(new WebAccountDetailDialog());
        }
        else {
            this.openDialog.dispatch(new WebRegisterDialog());
        }
    }


}
}//package kabam.rotmg.account.web.commands
