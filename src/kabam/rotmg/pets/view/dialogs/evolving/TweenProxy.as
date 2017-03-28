package kabam.rotmg.pets.view.dialogs.evolving {
import flash.display.DisplayObject;

public class TweenProxy {

    protected var onComplete:Function;
    protected var target:DisplayObject;

    public function TweenProxy(_arg_1:DisplayObject) {
        this.target = _arg_1;
    }

    public function start():void {
    }

    public function setOnComplete(_arg_1:Function):void {
        this.onComplete = _arg_1;
    }


}
}//package kabam.rotmg.pets.view.dialogs.evolving
