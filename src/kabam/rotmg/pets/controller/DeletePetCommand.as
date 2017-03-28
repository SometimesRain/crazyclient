package kabam.rotmg.pets.controller {
import com.company.assembleegameclient.editor.Command;

import kabam.rotmg.pets.data.PetsModel;

public class DeletePetCommand extends Command {

    [Inject]
    public var petID:int;
    [Inject]
    public var petsModel:PetsModel;


    override public function execute():void {
        this.petsModel.deletePet(this.petID);
    }


}
}//package kabam.rotmg.pets.controller
