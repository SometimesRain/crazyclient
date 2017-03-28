package kabam.rotmg.promotions.view.components {
import flash.display.Sprite;

public class TransparentButton extends Sprite {

    public function TransparentButton(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int) {
        graphics.beginFill(0, 0);
        graphics.drawRect(0, 0, _arg_3, _arg_4);
        graphics.endFill();
        this.x = _arg_1;
        this.y = _arg_2;
        buttonMode = true;
    }

}
}//package kabam.rotmg.promotions.view.components
