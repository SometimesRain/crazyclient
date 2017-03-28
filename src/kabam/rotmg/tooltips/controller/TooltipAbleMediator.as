package kabam.rotmg.tooltips.controller {
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.tooltips.TooltipAble;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TooltipAbleMediator extends Mediator {

    [Inject]
    public var view:TooltipAble;
    [Inject]
    public var showToolTip:ShowTooltipSignal;
    [Inject]
    public var hideToolTips:HideTooltipsSignal;


    override public function initialize():void {
        this.view.setShowToolTipSignal(this.showToolTip);
        this.view.setHideToolTipsSignal(this.hideToolTips);
    }


}
}//package kabam.rotmg.tooltips.controller
