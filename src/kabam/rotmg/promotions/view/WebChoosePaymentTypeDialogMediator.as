package kabam.rotmg.promotions.view {
import kabam.rotmg.account.core.PaymentData;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.promotions.model.BeginnersPackageModel;
import kabam.rotmg.promotions.signals.MakeBeginnersPackagePaymentSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class WebChoosePaymentTypeDialogMediator extends Mediator {

    [Inject]
    public var view:WebChoosePaymentTypeDialog;
    [Inject]
    public var model:BeginnersPackageModel;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var makePayment:MakeBeginnersPackagePaymentSignal;


    override public function initialize():void {
        this.view.close.add(this.onClose);
        this.view.select.add(this.onSelect);
        this.view.centerOnScreen();
    }

    override public function destroy():void {
        this.view.close.remove(this.onClose);
        this.view.select.remove(this.onSelect);
    }

    private function onClose():void {
        this.closeDialogs.dispatch();
    }

    private function onSelect(_arg_1:String):void {
        var _local_2:PaymentData = new PaymentData();
        _local_2.offer = this.model.getOffer();
        _local_2.paymentMethod = _arg_1;
        this.makePayment.dispatch(_local_2);
        this.closeDialogs.dispatch();
    }


}
}//package kabam.rotmg.promotions.view
