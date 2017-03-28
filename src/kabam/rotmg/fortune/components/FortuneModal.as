package kabam.rotmg.fortune.components {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.map.ParticleModalMap;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.particles.LightningEffect;
import com.company.assembleegameclient.objects.particles.NovaEffect;
import com.company.assembleegameclient.ui.dialogs.DebugDialog;
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.assembleegameclient.util.Currency;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;
import com.gskinner.motion.GTween;
import com.gskinner.motion.easing.Sine;

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.filters.GlowFilter;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.utils.Timer;
import flash.utils.getTimer;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.view.EmptyFrame;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.fortune.model.FortuneInfo;
import kabam.rotmg.fortune.services.FortuneModel;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.game.view.CreditDisplay;
import kabam.rotmg.messaging.impl.data.WorldPosData;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.ui.view.NotEnoughGoldDialog;
import kabam.rotmg.ui.view.components.MapBackground;
import kabam.rotmg.util.components.CountdownTimer;
import kabam.rotmg.util.components.InfoHoverPaneFactory;
import kabam.rotmg.util.components.SimpleButton;

import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;

public class FortuneModal extends EmptyFrame {

    public static var backgroundImageEmbed:Class = FortuneModal_backgroundImageEmbed;
    public static var fortunePlatformEmbed:Class = FortuneModal_fortunePlatformEmbed;
    public static var fortunePlatformEmbed2:Class = FortuneModal_fortunePlatformEmbed2;
    public static const MODAL_WIDTH:int = 800;
    public static const MODAL_HEIGHT:int = 600;
    public static var modalWidth:int = MODAL_WIDTH;//800
    public static var modalHeight:int = MODAL_HEIGHT;//600
    private static var texts_:Vector.<TextField>;
    public static const STATE_ROUND_1:int = 1;
    public static const STATE_ROUND_2:int = 2;
    public static const INIT_RADIUS_FROM_MAINCRYTAL:Number = 200;
    public static var fMouseX:int;
    public static var fMouseY:int;
    public static var crystalMainY:int = ((MODAL_HEIGHT / 2) - 20);//280
    private static const ITEM_SIZE_IN_MC:int = 120;
    public static var modalIsOpen:Boolean = false;
    public static const closed:Signal = new Signal();

    private const SWITCH_DELAY_NORMAL:Number = 1200;
    private const SWITCH_DELAY_FAST:Number = 100;
    private const GAME_STAGE_IDLE:int = 0;
    private const GAME_STAGE_SPIN:int = 1;
    private const MAX_SPIN_SPEED:int = 120;
    private const MASTERS_LORE_STRING_TIME:Number = 1.3;
    private const SHOW_PRIZES_TIME:Number = 6;
    private const SPIN_TIME:Number = 2.75;
    private const DISPLAY_PRIZE_TIME_1:Number = 3.75;
    private const DISPLAY_PRIZE_TIME_2:Number = 5;
    private const NOVA_DELAY_TIME:Number = 0.12;
    private const COUNTDOWN_AMOUNT:Number = 10;

    public var crystalMain:CrystalMain;
    public var crystals:Vector.<CrystalSmall>;
    public var crystalClicked:CrystalSmall = null;
    private var buyButtonGold:SimpleButton;
    private var buyButtonFortune:SimpleButton;
    private var resetButton:SimpleButton;
    private var largeCloseButton:DialogCloseButton;
    private var currentString:int = -1;
    private var countdownTimer:CountdownTimer;
    public var client:AppEngineClient;
    public var account:Account;
    public var model:FortuneModel;
    public var fortuneInfo:FortuneInfo;
    public var state:int = 1;
    private var particleMap:ParticleModalMap;
    private var itemSwitchTimer:Timer;
    private var tooltipItemIDIndex:int = -1;
    private var currenttooltipItem:int = 0;
    public var tooltipItems:Vector.<ItemWithTooltip>;
    private var lastUpdate_:int;
    public var mapBackground:MapBackground;
    private var pscale:Number;
    private var gameStage_:int = 0;
    private var boughtWithGold:Boolean = false;
    private var radius:int = 200;
    private var dtBuildup:Number = 0;
    private var direction:int = 4;
    private var spinSpeed:int = 0;
    private var platformMain:Sprite;
    private var platformMainSub:Sprite;
    public var creditDisplay_:CreditDisplay;
    private var onHoverPanel:Sprite;
    private var goldPrice_:int = -1;
    private var goldPriceSecond_:int = -1;
    private var tokenPrice_:int = -1;
    private var gs_:GameSprite = null;
    private var chooseingState:Boolean = false;
    private var items:Array;

    public function FortuneModal(_arg_1:GameSprite = null) {
        this.crystalMain = new CrystalMain();
        this.crystals = Vector.<CrystalSmall>([new CrystalSmall(), new CrystalSmall(), new CrystalSmall()]);
        this.buyButtonGold = new SimpleButton("Play for ", 0, Currency.INVALID);
        this.buyButtonFortune = new SimpleButton("Play for ", 0, Currency.INVALID);
        this.resetButton = new SimpleButton("Return", 0, Currency.INVALID);
        this.itemSwitchTimer = new Timer(this.SWITCH_DELAY_NORMAL);
        modalWidth = MODAL_WIDTH;
        modalHeight = MODAL_HEIGHT;
        super(modalWidth, modalHeight);
        modalIsOpen = true;
        this.makePlatforms();
        this.pscale = ParticleModalMap.PSCALE;
        this.particleMap = new ParticleModalMap();
        addChild(this.particleMap);
        this.largeCloseButton = new DialogCloseButton(1);
        addChild(this.largeCloseButton);
        this.largeCloseButton.y = 4;
        this.largeCloseButton.x = ((modalWidth - this.largeCloseButton.width) - 5);
        var _local_2:Injector = StaticInjectorContext.getInjector();
        this.client = _local_2.getInstance(AppEngineClient);
        this.account = _local_2.getInstance(Account);
        this.model = _local_2.getInstance(FortuneModel);
        this.fortuneInfo = this.model.getFortune();
        if (this.fortuneInfo == null) {
            return;
        }
        this.crystalMain.setXPos((modalWidth / 2));
        this.crystalMain.setYPos(crystalMainY);
        this.resetBalls();
        addChild(this.crystalMain);
        this.lastUpdate_ = getTimer();
        this.countdownTimer = new CountdownTimer();
        this.countdownTimer.timerComplete.add(this.onCountdownComplete);
        addChild(this.countdownTimer);
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        addEventListener(Event.REMOVED_FROM_STAGE, this.destruct);
        this.creditDisplay_ = new CreditDisplay(null, false, true);
        this.creditDisplay_.x = 734;
        this.creditDisplay_.y = 0;
        addChild(this.creditDisplay_);
        var _local_3:Player = StaticInjectorContext.getInjector().getInstance(GameModel).player;
        if (_local_3 != null) {
            this.creditDisplay_.draw(_local_3.credits_, 0, _local_3.tokens_);
        }
        if (_arg_1 != null) {
            this.gs_ = _arg_1;
            this.gs_.creditDisplay_.visible = false;
        }
        var _local_4:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 1172);
        _local_4 = TextureRedrawer.redraw(_local_4, 75, true, 0);
        this.crystalMain.addEventListener(MouseEvent.ROLL_OVER, this.displayInfoHover);
        this.crystalMain.addEventListener(MouseEvent.ROLL_OUT, this.removeInfoHover);
        this.onHoverPanel = InfoHoverPaneFactory.make(this.fortuneInfo.infoImage);
        this.onHoverPanel.x = (modalWidth - (this.onHoverPanel.width + 10));
        this.onHoverPanel.y = 10;
        this.addItemSwitch();
        this.InitTexts();
        this.setString(0);
        this.InitButtons();
        addChild(this.onHoverPanel);
        this.onHoverPanel.addEventListener(MouseEvent.ROLL_OVER, this.removeInfoHover);
        this.onHoverPanel.visible = false;
    }

    public static function doEaseOutInAnimation(_arg_1:DisplayObject, _arg_2:Object = null, _arg_3:Object = null, _arg_4:Function = null):void {
        var _local_5:GTween = new GTween(_arg_1, (0.5 * 1), _arg_2, {"ease": Sine.easeOut});
        _local_5.nextTween = new GTween(_arg_1, (0.5 * 1), _arg_3, {"ease": Sine.easeIn});
        _local_5.nextTween.paused = true;
        _local_5.nextTween.end();
        _local_5.nextTween.onComplete = _arg_4;
    }


    private function displayInfoHover(_arg_1:MouseEvent):void {
        this.onHoverPanel.visible = true;
    }

    private function removeInfoHover(_arg_1:MouseEvent):void {
        if (!(_arg_1.relatedObject is ItemWithTooltip)) {
            this.onHoverPanel.visible = false;
        }
    }

    private function InitButtons():void {
        this.goldPrice_ = int(this.fortuneInfo.priceFirstInGold);
        this.tokenPrice_ = int(this.fortuneInfo.priceFirstInToken);
        this.goldPriceSecond_ = int(this.fortuneInfo.priceSecondInGold);
        this.buyButtonGold.setPrice(this.goldPrice_, Currency.GOLD);
        this.buyButtonGold.setEnabled(true);
        this.buyButtonGold.x = (((modalWidth / 2) - 100) - this.buyButtonGold.width);
        this.buyButtonGold.y = (((modalHeight * 70) / 75) - (this.buyButtonGold.height / 2));
        addChild(this.buyButtonGold);
        this.buyButtonGold.addEventListener(MouseEvent.CLICK, this.onBuyWithGoldClick);
        this.buyButtonFortune.setPrice(this.tokenPrice_, Currency.FORTUNE);
        this.buyButtonFortune.setEnabled(true);
        this.resetButton.visible = false;
        addChild(this.resetButton);
        this.resetButton.setText("Return");
        addChild(this.buyButtonFortune);
        this.buyButtonFortune.x = ((modalWidth / 2) + 100);
        this.buyButtonFortune.y = (((modalHeight * 70) / 75) - (this.buyButtonFortune.height / 2));
        this.resetButton.x = ((modalWidth / 2) + 100);
        this.resetButton.y = (((modalHeight * 70) / 75) - (this.buyButtonFortune.height / 2));
        this.buyButtonFortune.addEventListener(MouseEvent.CLICK, this.onBuyWithFortuneClick);
    }

    private function InitTexts():void {
        var _local_4:TextField;
        texts_ = new Vector.<TextField>();
        var _local_1:Vector.<String> = Vector.<String>(["HOW WILL YOU PLAY?", "THE FIVE MASTERS OF GOZOR WILL DETERMINE YOUR PRIZE!", "HERE'S WHAT YOU CAN WIN!", "Shuffling!", "PICK ONE TO WIN A PRIZE!", "YOU WON! ITEMS WILL BE PLACED IN YOUR GIFT CHEST", "TWO ITEMS LEFT! TAKE ANOTHER SHOT!", "PICK A SECOND PRIZE!", "PLAY AGAIN?", "Choose now or I will choose for you!", "Determining Prizes!", "Sorting Loot!", "What can you win?", "Big Prizes! Big Orbs! I love it!", "Wooah! Awesome lewt!", "Processing hadoop data..."]);
        var _local_2:TextFormat = new TextFormat();
        _local_2.size = 24;
        _local_2.font = "Myriad Pro";
        _local_2.bold = false;
        _local_2.align = TextFormatAlign.LEFT;
        _local_2.leftMargin = 0;
        _local_2.indent = 0;
        _local_2.leading = 0;
        var _local_3:uint;
        while (_local_3 < _local_1.length) {
            _local_4 = new TextField();
            _local_4.text = _local_1[_local_3];
            _local_4.textColor = 0xFFFF00;
            _local_4.autoSize = TextFieldAutoSize.CENTER;
            _local_4.selectable = false;
            _local_4.defaultTextFormat = _local_2;
            _local_4.setTextFormat(_local_2);
            _local_4.filters = [new GlowFilter(0xFFFFFF, 1, 2, 2, 1.5, 1)];
            texts_.push(_local_4);
            _local_3++;
        }
    }

    private function setString(_arg_1:int):void {
        if (this.parent == null) {
            return;
        }
        if ((((this.currentString >= 0)) && (!((texts_[this.currentString].parent == null))))) {
            removeChild(texts_[this.currentString]);
        }
        if (_arg_1 < 0) {
            return;
        }
        this.currentString = _arg_1;
        var _local_2:TextField = texts_[this.currentString];
        _local_2.x = ((modalWidth / 2) - (_local_2.width / 2));
        _local_2.y = (((modalHeight * 66) / 75) - (_local_2.height / 2));
        addChild(texts_[this.currentString]);
    }

    private function destruct(_arg_1:Event):void {
        this.largeCloseButton.clicked.removeAll();
        modalIsOpen = false;
        closed.dispatch();
        closed.removeAll();
        this.itemSwitchTimer.removeEventListener(TimerEvent.TIMER, this.onItemSwitch);
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        removeEventListener(Event.REMOVED_FROM_STAGE, this.destruct);
        this.countdownTimer.timerComplete.removeAll();
        this.countdownTimer.end();
        this.countdownTimer = null;
        this.buyButtonsDisable();
        this.ballClickDisable();
        this.crystalMain.removeEventListener(MouseEvent.ROLL_OVER, this.displayInfoHover);
        this.crystalMain.removeEventListener(MouseEvent.ROLL_OUT, this.removeInfoHover);
        this.onHoverPanel.removeEventListener(MouseEvent.ROLL_OVER, this.removeInfoHover);
        this.resetButton.removeEventListener(MouseEvent.CLICK, this.onResetClick);
        if (this.gs_ != null) {
            this.gs_.creditDisplay_.visible = false;
        }
    }

    private function onItemSwitch(_arg_1:TimerEvent = null):void {
        var _local_5:ItemWithTooltip;
        this.tooltipItemIDIndex++;
        if (this.tooltipItems == null) {
            this.tooltipItems = Vector.<ItemWithTooltip>([new ItemWithTooltip(this.fortuneInfo._rollsWithContentsUnique[this.tooltipItemIDIndex], ITEM_SIZE_IN_MC), new ItemWithTooltip(this.fortuneInfo._rollsWithContentsUnique[(this.tooltipItemIDIndex + 1)], ITEM_SIZE_IN_MC)]);
        }
        if (this.tooltipItemIDIndex >= this.fortuneInfo._rollsWithContentsUnique.length) {
            this.tooltipItemIDIndex = 0;
        }
        var _local_2:int = (this.tooltipItemIDIndex % 2);
        if (((!((this.tooltipItems[this.currenttooltipItem] == null))) && (!((this.tooltipItems[this.currenttooltipItem].parent == null))))) {
            _local_5 = this.tooltipItems[this.currenttooltipItem];
            this.doEaseInAnimation(_local_5, {"alpha": 0}, this.removeChildAfterTween);
        }
        var _local_3:ItemWithTooltip = new ItemWithTooltip(this.fortuneInfo._rollsWithContentsUnique[this.tooltipItemIDIndex], ITEM_SIZE_IN_MC, true);
        _local_3.onMouseOver.add(this.onItemSwitchPause);
        _local_3.onMouseOut.add(this.onItemSwitchContinue);
        _local_3.setXPos(this.crystalMain.getCenterX());
        _local_3.setYPos(this.crystalMain.getCenterY());
        this.tooltipItems[_local_2] = _local_3;
        _local_3.alpha = 0;
        addChild(_local_3);
        this.doEaseInAnimation(_local_3, {"alpha": 1});
        this.currenttooltipItem = _local_2;
        var _local_4:Player = StaticInjectorContext.getInjector().getInstance(GameModel).player;
        if (((!((this.creditDisplay_ == null))) && (!((_local_4 == null))))) {
            this.creditDisplay_.draw(_local_4.credits_, 0, _local_4.tokens_);
        }
    }

    private function removeChildAfterTween(_arg_1:GTween):void {
        if (_arg_1.target.parent != null) {
            _arg_1.target.parent.removeChild(_arg_1.target);
        }
    }

    public function onItemSwitchPause():void {
        this.itemSwitchTimer.stop();
    }

    public function onItemSwitchContinue():void {
        this.itemSwitchTimer.start();
        this.onItemSwitch();
    }

    public function addItemSwitch():void {
        this.itemSwitchTimer.delay = this.SWITCH_DELAY_NORMAL;
        this.itemSwitchTimer.addEventListener(TimerEvent.TIMER, this.onItemSwitch);
        this.onItemSwitchContinue();
    }

    private function removeItemSwitch():void {
        this.itemSwitchTimer.removeEventListener(TimerEvent.TIMER, this.onItemSwitch);
        var _local_1:int;
        while (_local_1 < 2) {
            if (((!((this.tooltipItems[_local_1] == null))) && (!((this.tooltipItems[_local_1].parent == null))))) {
                this.tooltipItems[_local_1].alpha = 0;
                this.tooltipItems[_local_1].onMouseOut.removeAll();
                this.tooltipItems[_local_1].onMouseOver.removeAll();
                this.tooltipItems[_local_1].parent.removeChild(this.tooltipItems[_local_1]);
            }
            _local_1++;
        }
        this.onItemSwitchPause();
    }

    private function canUseFortuneModal():Boolean {
        return (FortuneModel.HAS_FORTUNES);
    }

    private function doEaseInAnimation(_arg_1:DisplayObject, _arg_2:Object = null, _arg_3:Function = null):void {
        var _local_4:GTween = new GTween(_arg_1, 0.5, _arg_2, {
            "ease": Sine.easeOut,
            "onComplete": _arg_3
        });
    }

    private function onCountdownComplete():void {
        var _local_2:int;
        var _local_1:CrystalSmall;
        do {
            _local_2 = int((Math.random() * 3));
            if ((((this.state == STATE_ROUND_1)) || (!((this.crystals[_local_2] == this.crystalClicked))))) {
                _local_1 = this.crystals[_local_2];
            }
        } while (_local_1 == null);
        this.smallBallClick(_local_1);
    }

    protected function makePlatforms():void {
        var _local_1:ImageSprite;
        this.platformMain = new Sprite();
        _local_1 = new ImageSprite(new fortunePlatformEmbed2(), 500, 500);
        _local_1.x = (-(_local_1.width) / 2);
        _local_1.y = (-(_local_1.height) / 2);
        this.platformMain.addChild(_local_1);
        this.platformMain.x = (modalWidth / 2);
        this.platformMain.y = crystalMainY;
        this.platformMain.alpha = 0.25;
        addChild(this.platformMain);
        this.platformMainSub = new Sprite();
        _local_1 = new ImageSprite(new fortunePlatformEmbed(), 700, 700);
        _local_1.x = (-(_local_1.width) / 2);
        _local_1.y = (-(_local_1.height) / 2);
        this.platformMainSub.addChild(_local_1);
        this.platformMainSub.x = (modalWidth / 2);
        this.platformMainSub.y = crystalMainY;
        this.platformMainSub.alpha = 0.15;
        addChild(this.platformMainSub);
    }

    override protected function makeModalBackground():Sprite {
        var _local_1:Sprite = new Sprite();
        var _local_2:DisplayObject = new backgroundImageEmbed();
        _local_2.width = modalWidth;
        _local_2.height = modalHeight;
        _local_2.alpha = 0.7;
        _local_1.addChild(_local_2);
        return (_local_1);
    }

    private function onResetClick(_arg_1:MouseEvent):void {
        this.resetButton.removeEventListener(MouseEvent.CLICK, this.onResetClick);
        this.resetGame();
    }

    private function onBuyWithGoldClick(_arg_1:MouseEvent):void {
        this.onFirstBuySub(Currency.GOLD);
    }

    private function onBuyWithFortuneClick(_arg_1:MouseEvent):void {
        this.onFirstBuySub(Currency.FORTUNE);
    }

    private function onFirstBuySub(_arg_1:int):void {
        var _local_4:OpenDialogSignal;
        if (!this.canUseFortuneModal()) {
            this.fortuneEventOver();
        }
        var _local_2:Player = StaticInjectorContext.getInjector().getInstance(GameModel).player;
        if (_local_2 != null) {
            if ((((((_arg_1 == Currency.GOLD)) && ((this.state == STATE_ROUND_2)))) && (((_local_2.credits_ - this.goldPriceSecond_) < 0)))) {
                _local_4 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
                _local_4.dispatch(new NotEnoughGoldDialog());
                return;
            }
            if ((((_arg_1 == Currency.GOLD)) && (((_local_2.credits_ - this.goldPrice_) < 0)))) {
                _local_4 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
                _local_4.dispatch(new NotEnoughGoldDialog());
                return;
            }
            if ((((_arg_1 == Currency.FORTUNE)) && (((_local_2.tokens_ - this.tokenPrice_) < 0)))) {
                return;
            }
        }
        this.itemSwitchTimer.delay = this.SWITCH_DELAY_FAST;
        this.crystalMain.setAnimationStage(CrystalMain.ANIMATION_STAGE_WAITING);
        var _local_3:Object = this.makeBasicParams();
        if (_arg_1 == Currency.FORTUNE) {
            _local_3.currency = 2;
        }
        else {
            if (_arg_1 == Currency.GOLD) {
                _local_3.currency = 0;
            }
            else {
                return;
            }
        }
        if (this.state == STATE_ROUND_1) {
            _local_3.status = 0;
            this.crystalMain.removeEventListener(MouseEvent.ROLL_OVER, this.displayInfoHover);
        }
        if ((((this.state == STATE_ROUND_1)) && (!(this.client.requestInProgress())))) {
            this.buyButtonsDisable();
            this.boughtWithGold = (_arg_1 == Currency.GOLD);
            if (_local_2 != null) {
                if (this.boughtWithGold) {
                    _local_2.credits_ = (_local_2.credits_ - this.goldPrice_);
                    this.creditDisplay_.draw(_local_2.credits_, 0, _local_2.tokens_);
                }
                else {
                    if ((_local_2.tokens_ - this.tokenPrice_) < 0) {
                        return;
                    }
                    _local_2.tokens_ = (_local_2.tokens_ - this.tokenPrice_);
                    this.creditDisplay_.draw(_local_2.credits_, 0, _local_2.tokens_);
                }
            }
            this.client.sendRequest("/account/playFortuneGame", _local_3);
            this.setString((10 + int((Math.random() * 6))));
            this.client.complete.addOnce(this.onFirstBuyComplete);
            this.buyButtonGold.visible = false;
            this.buyButtonFortune.visible = false;
        }
        else {
            if (this.state == STATE_ROUND_2) {
                this.buyButtonsDisable();
                this.onFirstBuyAnimateSub();
                _local_2 = StaticInjectorContext.getInjector().getInstance(GameModel).player;
                if (_local_2 != null) {
                    _local_2.credits_ = (_local_2.credits_ - this.goldPriceSecond_);
                    this.creditDisplay_.draw(_local_2.credits_, 0, _local_2.tokens_);
                }
                this.buyButtonGold.visible = false;
                this.resetButton.visible = false;
            }
        }
    }

    private function onFirstBuyComplete(_arg_1:Boolean, _arg_2:*):void {
        var _local_3:XML;
        var _local_4:Player;
        var _local_5:Vector.<int>;
        var _local_6:int;
        var _local_7:Boolean;
        var _local_8:Number;
        var _local_9:Number;
        var _local_10:Number;
        var _local_11:Number;
        var _local_12:int;
        var _local_13:Number;
        var _local_14:Number;
        var _local_15:Number;
        var _local_16:Number;
        var _local_17:String;
        if (_arg_1) {
            _local_3 = new XML(_arg_2);
            this.items = _local_3.Candidates.split(",");
            _local_4 = StaticInjectorContext.getInjector().getInstance(GameModel).player;
            if (_local_4 != null) {
                if (_local_3.hasOwnProperty("Gold")) {
                    _local_4.credits_ = int(_local_3.Gold);
                    this.creditDisplay_.draw(_local_4.credits_, 0, _local_4.tokens_);
                }
                else {
                    if (_local_3.hasOwnProperty("FortuneToken")) {
                        _local_4.tokens_ = int(_local_3.FortuneToken);
                        this.creditDisplay_.draw(_local_4.credits_, 0, _local_4.tokens_);
                    }
                }
            }
            _local_5 = Vector.<int>([0, 2, 1]);
            _local_6 = Math.floor((Math.random() * 3));
            _local_7 = (Math.random() > 0.5);
            _local_8 = this.crystalMain.getCenterX();
            _local_9 = this.crystalMain.getCenterY();
            _local_10 = this.crystals[_local_5[_local_6]].getCenterX();
            _local_11 = this.crystals[_local_5[_local_6]].getCenterY();
            _local_12 = 0;
            _local_13 = _local_8;
            _local_14 = _local_9;
            _local_15 = 0.25;
            _local_16 = 1.2;
            this.removeItemSwitch();
            for each (_local_17 in this.items) {
                if (_local_12 == 0) {
                    new TimerCallback(_local_15, this.doLightning, _local_8, _local_9, _local_10, _local_11);
                    new TimerCallback((_local_15 + 0.1), this.crystals[_local_5[_local_6]].doItemShow, int(_local_17));
                }
                else {
                    _local_10 = this.crystals[_local_5[_local_6]].getCenterX();
                    _local_11 = this.crystals[_local_5[_local_6]].getCenterY();
                    new TimerCallback(_local_15, this.doLightning, _local_13, _local_14, _local_10, _local_11);
                    new TimerCallback((_local_15 + 0.1), this.crystals[_local_5[_local_6]].doItemShow, int(_local_17));
                }
                _local_13 = _local_10;
                _local_14 = _local_11;
                _local_15 = (_local_15 + _local_16);
                _local_12++;
                if (_local_7) {
                    _local_6 = ((_local_6 + 1) % 3);
                }
                else {
                    _local_6 = (((--_local_6) < 0) ? 2 : _local_6);
                }
            }
            new TimerCallback(this.SHOW_PRIZES_TIME, this.onFirstBuyAnimateSub);
        }
        else {
            this.handleError();
        }
    }

    private function onFirstBuyAnimateSub():void {
        if ((((this.state == STATE_ROUND_2)) && (!((this.crystalClicked == null))))) {
            this.resetBallsRound2();
        }
        var _local_1:int;
        while (_local_1 < 3) {
            this.crystals[_local_1].removeItemReveal();
            this.crystals[_local_1].saveReturnPotion();
            this.crystals[_local_1].setAnimation(6, 7);
            this.crystals[_local_1].setAnimationDuration(50);
            _local_1++;
        }
        this.setGameStage(this.GAME_STAGE_SPIN);
        this.crystalMain.setAnimationStage(CrystalMain.ANIMATION_STAGE_INNERROTATION);
        new TimerCallback(this.SPIN_TIME, this.onFirstBuyAnimateComplete);
        this.setString(3);
    }

    private function onFirstBuyAnimateComplete():void {
        this.setGameStage(this.GAME_STAGE_IDLE);
        if (this.state == STATE_ROUND_2) {
            this.setString(7);
        }
        else {
            this.setString(4);
        }
        this.ballClickEnable(this.crystalClicked);
        this.crystalMain.setAnimationStage(CrystalMain.ANIMATION_STAGE_BUZZING);
        this.doNova(this.crystalMain.getCenterX(), this.crystalMain.getCenterY(), 10, 0xFFFF);
        var _local_1:int;
        while (_local_1 < 3) {
            if (!(((this.state == STATE_ROUND_2)) && ((this.crystals[_local_1] == this.crystalClicked)))) {
                this.crystals[_local_1].setActive2();
                this.crystals[_local_1].doItemReturn();
                new TimerCallback(this.NOVA_DELAY_TIME, this.doNova, int(this.crystals[_local_1].returnCenterX()), int(this.crystals[_local_1].returnCenterY()), 5, 0xFFFF);
                new TimerCallback(this.NOVA_DELAY_TIME, this.crystals[_local_1].setAnimationPulse);
            }
            _local_1++;
        }
        if (this.countdownTimer == null) {
            return;
        }
        new TimerCallback(this.NOVA_DELAY_TIME, this.crystalMain.setAnimationStage, CrystalMain.ANIMATION_STAGE_PULSE);
        this.countdownTimer.start(this.COUNTDOWN_AMOUNT);
        this.countdownTimer.setXPos(this.crystalMain.getCenterX());
        this.countdownTimer.setYPos(this.crystalMain.getCenterY());
        new TimerCallback(7, this.setCountdownWarningString);
        this.chooseingState = true;
    }

    private function setCountdownWarningString():void {
        if (((!((this.countdownTimer == null))) && (this.countdownTimer.isRunning()))) {
            this.setString(9);
        }
    }

    private function handleError():void {
        var _local_1:OpenDialogSignal;
        _local_1 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
        var _local_2:Dialog = new Dialog("MysteryBoxRollModal.purchaseFailedString", "MysteryBoxRollModal.pleaseTryAgainString", "MysteryBoxRollModal.okString", null, null);
        _local_2.addEventListener(Dialog.LEFT_BUTTON, this.onErrorOk, false, 0, true);
        _local_1.dispatch(_local_2);
    }

    private function onErrorOk(_arg_1:Event):void {
        var _local_2:CloseDialogsSignal;
        _local_2 = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
        _local_2.dispatch();
    }

    private function fortuneEventOver():void {
        var _local_1:OpenDialogSignal;
        _local_1 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
        _local_1.dispatch(new DebugDialog("The Alchemist has left the Nexus.Please check back later.", "Oh no!"));
    }

    private function makeBasicParams():Object {
        var _local_1:Object = this.account.getCredentials();
        _local_1.gameId = this.fortuneInfo.id;
        return (_local_1);
    }

    private function onSmallBallClick(_arg_1:MouseEvent):void {
        this.smallBallClick(_arg_1.currentTarget);
    }

    private function smallBallClick(_arg_1:Object):void {
        var _local_2:int;
        var _local_3:int;
        while (_local_3 < 3) {
            if (this.crystals[_local_3] == _arg_1) {
                this.smallBallClickSub(_local_3, _local_2);
                this.crystals[_local_3].setAnimationClicked();
            }
            if (this.crystals[_local_3] != this.crystalClicked) {
                _local_2++;
            }
            this.crystals[_local_3].setGlowState(CrystalSmall.GLOW_STATE_FADE);
            _local_3++;
        }
        this.chooseingState = false;
    }

    private function smallBallClickSub(_arg_1:int, _arg_2:int):void {
        var _local_3:Object = this.makeBasicParams();
        _local_3.choice = _arg_2;
        _local_3.status = this.state;
        _local_3.currency = 0;
        if (!this.client.requestInProgress()) {
            this.countdownTimer.remove();
            this.ballClickDisable();
            this.crystalClicked = this.crystals[_arg_1];
            this.client.sendRequest("/account/playFortuneGame", _local_3);
            this.client.complete.addOnce(this.onSmallBallClickComplete);
        }
    }

    private function onSmallBallClickComplete(_arg_1:Boolean, _arg_2:*):void {
        var _local_3:XML;
        var _local_4:OpenDialogSignal;
        if (_arg_1) {
            _local_3 = new XML(_arg_2);
            if (this.state == STATE_ROUND_2) {
                new TimerCallback(0.25, this.doNova, this.crystalClicked.getCenterX(), this.crystalClicked.getCenterY(), 6, 0xFFFF);
                new TimerCallback(0.25, this.crystalClicked.doItemReveal, _local_3.Awards);
                new TimerCallback(this.DISPLAY_PRIZE_TIME_2, this.resetGame);
            }
            else {
                if (this.state == STATE_ROUND_1) {
                    this.state = STATE_ROUND_2;
                    new TimerCallback(this.DISPLAY_PRIZE_TIME_1, this.onSmallBallClickCompleteRound2, _local_3.Awards);
                    new TimerCallback(0.25, this.doNova, this.crystalClicked.getCenterX(), this.crystalClicked.getCenterY(), 6, 0xFFFF);
                    new TimerCallback(0.25, this.crystalClicked.doItemReveal, _local_3.Awards);
                }
            }
            new TimerCallback(0.5, this.setString, 5);
        }
        else {
            this.ballClickEnable(null);
            _local_4 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            if (this.state == STATE_ROUND_1) {
                _local_4.dispatch(new DebugDialog("You have run out of time to choose, but an item has been chosen for you.", "Oh no!"));
            }
            else {
                _local_4.dispatch(new DebugDialog("You have run out of time to choose.", "Oh no!"));
            }
        }
    }

    private function onSmallBallClickCompleteRound2(_arg_1:int):void {
        var _local_2:int;
        this.resetSpinCrystalsVars();
        this.buyButtonsEnable();
        this.buyButtonGold.setPrice(this.goldPriceSecond_, Currency.GOLD);
        this.buyButtonGold.visible = true;
        this.resetButton.visible = true;
        this.resetButton.addEventListener(MouseEvent.CLICK, this.onResetClick);
        _local_2 = 0;
        while (_local_2 < this.items.length) {
            if (int(this.items[_local_2]) == _arg_1) {
                this.items[_local_2] = this.items[(this.items.length - 1)];
            }
            _local_2++;
        }
        this.items.pop();
        _local_2 = 0;
        while (_local_2 < this.crystals.length) {
            if (this.crystals[_local_2] != this.crystalClicked) {
                this.crystals[_local_2].doItemShow(int(this.items.pop()));
            }
            _local_2++;
        }
        this.setString(6);
    }

    private function resetGame():void {
        this.state = STATE_ROUND_1;
        this.ballClickDisable();
        this.buyButtonsEnable();
        this.buyButtonGold.setPrice(this.goldPrice_, Currency.GOLD);
        this.buyButtonGold.visible = true;
        this.buyButtonFortune.visible = true;
        this.resetButton.visible = false;
        this.addItemSwitch();
        this.setString(0);
        this.resetSpinCrystalsVars();
        this.boughtWithGold = false;
        this.crystalMain.addEventListener(MouseEvent.ROLL_OVER, this.displayInfoHover);
        this.crystalMain.reset();
        var _local_1:int;
        while (_local_1 < 3) {
            this.crystals[_local_1].resetVars();
            _local_1++;
        }
        this.resetBalls();
    }

    private function resetSpinCrystalsVars():void {
        this.radius = INIT_RADIUS_FROM_MAINCRYTAL;
        this.dtBuildup = 0;
        this.direction = 8;
        this.spinSpeed = 0;
    }

    private function buyButtonsDisable():void {
        this.buyButtonGold.removeEventListener(MouseEvent.CLICK, this.onBuyWithGoldClick);
        this.buyButtonFortune.removeEventListener(MouseEvent.CLICK, this.onBuyWithFortuneClick);
    }

    private function buyButtonsEnable():void {
        if (this.state == STATE_ROUND_1) {
            this.buyButtonFortune.addEventListener(MouseEvent.CLICK, this.onBuyWithFortuneClick);
        }
        this.buyButtonGold.addEventListener(MouseEvent.CLICK, this.onBuyWithGoldClick);
    }

    private function ballClickDisable():void {
        var _local_1:int;
        while (_local_1 < 3) {
            this.crystals[_local_1].removeEventListener(MouseEvent.CLICK, this.onSmallBallClick);
            _local_1++;
        }
    }

    private function ballClickEnable(_arg_1:CrystalSmall = null):void {
        var _local_2:int;
        while (_local_2 < 3) {
            if (this.crystals[_local_2] == _arg_1) {
                this.crystals[_local_2].removeEventListener(MouseEvent.CLICK, this.onSmallBallClick);
            }
            else {
                this.crystals[_local_2].addEventListener(MouseEvent.CLICK, this.onSmallBallClick);
                this.crystals[_local_2].setMouseTracking(true);
            }
            _local_2++;
        }
    }

    private function resetBalls():void {
        var _local_3:Number;
        var _local_1:int = INIT_RADIUS_FROM_MAINCRYTAL;
        var _local_2:int;
        while (_local_2 < 3) {
            _local_3 = (((((_local_2 + 1) * 120) - 60) * Math.PI) / 180);
            this.crystals[_local_2].setXPos((this.crystalMain.getCenterX() + (_local_1 * Math.sin(_local_3))));
            this.crystals[_local_2].setYPos((this.crystalMain.getCenterY() + (_local_1 * Math.cos(_local_3))));
            if (this.crystals[_local_2].parent == null) {
                addChild(this.crystals[_local_2]);
            }
            else {
                if (this.crystals[_local_2].visible == false) {
                    this.crystals[_local_2].visible = true;
                }
            }
            this.crystals[_local_2].removeItemReveal();
            this.crystals[_local_2].setInactive();
            this.crystals[_local_2].reset();
            _local_2++;
        }
        this.crystalClicked = null;
    }

    private function resetBallsRound2():void {
        var _local_4:Number;
        var _local_1:int;
        var _local_2:int = INIT_RADIUS_FROM_MAINCRYTAL;
        if (((!((this.crystalClicked == null))) && (this.crystalClicked.parent))) {
            this.crystalClicked.visible = false;
            this.crystalClicked.setInactive();
        }
        var _local_3:int;
        while (_local_3 < 3) {
            if (this.crystals[_local_3] != this.crystalClicked) {
                _local_4 = ((((_local_1 * 120) - 60) * Math.PI) / 180);
                this.crystals[_local_3].setXPos((this.crystalMain.getCenterX() + (_local_2 * Math.sin(_local_4))));
                this.crystals[_local_3].setYPos((this.crystalMain.getCenterY() + (_local_2 * Math.cos(_local_4))));
                _local_1++;
            }
            _local_3++;
        }
    }

    public function spinCrystals():void {
        var _local_3:Number;
        var _local_1:int = ((200 * Math.abs(((int((getTimer() / 2)) % 1000) - 500))) / 1000);
        if (this.spinSpeed < this.MAX_SPIN_SPEED) {
            this.spinSpeed = (this.spinSpeed + 4);
        }
        var _local_2:int;
        while (_local_2 < 3) {
            _local_3 = ((((((_local_2 + 1) * (120 + this.spinSpeed)) - 60) - getTimer()) * Math.PI) / 180);
            this.crystals[_local_2].setXPos((this.crystalMain.getCenterX() + (this.radius * Math.sin(_local_3))));
            this.crystals[_local_2].setYPos((this.crystalMain.getCenterY() + (this.radius * Math.cos(_local_3))));
            _local_2++;
        }
        if (this.radius == INIT_RADIUS_FROM_MAINCRYTAL) {
            this.direction = (this.direction * -1);
        }
        if (this.radius < 0) {
            this.radius = 0;
        }
        else {
            if (this.spinSpeed == this.MAX_SPIN_SPEED) {
                this.radius = (this.radius - ((this.direction * 2.85) / this.SPIN_TIME));
            }
        }
    }

    public function onEnterFrame(_arg_1:Event):void {
        var _local_5:Number;
        var _local_2:int = getTimer();
        var _local_3:int = (_local_2 - this.lastUpdate_);
        fMouseX = mouseX;
        fMouseY = mouseY;
        if (this.gameStage_ == this.GAME_STAGE_SPIN) {
            this.spinCrystals();
            this.crystalMain.setAnimationDuration(((this.MAX_SPIN_SPEED + 80) - this.spinSpeed));
        }
        var _local_4:int;
        while (_local_4 < 3) {
            this.crystals[_local_4].update(_local_2, _local_3);
            _local_4++;
        }
        this.rotateAroundCenter(this.platformMain, 0.1);
        this.rotateAroundCenter(this.platformMainSub, -0.15);
        if (this.chooseingState) {
            _local_5 = Math.random();
            if (_local_5 < 0.05) {
                this.crystals[int(((_local_5 * 200) % 3))].setShake(true);
            }
        }
        this.draw(_local_2, _local_3);
    }

    public function rotateAroundCenter(_arg_1:DisplayObject, _arg_2:Number):void {
        if (_arg_2 < 0) {
            _arg_2 = (_arg_2 * -1);
            _arg_1.rotation = (Math.abs(((_arg_1.rotation - _arg_2) + 360)) % 360);
        }
        else {
            _arg_1.rotation = ((_arg_1.rotation + _arg_2) % 360);
        }
    }

    public function draw(_arg_1:int, _arg_2:int):void {
        this.crystalMain.drawAnimation(_arg_1, _arg_2);
        this.particleMap.update(_arg_1, _arg_2);
        this.particleMap.draw(null, _arg_1);
        this.lastUpdate_ = _arg_1;
    }

    private function doNova(_arg_1:Number, _arg_2:Number, _arg_3:int = 20, _arg_4:int = 12447231):void {
        var _local_5:GameObject;
        var _local_6:NovaEffect;
        if (this.particleMap != null) {
            _local_5 = new GameObject(null);
            _local_5.x_ = ParticleModalMap.getLocalPos(_arg_1);
            _local_5.y_ = ParticleModalMap.getLocalPos(_arg_2);
            _local_6 = new NovaEffect(_local_5, _arg_3, _arg_4);
            this.particleMap.addObj(_local_6, _local_5.x_, _local_5.y_);
        }
    }

    private function doLightning(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:int = 200, _arg_6:int = 12447231):void {
        if (this.parent == null) {
            return;
        }
        var _local_7:GameObject = new GameObject(null);
        _local_7.x_ = ParticleModalMap.getLocalPos(_arg_1);
        _local_7.y_ = ParticleModalMap.getLocalPos(_arg_2);
        var _local_8:WorldPosData = new WorldPosData();
        _local_8.x_ = ParticleModalMap.getLocalPos(_arg_3);
        _local_8.y_ = ParticleModalMap.getLocalPos(_arg_4);
        var _local_9:LightningEffect = new LightningEffect(_local_7, _local_8, _arg_6, _arg_5);
        this.particleMap.addObj(_local_9, _local_7.x_, _local_7.y_);
    }

    private function setGameStage(_arg_1:int):void {
        this.gameStage_ = _arg_1;
    }


}
}//package kabam.rotmg.fortune.components
