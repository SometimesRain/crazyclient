package kabam.rotmg.tooltips {
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;

public interface TooltipAble {

    function setShowToolTipSignal(_arg_1:ShowTooltipSignal):void;

    function getShowToolTip():ShowTooltipSignal;

    function setHideToolTipsSignal(_arg_1:HideTooltipsSignal):void;

    function getHideToolTips():HideTooltipsSignal;

}
}//package kabam.rotmg.tooltips
