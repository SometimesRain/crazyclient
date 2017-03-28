package kabam.rotmg.pets.view.components {
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import kabam.rotmg.core.signals.ShowTooltipSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetAbilityDisplayMediator extends Mediator {

    [Inject]
    public var view:PetAbilityDisplay;
    [Inject]
    public var showToolTip:ShowTooltipSignal;


    override public function initialize():void {
        this.view.addToolTip.add(this.onAddToolTip);
    }

    override public function destroy():void {
        this.view.destroy();
    }

    private function onAddToolTip(_arg_1:ToolTip):void {
        this.showToolTip.dispatch(_arg_1);
    }


}
}//package kabam.rotmg.pets.view.components
