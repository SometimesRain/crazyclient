package kabam.rotmg.questrewards.view {
import com.company.assembleegameclient.map.ParticleModalMap;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.util.Currency;
import com.gskinner.motion.GTween;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import kabam.display.Loader.LoaderProxy;
import kabam.display.Loader.LoaderProxyConcrete;
import kabam.rotmg.account.core.view.EmptyFrame;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.questrewards.components.ModalItemSlot;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.components.LegacyBuyButton;

import org.osflash.signals.Signal;

public class QuestRewardsView extends EmptyFrame {

    public static const closed:Signal = new Signal();
    public static var backgroundImageEmbed:Class = QuestRewardsView_backgroundImageEmbed;
    public static var questCompleteBanner:Class = QuestRewardsView_questCompleteBanner;
    public static var dailyQuestBanner:Class = QuestRewardsView_dailyQuestBanner;
    public static var rewardgranted:Class = QuestRewardsView_rewardgranted;
    public static const MODAL_WIDTH:int = 600;
    public static const MODAL_HEIGHT:int = 600;

    private var rightSlot:ModalItemSlot;
    private var prevSlot:ModalItemSlot;
    private var nextSlot:ModalItemSlot;
    public var exchangeButton:LegacyBuyButton;
    private var infoImageLoader:LoaderProxy;
    private var infoImage:DisplayObject;
    private var leftCenter:int = -1;
    private var dqbanner:DisplayObject;

    public function QuestRewardsView():void {
        this.exchangeButton = new LegacyBuyButton("Turn in!", 36, 0, Currency.INVALID, true);
        this.infoImageLoader = new LoaderProxyConcrete();
        super(MODAL_WIDTH, MODAL_HEIGHT);
        this.rightSlot = new ModalItemSlot(true, true);
        this.rightSlot.hideOuterSlot(false);
        this.prevSlot = new ModalItemSlot();
        this.prevSlot.hideOuterSlot(true);
        this.nextSlot = new ModalItemSlot();
        this.nextSlot.hideOuterSlot(true);
    }

    public function init(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String):void {
        var _local_7:TextField;
        var _local_10:TextFormat;
        var _local_5:String = ("Tier " + _arg_1.toString());
        setTitle(_local_5, true);
        this.dqbanner = new dailyQuestBanner();
        addChild(this.dqbanner);
        this.dqbanner.x = (((modalWidth / 4) * 1.1) - (this.dqbanner.width / 2));
        this.dqbanner.y = ((modalHeight / 20) + 2);
        this.leftCenter = (this.dqbanner.x + (this.dqbanner.width / 2));
        title.setSize(20);
        title.setColor(16689154);
        title.x = (((modalWidth / 4) * 1.1) - (title.width / 2));
        title.y = ((this.dqbanner.y + this.dqbanner.height) + 5);
        title.setBold(false);
        if (title.textField != null) {
            _local_10 = title.getTextFormat(0, _local_5.length);
            _local_10.leading = 10;
            title.setTextFormat(_local_10, 0, _local_5.length);
        }
        var _local_6:TextFormat = new TextFormat();
        _local_6.size = 13;
        _local_6.font = "Myraid Pro";
        _local_6.align = TextFormatAlign.CENTER;
        _local_7 = new TextField();
        _local_7.defaultTextFormat = _local_6;
        _local_7.text = "All Quests refresh daily at 5pm Pacific Time";
        _local_7.wordWrap = true;
        _local_7.width = 600;
        _local_7.height = 200;
        _local_7.y = 554;
        _local_7.textColor = 16689154;
        _local_7.alpha = 0.8;
        _local_7.selectable = false;
        addChild(_local_7);
        var _local_8:String = LineBuilder.getLocalizedStringFromKey(ObjectLibrary.typeToDisplayId_[_arg_2]);
        this.constructDescription(_arg_3, _local_8);
        this.addCloseButton();
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        addChild(this.rightSlot);
        addChild(this.prevSlot);
        this.prevSlot.setCheckMark();
        if (_arg_1 == 1) {
            this.prevSlot.visible = false;
        }
        addChild(this.nextSlot);
        this.nextSlot.setQuestionMark();
        this.rightSlot.setUsageText("Drag the item from your inventory into the slot", 14, 0xFFFF);
        this.rightSlot.setActionButton(this.exchangeButton);
        addChild(this.exchangeButton);
        this.exchangeButton.setText("Turn in!");
        this.exchangeButton.scaleButtonWidth(1.3);
        this.exchangeButton.scaleButtonHeight(2.4);
        var _local_9:BitmapData = ObjectLibrary.getRedrawnTextureFromType(_arg_2, 80, true, false);
        this.rightSlot.setEmbeddedImage(new Bitmap(_local_9));
        ((this.infoImageLoader) && (this.infoImageLoader.unload()));
        this.infoImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onRewardLoadComplete);
        this.infoImageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onRewardLoadError);
        this.infoImageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR, this.onRewardLoadError);
        this.infoImageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, this.onRewardLoadError);
        this.infoImageLoader.load(new URLRequest(_arg_4));
        this.positionAssets();
    }

    private function positionAssets():void {
        this.rightSlot.x = (this.leftCenter - (this.rightSlot.width / 2));
        this.rightSlot.y = 350;
        this.prevSlot.width = (this.prevSlot.width * 0.8);
        this.prevSlot.height = (this.prevSlot.height * 0.8);
        this.prevSlot.x = (this.rightSlot.x - this.prevSlot.width);
        this.prevSlot.y = (this.rightSlot.y + ((82 - this.prevSlot.height) / 2));
        this.nextSlot.width = (this.nextSlot.width * 0.8);
        this.nextSlot.height = (this.nextSlot.height * 0.8);
        this.nextSlot.x = (this.rightSlot.x + this.rightSlot.width);
        this.nextSlot.y = (this.rightSlot.y + ((82 - this.nextSlot.height) / 2));
        this.exchangeButton.x = (this.leftCenter - (this.exchangeButton.width / 2));
        this.exchangeButton.y = (this.rightSlot.y + 100);
        this.exchangeButton.height = 50;
        background = this.makeModalBackground();
    }

    private function addInfoImageChild():void {
        if (this.infoImage == null) {
            return;
        }
        this.infoImage.alpha = 0;
        addChild(this.infoImage);
        var _local_1:int = 8;
        this.infoImage.x = ((desc.x + desc.width) + 1);
        this.infoImage.y = (modalHeight / 20);
        var _local_2:Shape = new Shape();
        var _local_3:Graphics = _local_2.graphics;
        _local_3.beginFill(0);
        _local_3.drawRect(0, 0, 600, 550);
        _local_3.endFill();
        addChild(_local_2);
        this.infoImage.mask = _local_2;
        new GTween(this.infoImage, 1.25, {"alpha": 1});
    }

    private function onRewardLoadComplete(_arg_1:Event):void {
        this.infoImageLoader.removeEventListener(Event.COMPLETE, this.onRewardLoadComplete);
        this.infoImageLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.onRewardLoadError);
        this.infoImageLoader.removeEventListener(IOErrorEvent.DISK_ERROR, this.onRewardLoadError);
        this.infoImageLoader.removeEventListener(IOErrorEvent.NETWORK_ERROR, this.onRewardLoadError);
        if (((!((this.infoImage == null))) && (!((this.infoImage.parent == null))))) {
            removeChild(this.infoImage);
        }
        this.infoImage = DisplayObject(this.infoImageLoader);
        this.addInfoImageChild();
    }

    private function onRewardLoadError(_arg_1:IOErrorEvent):void {
        this.infoImageLoader.removeEventListener(Event.COMPLETE, this.onRewardLoadComplete);
        this.infoImageLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.onRewardLoadError);
        this.infoImageLoader.removeEventListener(IOErrorEvent.DISK_ERROR, this.onRewardLoadError);
        this.infoImageLoader.removeEventListener(IOErrorEvent.NETWORK_ERROR, this.onRewardLoadError);
    }

    public function getItemSlot():ModalItemSlot {
        return (this.rightSlot);
    }

    public function getExchangeButton():LegacyBuyButton {
        return (this.exchangeButton);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        closeButton.clicked.remove(this.onClosed);
    }

    private function onClosed():void {
        closed.dispatch();
    }

    override protected function makeModalBackground():Sprite {
        x = 0;
        var _local_1:Sprite = new Sprite();
        var _local_2:DisplayObject = new backgroundImageEmbed();
        _local_2.width = modalWidth;
        _local_2.height = modalHeight;
        _local_2.alpha = 0.74;
        _local_1.addChild(_local_2);
        return (_local_1);
    }

    private function addCloseButton():void {
        var _local_1:DialogCloseButton = new DialogCloseButton(0.82);
        addChild(_local_1);
        _local_1.y = 4;
        _local_1.x = ((modalWidth - _local_1.width) - 5);
        _local_1.clicked.add(this.onClosed);
        closeButton = _local_1;
    }

    public function noNewQuests():void {
        this.addCloseButton();
        var _local_1:TextField = new TextField();
        var _local_2:String = "ALL QUESTS COMPLETED!";
        var _local_3:String = "";
        _local_1.text = ((_local_2 + "\n\n\n\n") + _local_3);
        _local_1.width = 600;
        var _local_4:FontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
        var _local_5:TextFormat = _local_4.apply(_local_1, 32, 0xFFFFFF, true, true);
        _local_1.selectable = false;
        _local_1.x = 0;
        _local_1.y = 150;
        _local_1.embedFonts = true;
        _local_1.filters = [new GlowFilter(49941)];
        addChild(new ParticleModalMap(1));
        addChild(_local_1);
        _local_1 = new TextField();
        _local_2 = "";
        _local_3 = "Return at 5pm Pacific Time for New Quests!";
        _local_1.text = ((_local_2 + "\n\n\n") + _local_3);
        _local_1.width = 600;
        _local_4.apply(_local_1, 17, 49941, false, true);
        _local_1.selectable = false;
        _local_1.x = 0;
        _local_1.y = 150;
        _local_1.embedFonts = true;
        _local_1.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(_local_1);
    }

    public function constructDescription(_arg_1:String, _arg_2:String = ""):void {
        var _local_4:String;
        var _local_6:TextFormat;
        var _local_3:int = _arg_1.indexOf("{goal}");
        if (_local_3 != -1) {
            _local_4 = _arg_1.split("{goal}").join(_arg_2);
            setDesc(_local_4, true);
        }
        else {
            _local_4 = _arg_1;
        }
        setDesc(_local_4, true);
        desc.setColor(16689154);
        desc.setBold(false);
        desc.setSize(15);
        desc.setTextWidth(315);
        desc.x = ((((modalWidth / 4) * 1.1) - (desc.width / 2)) + 3);
        desc.y = (((title) != null) ? ((title.y + title.height) + 6) : 165);
        desc.setAutoSize(TextFieldAutoSize.LEFT);
        desc.setHorizontalAlign("left");
        desc.filters = [new DropShadowFilter(0, 0, 0)];
        desc.setLeftMargin(14);
        var _local_5:TextFormat = desc.getTextFormat(0, _local_4.length);
        _local_5.leading = 4;
        desc.setTextFormat(_local_5, 0, _local_4.length);
        if (_local_3 != -1) {
            _local_6 = desc.getTextFormat(_local_3, (_local_3 + _arg_2.length));
            _local_6.color = 196098;
            _local_6.bold = true;
            desc.setTextFormat(_local_6, _local_3, (_local_3 + _arg_2.length));
        }
    }

    public function onQuestComplete():void {
        var _local_1:DisplayObject = new questCompleteBanner();
        _local_1.x = 120;
        _local_1.y = 180;
        _local_1.scaleX = 0.1;
        _local_1.scaleY = 0.1;
        new GTween(_local_1, 0.4, {
            "alpha": 1,
            "scaleX": 0.6,
            "scaleY": 0.6,
            "x": 30,
            "y": 130
        });
        addChild(_local_1);
        var _local_2:DisplayObject = new rewardgranted();
        _local_2.x = (this.infoImage.x + 4);
        _local_2.y = (this.infoImage.y + 4);
        _local_2.alpha = 0;
        addChild(_local_2);
        new GTween(_local_2, 0.4, {"alpha": 1});
        new GTween(desc, 0.4, {"alpha": 0.2});
        new GTween(this.dqbanner, 0.4, {"alpha": 0.2});
        new GTween(title, 0.4, {"alpha": 0.2});
        this.rightSlot.highLightAll(0x545454);
        this.rightSlot.stopOutLineAnimation();
    }

    public function onExchangeClick():void {
        this.rightSlot.playOutLineAnimation(-1);
    }


}
}//package kabam.rotmg.questrewards.view
