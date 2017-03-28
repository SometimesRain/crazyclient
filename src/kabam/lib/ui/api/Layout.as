package kabam.lib.ui.api {
import flash.display.DisplayObject;

public interface Layout {

    function getPadding():int;

    function setPadding(_arg_1:int):void;

    function layout(_arg_1:Vector.<DisplayObject>, _arg_2:int = 0):void;

}
}//package kabam.lib.ui.api
