package kabam.rotmg.account.steam.services {
import com.company.assembleegameclient.ui.dialogs.DebugDialog;
import com.company.assembleegameclient.util.offer.Offer;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.PaymentData;
import kabam.rotmg.account.core.services.MakePaymentTask;
import kabam.rotmg.account.steam.SteamApi;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

import robotlegs.bender.framework.api.ILogger;

public class SteamMakePaymentTask extends BaseTask implements MakePaymentTask {

    [Inject]
    public var steam:SteamApi;
    [Inject]
    public var payment:PaymentData;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var second:AppEngineClient;
    private var offer:Offer;


    override protected function startTask():void {
        this.logger.debug("start task");
        this.offer = this.payment.offer;
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/steamworks/purchaseOffer", {
            "steamid": this.steam.getSteamId(),
            "data": this.offer.data_
        });
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.onPurchaseOfferComplete();
        }
        else {
            this.onPurchaseOfferError(_arg_2);
        }
    }

    private function onPurchaseOfferComplete():void {
        this.logger.debug("purchaseOffer complete");
        this.steam.paymentAuthorized.addOnce(this.onPaymentAuthorized);
    }

    private function onPaymentAuthorized(_arg_1:uint, _arg_2:String, _arg_3:Boolean):void {
        this.logger.debug("payment authorized {0},{1},{2}", [_arg_1, _arg_2, _arg_3]);
        this.second.setMaxRetries(2);
        this.client.complete.addOnce(this.onAuthorized);
        this.second.sendRequest("/steamworks/finalizePurchase", {
            "appid": _arg_1,
            "orderid": _arg_2,
            "authorized": ((_arg_3) ? 1 : 0)
        });
    }

    private function onAuthorized(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.onPurchaseFinalizeComplete();
        }
        else {
            this.onPurchaseFinalizeError(_arg_2);
        }
    }

    private function onPurchaseFinalizeComplete():void {
        this.logger.debug("purchaseFinalized complete");
        completeTask(true);
    }

    private function onPurchaseFinalizeError(_arg_1:String):void {
        this.logger.debug("purchaseFinalized error {0}", [_arg_1]);
        this.openDialog.dispatch(new DebugDialog(("Error: " + _arg_1)));
        completeTask(false);
    }

    private function onPurchaseOfferError(_arg_1:String):void {
        this.logger.debug("purchaseOffer request error {0}", [_arg_1]);
        this.openDialog.dispatch(new DebugDialog(("Error: " + _arg_1)));
        completeTask(false);
    }


}
}//package kabam.rotmg.account.steam.services
