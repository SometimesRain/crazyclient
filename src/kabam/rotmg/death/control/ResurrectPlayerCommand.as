package kabam.rotmg.death.control {
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.death.model.DeathModel;
import kabam.rotmg.death.view.ResurrectionView;

import robotlegs.bender.framework.api.ILogger;

public class ResurrectPlayerCommand {

    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var deathModel:DeathModel;
    [Inject]
    public var setScreen:SetScreenSignal;
    [Inject]
    public var logger:ILogger;


    public function execute():void {
        this.logger.info("Resurrect Player");
        this.deathModel.clearPendingDeathView();
        this.model.setHasPlayerDied(true);
        this.setScreen.dispatch(new ResurrectionView());
    }


}
}//package kabam.rotmg.death.control
