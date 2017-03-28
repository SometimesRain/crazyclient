package kabam.rotmg.classes.view {
import com.company.assembleegameclient.util.Currency;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.CharacterSkinState;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.util.components.RadioButton;
import kabam.rotmg.util.components.api.BuyButton;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class CharacterSkinListItem extends Sprite {

    public static const WIDTH:int = 420;
    public static const PADDING:int = 16;
    public static const HEIGHT:int = 60;
    private static const HIGHLIGHTED_COLOR:uint = 0x7B7B7B;
    private static const AVAILABLE_COLOR:uint = 0x5A5A5A;
    private static const LOCKED_COLOR:uint = 0x282828;

    private const grayscaleMatrix:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
    private const background:Shape = makeBackground();
    private const skinContainer:Sprite = makeSkinContainer();
    private const nameText:TextFieldDisplayConcrete = makeNameText();
    private const selectionButton:RadioButton = makeSelectionButton();
    private const lock:Bitmap = makeLock();
    private const lockText:TextFieldDisplayConcrete = makeLockText();
    private const buyButtonContainer:Sprite = makeBuyButtonContainer();
    private const limitedBanner:CharacterSkinLimitedBanner = makeLimitedBanner();
    public const buy:Signal = new NativeMappedSignal(buyButtonContainer, MouseEvent.CLICK);
    public const over:Signal = new Signal();
    public const out:Signal = new Signal();
    public const selected:Signal = selectionButton.changed;

    private var model:CharacterSkin;
    private var state:CharacterSkinState;
    private var isSelected:Boolean = false;
    private var skinIcon:Bitmap;
    private var buyButton:BuyButton;
    private var isOver:Boolean;

    public function CharacterSkinListItem() {
        this.state = CharacterSkinState.NULL;
        super();
    }

    private function makeBackground():Shape {
        var _local_1:Shape = new Shape();
        this.drawBackground(_local_1.graphics, WIDTH);
        addChild(_local_1);
        return (_local_1);
    }

    private function makeSkinContainer():Sprite {
        var _local_1:Sprite;
        _local_1 = new Sprite();
        _local_1.x = 8;
        _local_1.y = 4;
        addChild(_local_1);
        return (_local_1);
    }

    private function makeNameText():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete;
        _local_1 = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setBold(true);
        _local_1.x = 75;
        _local_1.y = 15;
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        addChild(_local_1);
        return (_local_1);
    }

    private function makeSelectionButton():RadioButton {
        var _local_1:RadioButton;
        _local_1 = new RadioButton();
        _local_1.setSelected(false);
        _local_1.x = ((WIDTH - _local_1.width) - 15);
        _local_1.y = ((HEIGHT / 2) - (_local_1.height / 2));
        addChild(_local_1);
        return (_local_1);
    }

    private function makeLock():Bitmap {
        var _local_1:Bitmap = new Bitmap();
        _local_1.scaleX = 2;
        _local_1.scaleY = 2;
        _local_1.visible = false;
        addChild(_local_1);
        return (_local_1);
    }

    public function setLockIcon(_arg_1:BitmapData):void {
        this.lock.bitmapData = _arg_1;
        this.lock.x = ((this.lockText.x - this.lock.width) - 5);
        this.lock.y = ((HEIGHT / 2) - (this.lock.height * 0.5));
    }

    private function makeLockText():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(14).setColor(0xFFFFFF);
        _local_1.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        addChild(_local_1);
        return (_local_1);
    }

    private function makeBuyButtonContainer():Sprite {
        var _local_1:Sprite = new Sprite();
        _local_1.x = (WIDTH - PADDING);
        _local_1.y = (HEIGHT * 0.5);
        addChild(_local_1);
        return (_local_1);
    }

    private function makeLimitedBanner():CharacterSkinLimitedBanner {
        var _local_1:CharacterSkinLimitedBanner;
        _local_1 = new CharacterSkinLimitedBanner();
        _local_1.readyForPositioning.addOnce(this.setLimitedBannerVisibility);
        _local_1.y = -1;
        _local_1.visible = false;
        addChild(_local_1);
        return (_local_1);
    }

    public function setBuyButton(_arg_1:BuyButton):void {
        this.buyButton = _arg_1;
        _arg_1.readyForPlacement.add(this.onReadyForPlacement);
        ((this.model) && (this.setCost()));
        this.buyButtonContainer.addChild(_arg_1);
        _arg_1.x = -(_arg_1.width);
        _arg_1.y = (-(_arg_1.height) * 0.5);
        this.buyButtonContainer.visible = (this.state == CharacterSkinState.PURCHASABLE);
        this.setLimitedBannerVisibility();
    }

    private function onReadyForPlacement():void {
        this.buyButton.x = -(this.buyButton.width);
    }

    public function setSkin(_arg_1:Bitmap):void {
        ((this.skinIcon) && (this.skinContainer.removeChild(this.skinIcon)));
        this.skinIcon = _arg_1;
        ((this.skinIcon) && (this.skinContainer.addChild(this.skinIcon)));
    }

    public function getModel():CharacterSkin {
        return (this.model);
    }

    public function setModel(_arg_1:CharacterSkin):void {
        ((this.model) && (this.model.changed.remove(this.onModelChanged)));
        this.model = _arg_1;
        ((this.model) && (this.model.changed.add(this.onModelChanged)));
        this.onModelChanged(this.model);
        addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
    }

    private function onModelChanged(_arg_1:CharacterSkin):void {
        this.state = ((this.model) ? this.model.getState() : CharacterSkinState.NULL);
        this.updateName();
        this.updateState();
        ((this.buyButton) && (this.setCost()));
        this.updateUnlockText();
        this.setLimitedBannerVisibility();
        this.setIsSelected(((this.model) && (this.model.getIsSelected())));
    }

    public function getState():CharacterSkinState {
        return (this.state);
    }

    private function updateName():void {
        this.nameText.setStringBuilder(new LineBuilder().setParams(((this.model) ? this.model.name : "")));
    }

    private function updateState():void {
        this.setButtonVisibilities();
        this.updateBackground();
        this.setEventListeners();
        this.updateGrayFilter();
    }

    private function setLimitedBannerVisibility():void {
        this.limitedBanner.visible = ((((((this.model) && (this.model.limited))) && (!((this.state == CharacterSkinState.OWNED))))) && (!((this.state == CharacterSkinState.PURCHASING))));
        this.limitedBanner.x = ((((((this.state == CharacterSkinState.LOCKED)) || (!(this.buyButton)))) ? (this.lock.x - 5) : ((this.buyButtonContainer.x + this.buyButton.x) - 15)) - this.limitedBanner.width);
    }

    private function setButtonVisibilities():void {
        var _local_1:Boolean = (this.state == CharacterSkinState.OWNED);
        var _local_2:Boolean = (this.state == CharacterSkinState.PURCHASABLE);
        var _local_3:Boolean = (this.state == CharacterSkinState.PURCHASING);
        var _local_4:Boolean = (this.state == CharacterSkinState.LOCKED);
        this.selectionButton.visible = _local_1;
        ((this.buyButtonContainer) && ((this.buyButtonContainer.visible = _local_2)));
        this.lock.visible = _local_4;
        this.lockText.visible = ((_local_4) || (_local_3));
    }

    private function setEventListeners():void {
        if (this.state == CharacterSkinState.OWNED) {
            this.addEventListeners();
        }
        else {
            this.removeEventListeners();
        }
    }

    private function setCost():void {
        var _local_1:int = ((this.model) ? this.model.cost : 0);
        this.buyButton.setPrice(_local_1, Currency.GOLD);
    }

    public function getIsSelected():Boolean {
        return (this.isSelected);
    }

    public function setIsSelected(_arg_1:Boolean):void {
        this.isSelected = ((_arg_1) && ((this.state == CharacterSkinState.OWNED)));
        this.selectionButton.setSelected(_arg_1);
        this.updateBackground();
    }

    private function updateUnlockText():void {
        if (((!((this.model == null))) && (!((this.model.unlockSpecial == null))))) {
            this.lockText.setStringBuilder(new StaticStringBuilder(this.model.unlockSpecial));
            this.lockText.setTextWidth(110);
            this.lockText.setWordWrap(true);
            this.lockText.setMultiLine(true);
            this.lockText.setAutoSize(TextFieldAutoSize.LEFT);
            this.lockText.setHorizontalAlign(TextFormatAlign.LEFT);
            this.lockText.setVerticalAlign(TextFieldAutoSize.CENTER);
            this.lockText.y = (HEIGHT / 7);
        }
        else {
            this.lockText.setStringBuilder((((this.state) == CharacterSkinState.PURCHASING) ? new LineBuilder().setParams(TextKey.PURCHASING_SKIN) : this.makeUnlockTextStringBuilder()));
            this.lockText.y = (HEIGHT / 2);
        }
        this.lockText.x = ((WIDTH - this.lockText.width) - 15);
        this.lock.x = ((this.lockText.x - this.lock.width) - 5);
    }

    private function makeUnlockTextStringBuilder():StringBuilder {
        var _local_1:LineBuilder = new LineBuilder();
        var _local_2:String = ((this.model) ? this.model.unlockLevel.toString() : "");
        return (_local_1.setParams(TextKey.UNLOCK_LEVEL_SKIN, {"level": _local_2}));
    }

    private function addEventListeners():void {
        addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function removeEventListeners():void {
        removeEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(_arg_1:MouseEvent):void {
        this.setIsSelected(true);
    }

    private function onOver(_arg_1:MouseEvent):void {
        this.isOver = true;
        this.updateBackground();
        this.over.dispatch();
    }

    private function onOut(_arg_1:MouseEvent):void {
        this.isOver = false;
        this.updateBackground();
        this.out.dispatch();
    }

    private function updateBackground():void {
        var _local_1:ColorTransform = this.background.transform.colorTransform;
        _local_1.color = this.getColor();
        this.background.transform.colorTransform = _local_1;
    }

    private function getColor():uint {
        if (this.state.isDisabled()) {
            return (LOCKED_COLOR);
        }
        if (((this.isSelected) || (this.isOver))) {
            return (HIGHLIGHTED_COLOR);
        }
        return (AVAILABLE_COLOR);
    }

    private function updateGrayFilter():void {
        filters = (((this.state) == CharacterSkinState.PURCHASING) ? [this.grayscaleMatrix] : []);
    }

    public function setWidth(_arg_1:int):void {
        this.buyButtonContainer.x = (_arg_1 - PADDING);
        this.lockText.x = ((_arg_1 - this.lockText.width) - 15);
        this.lock.x = ((this.lockText.x - this.lock.width) - 5);
        this.selectionButton.x = ((_arg_1 - this.selectionButton.width) - 15);
        this.setLimitedBannerVisibility();
        this.drawBackground(this.background.graphics, _arg_1);
    }

    private function drawBackground(_arg_1:Graphics, _arg_2:int):void {
        _arg_1.clear();
        _arg_1.beginFill(AVAILABLE_COLOR);
        _arg_1.drawRect(0, 0, _arg_2, HEIGHT);
        _arg_1.endFill();
    }


}
}//package kabam.rotmg.classes.view
