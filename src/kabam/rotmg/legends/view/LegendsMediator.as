package kabam.rotmg.legends.view {
import kabam.rotmg.death.model.DeathModel;
import kabam.rotmg.fame.control.ShowFameViewSignal;
import kabam.rotmg.legends.control.ExitLegendsSignal;
import kabam.rotmg.legends.control.FameListUpdateSignal;
import kabam.rotmg.legends.control.RequestFameListSignal;
import kabam.rotmg.legends.model.Legend;
import kabam.rotmg.legends.model.LegendsModel;
import kabam.rotmg.legends.model.Timespan;

import robotlegs.bender.bundles.mvcs.Mediator;

public class LegendsMediator extends Mediator {

    [Inject]
    public var view:LegendsView;
    [Inject]
    public var model:LegendsModel;
    [Inject]
    public var deathModel:DeathModel;
    [Inject]
    public var showFameDetail:ShowFameViewSignal;
    [Inject]
    public var requestFameList:RequestFameListSignal;
    [Inject]
    public var update:FameListUpdateSignal;
    [Inject]
    public var exit:ExitLegendsSignal;


    override public function initialize():void {
        this.view.close.add(this.onClose);
        this.view.timespanChanged.add(this.onTimespanChanged);
        this.view.showDetail.add(this.onShowCharacter);
        this.update.add(this.updateLegendList);
        this.onTimespanChanged(this.model.getTimespan());
    }

    private function onClose():void {
        this.exit.dispatch();
    }

    override public function destroy():void {
        this.view.close.remove(this.onClose);
        this.view.timespanChanged.remove(this.onTimespanChanged);
        this.view.showDetail.remove(this.onShowCharacter);
        this.update.remove(this.updateLegendList);
        this.deathModel.clearPendingDeathView();
        this.model.clear();
    }

    private function onTimespanChanged(_arg_1:Timespan):void {
        this.model.setTimespan(_arg_1);
        if (this.model.hasLegendList()) {
            this.updateLegendList();
        }
        else {
            this.showLoadingAndRequestFameList();
        }
    }

    private function showLoadingAndRequestFameList():void {
        this.view.clear();
        this.view.showLoading();
        this.requestFameList.dispatch(this.model.getTimespan());
    }

    private function updateLegendList(_arg_1:Timespan = null):void {
        _arg_1 = ((_arg_1) || (this.model.getTimespan()));
        this.view.hideLoading();
        this.view.setLegendsList(_arg_1, this.model.getLegendList());
    }

    private function onShowCharacter(_arg_1:Legend):void {
        this.showFameDetail.dispatch(_arg_1);
    }


}
}//package kabam.rotmg.legends.view
