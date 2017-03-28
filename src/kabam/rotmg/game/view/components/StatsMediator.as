package kabam.rotmg.game.view.components {
import com.company.assembleegameclient.objects.Player;

import flash.events.MouseEvent;

import kabam.rotmg.ui.signals.UpdateHUDSignal;
import kabam.rotmg.ui.view.StatsDockedSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class StatsMediator extends Mediator {

    [Inject]
    public var view:StatsView;
    [Inject]
    public var updateHUD:UpdateHUDSignal;
    [Inject]
    public var statsUndocked:StatsUndockedSignal;
    [Inject]
    public var statsDocked:StatsDockedSignal;


    override public function initialize():void {
        //this.view.mouseDown.add(this.onStatsDrag);
        this.updateHUD.add(this.onUpdateHUD);
        //this.statsDocked.add(this.onStatsDock);
    }

    override public function destroy():void {
        //this.view.mouseDown.remove(this.onStatsDrag);
        this.updateHUD.remove(this.onUpdateHUD);
    }

    private function onUpdateHUD(_arg_1:Player):void {
        if(view.myPlayer == false)
        {
            return;
        }
        this.view.draw(_arg_1);
    }

    /*private function onStatsDrag(_arg_1:MouseEvent):void {
        if (this.view.currentState == StatsView.STATE_DOCKED) {
            this.view.undock();
            this.statsUndocked.dispatch(this.view);
        }
    }

    private function onStatsDock():void {
        this.view.dock();
    }*/


}
}//package kabam.rotmg.game.view.components
