package kabam.rotmg.ui.view {
import flash.display.Sprite;

public class CharacterWindowBackground extends Sprite {

    public function CharacterWindowBackground() {
        var _local_1:Sprite = new Sprite();
        _local_1.graphics.beginFill(0x363636);
        _local_1.graphics.drawRect(0, 0, 200, 600);
        addChild(_local_1);
    }

}
}//package kabam.rotmg.ui.view
