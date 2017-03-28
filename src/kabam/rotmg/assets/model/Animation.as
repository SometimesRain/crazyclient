package kabam.rotmg.assets.model {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class Animation extends Sprite {

    private const DEFAULT_SPEED:int = 200;
    private const bitmap:Bitmap = makeBitmap();
    private const frames:Vector.<BitmapData> = new Vector.<BitmapData>(0);
    private const timer:Timer = makeTimer();

    private var started:Boolean;
    private var index:int;
    private var count:uint;
    private var disposed:Boolean;


    private function makeBitmap():Bitmap {
        var _local_1:Bitmap = new Bitmap();
        addChild(_local_1);
        return (_local_1);
    }

    private function makeTimer():Timer {
        var _local_1:Timer = new Timer(this.DEFAULT_SPEED);
        _local_1.addEventListener(TimerEvent.TIMER, this.iterate);
        return (_local_1);
    }

    public function getSpeed():int {
        return (this.timer.delay);
    }

    public function setSpeed(_arg_1:int):void {
        this.timer.delay = _arg_1;
    }

    public function setFrames(... rest):void {
        var _local_2:BitmapData;
        this.frames.length = 0;
        this.index = 0;
        for each (_local_2 in rest) {
            this.count = this.frames.push(_local_2);
        }
        if (this.started) {
            this.start();
        }
        else {
            this.iterate();
        }
    }

    public function addFrame(_arg_1:BitmapData):void {
        this.count = this.frames.push(_arg_1);
        ((this.started) && (this.start()));
    }

    public function start():void {
        if (((!(this.started)) && ((this.count > 0)))) {
            this.timer.start();
            this.iterate();
        }
        this.started = true;
    }

    public function stop():void {
        ((this.started) && (this.timer.stop()));
        this.started = false;
    }

    private function iterate(_arg_1:TimerEvent = null):void {
        this.index = (++this.index % this.count);
        this.bitmap.bitmapData = this.frames[this.index];
    }

    public function dispose():void {
        var _local_1:BitmapData;
        this.disposed = true;
        this.stop();
        this.index = 0;
        this.count = 0;
        this.frames.length = 0;
        for each (_local_1 in this.frames) {
            _local_1.dispose();
        }
    }

    public function isStarted():Boolean {
        return (this.started);
    }

    public function isDisposed():Boolean {
        return (this.disposed);
    }


}
}//package kabam.rotmg.assets.model
