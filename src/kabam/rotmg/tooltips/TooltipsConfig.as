package kabam.rotmg.tooltips {
import kabam.rotmg.tooltips.view.TooltipsMediator;
import kabam.rotmg.tooltips.view.TooltipsView;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

public class TooltipsConfig implements IConfig {

    [Inject]
    public var context:IContext;
    [Inject]
    public var mediatorMap:IMediatorMap;


    public function configure():void {
        this.mediatorMap.map(TooltipsView).toMediator(TooltipsMediator);
    }


}
}//package kabam.rotmg.tooltips
