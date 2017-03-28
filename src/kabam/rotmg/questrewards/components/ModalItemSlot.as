package kabam.rotmg.questrewards.components {
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.getTimer;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.fortune.components.TimerCallback;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.slot.FoodFeedFuseSlot;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.util.components.LegacyBuyButton;

public class ModalItemSlot extends FoodFeedFuseSlot {

    public var interactable:Boolean = false;
    private var usageText:TextField;
    private var actionButton:LegacyBuyButton = null;
    private var animatedOutlines:Vector.<Shape>;
    private var curOutline:int = 0;
    private var animationDir:int = 1;
    private var animationStartIndex:int = 0;
    private var marking:TextField;
    private var embeddedImage_:Bitmap;
    private var embeddedSprite_:Sprite;
    private var embeddedSpriteCopy_:Sprite;
    private var dir:Number = 0.018;
    private var hovering:Boolean = false;

    public function ModalItemSlot(_arg_1:Boolean = false, _arg_2:Boolean = false) {
        var _local_3:Shape;
        var _local_4:int;
        this.animatedOutlines = new Vector.<Shape>();
        super();
        if (_arg_1) {
            this.interactable = _arg_1;
            addEventListener(MouseEvent.ROLL_OVER, this.onMouseOverGoalSlot);
        }
        highlight(true, 16689154, true);
        if (_arg_2) {
            _local_4 = 0;
            while (_local_4 < 3) {
                _local_3 = PetsViewAssetFactory.returnPetSlotShape((56 + (_local_4 * 10)), 0x545454, (-5 + (-5 * _local_4)), false, true, 4);
                addChild(_local_3);
                this.animatedOutlines.push(_local_3);
                _local_4++;
            }
            this.animationStartIndex = (this.animatedOutlines.length - 1);
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }
    }

    override public function updateTitle():void {
        if (!empty) {
            this.highLightAll(196098);
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            if (this.actionButton) {
                this.actionButton.setOutLineColor(196098);
                this.actionButton.draw();
            }
            if (((!((this.embeddedSprite_ == null))) && (!((this.embeddedSprite_.parent == null))))) {
                this.embeddedSpriteCopy_.visible = false;
                this.embeddedSpriteCopy_.alpha = 0;
                this.embeddedSprite_.alpha = 1;
            }
        }
        else {
            if (this.animatedOutlines.length > 0) {
                addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            }
            if (((!((this.embeddedSprite_ == null))) && (!((this.embeddedSprite_.parent == null))))) {
                this.embeddedSpriteCopy_.visible = true;
            }
            if (this.actionButton) {
                this.actionButton.setOutLineColor(0x545454);
                this.actionButton.draw();
            }
        }
    }

    public function makeRedTemporarily():void {
        this.highLightAll(0xFF0000);
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        new TimerCallback(1.25, addEventListener, Event.ENTER_FRAME, this.onEnterFrame);
    }

    public function setCheckMark():void {
        if (this.marking == null) {
            this.marking = this.buildTextField();
            this.marking.text = "✓";
            this.marking.textColor = 0xFF00;
            addChild(this.marking);
            this.marking.y = Math.round((((height / 2) - (this.marking.textHeight / 2)) / 7));
        }
    }

    public function setQuestionMark():void {
        if (this.marking == null) {
            this.marking = this.buildTextField();
            this.marking.text = "?";
            this.marking.textColor = 0xFF0000;
            addChild(this.marking);
            this.marking.y = Math.round((((height / 2) - (this.marking.textHeight / 2)) / 7));
        }
    }

    public function removeMarking():void {
        if (((!((this.marking == null))) && (!((this.marking.parent == null))))) {
            removeChild(this.marking);
        }
    }

    private function buildTextField():TextField {
        var _local_1:FontModel = new FontModel();
        var _local_2:TextField = new TextField();
        var _local_3:TextFormat = _local_2.defaultTextFormat;
        _local_3.size = 36;
        _local_3.font = _local_1.getFont().getName();
        _local_3.bold = true;
        _local_3.align = "center";
        _local_2.defaultTextFormat = _local_3;
        _local_2.alpha = 0.8;
        _local_2.width = width;
        _local_2.selectable = false;
        return (_local_2);
    }

    private function onMouseOverGoalSlot(_arg_1:Event):void {
        if (empty) {
            this.hovering = true;
            if (((!((this.usageText == null))) && ((this.usageText.parent == null)))) {
                addChild(this.usageText);
            }
            removeEventListener(MouseEvent.ROLL_OVER, this.onMouseOverGoalSlot);
            addEventListener(MouseEvent.ROLL_OUT, this.onMouseOutsideGoalSlot);
        }
    }

    private function onMouseOutsideGoalSlot(_arg_1:Event):void {
        if (empty) {
            this.hovering = false;
            new TimerCallback(0.5, this.removeIfStillOutside);
            addEventListener(MouseEvent.ROLL_OVER, this.onMouseOverGoalSlot);
            removeEventListener(MouseEvent.ROLL_OUT, this.onMouseOutsideGoalSlot);
        }
    }

    private function removeIfStillOutside():void {
        if ((((((this.hovering == false)) && (!((this.usageText == null))))) && (!((this.usageText.parent == null))))) {
            removeChild(this.usageText);
        }
    }

    public function setUsageText(_arg_1:String, _arg_2:int, _arg_3:int):void {
        this.usageText = new TextField();
        this.usageText.text = _arg_1;
        this.usageText.autoSize = TextFieldAutoSize.LEFT;
        var _local_4:FontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
        _local_4.apply(this.usageText, _arg_2, _arg_3, false, true);
        this.usageText.y = (this.y + this.height);
        this.usageText.x = ((this.x + (this.width / 2)) - (this.usageText.width / 2));
    }

    public function setActionButton(_arg_1:LegacyBuyButton):void {
        this.actionButton = _arg_1;
    }

    private function onEnterFrame(_arg_1:Event):void {
        var _local_3:ColorTransform;
        var _local_4:int;
        var _local_5:int;
        var _local_2:int = uint(((getTimer() / 500) % 3));
        if (_local_2 != this.curOutline) {
            this.curOutline = _local_2;
            _local_4 = 0;
            while (_local_4 < this.animatedOutlines.length) {
                _local_3 = this.animatedOutlines[_local_4].transform.colorTransform;
                _local_3.color = 0x545454;
                _local_3.alphaMultiplier = (1 - (_local_4 * 0.3));
                this.animatedOutlines[_local_4].transform.colorTransform = _local_3;
                _local_4++;
            }
            _local_5 = (this.animationStartIndex - (this.curOutline * this.animationDir));
            _local_3 = this.animatedOutlines[_local_5].transform.colorTransform;
            _local_3.color = 196098;
            this.animatedOutlines[_local_5].transform.colorTransform = _local_3;
        }
        if (this.embeddedImage_) {
            if ((((this.embeddedSprite_.alpha == 1)) || ((this.embeddedSprite_.alpha == 0)))) {
                this.dir = (this.dir * -1);
            }
            this.embeddedSprite_.alpha = (this.embeddedSprite_.alpha + this.dir);
            this.embeddedSpriteCopy_.alpha = (this.embeddedSpriteCopy_.alpha - this.dir);
            if (this.embeddedSprite_.alpha >= 1) {
                this.embeddedSprite_.alpha = 1;
                this.embeddedSpriteCopy_.alpha = 0;
            }
            else {
                if (this.embeddedSprite_.alpha <= 0) {
                    this.embeddedSprite_.alpha = 0;
                    this.embeddedSpriteCopy_.alpha = 1;
                }
            }
        }
    }

    public function highLightAll(_arg_1:int):void {
        var _local_3:ColorTransform;
        var _local_2:int = (this.animatedOutlines.length - 1);
        while (_local_2 >= 0) {
            _local_3 = this.animatedOutlines[_local_2].transform.colorTransform;
            _local_3.color = _arg_1;
            _local_3.alphaMultiplier = (1 - (_local_2 * 0.3));
            this.animatedOutlines[_local_2].transform.colorTransform = _local_3;
            _local_2--;
        }
    }

    public function playOutLineAnimation(_arg_1:int):void {
        this.animationDir = _arg_1;
        if (_arg_1 == -1) {
            this.animationStartIndex = 0;
        }
        else {
            if (_arg_1 == 1) {
                this.animationStartIndex = (this.animatedOutlines.length - 1);
            }
        }
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    public function stopOutLineAnimation():void {
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    public function setEmbeddedImage(_arg_1:Bitmap):void {
        this.embeddedImage_ = _arg_1;
        var _local_2:Bitmap = new Bitmap(_arg_1.bitmapData);
        this.embeddedSprite_ = new Sprite();
        this.embeddedSpriteCopy_ = new Sprite();
        this.embeddedSprite_.x = ((100 - this.embeddedImage_.width) * 0.5);
        this.embeddedSprite_.y = ((46 - this.embeddedImage_.height) * 0.5);
        this.embeddedSpriteCopy_.x = this.embeddedSprite_.x;
        this.embeddedSpriteCopy_.y = this.embeddedSprite_.y;
        this.embeddedSprite_.addChild(this.embeddedImage_);
        this.embeddedSpriteCopy_.addChild(_local_2);
        addChild(this.embeddedSpriteCopy_);
        addChild(this.embeddedSprite_);
        if (((!((itemSprite == null))) && (!((getChildIndex(itemSprite) == -1))))) {
            removeChild(itemSprite);
            addChild(itemSprite);
        }
        this.embeddedSprite_.filters = [grayscaleMatrix];
        var _local_3:ColorTransform = new ColorTransform();
        _local_3.color = 0x292929;
        this.embeddedSprite_.transform.colorTransform = _local_3;
        this.embeddedSpriteCopy_.alpha = 0;
    }


}
}//package kabam.rotmg.questrewards.components
