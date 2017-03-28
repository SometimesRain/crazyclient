package kabam.rotmg.mysterybox.components {
import com.company.assembleegameclient.map.ParticleModalMap;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.assembleegameclient.ui.dialogs.NotEnoughFameDialog;
import com.company.assembleegameclient.util.Currency;
import com.gskinner.motion.GTween;
import com.gskinner.motion.easing.Sine;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;
import flash.utils.Timer;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.assets.EmbeddedAssets;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.fortune.components.ItemWithTooltip;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
import kabam.rotmg.mysterybox.services.GetMysteryBoxesTask;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.pets.view.dialogs.evolving.Spinner;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.view.NotEnoughGoldDialog;
import kabam.rotmg.util.components.LegacyBuyButton;
import kabam.rotmg.util.components.UIAssetsHelper;

import org.swiftsuspenders.Injector;

public class MysteryBoxRollModal extends Sprite {

    public static const WIDTH:int = 415;
    public static const HEIGHT:int = 400;
    public static const TEXT_MARGIN:int = 20;
    public static var open:Boolean;

    private const ROLL_STATE:int = 1;
    private const IDLE_STATE:int = 0;
    private const iconSize:Number = 160;
    private const playAgainString:String = "MysteryBoxRollModal.playAgainString";
    private const playAgainXTimesString:String = "MysteryBoxRollModal.playAgainXTimesString";
    private const youWonString:String = "MysteryBoxRollModal.youWonString";
    private const rewardsInVaultString:String = "MysteryBoxRollModal.rewardsInVaultString";

    public var client:AppEngineClient;
    public var account:Account;
    public var parentSelectModal:MysteryBoxSelectModal;
    private var state:int;
    private var isShowReward:Boolean = false;
    private var rollCount:int = 0;
    private var rollTarget:int = 0;
    private var quantity_:int = 0;
    private var mbi:MysteryBoxInfo;
    private var spinners:Sprite;
    private var itemBitmaps:Vector.<Bitmap>;
    private var rewardsArray:Vector.<ItemWithTooltip>;
    private var closeButton:DialogCloseButton;
    private var particleModalMap:ParticleModalMap;
    private var minusNavSprite:Sprite;
    private var plusNavSprite:Sprite;
    private var boxButton:LegacyBuyButton;
    private var titleText:TextFieldDisplayConcrete;
    private var infoText:TextFieldDisplayConcrete;
    private var descTexts:Vector.<TextFieldDisplayConcrete>;
    private var swapImageTimer:Timer;
    private var totalRollTimer:Timer;
    private var nextRollTimer:Timer;
    private var indexInRolls:Vector.<int>;
    private var lastReward:String = "";
    private var requestComplete:Boolean = false;
    private var timerComplete:Boolean = false;
    private var goldBackground:DisplayObject;
    private var goldBackgroundMask:DisplayObject;
    private var rewardsList:Array;

    public function MysteryBoxRollModal(_arg_1:MysteryBoxInfo, _arg_2:int):void {
        this.spinners = new Sprite();
        this.itemBitmaps = new Vector.<Bitmap>();
        this.rewardsArray = new Vector.<ItemWithTooltip>();
        this.closeButton = PetsViewAssetFactory.returnCloseButton(WIDTH);
        this.boxButton = new LegacyBuyButton(this.playAgainString, 16, 0, Currency.INVALID);
        this.descTexts = new Vector.<TextFieldDisplayConcrete>();
        this.swapImageTimer = new Timer(50);
        this.totalRollTimer = new Timer(2000);
        this.nextRollTimer = new Timer(800);
        this.indexInRolls = new Vector.<int>();
        this.goldBackground = new EmbeddedAssets.EvolveBackground();
        this.goldBackgroundMask = new EmbeddedAssets.EvolveBackground();
        super();
        this.mbi = _arg_1;
        this.closeButton.disableLegacyCloseBehavior();
        this.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseClick);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.infoText = this.getText(this.rewardsInVaultString, TEXT_MARGIN, 220).setSize(20).setColor(0);
        this.infoText.y = 40;
        this.infoText.filters = [];
        this.addComponemts();
        open = true;
        this.boxButton.x = (this.boxButton.x + ((WIDTH / 2) - 100));
        this.boxButton.y = (this.boxButton.y + (HEIGHT - 43));
        this.boxButton._width = 200;
        this.boxButton.addEventListener(MouseEvent.CLICK, this.onRollClick);
        this.minusNavSprite = UIAssetsHelper.createLeftNevigatorIcon(UIAssetsHelper.LEFT_NEVIGATOR, 3);
        this.minusNavSprite.addEventListener(MouseEvent.CLICK, this.onNavClick);
        this.minusNavSprite.filters = [new GlowFilter(0, 1, 2, 2, 10, 1)];
        this.minusNavSprite.x = ((WIDTH / 2) + 110);
        this.minusNavSprite.y = (HEIGHT - 35);
        this.minusNavSprite.alpha = 0;
        addChild(this.minusNavSprite);
        this.plusNavSprite = UIAssetsHelper.createLeftNevigatorIcon(UIAssetsHelper.RIGHT_NEVIGATOR, 3);
        this.plusNavSprite.addEventListener(MouseEvent.CLICK, this.onNavClick);
        this.plusNavSprite.filters = [new GlowFilter(0, 1, 2, 2, 10, 1)];
        this.plusNavSprite.x = ((WIDTH / 2) + 110);
        this.plusNavSprite.y = (HEIGHT - 50);
        this.plusNavSprite.alpha = 0;
        addChild(this.plusNavSprite);
        var _local_3:Injector = StaticInjectorContext.getInjector();
        this.client = _local_3.getInstance(AppEngineClient);
        this.account = _local_3.getInstance(Account);
        var _local_4:uint;
        while (_local_4 < this.mbi._rollsWithContents.length) {
            this.indexInRolls.push(0);
            _local_4++;
        }
        this.centerModal();
        this.configureRollByQuantity(_arg_2);
        this.sendRollRequest();
    }

    private static function makeModalBackground(_arg_1:int, _arg_2:int):PopupWindowBackground {
        var _local_3:PopupWindowBackground = new PopupWindowBackground();
        _local_3.draw(_arg_1, _arg_2, PopupWindowBackground.TYPE_TRANSPARENT_WITH_HEADER);
        return (_local_3);
    }


    private function configureRollByQuantity(_arg_1:*):void {
        var _local_2:int;
        var _local_3:int;
        this.quantity_ = _arg_1;
        switch (_arg_1) {
            case 1:
                this.rollCount = 1;
                this.rollTarget = 1;
                this.swapImageTimer.delay = 50;
                this.totalRollTimer.delay = 2000;
                break;
            case 5:
                this.rollCount = 0;
                this.rollTarget = 4;
                this.swapImageTimer.delay = 50;
                this.totalRollTimer.delay = 1000;
                break;
            case 10:
                this.rollCount = 0;
                this.rollTarget = 9;
                this.swapImageTimer.delay = 50;
                this.totalRollTimer.delay = 1000;
                break;
            default:
                this.rollCount = 1;
                this.rollTarget = 1;
                this.swapImageTimer.delay = 50;
                this.totalRollTimer.delay = 2000;
        }
        if (this.mbi.isOnSale()) {
            _local_2 = (this.mbi.saleAmount * this.quantity_);
            _local_3 = this.mbi.saleCurrency;
        }
        else {
            _local_2 = (this.mbi.priceAmount * this.quantity_);
            _local_3 = this.mbi.priceCurrency;
        }
        if (this.quantity_ == 1) {
            this.boxButton.setPrice(_local_2, this.mbi.priceCurrency);
        }
        else {
            this.boxButton.currency = _local_3;
            this.boxButton.price = _local_2;
            this.boxButton.setStringBuilder(new LineBuilder().setParams(this.playAgainXTimesString, {
                "cost": _local_2.toString(), 
                "repeat": this.quantity_.toString()
            }));
        }
    }

    public function getText(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Boolean = false):TextFieldDisplayConcrete {
        var _local_5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth((WIDTH - (TEXT_MARGIN * 2)));
        _local_5.setBold(true);
        if (_arg_4) {
            _local_5.setStringBuilder(new StaticStringBuilder(_arg_1));
        }
        else {
            _local_5.setStringBuilder(new LineBuilder().setParams(_arg_1));
        }
        _local_5.setWordWrap(true);
        _local_5.setMultiLine(true);
        _local_5.setAutoSize(TextFieldAutoSize.CENTER);
        _local_5.setHorizontalAlign(TextFormatAlign.CENTER);
        _local_5.filters = [new DropShadowFilter(0, 0, 0)];
        _local_5.x = _arg_2;
        _local_5.y = _arg_3;
        return (_local_5);
    }

    private function addComponemts():void {
        var _local_1:int = 27;
        var _local_2:int = 28;
        this.goldBackgroundMask.y = (this.goldBackground.y = _local_1);
        this.goldBackgroundMask.x = (this.goldBackground.x = 1);
        this.goldBackgroundMask.width = (this.goldBackground.width = (WIDTH - 1));
        this.goldBackgroundMask.height = (this.goldBackground.height = (HEIGHT - _local_2));
        addChild(this.goldBackground);
        addChild(this.goldBackgroundMask);
        var _local_3:Spinner = new Spinner();
        var _local_4:Spinner = new Spinner();
        _local_3.degreesPerSecond = 50;
        _local_4.degreesPerSecond = (_local_3.degreesPerSecond * 1.5);
        var _local_5:Number = 0.7;
        _local_4.width = (_local_3.width * _local_5);
        _local_4.height = (_local_3.height * _local_5);
        _local_4.alpha = (_local_3.alpha = 0.7);
        this.spinners.addChild(_local_3);
        this.spinners.addChild(_local_4);
        this.spinners.mask = this.goldBackgroundMask;
        this.spinners.x = (WIDTH / 2);
        this.spinners.y = (((HEIGHT - 30) / 3) + 50);
        this.spinners.alpha = 0;
        addChild(this.spinners);
        addChild(makeModalBackground(WIDTH, HEIGHT));
        addChild(this.closeButton);
        this.particleModalMap = new ParticleModalMap(ParticleModalMap.MODE_AUTO_UPDATE);
        addChild(this.particleModalMap);
    }

    private function sendRollRequest():void {
        if (!this.moneyCheckPass()) {
            return;
        }
        this.state = this.ROLL_STATE;
        this.closeButton.visible = false;
        var _local_1:Object = this.account.getCredentials();
        _local_1.boxId = this.mbi.id;
        if (this.mbi.isOnSale()) {
            _local_1.quantity = this.quantity_;
            _local_1.price = this.mbi._saleAmount;
            _local_1.currency = this.mbi._saleCurrency;
        }
        else {
            _local_1.quantity = this.quantity_;
            _local_1.price = this.mbi._priceAmount;
            _local_1.currency = this.mbi._priceCurrency;
        }
        this.client.sendRequest("/account/purchaseMysteryBox", _local_1);
        this.titleText = this.getText(this.mbi._title, TEXT_MARGIN, 6, true).setSize(18);
        this.titleText.setColor(0xFFDE00);
        addChild(this.titleText);
        addChild(this.infoText);
        this.playRollAnimation();
        this.lastReward = "";
        this.rewardsList = [];
        this.requestComplete = false;
        this.timerComplete = false;
        this.totalRollTimer.addEventListener(TimerEvent.TIMER, this.onTotalRollTimeComplete);
        this.totalRollTimer.start();
        this.client.complete.addOnce(this.onComplete);
    }

    private function playRollAnimation():void {
        var _local_2:Bitmap;
        var _local_1:int;
        while (_local_1 < this.mbi._rollsWithContents.length) {
            _local_2 = new Bitmap(ObjectLibrary.getRedrawnTextureFromType(this.mbi._rollsWithContentsUnique[this.indexInRolls[_local_1]], this.iconSize, true));
            this.itemBitmaps.push(_local_2);
            _local_1++;
        }
        this.displayItems(this.itemBitmaps);
        this.swapImageTimer.addEventListener(TimerEvent.TIMER, this.swapItemImage);
        this.swapImageTimer.start();
    }

    private function onTotalRollTimeComplete(_arg_1:TimerEvent):void {
        this.totalRollTimer.stop();
        this.timerComplete = true;
        if (this.requestComplete) {
            this.showReward();
        }
        this.totalRollTimer.removeEventListener(TimerEvent.TIMER, this.onTotalRollTimeComplete);
    }

    private function onNextRollTimerComplete(_arg_1:TimerEvent):void {
        this.nextRollTimer.stop();
        this.nextRollTimer.removeEventListener(TimerEvent.TIMER, this.onNextRollTimerComplete);
        this.shelveReward();
        this.clearReward();
        this.rollCount++;
        this.prepareNextRoll();
    }

    private function prepareNextRoll():void
    {
        this.titleText = this.getText(this.mbi._title, TEXT_MARGIN, 6, true).setSize(18);
        this.titleText.setColor(0xFFDE00);
        addChild(this.titleText);
        addChild(this.infoText);
        this.playRollAnimation();
        this.timerComplete = false;
        this.lastReward = this.rewardsList[0];
        this.totalRollTimer.addEventListener(TimerEvent.TIMER, this.onTotalRollTimeComplete);
        this.totalRollTimer.start();
    }

    private function swapItemImage(_arg_1:TimerEvent):void {
        this.swapImageTimer.stop();
        var _local_2:uint = 0;
        while (_local_2 < this.indexInRolls.length) {
            if (this.indexInRolls[_local_2] < (this.mbi._rollsWithContentsUnique.length - 1)) {
                var _local_3:Vector.<int> = this.indexInRolls;
                var _local_4:uint = _local_2;
                var _local_5:int = (_local_3[_local_4] + 1);
                _local_3[_local_4] = _local_5;
            }
            else {
                this.indexInRolls[_local_2] = 0;
            }
            this.itemBitmaps[_local_2].bitmapData = new Bitmap(ObjectLibrary.getRedrawnTextureFromType(this.mbi._rollsWithContentsUnique[this.indexInRolls[_local_2]], this.iconSize, true)).bitmapData;
            _local_2++;
        }
        this.swapImageTimer.start();
    }

    private function displayItems(_arg_1:Vector.<Bitmap>):void {
        var _local_2:Bitmap;
        switch (_arg_1.length) {
            case 1:
                _arg_1[0].x = (_arg_1[0].x + ((WIDTH / 2) - 40));
                _arg_1[0].y = (_arg_1[0].y + (HEIGHT / 3));
                break;
            case 2:
                _arg_1[0].x = (_arg_1[0].x + ((WIDTH / 2) + 20));
                _arg_1[0].y = (_arg_1[0].y + (HEIGHT / 3));
                _arg_1[1].x = (_arg_1[1].x + ((WIDTH / 2) - 100));
                _arg_1[1].y = (_arg_1[1].y + (HEIGHT / 3));
                break;
            case 3:
                _arg_1[0].x = (_arg_1[0].x + ((WIDTH / 2) - 140));
                _arg_1[0].y = (_arg_1[0].y + (HEIGHT / 3));
                _arg_1[1].x = (_arg_1[1].x + ((WIDTH / 2) - 40));
                _arg_1[1].y = (_arg_1[1].y + (HEIGHT / 3));
                _arg_1[2].x = (_arg_1[2].x + ((WIDTH / 2) + 60));
                _arg_1[2].y = (_arg_1[2].y + (HEIGHT / 3));
                break;
        }
        for each (_local_2 in _arg_1) {
            addChild(_local_2);
        }
    }

    private function onComplete(_arg_1:Boolean, _arg_2:String):void {
        var _local_3:XML;
        var _local_4:XML;
        var _local_5:Player;
        var _local_6:PlayerModel;
        var _local_7:OpenDialogSignal;
        var _local_8:String;
        var _local_9:Dialog;
        var _local_10:Injector;
        var _local_11:GetMysteryBoxesTask;
        var _local_12:Array;
        var _local_13:int;
        var _local_14:Array;
        var _local_15:int;
        var _local_16:Array;
        this.requestComplete = true;
        if(_arg_1)
        {
            _local_3 = new XML(_arg_2);
            for each(_local_4 in _local_3.elements("Awards"))
            {
                this.rewardsList.push(_local_4.toString());
            }
            this.lastReward = this.rewardsList[0];
            if(this.timerComplete)
            {
                this.showReward();
            }
            if(_local_3.hasOwnProperty("Left") && this.mbi.unitsLeft != -1)
            {
                this.mbi.unitsLeft = int(_local_3.Left);
            }
            _local_5 = StaticInjectorContext.getInjector().getInstance(GameModel).player;
            if(_local_5 != null)
            {
                if(_local_3.hasOwnProperty("Gold"))
                {
                    _local_5.setCredits(int(_local_3.Gold));
                }
                else if(_local_3.hasOwnProperty("Fame"))
                {
                    _local_5.fame_ = _local_3.Fame;
                }
            }
            else
            {
                _local_6 = StaticInjectorContext.getInjector().getInstance(PlayerModel);
                if(_local_6 != null)
                {
                    if(_local_3.hasOwnProperty("Gold"))
                    {
                        _local_6.setCredits(int(_local_3.Gold));
                    }
                    else if(_local_3.hasOwnProperty("Fame"))
                    {
                        _local_6.setFame(int(_local_3.Fame));
                    }
                }
            }
        }
        else
        {
            this.totalRollTimer.removeEventListener(TimerEvent.TIMER,this.onTotalRollTimeComplete);
            this.totalRollTimer.stop();
            _local_7 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            _local_8 = "MysteryBoxRollModal.pleaseTryAgainString";
            if(LineBuilder.getLocalizedStringFromKey(_arg_2) != "")
            {
                _local_8 = _arg_2;
            }
            if(_arg_2.indexOf("MysteryBoxError.soldOut") >= 0)
            {
                _local_12 = _arg_2.split("|");
                if(_local_12.length == 2)
                {
                    _local_13 = _local_12[1];
                    if(_local_13 == 0)
                    {
                        _local_8 = "MysteryBoxError.soldOutAll";
                    }
                    else
                    {
                        _local_8 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutLeft", {
                            "left": this.mbi.unitsLeft,
                            "box": (this.mbi.unitsLeft == 1 ? LineBuilder.getLocalizedStringFromKey("MysteryBoxError.box") : LineBuilder.getLocalizedStringFromKey("MysteryBoxError.boxes"))
                        });
                    }
                }
            }
            if(_arg_2.indexOf("MysteryBoxError.maxPurchase") >= 0)
            {
                _local_14 = _arg_2.split("|");
                if(_local_14.length == 2)
                {
                    _local_15 = _local_14[1];
                    if(_local_15 == 0)
                    {
                        _local_8 = "MysteryBoxError.maxPurchase";
                    }
                    else
                    {
                        _local_8 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.maxPurchaseLeft",{"left": _local_15});
                    }
                }
            }
            if(_arg_2.indexOf("blockedForUser") >= 0)
            {
                _local_16 = _arg_2.split("|");
                if(_local_16.length == 2)
                {
                    _local_8 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.blockedForUser", {"date": _local_16[1]});
                }
            }
            _local_9 = new Dialog("MysteryBoxRollModal.purchaseFailedString", _local_8, "MysteryBoxRollModal.okString", null, null);
            _local_9.addEventListener(Dialog.LEFT_BUTTON, this.onErrorOk);
            _local_7.dispatch(_local_9);
            _local_10 = StaticInjectorContext.getInjector();
            _local_11 = _local_10.getInstance(GetMysteryBoxesTask);
            _local_11.clearLastRanBlock();
            _local_11.start();
            this.close(true);
        }
    }

    private function onErrorOk(_arg_1:Event):void {
        var _local_2:OpenDialogSignal;
        _local_2 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
        _local_2.dispatch(new MysteryBoxSelectModal());
    }

    public function moneyCheckPass():Boolean {
        var _local_1:int;
        var _local_2:int;
        var _local_7:OpenDialogSignal;
        var _local_8:PlayerModel;
        if (((this.mbi.isOnSale()) && (!((this.mbi.saleAmount == ""))))) {
            _local_1 = int(this.mbi.saleCurrency);
            _local_2 = (int(this.mbi.saleAmount) * this.quantity_);
        }
        else {
            _local_1 = int(this.mbi.priceCurrency);
            _local_2 = (int(this.mbi.priceAmount) * this.quantity_);
        }
        var _local_3:Boolean = true;
        var _local_4:int;
        var _local_5:int;
        var _local_6:Player = StaticInjectorContext.getInjector().getInstance(GameModel).player;
        if (_local_6 != null) {
            _local_5 = _local_6.credits_;
            _local_4 = _local_6.fame_;
        }
        else {
            _local_8 = StaticInjectorContext.getInjector().getInstance(PlayerModel);
            if (_local_8 != null) {
                _local_5 = _local_8.getCredits();
                _local_4 = _local_8.getFame();
            }
        }
        if ((((_local_1 == Currency.GOLD)) && ((_local_5 < _local_2)))) {
            _local_7 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            _local_7.dispatch(new NotEnoughGoldDialog());
            _local_3 = false;
        }
        else {
            if ((((_local_1 == Currency.FAME)) && ((_local_4 < _local_2)))) {
                _local_7 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
                _local_7.dispatch(new NotEnoughFameDialog());
                _local_3 = false;
            }
        }
        return (_local_3);
    }

    public function onCloseClick(_arg_1:MouseEvent):void {
        this.close();
    }

    private function close(_arg_1:Boolean = false):void {
        var _local_2:OpenDialogSignal;
        if (this.state == this.ROLL_STATE) {
            return;
        }
        if (!_arg_1) {
            _local_2 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            if (this.parentSelectModal != null) {
                this.parentSelectModal.updateContent();
                _local_2.dispatch(this.parentSelectModal);
            }
            else {
                _local_2.dispatch(new MysteryBoxSelectModal());
            }
        }
        open = false;
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        open = false;
    }

    private function showReward():void {
        var _local_4:String;
        var _local_5:uint;
        var _local_6:TextFieldDisplayConcrete;
        this.swapImageTimer.removeEventListener(TimerEvent.TIMER, this.swapItemImage);
        this.swapImageTimer.stop();
        this.state = this.IDLE_STATE;
        if (this.rollCount < this.rollTarget) {
            this.nextRollTimer.addEventListener(TimerEvent.TIMER, this.onNextRollTimerComplete);
            this.nextRollTimer.start();
        }
        this.closeButton.visible = true;
        var _local_1:String = this.rewardsList.shift();
        var _local_2:Array = _local_1.split(",");
        removeChild(this.infoText);
        this.titleText.setStringBuilder(new LineBuilder().setParams(this.youWonString));
        this.titleText.setColor(0xFFDE00);
        var _local_3:int = 40;
        for each (_local_4 in _local_2) {
            _local_6 = this.getText(ObjectLibrary.typeToDisplayId_[_local_4], TEXT_MARGIN, _local_3).setSize(16).setColor(0);
            _local_6.filters = [];
            _local_6.setSize(18);
            _local_6.x = 20;
            addChild(_local_6);
            this.descTexts.push(_local_6);
            _local_3 = (_local_3 + 25);
        }
        _local_5 = 0;
        while (_local_5 < _local_2.length) {
            if (_local_5 < this.itemBitmaps.length) {
                this.itemBitmaps[_local_5].bitmapData = new Bitmap(ObjectLibrary.getRedrawnTextureFromType(int(_local_2[_local_5]), this.iconSize, true)).bitmapData;
            }
            _local_5++;
        }
        _local_5 = 0;
        while (_local_5 < this.itemBitmaps.length) {
            this.doEaseInAnimation(this.itemBitmaps[_local_5], {
                "scaleX": 1.25, 
                "scaleY": 1.25
            }, {
                "scaleX": 1, 
                "scaleY": 1
            });
            _local_5++;
        }
        this.boxButton.alpha = 0;
        addChild(this.boxButton);
        if (this.rollCount == this.rollTarget) {
            this.doEaseInAnimation(this.boxButton, {"alpha": 0}, {"alpha": 1});
            this.doEaseInAnimation(this.minusNavSprite, {"alpha": 0}, {"alpha": 1});
            this.doEaseInAnimation(this.plusNavSprite, {"alpha": 0}, {"alpha": 1});
        }
        this.doEaseInAnimation(this.spinners, {"alpha": 0}, {"alpha": 1});
        this.isShowReward = true;
    }

    private function doEaseInAnimation(_arg_1:DisplayObject, _arg_2:Object = null, _arg_3:Object = null):void {
        var _local_4:GTween = new GTween(_arg_1, (0.5 * 1), _arg_2, {"ease": Sine.easeOut});
        _local_4.nextTween = new GTween(_arg_1, (0.5 * 1), _arg_3, {"ease": Sine.easeIn});
        _local_4.nextTween.paused = true;
    }

    private function shelveReward():void {
        var _local_2:ItemWithTooltip;
        var _local_3:int;
        var _local_4:int;
        var _local_5:int;
        var _local_6:int;
        var _local_7:int;
        var _local_8:int;
        var _local_1:Array = this.lastReward.split(", ");
        if (_local_1.length > 0) {
            _local_2 = new ItemWithTooltip(int(_local_1[0]), 64);
            _local_3 = ((HEIGHT / 6) - 10);
            _local_4 = (WIDTH - 65);
            _local_2.x = (5 + (_local_4 * int((this.rollCount / 5))));
            _local_2.y = (80 + (_local_3 * (this.rollCount % 5)));
            _local_5 = (((WIDTH / 2) - 40) + (this.itemBitmaps[0].width * 0.5));
            _local_6 = ((HEIGHT / 3) + (this.itemBitmaps[0].height * 0.5));
            _local_7 = (_local_2.x + (_local_2.height * 0.5));
            _local_8 = ((100 + (_local_3 * (this.rollCount % 5))) + (0.5 * ((HEIGHT / 6) - 20)));
            this.particleModalMap.doLightning(_local_5, _local_6, _local_7, _local_8, 115, 15787660, 0.2);
            addChild(_local_2);
            this.rewardsArray.push(_local_2);
        }
    }

    private function clearReward():void {
        var _local_1:TextFieldDisplayConcrete;
        var _local_2:Bitmap;
        this.spinners.alpha = 0;
        this.minusNavSprite.alpha = 0;
        this.plusNavSprite.alpha = 0;
        removeChild(this.titleText);
        for each (_local_1 in this.descTexts) {
            removeChild(_local_1);
        }
        while (this.descTexts.length > 0) {
            this.descTexts.pop();
        }
        removeChild(this.boxButton);
        for each (_local_2 in this.itemBitmaps) {
            removeChild(_local_2);
        }
        while (this.itemBitmaps.length > 0) {
            this.itemBitmaps.pop();
        }
    }

    private function clearShelveReward():void {
        var _local_1:ItemWithTooltip;
        for each (_local_1 in this.rewardsArray) {
            removeChild(_local_1);
        }
        while (this.rewardsArray.length > 0) {
            this.rewardsArray.pop();
        }
    }

    private function centerModal():void {
        x = ((WebMain.STAGE.stageWidth / 2) - (WIDTH / 2));
        y = ((WebMain.STAGE.stageHeight / 2) - (HEIGHT / 2));
    }

    private function onNavClick(_arg_1:MouseEvent):void {
        if (_arg_1.currentTarget == this.minusNavSprite) {
            switch (this.quantity_) {
                case 5:
                    this.configureRollByQuantity(1);
                    break;
                case 10:
                    this.configureRollByQuantity(5);
                    break;
            }
        }
        else {
            if (_arg_1.currentTarget == this.plusNavSprite) {
                switch (this.quantity_) {
                    case 1:
                        this.configureRollByQuantity(5);
                        return;
                    case 5:
                        this.configureRollByQuantity(10);
                        return;
                }
            }
        }
    }

    private function onRollClick(_arg_1:MouseEvent):void {
        this.configureRollByQuantity(this.quantity_);
        this.clearReward();
        this.clearShelveReward();
        this.sendRollRequest();
    }


}
}//package kabam.rotmg.mysterybox.components
