package com.company.util {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

public class SpriteUtil {


    public static function safeAddChild(_arg_1:DisplayObjectContainer, _arg_2:DisplayObject):void {
        if (((((!((_arg_1 == null))) && (!((_arg_2 == null))))) && (!(_arg_1.contains(_arg_2))))) {
            _arg_1.addChild(_arg_2);
        }
    }

    public static function safeRemoveChild(_arg_1:DisplayObjectContainer, _arg_2:DisplayObject):void {
        if (((((!((_arg_1 == null))) && (!((_arg_2 == null))))) && (_arg_1.contains(_arg_2)))) {
            _arg_1.removeChild(_arg_2);
        }
    }


}
}//package com.company.util
