package kabam.rotmg.arena.control {
import kabam.rotmg.arena.model.CurrentArenaRunModel;

import robotlegs.bender.bundles.mvcs.Command;

public class ClearCurrentRunCommand extends Command {

    [Inject]
    public var currentRunModel:CurrentArenaRunModel;


    override public function execute():void {
        this.currentRunModel.clear();
    }


}
}//package kabam.rotmg.arena.control
