package kabam.rotmg.game.view {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
import kabam.rotmg.account.core.view.RegisterPromptDialog;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.text.model.TextKey;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MoneyChangerPanelMediator extends Mediator {

    [Inject]
    public var account:Account;
    [Inject]
    public var view:MoneyChangerPanel;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var openMoneyWindow:OpenMoneyWindowSignal;


    override public function initialize():void {
        this.view.triggered.add(this.onTriggered);
    }

    override public function destroy():void {
        this.view.triggered.remove(this.onTriggered);
    }

    private function onTriggered():void {
        if (this.account.isRegistered()) {
            this.openMoneyWindow.dispatch();
        }
        else {
            this.openDialog.dispatch(new RegisterPromptDialog(TextKey.MONEY_GOLD_NEED_REGISTRATION));
        }
    }


}
}//package kabam.rotmg.game.view
