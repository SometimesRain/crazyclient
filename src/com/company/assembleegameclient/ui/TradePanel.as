package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.game.AGameSprite;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import kabam.rotmg.messaging.impl.incoming.TradeStart;
import kabam.rotmg.text.model.TextKey;

public class TradePanel extends Sprite {

    public static const WIDTH:int = 200;
    public static const HEIGHT:int = 400;

    public var gs_:AGameSprite;
    private var myInv_:TradeInventory;
    private var yourInv_:TradeInventory;
    private var cancelButton_:DeprecatedTextButton;
    private var tradeButton_:TradeButton;

    public function TradePanel(_arg_1:AGameSprite, _arg_2:TradeStart) {
        this.gs_ = _arg_1;
        var _local_3:String = this.gs_.map.player_.name_;
        this.myInv_ = new TradeInventory(_arg_1, _local_3, _arg_2.myItems_, true);
        this.myInv_.x = 14;
        this.myInv_.y = 0;
        this.myInv_.addEventListener(Event.CHANGE, this.onMyInvChange);
        addChild(this.myInv_);
        this.yourInv_ = new TradeInventory(_arg_1, _arg_2.yourName_, _arg_2.yourItems_, false);
        this.yourInv_.x = 14;
        this.yourInv_.y = 174;
        addChild(this.yourInv_);
        this.cancelButton_ = new DeprecatedTextButton(16, TextKey.PLAYERMENU_CANCEL, 80);
        this.cancelButton_.addEventListener(MouseEvent.CLICK, this.onCancelClick);
        this.cancelButton_.textChanged.addOnce(this.onCancelTextChanged);
        addChild(this.cancelButton_);
        this.tradeButton_ = new TradeButton(16, 80);
        this.tradeButton_.x = (((3 * WIDTH) / 4) - (this.tradeButton_.bWidth / 2));
        this.tradeButton_.addEventListener(MouseEvent.CLICK, this.onTradeClick);
        addChild(this.tradeButton_);
        this.checkTrade();
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onCancelTextChanged():void {
        this.cancelButton_.x = ((WIDTH / 4) - (this.cancelButton_.bWidth / 2));
        this.cancelButton_.y = ((HEIGHT - this.cancelButton_.height) - 10);
        this.tradeButton_.y = this.cancelButton_.y;
    }

    public function setYourOffer(_arg_1:Vector.<Boolean>):void {
        this.yourInv_.setOffer(_arg_1);
        this.checkTrade();
    }

    public function youAccepted(_arg_1:Vector.<Boolean>, _arg_2:Vector.<Boolean>):void {
        if (((this.myInv_.isOffer(_arg_1)) && (this.yourInv_.isOffer(_arg_2)))) {
            this.yourInv_.setMessage(TradeInventory.TRADEACCEPTED_MESSAGE);
        }
    }

    private function onAddedToStage(_arg_1:Event):void {
        stage.addEventListener(Event.ACTIVATE, this.onActivate);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        stage.removeEventListener(Event.ACTIVATE, this.onActivate);
    }

    private function onActivate(_arg_1:Event):void {
        this.tradeButton_.reset();
    }

    private function onMyInvChange(_arg_1:Event):void {
        this.gs_.gsc_.changeTrade(this.myInv_.getOffer());
        this.checkTrade();
    }

    private function onCancelClick(_arg_1:MouseEvent):void {
        this.gs_.gsc_.cancelTrade();
        dispatchEvent(new Event(Event.CANCEL));
    }

    private function onTradeClick(_arg_1:MouseEvent):void {
        this.gs_.gsc_.acceptTrade(this.myInv_.getOffer(), this.yourInv_.getOffer());
        this.myInv_.setMessage(TradeInventory.TRADEACCEPTED_MESSAGE);
    }

    public function checkTrade():void {
        var _local_1:int = this.myInv_.numIncluded();
        var _local_2:int = this.myInv_.numEmpty();
        var _local_3:int = this.yourInv_.numIncluded();
        var _local_4:int = this.yourInv_.numEmpty();
        var _local_5:Boolean = true;
        if (((_local_3 - _local_1) - _local_2) > 0) {
            this.myInv_.setMessage(TradeInventory.NOTENOUGHSPACE_MESSAGE);
            _local_5 = false;
        }
        else {
            this.myInv_.setMessage(TradeInventory.CLICKITEMS_MESSAGE);
        }
        if (((_local_1 - _local_3) - _local_4) > 0) {
            this.yourInv_.setMessage(TradeInventory.NOTENOUGHSPACE_MESSAGE);
            _local_5 = false;
        }
        else {
            this.yourInv_.setMessage(TradeInventory.TRADEWAITING_MESSAGE);
        }
        if (_local_5) {
            this.tradeButton_.reset();
        }
        else {
            this.tradeButton_.disable();
        }
    }


}
}//package com.company.assembleegameclient.ui
