package kabam.rotmg.packages.view {
import flash.display.BlendMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class BusyIndicator extends Sprite {

    private const pinwheel:Sprite = makePinWheel();
    private const innerCircleMask:Sprite = makeInner();
    private const quarterCircleMask:Sprite = makeQuarter();
    private const timer:Timer = new Timer(25);
    private const radius:int = 22;
    private const color:uint = 0xFFFFFF;

    public function BusyIndicator() {
        x = (y = this.radius);
        this.addChildren();
        addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
    }

    private function makePinWheel():Sprite {
        var _local_1:Sprite;
        _local_1 = new Sprite();
        _local_1.blendMode = BlendMode.LAYER;
        _local_1.graphics.beginFill(this.color);
        _local_1.graphics.drawCircle(0, 0, this.radius);
        _local_1.graphics.endFill();
        return (_local_1);
    }

    private function makeInner():Sprite {
        var _local_1:Sprite = new Sprite();
        _local_1.blendMode = BlendMode.ERASE;
        _local_1.graphics.beginFill((0xFFFFFF * 0.6));
        _local_1.graphics.drawCircle(0, 0, (this.radius / 2));
        _local_1.graphics.endFill();
        return (_local_1);
    }

    private function makeQuarter():Sprite {
        var _local_1:Sprite = new Sprite();
        _local_1.graphics.beginFill(0xFFFFFF);
        _local_1.graphics.drawRect(0, 0, this.radius, this.radius);
        _local_1.graphics.endFill();
        return (_local_1);
    }

    private function addChildren():void {
        this.pinwheel.addChild(this.innerCircleMask);
        this.pinwheel.addChild(this.quarterCircleMask);
        this.pinwheel.mask = this.quarterCircleMask;
        addChild(this.pinwheel);
    }

    private function onAdded(_arg_1:Event):void {
        this.timer.addEventListener(TimerEvent.TIMER, this.updatePinwheel);
        this.timer.start();
    }

    private function onRemoved(_arg_1:Event):void {
        this.timer.stop();
        this.timer.removeEventListener(TimerEvent.TIMER, this.updatePinwheel);
    }

    private function updatePinwheel(_arg_1:TimerEvent):void {
        this.quarterCircleMask.rotation = (this.quarterCircleMask.rotation + 20);
    }


}
}//package kabam.rotmg.packages.view
