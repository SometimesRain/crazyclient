package kabam.lib.ui.api {
import flash.display.DisplayObject;

public interface List {

    function addItem(_arg_1:DisplayObject):void;

    function setItems(_arg_1:Vector.<DisplayObject>):void;

    function getItemAt(_arg_1:int):DisplayObject;

    function getItemCount():int;

}
}//package kabam.lib.ui.api
