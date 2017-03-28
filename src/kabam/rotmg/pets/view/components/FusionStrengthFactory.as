package kabam.rotmg.pets.view.components {
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class FusionStrengthFactory {

    private static const FONT_SIZE:int = 14;


    public static function makeRoundedBox():DisplayObjectContainer {
        var _local_1:Sprite = new Sprite();
        _local_1.graphics.beginFill(0x535353);
        _local_1.graphics.drawRoundRect(0, 0, 222, 40, 10, 10);
        _local_1.graphics.endFill();
        return (_local_1);
    }

    public static function makeText():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local_1.setStringBuilder(new LineBuilder().setParams("FusionStrength.text")).setAutoSize(TextFieldAutoSize.LEFT).setColor(FusionStrength.DEFAULT_COLOR);
        configureText(_local_1);
        return (_local_1);
    }

    public static function makeFusionText():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setAutoSize(TextFieldAutoSize.RIGHT);
        configureText(_local_1);
        return (_local_1);
    }

    private static function configureText(_arg_1:TextFieldDisplayConcrete):void {
        _arg_1.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE).setSize(FONT_SIZE).setBold(true);
    }


}
}//package kabam.rotmg.pets.view.components
