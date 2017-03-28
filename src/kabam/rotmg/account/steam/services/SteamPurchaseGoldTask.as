package kabam.rotmg.account.steam.services {
import com.company.assembleegameclient.ui.dialogs.DebugDialog;
import com.company.assembleegameclient.util.offer.Offer;

import flash.utils.setTimeout;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.PurchaseGoldTask;
import kabam.rotmg.account.steam.SteamApi;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.signals.MoneyFrameEnableCancelSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.external.command.RequestPlayerCreditsSignal;

import robotlegs.bender.framework.api.ILogger;

public class SteamPurchaseGoldTask extends BaseTask implements PurchaseGoldTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var steam:SteamApi;
    [Inject]
    public var offer:Offer;
    [Inject]
    public var paymentMethod:String;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var moneyFrameEnableCancelSignal:MoneyFrameEnableCancelSignal;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var first:AppEngineClient;
    [Inject]
    public var second:AppEngineClient;
    [Inject]
    public var requestPlayerCredits:RequestPlayerCreditsSignal;


    override protected function startTask():void {
        if(!this.steam.isOverlayEnabled)
        {
            this.logger.debug("isOverlayEnabled false!");
            this.reportError("Can’t process purchase, because Steam Overlay is disabled for the RotMG! To enabled it go to you games library, right click on the \"Realm of the Mad God\" and select \"Properties\" from the drop-down menu. On the \"Properties\" popup, select \"GENERAL\" tab and select option \"Enable the Steam Overlay while in-game\". Next, restart the game and try again.");
        }
        else
        {
            this.logger.debug("SteamPurchaseGoldTask startTask");
            this.steam.paymentAuthorized.addOnce(this.onPaymentAuthorized);
            this.first.setMaxRetries(2);
            this.first.complete.addOnce(this.onComplete);
            this.first.sendRequest("/steamworks/purchaseOffer", {
                "steamid": this.steam.getSteamId(),
                "data": this.offer.data_
            });
        }
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.onPurchaseOfferComplete();
        }
        else {
            this.reportError(_arg_2);
        }
    }

    private function onPurchaseOfferComplete():void {
        this.logger.debug("SteamPurchaseGoldTask purchaseOffer confirmed by AppEngine");
        setTimeout(function ():void {
            moneyFrameEnableCancelSignal.dispatch();
        }, 1100);
    }

    private function onPaymentAuthorized(_arg_1:uint, _arg_2:String, _arg_3:Boolean):void {
        if (_arg_3 == false) {
            this.logger.debug("SteamPurchaseGoldTask payment canceled by user");
            completeTask(true);
            this.second.setMaxRetries(2);
            this.second.sendRequest("/steamworks/finalizePurchase", {
                "appid": _arg_1,
                "orderid": _arg_2,
                "authorized": 0
            });
        }
        else {
            this.logger.debug("SteamPurchaseGoldTask payment authorized by Steam");
            this.second.setMaxRetries(2);
            this.second.complete.addOnce(this.onAuthorized);
            this.second.sendRequest("/steamworks/finalizePurchase", {
                "appid": _arg_1,
                "orderid": _arg_2,
                "authorized": ((_arg_3) ? 1 : 0)
            });
        }
    }

    private function onAuthorized(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.onPurchaseFinalizeComplete();
        }
        else {
            this.reportError(_arg_2);
        }
    }

    private function onPurchaseFinalizeComplete():void {
        this.logger.debug("SteamPurchaseGoldTask purchase finalized");
        this.requestPlayerCredits.dispatch();
        completeTask(true);
    }

    private function reportError(_arg_1:String):void {
        var _local_2:String = ("Error: " + _arg_1);
        this.logger.debug("finalize error {0}", [_local_2]);
        this.openDialog.dispatch(new DebugDialog(_local_2));
        completeTask(false);
    }


}
}//package kabam.rotmg.account.steam.services
