package kabam.rotmg.ui.commands {
import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.ui.view.TitleView;

public class ShowTitleUICommand {

    [Inject]
    public var setScreen:SetScreenSignal;
    [Inject]
    public var updateAccount:UpdateAccountInfoSignal;


    public function execute():void {
        this.setScreen.dispatch(new TitleView());
        this.updateAccount.dispatch();
    }


}
}//package kabam.rotmg.ui.commands
