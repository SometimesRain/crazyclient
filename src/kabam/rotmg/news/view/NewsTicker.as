package kabam.rotmg.news.view {
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.text.TextField;
import flash.utils.Timer;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.model.FontModel;

public class NewsTicker extends Sprite {

    private static var pendingScrollText:String = "";

    private const WIDTH:int = 280;
    private const HEIGHT:int = 25;
    private const MAX_REPEATS:int = 2;
    private const SCROLL_PREPEND:String = "                                                                               ";
    private const SCROLL_APPEND:String = "                                                                                ";

    public var scrollText:TextField;
    private var timer:Timer;
    private var currentRepeat:uint = 0;
    private var scrollOffset:int = 0;

    public function NewsTicker() {
        this.scrollText = this.createScrollText();
        this.timer = new Timer(0.17, 0);
        this.drawBackground();
        this.align();
        this.visible = false;
        if (NewsTicker.pendingScrollText != "") {
            this.activateNewScrollText(NewsTicker.pendingScrollText);
            NewsTicker.pendingScrollText = "";
        }
    }

    public static function setPendingScrollText(_arg_1:String):void {
        NewsTicker.pendingScrollText = _arg_1;
    }


    public function activateNewScrollText(_arg_1:String):void {
        if (this.visible == false) {
            this.visible = true;
        }
        else {
            return;
        }
        this.scrollText.text = ((this.SCROLL_PREPEND + _arg_1) + this.SCROLL_APPEND);
        this.timer.addEventListener(TimerEvent.TIMER, this.scrollAnimation);
        this.currentRepeat = 1;
        this.timer.start();
    }

    private function scrollAnimation(_arg_1:TimerEvent):void {
        this.timer.stop();
        if (this.scrollText.scrollH < this.scrollText.maxScrollH) {
            this.scrollOffset++;
            this.scrollText.scrollH = this.scrollOffset;
            this.timer.start();
        }
        else {
            if ((((this.currentRepeat >= 1)) && ((this.currentRepeat < this.MAX_REPEATS)))) {
                this.currentRepeat++;
                this.scrollOffset = 0;
                this.scrollText.scrollH = 0;
                this.timer.start();
            }
            else {
                this.currentRepeat = 0;
                this.scrollOffset = 0;
                this.scrollText.scrollH = 0;
                this.timer.removeEventListener(TimerEvent.TIMER, this.scrollAnimation);
                this.visible = false;
            }
        }
    }

    private function align():void {
        this.scrollText.x = 5;
        this.scrollText.y = 2;
    }

    private function drawBackground():void {
        graphics.beginFill(0, 0.4);
        graphics.drawRoundRect(0, 0, this.WIDTH, this.HEIGHT, 12, 12);
        graphics.endFill();
    }

    private function createScrollText():TextField {
        var _local_1:TextField;
        _local_1 = new TextField();
        var _local_2:FontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
        _local_2.apply(_local_1, 16, 0xFFFFFF, false);
        _local_1.selectable = false;
        _local_1.doubleClickEnabled = false;
        _local_1.mouseEnabled = false;
        _local_1.mouseWheelEnabled = false;
        _local_1.text = "";
        _local_1.wordWrap = false;
        _local_1.multiline = false;
        _local_1.selectable = false;
        _local_1.width = (this.WIDTH - 10);
        _local_1.height = 25;
        addChild(_local_1);
        return (_local_1);
    }


}
}//package kabam.rotmg.news.view
