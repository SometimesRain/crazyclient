package kabam.rotmg.account.web.view {
import com.company.ui.BaseSimpleText;

import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;

public class FormField extends Sprite {

    protected static const BACKGROUND_COLOR:uint = 0x333333;
    protected static const ERROR_BORDER_COLOR:uint = 16549442;
    protected static const NORMAL_BORDER_COLOR:uint = 0x454545;
    protected static const TEXT_COLOR:uint = 0xB3B3B3;


    public function getHeight():Number {
        return (0);
    }

    protected function drawSimpleTextBackground(_arg_1:BaseSimpleText, _arg_2:int, _arg_3:int, _arg_4:Boolean):void {
        var _local_5:uint = ((_arg_4) ? ERROR_BORDER_COLOR : NORMAL_BORDER_COLOR);
        graphics.lineStyle(2, _local_5, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND);
        graphics.beginFill(BACKGROUND_COLOR, 1);
        graphics.drawRect(((_arg_1.x - _arg_2) - 5), (_arg_1.y - _arg_3), (_arg_1.width + (_arg_2 * 2)), (_arg_1.height + (_arg_3 * 2)));
        graphics.endFill();
        graphics.lineStyle();
    }


}
}//package kabam.rotmg.account.web.view
