package kabam.rotmg.pets.view.components {
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.pets.data.PetSlotsState;
import kabam.rotmg.pets.data.PetsModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetFuserMediator extends Mediator {

    [Inject]
    public var view:PetFuser;
    [Inject]
    public var petsModel:PetsModel;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var petSlotsState:PetSlotsState;


    override public function initialize():void {
        if (!this.petSlotsState.leftSlotPetVO) {
            this.petSlotsState.leftSlotPetVO = this.petsModel.getActivePet();
        }
        this.view.initialize(this.petSlotsState);
    }


}
}//package kabam.rotmg.pets.view.components
