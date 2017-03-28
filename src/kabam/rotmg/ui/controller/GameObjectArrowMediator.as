package kabam.rotmg.ui.controller {
import com.company.assembleegameclient.map.partyoverlay.GameObjectArrow;

import kabam.rotmg.core.view.Layers;

import robotlegs.bender.bundles.mvcs.Mediator;

public class GameObjectArrowMediator extends Mediator {

    [Inject]
    public var view:GameObjectArrow;
    [Inject]
    public var layers:Layers;


    override public function initialize():void {
        this.view.menuLayer = this.layers.top;
    }


}
}//package kabam.rotmg.ui.controller
