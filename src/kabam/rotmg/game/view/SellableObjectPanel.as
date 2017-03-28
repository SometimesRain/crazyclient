package kabam.rotmg.game.view {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Merchant;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.SellableObject;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.ConfirmBuyModal;
import com.company.assembleegameclient.ui.RankText;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.util.Currency;
import com.company.assembleegameclient.util.GuildUtil;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;
import kabam.rotmg.util.components.LegacyBuyButton;

import org.osflash.signals.Signal;

public class SellableObjectPanel extends Panel implements TooltipAble {

    private const BUTTON_OFFSET:int = 17;

    public var hoverTooltipDelegate:HoverTooltipDelegate;
    public var buyItem:Signal;
    private var owner_:SellableObject;
    private var nameText_:TextFieldDisplayConcrete;
    private var buyButton_:LegacyBuyButton;
    private var rankReqText_:Sprite;
    private var guildRankReqText_:TextFieldDisplayConcrete;
    private var icon_:Sprite;
    private var bitmap_:Bitmap;
    private var confirmBuyModal:ConfirmBuyModal;
    private var availableInventoryNumber:int;

    public function SellableObjectPanel(_arg_1:GameSprite, _arg_2:SellableObject) {
        this.hoverTooltipDelegate = new HoverTooltipDelegate();
        this.buyItem = new Signal(SellableObject);
        super(_arg_1);
        this.nameText_ = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth((WIDTH - 44));
        this.nameText_.setBold(true);
        this.nameText_.setStringBuilder(new LineBuilder().setParams(TextKey.SELLABLEOBJECTPANEL_TEXT));
        this.nameText_.setWordWrap(true);
        this.nameText_.setMultiLine(true);
        this.nameText_.setAutoSize(TextFieldAutoSize.CENTER);
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.nameText_);
        this.icon_ = new Sprite();
        addChild(this.icon_);
        this.bitmap_ = new Bitmap(null);
        this.icon_.addChild(this.bitmap_);
        this.buyButton_ = new LegacyBuyButton(TextKey.SELLABLEOBJECTPANEL_BUY, 16, 0, Currency.INVALID);
        this.buyButton_.addEventListener(MouseEvent.CLICK, this.onBuyButtonClick);
        addChild(this.buyButton_);
        this.setOwner(_arg_2);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.hoverTooltipDelegate.setDisplayObject(this);
        this.hoverTooltipDelegate.tooltip = _arg_2.getTooltip();
    }

    private static function createRankReqText(rankReq:int):Sprite {
        var requiredText:TextFieldDisplayConcrete;
        var rankText:Sprite;
        var rankReqText:Sprite = new Sprite();
        requiredText = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        requiredText.filters = [new DropShadowFilter(0, 0, 0)];
        rankReqText.addChild(requiredText);
        rankText = new RankText(rankReq, false, false);
        rankReqText.addChild(rankText);
        requiredText.textChanged.addOnce(function ():void {
            rankText.x = ((requiredText.width * 0.5) + 4);
            rankText.y = (-(rankText.height) / 2);
        });
        requiredText.setStringBuilder(new LineBuilder().setParams(TextKey.SELLABLE_OBJECT_PANEL_RANK_REQUIRED));
        return (rankReqText);
    }

    private static function createGuildRankReqText(_arg_1:int):TextFieldDisplayConcrete {
        var _local_2:TextFieldDisplayConcrete;
        _local_2 = new TextFieldDisplayConcrete().setSize(16).setColor(0xFF0000).setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        var _local_3:String = GuildUtil.rankToString(_arg_1);
        _local_2.setStringBuilder(new LineBuilder().setParams(TextKey.SELLABLE_OBJECT_PANEL_GUILD_RANK, {"amount": _local_3}));
        _local_2.filters = [new DropShadowFilter(0, 0, 0)];
        return (_local_2);
    }


    public function setOwner(_arg_1:SellableObject):void {
        if (_arg_1 == this.owner_) {
            return;
        }
        this.owner_ = _arg_1;
        this.buyButton_.setPrice(this.owner_.price_, this.owner_.currency_);
        var _local_2:String = this.owner_.soldObjectName();
        this.nameText_.setStringBuilder(new LineBuilder().setParams(_local_2));
        this.bitmap_.bitmapData = this.owner_.getIcon();
    }

    public function setInventorySpaceAmount(_arg_1:int):void {
        this.availableInventoryNumber = _arg_1;
    }

    private function onAddedToStage(_arg_1:Event):void {
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        this.icon_.x = -4;
        this.icon_.y = -8;
        this.nameText_.x = 44;
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        if (((((!((parent == null))) && (!((this.confirmBuyModal == null))))) && (this.confirmBuyModal.open))) {
            parent.removeChild(this.confirmBuyModal);
        }
    }

    private function onBuyButtonClick(_arg_1:MouseEvent):void {
        if (ConfirmBuyModal.free) {
            this.buyEvent();
        }
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        if ((((((_arg_1.keyCode == Parameters.data_.interact)) && ((stage.focus == null)))) && (ConfirmBuyModal.free))) {
            this.buyEvent();
        }
    }

    private function buyEvent():void {
        var _local_1:Account = StaticInjectorContext.getInjector().getInstance(Account);
        if (((((!((parent == null))) && (_local_1.isRegistered()))) && ((this.owner_ is Merchant)))) {
            this.confirmBuyModal = new ConfirmBuyModal(this.buyItem, this.owner_, this.buyButton_.width, this.availableInventoryNumber);
            parent.addChild(this.confirmBuyModal);
        }
        else {
            this.buyItem.dispatch(this.owner_);
        }
    }

    override public function draw():void {
        var _local_1:Player = gs_.map.player_;
        this.nameText_.y = (((this.nameText_.height) > 30) ? 0 : 12);
        var _local_2:int = this.owner_.rankReq_;
        if (_local_1.numStars_ < _local_2) {
            if (contains(this.buyButton_)) {
                removeChild(this.buyButton_);
            }
            if ((((this.rankReqText_ == null)) || (!(contains(this.rankReqText_))))) {
                this.rankReqText_ = createRankReqText(_local_2);
                this.rankReqText_.x = ((WIDTH / 2) - (this.rankReqText_.width / 2));
                this.rankReqText_.y = ((HEIGHT - (this.rankReqText_.height / 2)) - 20);
                addChild(this.rankReqText_);
            }
        }
        else {
            if (_local_1.guildRank_ < this.owner_.guildRankReq_) {
                if (contains(this.buyButton_)) {
                    removeChild(this.buyButton_);
                }
                if ((((this.guildRankReqText_ == null)) || (!(contains(this.guildRankReqText_))))) {
                    this.guildRankReqText_ = createGuildRankReqText(this.owner_.guildRankReq_);
                    this.guildRankReqText_.x = ((WIDTH / 2) - (this.guildRankReqText_.width / 2));
                    this.guildRankReqText_.y = ((HEIGHT - (this.guildRankReqText_.height / 2)) - 20);
                    addChild(this.guildRankReqText_);
                }
            }
            else {
                this.buyButton_.setPrice(this.owner_.price_, this.owner_.currency_);
                this.buyButton_.setEnabled((gs_.gsc_.outstandingBuy_ == null));
                this.buyButton_.x = ((WIDTH / 2) - (this.buyButton_.width / 2));
                this.buyButton_.y = ((HEIGHT - (this.buyButton_.height / 2)) - this.BUTTON_OFFSET);
                if (!contains(this.buyButton_)) {
                    addChild(this.buyButton_);
                }
                if (((!((this.rankReqText_ == null))) && (contains(this.rankReqText_)))) {
                    removeChild(this.rankReqText_);
                }
            }
        }
    }

    public function setShowToolTipSignal(_arg_1:ShowTooltipSignal):void {
        this.hoverTooltipDelegate.setShowToolTipSignal(_arg_1);
    }

    public function getShowToolTip():ShowTooltipSignal {
        return (this.hoverTooltipDelegate.getShowToolTip());
    }

    public function setHideToolTipsSignal(_arg_1:HideTooltipsSignal):void {
        this.hoverTooltipDelegate.setHideToolTipsSignal(_arg_1);
    }

    public function getHideToolTips():HideTooltipsSignal {
        return (this.hoverTooltipDelegate.getHideToolTips());
    }


}
}//package kabam.rotmg.game.view
