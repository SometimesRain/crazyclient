package kabam.rotmg.util.components {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.rotmg.pets.view.components.PopupWindowBackground;

public class InfoHoverPaneFactory extends Sprite {


    public static function make(_arg_1:DisplayObject):Sprite {
        var _local_4:PopupWindowBackground;
        if (_arg_1 == null) {
            return (null);
        }
        var _local_2:Sprite = new Sprite();
        var _local_3:int = 8;
        _arg_1.width = (291 - _local_3);
        _arg_1.height = ((598 - (_local_3 * 2)) - 2);
        _local_2.addChild(_arg_1);
        _local_4 = new PopupWindowBackground();
        _local_4.draw(_arg_1.width, (_arg_1.height + 2), PopupWindowBackground.TYPE_TRANSPARENT_WITHOUT_HEADER);
        _local_4.x = _arg_1.x;
        _arg_1.y--;
        _local_2.addChild(_local_4);
        return (_local_2);
    }


}
}//package kabam.rotmg.util.components
