package kabam.rotmg.pets.controller {
import com.company.assembleegameclient.editor.Command;

import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.messaging.impl.EvolvePetInfo;
import kabam.rotmg.pets.view.dialogs.evolving.EvolveDialog;

import org.swiftsuspenders.Injector;

public class EvolvePetCommand extends Command {

    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var evolvePetInfo:EvolvePetInfo;
    [Inject]
    public var injector:Injector;


    override public function execute():void {
        var _local_1:EvolveDialog = this.injector.getInstance(EvolveDialog);
        this.openDialog.dispatch(_local_1);
        _local_1.evolveAnimation.setEvolvedPets(this.evolvePetInfo);
    }


}
}//package kabam.rotmg.pets.controller
