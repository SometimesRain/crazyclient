package kabam.rotmg.arena.control {
import kabam.rotmg.arena.model.CurrentArenaRunModel;
import kabam.rotmg.game.model.GameModel;

import robotlegs.bender.bundles.mvcs.Command;

public class ArenaDeathCommand extends Command {

    [Inject]
    public var model:CurrentArenaRunModel;
    [Inject]
    public var gameModel:GameModel;


    override public function execute():void {
        this.model.died = true;
    }


}
}//package kabam.rotmg.arena.control
