package kabam.rotmg.pets.view {
import kabam.rotmg.pets.controller.reskin.UpdateSelectedPetForm;
import kabam.rotmg.pets.data.PetFormModel;
import kabam.rotmg.pets.data.PetRarityEnum;
import kabam.rotmg.pets.data.PetSkinGroupVO;
import kabam.rotmg.pets.data.PetVO;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetSkinGroupMediator extends Mediator {

    [Inject]
    public var view:PetSkinGroup;
    [Inject]
    public var petFormModel:PetFormModel;
    [Inject]
    public var updateSelectedPetForm:UpdateSelectedPetForm;


    override public function initialize():void {
        var _local_1:PetSkinGroupVO = this.petFormModel.petSkinGroupVOs[this.view.index];
        var _local_2:PetRarityEnum = _local_1.petRarityEnum;
        this.updateSelectedPetForm.add(this.onUpdateSelectedPetForm);
        this.view.skinSelected.add(this.onSkinSelected);
        this.view.disabled = this.isSelectedPetRarerThan(_local_2);
        this.view.init(_local_1);
    }

    private function onSkinSelected(_arg_1:PetVO):void {
        this.petFormModel.setSelectedSkin(_arg_1.getSkinID());
        this.updateSelectedPetForm.dispatch();
    }

    private function onUpdateSelectedPetForm():void {
        this.view.onSlotSelected(this.petFormModel.getSelectedSkin());
    }

    private function isSelectedPetRarerThan(_arg_1:PetRarityEnum):Boolean {
        var _local_2:PetVO = this.petFormModel.getSelectedPet();
        var _local_3:PetRarityEnum = PetRarityEnum.selectByValue(_local_2.getRarity());
        var _local_4:int = _local_3.ordinal;
        return ((_arg_1.ordinal > _local_4));
    }


}
}//package kabam.rotmg.pets.view
