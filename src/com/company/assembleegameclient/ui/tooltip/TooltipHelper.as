package com.company.assembleegameclient.ui.tooltip {
public class TooltipHelper {

    public static const BETTER_COLOR:uint = 0xFF00;
    public static const WORSE_COLOR:uint = 0xFF0000;
    public static const NO_DIFF_COLOR:uint = 16777103;


    public static function wrapInFontTag(_arg_1:String, _arg_2:String):String {
        return ((((('<font color="' + _arg_2) + '">') + _arg_1) + "</font>"));
    }

    public static function getOpenTag(_arg_1:uint):String {
        return ((('<font color="#' + _arg_1.toString(16)) + '">'));
    }

    public static function getCloseTag():String {
        return ("</font>");
    }

    public static function getFormattedRangeString(_arg_1:Number):String {
        var _local_2:Number = (_arg_1 - int(_arg_1));
        return ((((int((_local_2 * 10))) == 0) ? int(_arg_1).toString() : _arg_1.toFixed(1)));
    }

    public static function getTextColor(_arg_1:Number):uint {
        if (_arg_1 < 0) {
            return (WORSE_COLOR);
        }
        if (_arg_1 > 0) {
            return (BETTER_COLOR);
        }
        return (NO_DIFF_COLOR);
    }


}
}//package com.company.assembleegameclient.ui.tooltip
