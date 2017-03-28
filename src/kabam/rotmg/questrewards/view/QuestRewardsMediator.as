package kabam.rotmg.questrewards.view {
import com.gskinner.motion.GTween;

import flash.events.MouseEvent;
import flash.events.TimerEvent;

import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.fortune.components.TimerCallback;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.messaging.impl.incoming.QuestFetchResponse;
import kabam.rotmg.messaging.impl.incoming.QuestRedeemResponse;
import kabam.rotmg.questrewards.components.ModalItemSlot;
import kabam.rotmg.questrewards.controller.QuestFetchCompleteSignal;
import kabam.rotmg.questrewards.controller.QuestRedeemCompleteSignal;
import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.util.components.LegacyBuyButton;

import org.swiftsuspenders.Injector;

import robotlegs.bender.bundles.mvcs.Mediator;

public class QuestRewardsMediator extends Mediator {

    public static var questsCompletedDayUTC:Number = -1;

    [Inject]
    public var container:QuestRewardsContainer;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var injector:Injector;
    [Inject]
    public var hudModel:HUDModel;
    [Inject]
    public var questFetchComplete:QuestFetchCompleteSignal;
    [Inject]
    public var questRedeemComplete:QuestRedeemCompleteSignal;
    public var targetItem:int = -1;
    public var itemslot:ModalItemSlot;
    public var exchangeButton:LegacyBuyButton;
    public var gsc:GameServerConnection;
    private var view:QuestRewardsView;
    private var oldView:QuestRewardsView;
    private var state_tinkering:Boolean = false;


    override public function initialize():void {
        if (this.container.parent == null) {
            return;
        }
        var _local_1:Number = 0.2;
        if (((!((this.view == null))) && (!((this.view.parent == null))))) {
            this.removeEvents();
            this.oldView = this.view;
            this.resetVars();
            new GTween(this.oldView, 0.4, {"alpha": 0});
            new TimerCallback(0.4, this.removeOldView);
            _local_1 = 0.4;
        }
        this.view = new QuestRewardsView();
        this.container.addChild(this.view);
        this.view.alpha = 0;
        new GTween(this.view, _local_1, {"alpha": 1});
        if (((((!((this.hudModel == null))) && (!((this.hudModel.gameSprite == null))))) && (!((this.hudModel.gameSprite.gsc_ == null))))) {
            this.gsc = this.hudModel.gameSprite.gsc_;
            this.gsc.questFetch();
            this.view.setCloseButton(true);
        }
        else {
            this.onClose();
            return;
        }
        this.questFetchComplete.add(this.onQuestFetchComplete);
        this.questRedeemComplete.add(this.onQuestRedeemComplete);
        QuestRewardsView.closed.add(this.onClose);
    }

    private function presentNextQuest():void {
        this.removeEvents();
        this.initialize();
    }

    private function removeOldView():void {
        if (((!((this.oldView == null))) && (!((this.oldView.parent == null))))) {
            this.container.removeChild(this.oldView);
        }
    }

    private function onClose():void {
        QuestRewardsView.closed.removeAll();
        this.removeEvents();
        this.closeDialogs.dispatch();
    }

    private function onInit(_arg_1:TimerEvent):void {
        if (Math.random() < 0.5) {
            this.view.init(1, 3205, "AAAAAAHHH we are in need of this {goal} now. Help help help.", "http://i.imgur.com/ceobPxd.png");
        }
        else {
            this.view.init(1, 1793, "WOAAH we are in need of this {goal} now. Help help.", "https://www.google.com/images/srpr/logo11w.png");
        }
    }

    private function onQuestFetchComplete(_arg_1:QuestFetchResponse):void {
        this.targetItem = int(_arg_1.goal);
        var _local_2:int = _arg_1.tier;
        if (_local_2 > 0) {
            this.view.init(int(_arg_1.tier), this.targetItem, _arg_1.description, _arg_1.image);
            this.setupEvents();
        }
        else {
            if (_local_2 == -1) {
                if (((!((this.oldView == null))) || (((!((questsCompletedDayUTC == -1))) && ((questsCompletedDayUTC == new Date().dayUTC)))))) {
                    this.view.noNewQuests();
                    questsCompletedDayUTC = new Date().dayUTC;
                }
                else {
                    this.onClose();
                }
            }
            else {
                this.view.constructDescription(_arg_1.description);
            }
        }
    }

    private function onQuestRedeemComplete(_arg_1:QuestRedeemResponse):void {
        var _local_2:Boolean = Boolean(_arg_1.ok);
        var _local_3:String = String(_arg_1.message);
        this.state_tinkering = false;
        if (this.exchangeButton != null) {
            this.exchangeButton.addEventListener(MouseEvent.CLICK, this.onOKClick);
            this.exchangeButton.freezeSize();
            this.exchangeButton.setText("OK");
            this.exchangeButton.setOutLineColor(0x545454);
            this.exchangeButton.draw();
            this.itemslot.setCheckMark();
            this.view.onQuestComplete();
        }
    }

    private function setupEvents():void {
        this.itemslot = this.view.getItemSlot();
        this.exchangeButton = this.view.getExchangeButton();
        this.itemslot.foodLoaded.remove(this.onNewItem);
        this.itemslot.foodLoaded.add(this.onNewItem);
        this.itemslot.foodUnloaded.remove(this.onClearItem);
        this.itemslot.foodUnloaded.add(this.onClearItem);
        this.exchangeButton.removeEventListener(MouseEvent.CLICK, this.onExchangeClick);
        this.exchangeButton.removeEventListener(MouseEvent.CLICK, this.onOKClick);
    }

    private function removeEvents():void {
        this.questFetchComplete.remove(this.onQuestFetchComplete);
        this.questRedeemComplete.remove(this.onQuestFetchComplete);
        if (this.itemslot != null) {
            this.itemslot.foodLoaded.remove(this.onNewItem);
            this.itemslot.foodUnloaded.remove(this.onClearItem);
        }
        if (this.exchangeButton != null) {
            this.exchangeButton.removeEventListener(MouseEvent.CLICK, this.onExchangeClick);
            this.exchangeButton.removeEventListener(MouseEvent.CLICK, this.onOKClick);
        }
    }

    private function resetVars():void {
        this.targetItem = -1;
        this.itemslot = null;
        this.exchangeButton = null;
        this.targetItem = -1;
        this.itemslot = null;
        this.exchangeButton = null;
        this.gsc = null;
    }

    override public function destroy():void {
        this.removeEvents();
    }

    private function onNewItem(_arg_1:int):void {
        if (((!((this.itemslot == null))) && (!(this.state_tinkering)))) {
            if (_arg_1 == this.targetItem) {
                this.exchangeButton.addEventListener(MouseEvent.CLICK, this.onExchangeClick);
                this.itemslot.hideOuterSlot(false);
                this.itemslot.empty = false;
                this.itemslot.updateTitle();
            }
            else {
                this.itemslot.clearItem();
                this.itemslot.makeRedTemporarily();
                this.itemslot.hideOuterSlot(true);
            }
        }
    }

    private function onClearItem():void {
    }

    private function onExchangeClick(_arg_1:MouseEvent):void {
        if (this.gsc != null) {
            this.exchangeButton.removeEventListener(MouseEvent.CLICK, this.onExchangeClick);
            this.exchangeButton.setText("Tinkering");
            this.exchangeButton.setOutLineColor(0x545454);
            this.exchangeButton.draw();
            this.state_tinkering = true;
            this.gsc.questRedeem(this.itemslot.objectId, this.itemslot.slotId, this.itemslot.itemId);
            this.view.onExchangeClick();
        }
    }

    private function onOKClick(_arg_1:MouseEvent):void {
        this.initialize();
    }


}
}//package kabam.rotmg.questrewards.view
