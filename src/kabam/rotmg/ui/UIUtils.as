package kabam.rotmg.ui {
import flash.display.Sprite;
import flash.display.StageQuality;

public class UIUtils {

    private static const NOTIFICATION_BACKGROUND_WIDTH:Number = 95;
    public static const NOTIFICATION_BACKGROUND_HEIGHT:Number = 25;
    private static const NOTIFICATION_BACKGROUND_ALPHA:Number = 0.4;
    private static const NOTIFICATION_BACKGROUND_COLOR:Number = 0;
    public static const EXPERIMENTAL_MENU_PASSWORD:String = "decamenu";
    public static var SHOW_EXPERIMENTAL_MENU:Boolean = false;
    public static const NOTIFICATION_SPACE:uint = 28;


    public static function makeStaticHUDBackground():Sprite {
        var _local_1:Number = NOTIFICATION_BACKGROUND_WIDTH;
        var _local_2:Number = NOTIFICATION_BACKGROUND_HEIGHT;
        return (makeHUDBackground(_local_1, _local_2));
    }

    public static function makeHUDBackground(_arg_1:Number, _arg_2:Number):Sprite {
        var _local_3:Sprite = new Sprite();
        return (drawHUDBackground(_local_3, _arg_1, _arg_2));
    }

    private static function drawHUDBackground(_arg_1:Sprite, _arg_2:Number, _arg_3:Number):Sprite {
        _arg_1.graphics.beginFill(NOTIFICATION_BACKGROUND_COLOR, NOTIFICATION_BACKGROUND_ALPHA);
        _arg_1.graphics.drawRoundRect(0, 0, _arg_2, _arg_3, 12, 12);
        _arg_1.graphics.endFill();
        return (_arg_1);
    }

    public static function toggleQuality(_arg_1:Boolean):void {
        if (WebMain.STAGE != null) {
            WebMain.STAGE.quality = ((_arg_1) ? StageQuality.HIGH : StageQuality.LOW);
        }
    }


}
}//package kabam.rotmg.ui
