package kabam.rotmg.pets.controller {
import com.company.assembleegameclient.editor.Command;

import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.pets.view.dialogs.EggHatchedDialog;

public class HatchPetCommand extends Command {

    [Inject]
    public var petName:String;
    [Inject]
    public var petSkin:int;
    [Inject]
    public var openDialog:OpenDialogSignal;


    override public function execute():void {
        this.openDialog.dispatch(new EggHatchedDialog(this.petName, this.petSkin));
    }


}
}//package kabam.rotmg.pets.controller
