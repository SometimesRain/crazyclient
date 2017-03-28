package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;
import com.company.assembleegameclient.util.offer.Offer;

import kabam.lib.tasks.Task;
import kabam.rotmg.account.core.model.MoneyConfig;
import kabam.rotmg.account.core.model.OfferModel;
import kabam.rotmg.account.core.services.GetOffersTask;
import kabam.rotmg.account.core.signals.PurchaseGoldSignal;
import kabam.rotmg.account.core.view.MoneyFrame;
import kabam.rotmg.arena.model.CurrentArenaRunModel;
import kabam.rotmg.arena.view.ContinueOrQuitDialog;
import kabam.rotmg.core.signals.MoneyFrameEnableCancelSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;
import robotlegs.bender.framework.api.ILogger;

public class MoneyFrameMediator extends Mediator {

    [Inject]
    public var view:MoneyFrame;
    [Inject]
    public var model:OfferModel;
    [Inject]
    public var config:MoneyConfig;
    [Inject]
    public var purchaseGold:PurchaseGoldSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var moneyFrameEnableCancelSignal:MoneyFrameEnableCancelSignal;
    [Inject]
    public var getOffers:GetOffersTask;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var hudModel:HUDModel;
    [Inject]
    public var currentArenaRun:CurrentArenaRunModel;


    override public function initialize():void {
        this.view.buyNow.add(this.onBuyNow);
        this.view.cancel.add(this.onCancel);
        this.moneyFrameEnableCancelSignal.addOnce(this.onMoneyFrameEnableCancel);
        this.initializeViewWhenOffersAreAvailable();
    }

    private function initializeViewWhenOffersAreAvailable():void {
        if (this.model.offers) {
            this.view.initialize(this.model.offers, this.config);
        }
        else {
            this.requestOffersData();
        }
    }

    private function requestOffersData():void {
        this.getOffers.finished.addOnce(this.onOffersReceived);
        this.getOffers.start();
    }

    private function onOffersReceived(_arg_1:Task, _arg_2:Boolean, _arg_3:String = ""):void {
        if (_arg_2) {
            this.view.initialize(this.model.offers, this.config);
        }
        else {
            this.openDialog.dispatch(new ErrorDialog("Unable to get gold offer information"));
        }
    }

    override public function destroy():void {
        if (this.hudModel.gameSprite.map.name_ == "Arena") {
            this.openDialog.dispatch(new ContinueOrQuitDialog(this.currentArenaRun.costOfContinue, true));
        }
        this.view.buyNow.add(this.onBuyNow);
        this.view.cancel.add(this.onCancel);
    }

    protected function onBuyNow(_arg_1:Offer, _arg_2:String):void {
        this.logger.info("offer {0}, paymentMethod {1}", [_arg_1, _arg_2]);
        this.purchaseGold.dispatch(_arg_1, _arg_2);
    }

    protected function onMoneyFrameEnableCancel():void {
        this.view.enableOnlyCancel();
    }

    protected function onCancel():void {
        this.closeDialogs.dispatch();
    }


}
}//package com.company.assembleegameclient.account.ui
