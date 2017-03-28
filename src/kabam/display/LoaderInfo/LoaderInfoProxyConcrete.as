package kabam.display.LoaderInfo {
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.events.EventDispatcher;

public class LoaderInfoProxyConcrete extends EventDispatcher implements LoaderInfoProxy {

    private var _loaderInfo:LoaderInfo;


    override public function toString():String {
        return (this._loaderInfo.toString());
    }

    override public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean = false, _arg_4:int = 0, _arg_5:Boolean = false):void {
        this._loaderInfo.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
    }

    override public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean = false):void {
        this._loaderInfo.removeEventListener(_arg_1, _arg_2, _arg_3);
    }

    override public function dispatchEvent(_arg_1:Event):Boolean {
        return (this._loaderInfo.dispatchEvent(_arg_1));
    }

    override public function hasEventListener(_arg_1:String):Boolean {
        return (this._loaderInfo.hasEventListener(_arg_1));
    }

    override public function willTrigger(_arg_1:String):Boolean {
        return (this._loaderInfo.willTrigger(_arg_1));
    }

    public function set loaderInfo(_arg_1:LoaderInfo):void {
        this._loaderInfo = _arg_1;
    }


}
}//package kabam.display.LoaderInfo
