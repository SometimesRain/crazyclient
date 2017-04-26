package kabam.rotmg.minimap {
import kabam.rotmg.minimap.control.MiniMapZoomSignal;
import kabam.rotmg.minimap.control.SetMiniMapMapSignal;
import kabam.rotmg.minimap.control.UpdateGameObjectTileSignal;
import kabam.rotmg.minimap.control.UpdateGroundTileSignal;
import kabam.rotmg.minimap.view.MiniMap;
import kabam.rotmg.minimap.view.MiniMapMediator;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

public class MiniMapConfig implements IConfig {

    [Inject]
    public var context:IContext;
    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;


    public function configure():void {
        this.injector.map(MiniMapZoomSignal).asSingleton();
        this.injector.map(SetMiniMapMapSignal).asSingleton();
        this.injector.map(UpdateGameObjectTileSignal).asSingleton();
        this.injector.map(UpdateGroundTileSignal).asSingleton();
        this.mediatorMap.map(MiniMap).toMediator(MiniMapMediator);
    }


}
}//package kabam.rotmg.minimap
