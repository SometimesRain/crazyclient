package kabam.rotmg.promotions.commands {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.PaymentData;
import kabam.rotmg.account.core.signals.OpenAccountPaymentSignal;
import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
import kabam.rotmg.account.core.view.RegisterPromptDialog;
import kabam.rotmg.account.kabam.KabamAccount;
import kabam.rotmg.account.web.WebAccount;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.promotions.model.BeginnersPackageModel;
import kabam.rotmg.promotions.signals.MakeBeginnersPackagePaymentSignal;
import kabam.rotmg.text.model.TextKey;

public class BuyBeginnersPackageCommand {

    private static const REGISTER_DIALOG_TEXT:String = TextKey.BUY_BEGINNERS_PACKAGE_COMMAND_REGISTER_DIALOG;//"BuyBeginnersPackageCommand.registerDialog"

    [Inject]
    public var account:Account;
    [Inject]
    public var model:BeginnersPackageModel;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var openAccountPayment:OpenAccountPaymentSignal;
    [Inject]
    public var makePayment:MakeBeginnersPackagePaymentSignal;
    [Inject]
    public var openMoneyWindow:OpenMoneyWindowSignal;


    public function execute():void {
        if (this.account.isRegistered()) {
            this.openAccountSpecificPaymentScreen();
        }
        else {
            this.promptUserToRegisterAndAbort();
        }
    }

    private function openAccountSpecificPaymentScreen():void {
        if ((((this.account is WebAccount)) || ((this.account is KabamAccount)))) {
            this.openMoneyWindow.dispatch();
        }
        else {
            this.makePaymentImmediately();
        }
    }

    private function makePaymentImmediately():void {
        var _local_1:PaymentData = new PaymentData();
        _local_1.offer = this.model.getOffer();
        this.makePayment.dispatch(_local_1);
    }

    private function promptUserToRegisterAndAbort():void {
        this.openDialog.dispatch(new RegisterPromptDialog(REGISTER_DIALOG_TEXT));
    }


}
}//package kabam.rotmg.promotions.commands
