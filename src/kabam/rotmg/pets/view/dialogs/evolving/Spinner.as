package kabam.rotmg.pets.view.dialogs.evolving {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.getTimer;

import kabam.rotmg.assets.EmbeddedAssets;

public class Spinner extends Sprite {

    public const graphic:DisplayObject = new EmbeddedAssets.StarburstSpinner();

    public var degreesPerSecond:Number;
    private var secondsElapsed:Number;
    private var previousSeconds:Number;

    public function Spinner() {
        this.secondsElapsed = 0;
        this.defaultConfig();
        this.addGraphic();
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
    }

    private function defaultConfig():void {
        this.degreesPerSecond = 50;
    }

    private function addGraphic():void {
        addChild(this.graphic);
        this.graphic.x = ((-1 * width) / 2);
        this.graphic.y = ((-1 * height) / 2);
    }

    private function onRemoved(_arg_1:Event):void {
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onEnterFrame(_arg_1:Event):void {
        this.updateTimeElapsed();
        rotation = ((this.degreesPerSecond * this.secondsElapsed) % 360);
    }

    private function updateTimeElapsed():void {
        var _local_1:Number = (getTimer() / 1000);
        if (this.previousSeconds) {
            this.secondsElapsed = (this.secondsElapsed + (_local_1 - this.previousSeconds));
        }
        this.previousSeconds = _local_1;
    }


}
}//package kabam.rotmg.pets.view.dialogs.evolving
