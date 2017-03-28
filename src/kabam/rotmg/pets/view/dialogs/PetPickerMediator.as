package kabam.rotmg.pets.view.dialogs {
import kabam.rotmg.dialogs.control.OpenDialogNoModalSignal;
import kabam.rotmg.pets.data.PetSlotsState;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.view.components.PetIconFactory;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetPickerMediator extends Mediator {

    [Inject]
    public var view:PetPicker;
    [Inject]
    public var model:PetsModel;
    [Inject]
    public var petIconFactory:PetIconFactory;
    [Inject]
    public var petSlotsState:PetSlotsState;
    [Inject]
    public var openDialog:OpenDialogNoModalSignal;


    override public function initialize():void {
        this.view.setPets(this.model.getAllPets());
        var _local_1:PetVO = (((this.petSlotsState.selected) == PetSlotsState.LEFT) ? this.petSlotsState.rightSlotPetVO : this.petSlotsState.leftSlotPetVO);
        if (_local_1) {
            this.view.filterFusible(_local_1);
        }
        if (((this.petSlotsState.rightSlotPetVO) && (this.view.doDisableUsed))) {
            this.view.filterUsedPetVO(this.petSlotsState.rightSlotPetVO);
        }
        if (((this.petSlotsState.leftSlotPetVO) && (this.view.doDisableUsed))) {
            this.view.filterUsedPetVO(this.petSlotsState.leftSlotPetVO);
        }
        this.view.petPicked.addOnce(this.onPetPicked);
    }

    private function onPetPicked(_arg_1:PetVO):void {
        if (this.petSlotsState.selected == PetSlotsState.LEFT) {
            this.petSlotsState.leftSlotPetVO = _arg_1;
        }
        else {
            this.petSlotsState.rightSlotPetVO = _arg_1;
        }
        if (this.petSlotsState.caller) {
            this.openDialog.dispatch(new this.petSlotsState.caller());
        }
    }


}
}//package kabam.rotmg.pets.view.dialogs
