package kabam.rotmg.death.control {
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.death.model.DeathModel;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.messaging.impl.incoming.Death;

public class HandleDeathCommand {

    [Inject]
    public var death:Death;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var model:DeathModel;
    [Inject]
    public var player:PlayerModel;
    [Inject]
    public var resurrect:ResurrectPlayerSignal;
    [Inject]
    public var zombify:ZombifySignal;
    [Inject]
    public var normal:HandleNormalDeathSignal;


    public function execute():void {
        this.closeDialogs.dispatch();
        if (this.isZombieDeathPending()) {
            this.passPreviousDeathToFameView();
        }
        else {
            this.updateModelAndHandleDeath();
        }
    }

    private function isZombieDeathPending():Boolean {
        return (this.model.getIsDeathViewPending());
    }

    private function passPreviousDeathToFameView():void {
        this.normal.dispatch(this.model.getLastDeath());
    }

    private function updateModelAndHandleDeath():void {
        this.model.setLastDeath(this.death);
        if (this.death.isZombie) {
            this.zombify.dispatch(this.death);
        }
        else {
            if (!this.player.getHasPlayerDied()) {
                this.resurrect.dispatch(this.death);
            }
            else {
                this.normal.dispatch(this.death);
            }
        }
    }


}
}//package kabam.rotmg.death.control
