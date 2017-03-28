package kabam.display.Loader {
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.net.URLRequest;
import flash.system.LoaderContext;

import kabam.display.LoaderInfo.LoaderInfoProxy;
import kabam.display.LoaderInfo.LoaderInfoProxyConcrete;

public class LoaderProxyConcrete extends LoaderProxy {

    private var loader:Loader;
    private var _contentLoaderInfo:LoaderInfoProxy;

    public function LoaderProxyConcrete() {
        this.loader = (addChild(new Loader()) as Loader);
        super();
    }

    override public function get content():DisplayObject {
        return (this.loader.content);
    }

    override public function get contentLoaderInfo():LoaderInfoProxy {
        if (this._contentLoaderInfo == null) {
            this._contentLoaderInfo = new LoaderInfoProxyConcrete();
            this._contentLoaderInfo.loaderInfo = this.loader.contentLoaderInfo;
        }
        return (this._contentLoaderInfo);
    }

    override public function load(_arg_1:URLRequest, _arg_2:LoaderContext = null):void {
        this.loader.load(_arg_1, _arg_2);
    }

    override public function unload():void {
        this.loader.unload();
    }


}
}//package kabam.display.Loader
