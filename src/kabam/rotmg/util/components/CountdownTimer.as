package kabam.rotmg.util.components {
import com.gskinner.motion.GTween;

import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.utils.Timer;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;

public class CountdownTimer extends Sprite {

    public static const MARGIN:int = 8;

    public var countdownSeconds:int = 0;
    public var myTimer:Timer;
    public var text:TextFieldDisplayConcrete;
    public var background:SpriteBackground;
    public var timerComplete:Signal;
    public var centerX:Number = -1;

    public function CountdownTimer() {
        this.timerComplete = new Signal();
        super();
        this.text = new TextFieldDisplayConcrete().setSize(40).setColor(0xFFFFFF).setBold(true);
        this.text.filters = [new DropShadowFilter(0, 0, 0), new GlowFilter(0xFFFF00, 1, 1.5, 1.5, 4.5, 1)];
        this.text.setStringBuilder(new StaticStringBuilder(("" + this.countdownSeconds)));
        addChild(this.text);
        this.text.visible = false;
    }

    public function start(_arg_1:int = 5):void {
        if (((!((this.text == null))) && (!((this.text.parent == null))))) {
            removeChild(this.text);
        }
        this.text.setStringBuilder(new StaticStringBuilder(("" + _arg_1)));
        this.text.alpha = 0.5;
        this.text.scaleX = 1;
        this.text.scaleY = 1;
        this.text.visible = true;
        new GTween(this.text, 0.25, {
            "scaleX": 1.25,
            "scaleY": 1.25,
            "alpha": 1
        });
        addChild(this.text);
        this.countdownSeconds = _arg_1;
        this.myTimer = new Timer(1000, _arg_1);
        this.myTimer.addEventListener(TimerEvent.TIMER, this.countdown);
        this.myTimer.start();
    }

    public function end():void {
        if (((!((this.background == null))) && (!((this.background.parent == null))))) {
            removeChild(this.background);
        }
        if (((!((this.text == null))) && (!((this.text.parent == null))))) {
            removeChild(this.text);
        }
        this.countdownSeconds = 0;
        this.timerComplete.dispatch();
        if (this.myTimer != null) {
            this.myTimer.removeEventListener(TimerEvent.TIMER, this.countdown);
            this.myTimer.reset();
        }
    }

    public function remove():void {
        if (((!((this.background == null))) && (!((this.background.parent == null))))) {
            removeChild(this.background);
        }
        if (((!((this.text == null))) && (!((this.text.parent == null))))) {
            removeChild(this.text);
        }
        this.countdownSeconds = 0;
        this.myTimer.removeEventListener(TimerEvent.TIMER, this.countdown);
        this.myTimer.reset();
    }

    public function isRunning():Boolean {
        return (!((this.countdownSeconds == 0)));
    }

    public function countdown(_arg_1:TimerEvent):void {
        this.countdownSeconds--;
        if (this.countdownSeconds == 0) {
            this.end();
        }
        else {
            this.text.setStringBuilder(new StaticStringBuilder(("" + this.countdownSeconds)));
            this.text.alpha = 0.5;
            this.text.scaleX = 1;
            this.text.scaleY = 1;
            if ((((this.countdownSeconds == 9)) || ((this.countdownSeconds == 99)))) {
                this.reAlign();
            }
            new GTween(this.text, 0.25, {
                "scaleX": 1.25,
                "scaleY": 1.25,
                "alpha": 1
            });
        }
    }

    public function setXPos(_arg_1:Number):void {
        this.centerX = _arg_1;
        this.x = (this.centerX - ((this.width * 1.25) / 2));
    }

    public function reAlign():void {
        this.x = (this.centerX - ((this.width * 1.25) / 2));
    }

    public function setYPos(_arg_1:Number):void {
        this.y = (_arg_1 - ((this.height * 1.25) / 2));
    }

    public function getCenterX():Number {
        return ((this.x + (this.width / 2)));
    }

    public function getCenterY():Number {
        return ((this.y + (this.height / 2)));
    }


}
}//package kabam.rotmg.util.components
