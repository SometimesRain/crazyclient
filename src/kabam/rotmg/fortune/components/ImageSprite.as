package kabam.rotmg.fortune.components {
import flash.display.DisplayObject;
import flash.display.Sprite;

public class ImageSprite extends Sprite {

    public var displayOb_:DisplayObject;

    public function ImageSprite(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number) {
        this.displayOb_ = _arg_1;
        addChild(_arg_1);
        this.width = _arg_2;
        this.height = _arg_3;
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


}
}//package kabam.rotmg.fortune.components
