package kabam.rotmg.mysterybox.components {
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.assembleegameclient.util.Currency;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;
import flash.utils.getTimer;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.util.components.LegacyBuyButton;
import kabam.rotmg.util.components.UIAssetsHelper;

public class MysteryBoxSelectEntry extends Sprite {

    public static var redBarEmbed:Class = MysteryBoxSelectEntry_redBarEmbed;

    private var buyButton:LegacyBuyButton;
    private const newString:String = "MysteryBoxSelectEntry.newString";
    private const onSaleString:String = "MysteryBoxSelectEntry.onSaleString";
    private const saleEndString:String = "MysteryBoxSelectEntry.saleEndString";

    public var mbi:MysteryBoxInfo;
    private var leftNavSprite:Sprite;
    private var rightNavSprite:Sprite;
    private var iconImage:DisplayObject;
    private var infoImageBorder:PopupWindowBackground;
    private var infoImage:DisplayObject;
    private var newText:TextFieldDisplayConcrete;
    private var sale:TextFieldDisplayConcrete;
    private var left:TextFieldDisplayConcrete;
    private var hoverState:Boolean = false;
    private var descriptionShowing:Boolean = false;
    private var redbar:DisplayObject;
    private var soldOut:Boolean;
    private var quantity_:int;
    private var title:TextFieldDisplayConcrete;

    public function MysteryBoxSelectEntry(_arg_1:MysteryBoxInfo):void {
        var _local_2:DisplayObject;
        this.redbar = new redBarEmbed();
        this.redbar.y = -5;
        this.redbar.width = (MysteryBoxSelectModal.modalWidth - 5);
        this.redbar.height = (MysteryBoxSelectModal.aMysteryBoxHeight - 8);
        addChild(this.redbar);
        _local_2 = new redBarEmbed();
        _local_2.y = 0;
        _local_2.width = (MysteryBoxSelectModal.modalWidth - 5);
        _local_2.height = ((MysteryBoxSelectModal.aMysteryBoxHeight - 8) + 5);
        _local_2.alpha = 0;
        addChild(_local_2);
        this.mbi = _arg_1;
        this.quantity_ = 1;
        this.title = this.getText(this.mbi.title, 74, 20, 18, true);
        this.title.textChanged.addOnce(this.updateTextPosition);
        addChild(this.title);
        this.addNewText();
        this.buyButton = new LegacyBuyButton("", 16, 0, Currency.INVALID, false, this.mbi.isOnSale());
        if(this.mbi.unitsLeft == 0)
        {
            this.buyButton.setText(LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutButton"));
        }
        else if(this.mbi.isOnSale())
        {
            this.buyButton.setPrice(this.mbi.saleAmount, this.mbi.saleCurrency);
        }
        else
        {
            this.buyButton.setPrice(this.mbi.priceAmount, this.mbi.priceCurrency);
        }
        this.buyButton.x = (MysteryBoxSelectModal.modalWidth - 120);
        this.buyButton.y = 16;
        this.buyButton._width = 70;
        this.addSaleText();
        if(this.mbi.unitsLeft > 0 || this.mbi.unitsLeft == -1)
        {
            this.buyButton.addEventListener(MouseEvent.CLICK, this.onBoxBuy);
        }
        addChild(this.buyButton);
        this.iconImage = this.mbi.iconImage;
        this.infoImage = this.mbi.infoImage;
        if (this.iconImage == null) {
            this.mbi.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onImageLoadComplete);
        }
        else {
            this.addIconImageChild();
        }
        if (this.infoImage == null) {
            this.mbi.infoImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onInfoLoadComplete);
        }
        else {
            this.addInfoImageChild();
        }
        this.mbi.quantity = this.quantity_.toString();
        if(this.mbi.unitsLeft > 0 || this.mbi.unitsLeft == -1)
        {
            this.leftNavSprite = UIAssetsHelper.createLeftNevigatorIcon(UIAssetsHelper.LEFT_NEVIGATOR, 3);
            this.leftNavSprite.x = this.buyButton.x + this.buyButton.width + 45;
            this.leftNavSprite.y = this.buyButton.y + this.buyButton.height / 2 - 2;
            this.leftNavSprite.addEventListener(MouseEvent.CLICK, this.onClick);
            addChild(this.leftNavSprite);
            this.rightNavSprite = UIAssetsHelper.createLeftNevigatorIcon(UIAssetsHelper.RIGHT_NEVIGATOR, 3);
            this.rightNavSprite.x = this.buyButton.x + this.buyButton.width + 45;
            this.rightNavSprite.y = this.buyButton.y + this.buyButton.height / 2 - 16;
            this.rightNavSprite.addEventListener(MouseEvent.CLICK, this.onClick);
            addChild(this.rightNavSprite);
        }
        this.addUnitsLeftText();
        addEventListener(MouseEvent.ROLL_OVER, this.onHover);
        addEventListener(MouseEvent.ROLL_OUT, this.onRemoveHover);
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function updateTextPosition():void
    {
        this.title.y = Math.round((this.redbar.height - (this.title.getTextHeight() + (this.title.textField.numLines == 1 ? 8 : 10))) / 2);
        if((this.mbi.isNew() || this.mbi.isOnSale()) && this.title.textField.numLines == 2)
        {
            this.title.y = this.title.y + 6;
        }
    }

    public function updateContent():void
    {
        if(this.left)
        {
            this.left.setStringBuilder(new LineBuilder().setParams(this.mbi.unitsLeft + " " + LineBuilder.getLocalizedStringFromKey("MysteryBoxSelectEntry.left")));
        }
    }

    private function addUnitsLeftText():void
    {
        var _local_1:uint = 0;
        var _loc2_:int = 0;
        if(this.mbi.unitsLeft >= 0)
        {
            _loc2_ = this.mbi.unitsLeft / this.mbi.totalUnits;
            if(_loc2_ <= 0.1)
            {
                _local_1 = 0xFF0000;
            }
            else if(_loc2_ <= 0.5)
            {
                _local_1 = 0xFFA900;
            }
            else
            {
                _local_1 = 0x00FF00;
            }
            this.left = this.getText(this.mbi.unitsLeft + " left", 20, 46, 11).setColor(_local_1);
            addChild(this.left);
        }
    }

    private function markAsSold():void
    {
        this.buyButton.setPrice(0, Currency.INVALID);
        this.buyButton.setText(LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutButton"));
        if(this.leftNavSprite && this.leftNavSprite.parent == this)
        {
            removeChild(this.leftNavSprite);
            this.leftNavSprite.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        if(this.rightNavSprite && this.rightNavSprite.parent == this)
        {
            removeChild(this.rightNavSprite);
            this.rightNavSprite.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
    }

    private function onHover(_arg_1:MouseEvent):void {
        this.hoverState = true;
        this.addInfoImageChild();
    }

    private function onRemoveHover(_arg_1:MouseEvent):void {
        this.hoverState = false;
        this.removeInfoImageChild();
    }

    private function onClick(_arg_1:MouseEvent):void {
        switch (_arg_1.currentTarget) {
            case this.rightNavSprite:
                if (this.quantity_ == 1) {
                    this.quantity_ = (this.quantity_ + 4);
                }
                else {
                    if (this.quantity_ < 10) {
                        this.quantity_ = (this.quantity_ + 5);
                    }
                }
                break;
            case this.leftNavSprite:
                if (this.quantity_ == 10) {
                    this.quantity_ = (this.quantity_ - 5);
                }
                else {
                    if (this.quantity_ > 1) {
                        this.quantity_ = (this.quantity_ - 4);
                    }
                }
                break;
        }
        this.mbi.quantity = this.quantity_.toString();
        if (this.mbi.isOnSale()) {
            this.buyButton.setPrice((this.mbi.saleAmount * this.quantity_), this.mbi.saleCurrency);
        }
        else {
            this.buyButton.setPrice((this.mbi.priceAmount * this.quantity_), this.mbi.priceCurrency);
        }
    }

    private function addNewText():void {
        if(this.mbi.isNew() && !this.mbi.isOnSale()) {
            this.newText = this.getText(this.newString, 74, 0).setColor(0xFFDE00);
            addChild(this.newText);
        }
    }

    private function onEnterFrame(_arg_1:Event):void {
        var _local_2:Number = (1.05 + (0.05 * Math.sin((getTimer() / 200))));
        if(this.sale)
        {
            this.sale.scaleX = _local_2;
            this.sale.scaleY = _local_2;
        }
        if (this.newText) {
            this.newText.scaleX = _local_2;
            this.newText.scaleY = _local_2;
        }
        if(this.mbi.unitsLeft == 0 && !this.soldOut) {
            this.soldOut = true;
            this.markAsSold();
        }
    }

    private function addSaleText():void {
        var _local_1:LineBuilder;
        var _local_2:TextFieldDisplayConcrete;
        var _local_3:TextFieldDisplayConcrete;
        if (this.mbi.isOnSale()) {
            this.sale = this.getText(this.onSaleString, 74, 0).setColor(0x00FF00);
            addChild(this.sale);
            _local_1 = this.mbi.getSaleTimeLeftStringBuilder();
            _local_2 = this.getText("", this.buyButton.x, this.buyButton.y + this.buyButton.height + 10, 10).setColor(0xFF0000);
            _local_2.setStringBuilder(_local_1);
            addChild(_local_2);
            _local_3 = this.getText(LineBuilder.getLocalizedStringFromKey("MysteryBoxSelectEntry.was") + " " + this.mbi.priceAmount + " " + this.mbi.currencyName, this.buyButton.x, this.buyButton.y - 14, 10).setColor(0xFF0000);
            addChild(_local_3);
        }
    }

    private function onImageLoadComplete(_arg_1:Event):void {
        this.mbi.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onImageLoadComplete);
        this.iconImage = DisplayObject(this.mbi.loader);
        this.addIconImageChild();
    }

    private function onInfoLoadComplete(_arg_1:Event):void {
        this.mbi.infoImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onInfoLoadComplete);
        this.infoImage = DisplayObject(this.mbi.infoImageLoader);
        this.addInfoImageChild();
    }

    public function getText(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int = 12, _arg_5:Boolean = false):TextFieldDisplayConcrete {
        var _local_6:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(_arg_4).setColor(0xFFFFFF).setTextWidth((MysteryBoxSelectModal.modalWidth - 185));
        _local_6.setBold(true);
        if (_arg_5) {
            _local_6.setStringBuilder(new StaticStringBuilder(_arg_1));
        }
        else {
            _local_6.setStringBuilder(new LineBuilder().setParams(_arg_1));
        }
        _local_6.setWordWrap(true);
        _local_6.setMultiLine(true);
        _local_6.setAutoSize(TextFieldAutoSize.LEFT);
        _local_6.setHorizontalAlign(TextFormatAlign.LEFT);
        _local_6.filters = [new DropShadowFilter(0, 0, 0)];
        _local_6.x = _arg_2;
        _local_6.y = _arg_3;
        return (_local_6);
    }

    private function addIconImageChild():void {
        if (this.iconImage == null) {
            return;
        }
        this.iconImage.width = 58;
        this.iconImage.height = 58;
        this.iconImage.x = 14;
        if(this.mbi.unitsLeft != -1)
        {
            this.iconImage.y = -6;
        }
        else
        {
            this.iconImage.y = 1;
        }
        addChild(this.iconImage);
    }

    private function addInfoImageChild():void {
        var _local_3:Array;
        var _local_4:ColorMatrixFilter;
        if (this.infoImage == null) {
            return;
        }
        this.infoImage.width = 283;
        this.infoImage.height = 580;
		//
        this.infoImage.x = 400 - x;
        this.infoImage.y = MysteryBoxSelectModal.modalHeight / 2 - y - 290;
		//
        if (((this.hoverState) && (!(this.descriptionShowing)))) {
            this.descriptionShowing = true;
            addChild(this.infoImage);
            this.infoImageBorder = new PopupWindowBackground();
            this.infoImageBorder.draw(this.infoImage.width, (this.infoImage.height + 2), PopupWindowBackground.TYPE_TRANSPARENT_WITHOUT_HEADER);
            this.infoImageBorder.x = this.infoImage.x;
            this.infoImageBorder.y = (this.infoImage.y - 1);
            addChild(this.infoImageBorder);
            _local_3 = [3.0742, -1.8282, -0.246, 0, 50, -0.9258, 2.1718, -0.246, 0, 50, -0.9258, -1.8282, 3.754, 0, 50, 0, 0, 0, 1, 0];
            _local_4 = new ColorMatrixFilter(_local_3);
            this.redbar.filters = [_local_4];
        }
    }

    private function removeInfoImageChild():void {
        if (this.descriptionShowing) {
            removeChild(this.infoImageBorder);
            removeChild(this.infoImage);
            this.descriptionShowing = false;
            this.redbar.filters = [];
        }
    }

    private function onBoxBuy(_arg_1:MouseEvent):void {
        var _local_2:OpenDialogSignal = null;
        var _local_3:String = null;
        var _local_4:Dialog = null;
        var _local_5:MysteryBoxRollModal = null;
        var _local_6:Boolean = false;
        if(this.mbi.unitsLeft != -1 && this.quantity_ > this.mbi.unitsLeft)
        {
            _local_2 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            _local_3 = "";
            if(this.mbi.unitsLeft == 0)
            {
                _local_3 = "MysteryBoxError.soldOutAll";
            }
            else
            {
                _local_3 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutLeft", {
                    "left": this.mbi.unitsLeft,
                    "box": (this.mbi.unitsLeft == 1 ? LineBuilder.getLocalizedStringFromKey("MysteryBoxError.box") : LineBuilder.getLocalizedStringFromKey("MysteryBoxError.boxes"))
                });
            }
            _local_4 = new Dialog("MysteryBoxRollModal.purchaseFailedString", _local_3, "MysteryBoxRollModal.okString", null, null);
            _local_4.addEventListener(Dialog.LEFT_BUTTON, this.onErrorOk);
            _local_2.dispatch(_local_4);
        }
        else
        {
            _local_5 = new MysteryBoxRollModal(this.mbi, this.quantity_);
            _local_6 = _local_5.moneyCheckPass();
            if(_local_6)
            {
                _local_5.parentSelectModal = MysteryBoxSelectModal(parent.parent);
                _local_2 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
                _local_2.dispatch(_local_5);
            }
        }
    }

    private function onErrorOk(_arg_1:Event):void
    {
        var _local_2:OpenDialogSignal;
        _local_2 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
        _local_2.dispatch(new MysteryBoxSelectModal());
    }

}
}//package kabam.rotmg.mysterybox.components
