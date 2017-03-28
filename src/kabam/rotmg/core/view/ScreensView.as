package kabam.rotmg.core.view {
import flash.display.Sprite;

public class ScreensView extends Sprite {

    private var current:Sprite;
    private var previous:Sprite;


    public function setScreen(_arg_1:Sprite):void {
        if (this.current == _arg_1) {
            return;
        }
        this.removePrevious();
        this.current = _arg_1;
        addChild(_arg_1);
    }

    private function removePrevious():void {
        if (((this.current) && (contains(this.current)))) {
            this.previous = this.current;
            removeChild(this.current);
        }
    }

    public function getPrevious():Sprite {
        return (this.previous);
    }


}
}//package kabam.rotmg.core.view
