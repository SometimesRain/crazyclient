package kabam.rotmg.fortune.components {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.MoreColorUtil;
import com.gskinner.motion.GTween;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.GlowFilter;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.ui.Mouse;

import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class CrystalSmall extends Sprite {

    public static const ANIM_PULSE:int = 1;
    public static const ANIM_HOVER:int = 2;
    public static const ANIM_CLICKED:int = 3;
    private static const ITEM_SIZE:int = 100;
    public static const GLOW_STATE_FADE:int = 1;
    public static const GLOW_STATE_PULSE:int = 2;
    private static const MAX_SHAKE:Number = 5;

    private const ANIMATION_FRAMES:Number = 3;
    private const STARTING_FRAME_INDEX:Number = 80;
    private const EXCITING_MODE_SQUARE_RANGE:int = 3500;

    public var crystal:Bitmap;
    public var crystalGrey:Bitmap;
    private var item:ItemWithTooltip;
    private var returnX:Number;
    private var returnY:Number;
    private var crystalFrames:Vector.<Bitmap>;
    private var animationDuration_:Number = 50;
    private var isTrackingMouse_:Boolean = false;
    private var isExcitingMode_:Boolean = false;
    public var active:Boolean = false;
    private var startFrame_:Number = 0;
    private var frameOffset_:Number = 0;
    private var dtBuildup_:Number = 0;
    private var numFramesofLoop_:Number;
    public var currentAnimation:int;
    public var size_:int = 100;
    private var itemNameField:TextField;
    private var originX:Number = 0;
    private var originY:Number = 0;
    private var shake:Boolean = false;
    private var shakeCount:int = 0;
    private var glowState:int = -1;
    private var pulsePolarity:Boolean = false;
    private var glowFilter:GlowFilter;

    public function CrystalSmall() {
        var _local_1:BitmapData;
        var _local_2:uint;
        this.itemNameField = new TextField();
        super();
        this.crystalFrames = new Vector.<Bitmap>();
        _local_2 = 0;
        while (_local_2 < 3) {
            _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", (this.STARTING_FRAME_INDEX + _local_2));
            _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, 0xFFFFFF, true);
            this.crystalFrames.push(new Bitmap(_local_1));
            _local_2++;
        }
        _local_2 = 0;
        while (_local_2 < 3) {
            _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", ((this.STARTING_FRAME_INDEX + 16) + _local_2));
            _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, 0xFFFFFF, true);
            this.crystalFrames.push(new Bitmap(_local_1));
            _local_2++;
        }
        _local_2 = 0;
        while (_local_2 < 7) {
            _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", ((this.STARTING_FRAME_INDEX + 32) + _local_2));
            _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, 0xFFFFFF, true);
            this.crystalFrames.push(new Bitmap(_local_1));
            _local_2++;
        }
        _local_2 = 0;
        while (_local_2 < 7) {
            _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", ((this.STARTING_FRAME_INDEX + 48) + _local_2));
            _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, 0xFFFFFF, true);
            this.crystalFrames.push(new Bitmap(_local_1));
            _local_2++;
        }
        _local_2 = 0;
        while (_local_2 < 5) {
            _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", ((this.STARTING_FRAME_INDEX + 64) + _local_2));
            _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, 0xFFFFFF, true);
            this.crystalFrames.push(new Bitmap(_local_1));
            _local_2++;
        }
        _local_2 = 0;
        while (_local_2 < 8) {
            _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", ((this.STARTING_FRAME_INDEX + 80) + _local_2));
            _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, 0xFFFFFF, true);
            this.crystalFrames.push(new Bitmap(_local_1));
            _local_2++;
        }
        _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", 0x0100);
        _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, 0, true);
        this.crystal = new Bitmap(_local_1);
        this.crystal.alpha = 0;
        addChild(this.crystal);
        this.crystalGrey = new Bitmap(_local_1);
        this.crystalGrey.filters = [new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix)];
        this.crystalGrey.alpha = 1;
        this.active = false;
        addChild(this.crystalGrey);
        this.glowFilter = new GlowFilter(49151, 1, 45, 45, 1.5);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        addEventListener(MouseEvent.ROLL_OVER, this.onMouseOver, false, 0, true);
        addEventListener(MouseEvent.ROLL_OUT, this.onMouseOutClip, false, 0, true);
        this.setInactive();
    }

    public function setXPos(_arg_1:Number):void {
        this.x = (_arg_1 - (this.width / 2));
    }

    public function setYPos(_arg_1:Number):void {
        this.y = (_arg_1 - (this.height / 2));
    }

    private function calculateXPos(_arg_1:Number):Number {
        return ((_arg_1 - (this.width / 2)));
    }

    private function calculateYPos(_arg_1:Number):Number {
        return ((_arg_1 - (this.height / 2)));
    }

    public function getCenterX():Number {
        return ((this.x + (this.width / 2)));
    }

    public function getCenterY():Number {
        return ((this.y + (this.height / 2)));
    }

    public function returnCenterX():Number {
        return ((this.returnX + (this.width / 2)));
    }

    public function returnCenterY():Number {
        return ((this.returnY + (this.width / 2)));
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.removeItemReveal();
        this.crystal = null;
        this.crystalGrey = null;
        this.item = null;
        this.crystalFrames = null;
    }

    public function setGlowState(_arg_1:int):void {
        this.glowState = _arg_1;
        if (this.glowState == GLOW_STATE_PULSE) {
            this.glowFilter.alpha = 1;
        }
    }

    public function doItemReveal(_arg_1:int):void {
        if ((((this.parent == null)) || ((this.parent.parent == null)))) {
            return;
        }
        this.removeItemReveal();
        this.item = new ItemWithTooltip(_arg_1);
        this.item.itemBitmap.alpha = 1;
        parent.addChild(this.item);
        this.item.setXPos(this.getCenterX());
        this.item.setYPos(this.getCenterY());
        FortuneModal.doEaseOutInAnimation(this.item, {
            "scaleX": 1.25,
            "scaleY": 1.25
        }, {
            "scaleX": 1,
            "scaleY": 1
        });
        this.setInactive();
    }

    public function removeItemReveal():void {
        if (((!((this.item == null))) && (this.item.parent))) {
            parent.removeChild(this.item);
        }
        if (((!((this.itemNameField == null))) && (this.itemNameField.parent))) {
            parent.removeChild(this.itemNameField);
        }
    }

    public function doItemShow(_arg_1:int):void {
        if ((((this.parent == null)) || ((this.parent.parent == null)))) {
            return;
        }
        this.removeItemReveal();
        var _local_2:TextFormat = new TextFormat();
        _local_2.size = 18;
        _local_2.font = "Myriad Pro";
        _local_2.bold = false;
        _local_2.align = TextFormatAlign.LEFT;
        _local_2.leftMargin = 0;
        _local_2.indent = 0;
        _local_2.leading = 0;
        this.itemNameField.text = LineBuilder.getLocalizedStringFromKey(ObjectLibrary.typeToDisplayId_[_arg_1]);
        this.itemNameField.textColor = 0xFFFFFF;
        this.itemNameField.autoSize = TextFieldAutoSize.CENTER;
        this.itemNameField.selectable = false;
        this.itemNameField.defaultTextFormat = _local_2;
        this.itemNameField.setTextFormat(_local_2);
        this.item = new ItemWithTooltip(_arg_1, ITEM_SIZE);
        this.item.itemBitmap.alpha = 1;
        parent.addChild(this.item);
        this.item.alpha = 0;
        this.item.setXPos(this.getCenterX());
        this.item.setYPos(this.getCenterY());
        this.itemNameField.x = (this.item.getCenterX() - (this.itemNameField.width / 2));
        this.itemNameField.y = (this.item.y + 80);
        parent.addChild(this.itemNameField);
        var _local_3:GTween = new GTween(this.item, 1, {"alpha": 1});
        FortuneModal.doEaseOutInAnimation(this.item, {
            "scaleX": 1.25,
            "scaleY": 1.25
        }, {
            "scaleX": 1,
            "scaleY": 1
        });
        this.setActive();
    }

    public function doItemCenter(_arg_1:Number, _arg_2:Number):void {
        this.returnX = this.x;
        this.returnY = this.y;
        var _local_3:Number = this.calculateXPos(_arg_1);
        var _local_4:Number = this.calculateYPos(_arg_2);
        var _local_5:GTween = new GTween(this, 0.5, {
            "x": _local_3,
            "y": _local_4
        });
    }

    public function saveReturnPotion():void {
        this.returnX = this.x;
        this.returnY = this.y;
        this.originX = this.returnCenterX();
        this.originY = this.returnCenterY();
    }

    public function doItemReturn():void {
        var _local_1:GTween = new GTween(this, 0.12, {
            "x": this.returnX,
            "y": this.returnY
        });
        this.filters = [this.glowFilter];
        this.setGlowState(GLOW_STATE_PULSE);
    }

    public function setActive():void {
        if (!this.active) {
            this.crystal.alpha = 0;
            this.crystalGrey.alpha = 1;
            this.setAnimation(0, 3);
            this.setAnimationDuration(100);
        }
        this.active = true;
    }

    public function setActive2():void {
    }

    public function setInactive():void {
        if (this.active) {
            if (this.crystal != null) {
                this.crystal.alpha = 1;
            }
            if (this.crystalGrey != null) {
                this.crystalGrey.alpha = 0;
            }
        }
        this.active = false;
    }

    public function update(_arg_1:int, _arg_2:int):void {
        var _local_3:int;
        var _local_4:Number;
        if (this.active) {
            if ((((this.crystal.alpha < 1)) && ((this.crystalGrey.alpha > 0)))) {
                this.crystalGrey.alpha = (this.crystalGrey.alpha - 0.03);
                this.crystal.alpha = (this.crystal.alpha + 0.03);
            }
            else {
                this.crystalGrey.alpha = 0;
                this.crystal.alpha = 1;
            }
        }
        else {
            if ((((this.crystal.alpha > 0)) && ((this.crystalGrey.alpha < 1)))) {
                this.crystalGrey.alpha = (this.crystalGrey.alpha + 0.03);
                this.crystal.alpha = (this.crystal.alpha - 0.03);
            }
            else {
                this.crystalGrey.alpha = 1;
                this.crystal.alpha = 0;
            }
        }
        if (this.glowState == GLOW_STATE_FADE) {
            this.glowFilter.alpha = (this.glowFilter.alpha - 0.07);
            this.filters = [this.glowFilter];
            if (this.glowFilter.alpha <= 0.03) {
                this.filters = [];
            }
        }
        else {
            if (this.glowState == GLOW_STATE_PULSE) {
                if ((((this.glowFilter.alpha >= 0.95)) && (this.pulsePolarity))) {
                    this.pulsePolarity = false;
                }
                else {
                    if ((((this.glowFilter.alpha <= 0.5)) && (!(this.pulsePolarity)))) {
                        this.pulsePolarity = true;
                    }
                }
                _local_3 = ((this.pulsePolarity) ? 1 : -1);
                this.glowFilter.alpha = (this.glowFilter.alpha + (0.01 * _local_3));
                this.filters = [this.glowFilter];
            }
        }
        if (this.isTrackingMouse_) {
            _local_4 = this.squareDistanceTo(FortuneModal.fMouseX, FortuneModal.fMouseY);
            if (_local_4 <= this.EXCITING_MODE_SQUARE_RANGE) {
                if (this.currentAnimation != ANIM_HOVER) {
                    this.setAnimationHover();
                }
                this.animationDuration_ = Math.max((_local_4 / 8), 70);
                this.animationDuration_ = Math.min(this.animationDuration_, 170);
            }
            else {
                if (this.currentAnimation != ANIM_PULSE) {
                    this.setAnimationPulse();
                }
            }
        }
        if (this.shake) {
            this.setXPos((this.originX + ((Math.random() * 6) - 3)));
            this.setYPos((this.originY + ((Math.random() * 6) - 3)));
            this.shakeCount++;
            if (this.shakeCount == MAX_SHAKE) {
                this.shake = false;
                this.shakeCount = 0;
            }
        }
        this.drawAnimation(_arg_1, _arg_2);
    }

    public function setShake(_arg_1:Boolean):void {
        this.shake = _arg_1;
    }

    public function drawAnimation(_arg_1:int, _arg_2:int):void {
        if (this.active) {
            removeChild(this.crystal);
            this.dtBuildup_ = (this.dtBuildup_ + _arg_2);
            if (this.dtBuildup_ > this.animationDuration_) {
                this.frameOffset_ = ((this.frameOffset_ + 1) % this.numFramesofLoop_);
                this.dtBuildup_ = 0;
            }
            else {
                if (this.frameOffset_ > this.numFramesofLoop_) {
                    this.frameOffset_ = 0;
                }
            }
            this.crystal = this.crystalFrames[(this.startFrame_ + this.frameOffset_)];
            if (this.currentAnimation == ANIM_CLICKED) {
                if (this.scaleX > 0.01) {
                    this.scaleX = (this.scaleX - (_arg_2 * 0.002));
                    this.scaleY = (this.scaleY - (_arg_2 * 0.002));
                    this.setXPos((this.originX + (Math.random() * 5)));
                    this.setYPos((this.originY + (Math.random() * 5)));
                }
                else {
                    this.scaleX = 0.01;
                    this.scaleY = 0.01;
                }
            }
            addChild(this.crystal);
        }
    }

    public function setAnimationDuration(_arg_1:Number):void {
        this.animationDuration_ = _arg_1;
    }

    public function onMouseOver(_arg_1:MouseEvent):void {
        Mouse.cursor = "hand";
    }

    private function onMouseOutClip(_arg_1:MouseEvent):void {
        Mouse.cursor = Parameters.data_.cursorSelect;
    }

    public function setMouseTracking(_arg_1:Boolean):void {
        this.isTrackingMouse_ = _arg_1;
    }

    private function squareDistanceTo(_arg_1:Number, _arg_2:Number):Number {
        return ((((this.getCenterX() - _arg_1) * (this.getCenterX() - _arg_1)) + ((this.getCenterY() - _arg_2) * (this.getCenterY() - _arg_2))));
    }

    public function reset():void {
        this.active = false;
        this.animationDuration_ = 50;
        this.isTrackingMouse_ = false;
    }

    public function setAnimation(_arg_1:Number, _arg_2:Number):void {
        this.startFrame_ = _arg_1;
        this.frameOffset_ = 0;
        this.dtBuildup_ = 0;
        this.numFramesofLoop_ = _arg_2;
        this.currentAnimation = -1;
    }

    public function setAnimationPulse():void {
        this.setAnimation(0, 3);
        this.animationDuration_ = 250;
        this.currentAnimation = ANIM_PULSE;
    }

    public function setAnimationHover():void {
        this.setAnimation(20, 13);
        this.currentAnimation = ANIM_HOVER;
    }

    public function setAnimationClicked():void {
        this.setAnimation(3, 3);
        this.animationDuration_ = 20;
        this.currentAnimation = ANIM_CLICKED;
        this.setMouseTracking(false);
    }

    public function resetVars():void {
        this.active = false;
        this.frameOffset_ = 0;
        this.currentAnimation = -1;
        this.animationDuration_ = 50;
        this.isTrackingMouse_ = false;
        this.dtBuildup_ = 0;
        this.startFrame_ = 0;
        this.scaleX = 1;
        this.scaleY = 1;
    }


}
}//package kabam.rotmg.fortune.components
