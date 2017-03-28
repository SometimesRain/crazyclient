package kabam.rotmg.death.view {
import flash.display.BitmapData;

import kabam.rotmg.death.control.HandleNormalDeathSignal;
import kabam.rotmg.death.model.DeathModel;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.messaging.impl.incoming.Death;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ZombifyDialogMediator extends Mediator {

    [Inject]
    public var view:ZombifyDialog;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var handleDeath:HandleNormalDeathSignal;
    [Inject]
    public var death:DeathModel;


    override public function initialize():void {
        this.view.closed.addOnce(this.onClosed);
    }

    private function onClosed():void {
        var _local_1:Death;
        _local_1 = this.death.getLastDeath();
        var _local_2:BitmapData = new BitmapDataSpy(this.view.stage.width, this.view.stage.height);
        _local_2.draw(this.view.stage);
        _local_1.background = _local_2;
        this.closeDialogs.dispatch();
        this.handleDeath.dispatch(_local_1);
    }


}
}//package kabam.rotmg.death.view
