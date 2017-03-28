package com.company.assembleegameclient.ui.panels.mediators {
import com.company.assembleegameclient.ui.panels.PartyPanel;

import kabam.rotmg.core.view.Layers;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PartyPanelMediator extends Mediator {

    [Inject]
    public var view:PartyPanel;
    [Inject]
    public var layers:Layers;


    override public function initialize():void {
        this.view.menuLayer = this.layers.top;
    }

    override public function destroy():void {
        super.destroy();
    }


}
}//package com.company.assembleegameclient.ui.panels.mediators
