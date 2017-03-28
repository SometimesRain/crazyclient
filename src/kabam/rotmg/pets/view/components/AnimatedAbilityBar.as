package kabam.rotmg.pets.view.components {
import com.gskinner.motion.GTween;

import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.ColorTransform;

import org.osflash.signals.Signal;

public class AnimatedAbilityBar extends Sprite {

    public const animating:Signal = new Signal(Boolean);
    public const filledUp:Signal = new Signal();
    private const NORMAL_BAR_COLOR:uint = 0xB3B3B3;
    private const FILLING_BAR_COLOR:uint = 1572859;
    private const BACKGROUND_BAR_COLOR:uint = 0x565656;

    private var animatedBar:Shape;
    private var backgroundBar:Shape;
    private var maxPoints:int = 0;
    public var currentPoints:int = -1;
    private var maxWidth:int = 0;
    private var barHeight:int = 0;

    public function AnimatedAbilityBar(_arg_1:int, _arg_2:int) {
        this.animatedBar = new Shape();
        this.backgroundBar = new Shape();
        super();
        this.maxWidth = _arg_1;
        this.barHeight = _arg_2;
        this.backgroundBar.graphics.beginFill(this.BACKGROUND_BAR_COLOR, 1);
        this.backgroundBar.graphics.drawRect(0, 0, _arg_1, _arg_2);
        addChild(this.backgroundBar);
        addChild(this.animatedBar);
    }

    public function reset():void {
        this.currentPoints = 0;
        this.animatedBar.graphics.clear();
        this.animatedBar.graphics.beginFill(this.NORMAL_BAR_COLOR, 1);
        this.animatedBar.graphics.drawRect(0, 0, 1, this.barHeight);
        this.animatedBar.width = 1;
    }

    public function fill():void {
        if (this.currentPoints == this.maxPoints) {
            this.reset();
            this.filledUp.dispatch();
            return;
        }
        var _local_1:Number = this.maxWidth;
        this.setBarColor(this.FILLING_BAR_COLOR);
        var _local_2:GTween = new GTween(this.animatedBar, 1, {"width": _local_1});
        _local_2.onComplete = this.filled;
    }

    private function filled(_arg_1:GTween):void {
        this.filledUp.dispatch();
    }

    public function setBarColor(_arg_1:uint):void {
        var _local_2:ColorTransform = this.animatedBar.transform.colorTransform;
        _local_2.color = _arg_1;
        this.animatedBar.transform.colorTransform = _local_2;
    }

    public function setMaxPointValue(_arg_1:int):void {
        this.maxPoints = _arg_1;
        this.adjustFilledBar();
    }

    public function setCurrentPointValue(_arg_1:int):void {
        var _local_2:Number;
        if (this.currentPoints == -1) {
            this.currentPoints = _arg_1;
            _local_2 = this.getBarWidth();
            this.animatedBar.graphics.beginFill(this.NORMAL_BAR_COLOR, 1);
            this.animatedBar.graphics.drawRect(0, 0, _local_2, this.barHeight);
        }
        this.currentPoints = _arg_1;
        this.adjustFilledBar();
    }

    private function adjustFilledBar():void {
        var _local_2:GTween;
        var _local_1:int = this.getBarWidth();
        if (((((!((this.currentPoints == -1))) && (!((this.currentPoints == 0))))) && (!((_local_1 == Math.round(this.animatedBar.width)))))) {
            this.animating.dispatch(true);
            this.setBarColor(this.FILLING_BAR_COLOR);
            _local_2 = new GTween(this.animatedBar, 2, {"width": _local_1});
            _local_2.onComplete = this.handleTweenComplete;
        }
    }

    private function getBarWidth():int {
        var _local_1:int = ((this.currentPoints * this.maxWidth) / this.maxPoints);
        return (((isNaN(_local_1)) ? 1 : Math.round(Math.max(1, Math.min(this.maxWidth, _local_1)))));
    }

    public function handleTweenComplete(_arg_1:GTween):void {
        this.setBarColor(this.NORMAL_BAR_COLOR);
        this.animating.dispatch(false);
    }


}
}//package kabam.rotmg.pets.view.components
