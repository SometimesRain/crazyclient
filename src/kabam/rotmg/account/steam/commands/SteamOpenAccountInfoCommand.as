package kabam.rotmg.account.steam.commands {
import kabam.rotmg.account.steam.view.SteamAccountDetailDialog;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class SteamOpenAccountInfoCommand {

    [Inject]
    public var openDialog:OpenDialogSignal;


    public function execute():void {
        this.openDialog.dispatch(new SteamAccountDetailDialog());
    }


}
}//package kabam.rotmg.account.steam.commands
