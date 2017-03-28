package kabam.rotmg.account.core.commands {
import kabam.rotmg.account.core.view.MoneyFrame;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class InternalOpenMoneyWindowCommand {

    [Inject]
    public var openDialog:OpenDialogSignal;


    public function execute():void {
        this.openDialog.dispatch(new MoneyFrame());
    }


}
}//package kabam.rotmg.account.core.commands
