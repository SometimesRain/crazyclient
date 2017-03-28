package kabam.rotmg.death.control {
import kabam.rotmg.death.view.ZombifyDialog;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.dialogs.control.ShowDialogBackgroundSignal;

import robotlegs.bender.framework.api.ILogger;

public class ZombifyCommand {

    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var showDialogBackground:ShowDialogBackgroundSignal;
    [Inject]
    public var logger:ILogger;


    public function execute():void {
        this.logger.info("Zombify Player");
        this.openDialog.dispatch(new ZombifyDialog());
        this.showDialogBackground.dispatch(0x3300);
    }


}
}//package kabam.rotmg.death.control
