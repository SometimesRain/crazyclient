package kabam.rotmg.fortune.components {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.ColorMatrixFilter;

public class CrystalMain extends Sprite {

    public static const ANIMATION_STAGE_PULSE:int = 0;
    public static const ANIMATION_STAGE_BUZZING:int = 1;
    public static const ANIMATION_STAGE_INNERROTATION:int = 2;
    public static const ANIMATION_STAGE_FLASH:int = 3;
    public static const ANIMATION_STAGE_WAITING:int = 4;
    public static const GLOW_COLOR:int = 0;

    private const STARTING_FRAME_INDEX:Number = 176;

    public var bigCrystal:Bitmap;
    private var crystalFrames:Vector.<Bitmap>;
    private var animationDuration_:Number = 210;
    private var startFrame_:Number = 0;
    private var numFramesofLoop_:Number;
    public var size_:int = 150;

    public function CrystalMain() {
        var _local_1:BitmapData;
        var _local_2:uint;
        var _local_3:Bitmap;
        super();
        this.crystalFrames = new Vector.<Bitmap>();
        _local_2 = 0;
        while (_local_2 < 3) {
            _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", (this.STARTING_FRAME_INDEX + _local_2));
            _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, GLOW_COLOR, false);
            _local_3 = new Bitmap(_local_1);
            _local_3.filters = [new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix)];
            this.crystalFrames.push(_local_3);
            _local_2++;
        }
        _local_2 = 0;
        while (_local_2 < 3) {
            _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", ((this.STARTING_FRAME_INDEX + 16) + _local_2));
            _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, GLOW_COLOR, false);
            this.crystalFrames.push(new Bitmap(_local_1));
            _local_2++;
        }
        _local_2 = 0;
        while (_local_2 < 7) {
            _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", ((this.STARTING_FRAME_INDEX + 32) + _local_2));
            _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, GLOW_COLOR, false);
            this.crystalFrames.push(new Bitmap(_local_1));
            _local_2++;
        }
        _local_2 = 0;
        while (_local_2 < 7) {
            _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", ((this.STARTING_FRAME_INDEX + 48) + _local_2));
            _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, GLOW_COLOR, false);
            this.crystalFrames.push(new Bitmap(_local_1));
            _local_2++;
        }
        _local_2 = 0;
        while (_local_2 < 5) {
            _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", ((this.STARTING_FRAME_INDEX + 64) + _local_2));
            _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, GLOW_COLOR, false);
            this.crystalFrames.push(new Bitmap(_local_1));
            _local_2++;
        }
        _local_2 = 0;
        while (_local_2 < 8) {
            _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", ((this.STARTING_FRAME_INDEX + 80) + _local_2));
            _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, GLOW_COLOR, false);
            this.crystalFrames.push(new Bitmap(_local_1));
            _local_2++;
        }
        this.reset();
        _local_1 = AssetLibrary.getImageFromSet("lofiCharBig", 32);
        _local_1 = TextureRedrawer.redraw(_local_1, this.size_, true, GLOW_COLOR, false);
        this.bigCrystal = new Bitmap(_local_1);
        addChild(this.bigCrystal);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    public function reset():void {
        this.setAnimationStage(ANIMATION_STAGE_FLASH);
    }

    public function setXPos(_arg_1:Number):void {
        this.x = (_arg_1 - (this.width / 2));
    }

    public function setYPos(_arg_1:Number):void {
        this.y = (_arg_1 - (this.height / 2));
    }

    public function getCenterX():Number {
        return ((this.x + (this.width / 2)));
    }

    public function getCenterY():Number {
        return ((this.y + (this.height / 2)));
    }

    public function drawAnimation(_arg_1:int, _arg_2:int):void {
        removeChild(this.bigCrystal);
        this.bigCrystal = this.crystalFrames[(this.startFrame_ + uint(((_arg_1 / this.animationDuration_) % this.numFramesofLoop_)))];
        addChild(this.bigCrystal);
    }

    public function setAnimationDuration(_arg_1:Number):void {
        this.animationDuration_ = _arg_1;
    }

    public function setAnimation(_arg_1:Number, _arg_2:Number):void {
        this.startFrame_ = _arg_1;
        this.numFramesofLoop_ = _arg_2;
    }

    public function setAnimationStage(_arg_1:int):void {
        switch (_arg_1) {
            case ANIMATION_STAGE_PULSE:
                this.setAnimation(0, 0);
                this.setAnimationDuration(250);
                return;
            case ANIMATION_STAGE_BUZZING:
                this.setAnimation(3, 3);
                this.setAnimationDuration(10);
                return;
            case ANIMATION_STAGE_INNERROTATION:
                this.setAnimation(6, 7);
                this.setAnimationDuration(80);
                return;
            case ANIMATION_STAGE_FLASH:
                this.setAnimation(13, 7);
                this.setAnimationDuration(210);
                return;
            case ANIMATION_STAGE_WAITING:
                this.setAnimation(20, 13);
                this.setAnimationDuration(120);
                return;
            default:
                this.setAnimation(13, 7);
        }
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.bigCrystal = null;
        this.crystalFrames = null;
    }


}
}//package kabam.rotmg.fortune.components
