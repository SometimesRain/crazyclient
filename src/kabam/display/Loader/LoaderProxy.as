package kabam.display.Loader {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.net.URLRequest;
import flash.system.LoaderContext;

import kabam.display.LoaderInfo.LoaderInfoProxy;

public class LoaderProxy extends Sprite {


    public function get content():DisplayObject {
        return (null);
    }

    public function get contentLoaderInfo():LoaderInfoProxy {
        return (null);
    }

    public function load(_arg_1:URLRequest, _arg_2:LoaderContext = null):void {
    }

    public function unload():void {
    }


}
}//package kabam.display.Loader
