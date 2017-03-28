package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.appengine.CharacterStats;
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.ui.tooltip.ClassToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.Currency;
import com.company.assembleegameclient.util.FameUtil;
import com.company.rotmg.graphics.FullCharBoxGraphic;
import com.company.rotmg.graphics.LockedCharBoxGraphic;
import com.company.rotmg.graphics.StarGraphic;
import com.company.util.AssetLibrary;
import com.gskinner.motion.GTween;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.components.LegacyBuyButton;

import org.osflash.signals.natives.NativeSignal;

public class CharacterBox extends Sprite {

    public static const DELETE_CHAR:String = "DELETE_CHAR";
    public static const ENTER_NAME:String = "ENTER_NAME";
    private static const fullCT:ColorTransform = new ColorTransform(0.8, 0.8, 0.8);
    private static const emptyCT:ColorTransform = new ColorTransform(0.2, 0.2, 0.2);

    private var SaleTag:Class;
    public var playerXML_:XML = null;
    public var charStats_:CharacterStats;
    public var model:PlayerModel;
    public var available_:Boolean;
    private var graphicContainer_:Sprite;
    private var graphic_:Sprite;
    private var bitmap_:Bitmap;
    private var statusText_:TextFieldDisplayConcrete;
    private var classNameText_:TextFieldDisplayConcrete;
    private var buyButton_:LegacyBuyButton;
    private var cost:int = 0;
    private var lock_:Bitmap;
    private var saleText_:TextFieldDisplayConcrete;
    private var unlockedText_:TextFieldDisplayConcrete;
    private var saleTag_:CharacterBox_SaleTag;
    public var buyButtonClicked_:NativeSignal;
    public var characterSelectClicked_:NativeSignal;

    public function CharacterBox(_arg_1:XML, _arg_2:CharacterStats, _arg_3:PlayerModel, _arg_4:Boolean = false) {
        var _local_5:Sprite;
        this.SaleTag = CharacterBox_SaleTag;
        super();
        this.model = _arg_3;
        this.playerXML_ = _arg_1;
        this.charStats_ = _arg_2;
        this.available_ = ((_arg_4) || (_arg_3.isLevelRequirementsMet(this.objectType())));
        if (!this.available_) {
            this.graphic_ = new LockedCharBoxGraphic();
            this.cost = this.playerXML_.UnlockCost;
        }
        else {
            this.graphic_ = new FullCharBoxGraphic();
        }
        this.graphicContainer_ = new Sprite();
        addChild(this.graphicContainer_);
        this.graphicContainer_.addChild(this.graphic_);
        this.characterSelectClicked_ = new NativeSignal(this.graphicContainer_, MouseEvent.CLICK, MouseEvent);
        this.bitmap_ = new Bitmap(null);
        this.setImage(AnimatedChar.DOWN, AnimatedChar.STAND, 0);
        this.graphic_.addChild(this.bitmap_);
        this.classNameText_ = new TextFieldDisplayConcrete().setSize(14).setColor(0xFFFFFF).setAutoSize(TextFieldAutoSize.CENTER).setTextWidth(this.graphic_.width).setBold(true);
        //this.classNameText_.setStringBuilder(new LineBuilder().setParams(this.playerXML_.DisplayId));
		this.classNameText_.setStringBuilder(new LineBuilder().setParams(ClassToolTip.getDisplayId(this.playerXML_)));
        this.classNameText_.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
        this.graphic_.addChild(this.classNameText_);
        this.setBuyButton();
        this.setStatusButton();
        if (this.available_) {
            _local_5 = this.getStars(FameUtil.numStars(_arg_3.getBestFame(this.objectType())), FameUtil.STARS.length);
            _local_5.y = 60;
            _local_5.x = ((this.graphic_.width / 2) - (_local_5.width / 2));
            _local_5.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
            this.graphicContainer_.addChild(_local_5);
            this.classNameText_.y = 74;
        }
        else {
            addChild(this.buyButton_);
            this.lock_ = new Bitmap(AssetLibrary.getImageFromSet("lofiInterface2", 5));
            this.lock_.scaleX = 2;
            this.lock_.scaleY = 2;
            this.lock_.x = 4;
            this.lock_.y = 8;
            addChild(this.lock_);
            addChild(this.statusText_);
            this.classNameText_.y = 78;
        }
    }

    public function objectType():int {
        return (int(this.playerXML_.@type));
    }

    public function unlock():void {
        var _local_1:Sprite;
        var _local_2:GTween;
        if (this.available_ == false) {
            this.available_ = true;
            this.graphicContainer_.removeChild(this.graphic_);
            this.graphic_ = new FullCharBoxGraphic();
            this.graphicContainer_.addChild(this.graphic_);
            this.setImage(AnimatedChar.DOWN, AnimatedChar.STAND, 0);
            this.graphic_.addChild(this.bitmap_);
            this.graphic_.addChild(this.classNameText_);
            if (contains(this.statusText_)) {
                removeChild(this.statusText_);
            }
            if (contains(this.buyButton_)) {
                removeChild(this.buyButton_);
            }
            if (((this.lock_) && (contains(this.lock_)))) {
                removeChild(this.lock_);
            }
            if (((this.saleTag_) && (contains(this.saleTag_)))) {
                removeChild(this.saleTag_);
            }
            if (((this.saleText_) && (contains(this.saleText_)))) {
                removeChild(this.saleText_);
            }
            _local_1 = this.getStars(FameUtil.numStars(this.model.getBestFame(this.objectType())), FameUtil.STARS.length);
            _local_1.y = 60;
            _local_1.x = ((this.graphic_.width / 2) - (_local_1.width / 2));
            _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
            addChild(_local_1);
            this.classNameText_.y = 74;
            if (!this.unlockedText_) {
                this.getCharacterUnlockText();
            }
            addChild(this.unlockedText_);
            _local_2 = new GTween(this.unlockedText_, 2.5, {
                "alpha": 0,
                "y": -30
            });
            _local_2.onComplete = this.removeUnlockText;
        }
    }

    private function removeUnlockText(_arg_1:GTween):void {
        removeChild(this.unlockedText_);
    }

    public function getTooltip():ToolTip {
        return (new ClassToolTip(this.playerXML_, this.model, this.charStats_));
    }

    public function setOver(_arg_1:Boolean):void {
        if (!this.available_) {
            return;
        }
        if (_arg_1) {
            transform.colorTransform = new ColorTransform(1.2, 1.2, 1.2);
        }
        else {
            transform.colorTransform = new ColorTransform(1, 1, 1);
        }
    }

    private function setImage(_arg_1:int, _arg_2:int, _arg_3:Number):void {
        this.bitmap_.bitmapData = SavedCharacter.getImage(null, this.playerXML_, _arg_1, _arg_2, _arg_3, this.available_, false);
        this.bitmap_.x = ((this.graphic_.width / 2) - (this.bitmap_.bitmapData.width / 2));
    }

    private function getStars(_arg_1:int, _arg_2:int):Sprite {
        var _local_5:Sprite;
        var _local_3:Sprite = new Sprite();
        var _local_4:int;
        var _local_6:int;
        while (_local_4 < _arg_1) {
            _local_5 = new StarGraphic();
            _local_5.x = _local_6;
            _local_5.transform.colorTransform = fullCT;
            _local_3.addChild(_local_5);
            _local_6 = (_local_6 + _local_5.width);
            _local_4++;
        }
        while (_local_4 < _arg_2) {
            _local_5 = new StarGraphic();
            _local_5.x = _local_6;
            _local_5.transform.colorTransform = emptyCT;
            _local_3.addChild(_local_5);
            _local_6 = (_local_6 + _local_5.width);
            _local_4++;
        }
        return (_local_3);
    }

    public function setSale(_arg_1:int):void {
        if (!this.saleTag_) {
            this.saleTag_ = new this.SaleTag();
            this.saleTag_.x = 38;
            this.saleTag_.y = 8;
            addChild(this.saleTag_);
        }
        if (!this.saleText_) {
            this.setSaleText();
            addChild(this.saleText_);
        }
        this.saleText_.setStringBuilder(new LineBuilder().setParams(TextKey.PERCENT_OFF, {"percent": String(_arg_1)}));
    }

    private function setBuyButton():void {
        this.buyButton_ = new LegacyBuyButton(TextKey.BUY_FOR, 13, this.cost, Currency.GOLD);
        this.buyButton_.y = (this.buyButton_.y + this.graphic_.height);
        this.buyButton_.setWidth(this.graphic_.width);
        this.buyButtonClicked_ = new NativeSignal(this.buyButton_, MouseEvent.CLICK, MouseEvent);
    }

    private function setStatusButton():void {
        this.statusText_ = new TextFieldDisplayConcrete().setSize(14).setColor(0xFF0000).setAutoSize(TextFieldAutoSize.CENTER).setBold(true).setTextWidth(this.graphic_.width);
        this.statusText_.setStringBuilder(new LineBuilder().setParams(TextKey.LOCKED));
        this.statusText_.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
        this.statusText_.y = 58;
    }

    private function setSaleText():void {
        this.saleText_ = new TextFieldDisplayConcrete().setSize(14).setColor(0xFFFFFF).setAutoSize(TextFieldAutoSize.CENTER).setBold(true).setTextHeight(this.saleTag_.height).setTextWidth(this.saleTag_.width);
        this.saleText_.x = 42;
        this.saleText_.y = 12;
    }

    private function getCharacterUnlockText():void {
        this.unlockedText_ = new TextFieldDisplayConcrete().setSize(14).setColor(0xFF00).setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        this.unlockedText_.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
        this.unlockedText_.setStringBuilder(new LineBuilder().setParams(TextKey.UNLOCK_CLASS));
        this.unlockedText_.y = -20;
    }

    public function setIsBuyButtonEnabled(_arg_1:Boolean):void {
        this.buyButton_.setEnabled(_arg_1);
    }


}
}//package com.company.assembleegameclient.screens
