package kabam.rotmg.pets.view {
import kabam.rotmg.pets.controller.reskin.ReskinPetRequestSignal;
import kabam.rotmg.pets.controller.reskin.UpdateSelectedPetForm;
import kabam.rotmg.pets.data.PetFormModel;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.data.ReskinPetVO;
import kabam.rotmg.pets.data.ReskinViewState;
import kabam.rotmg.pets.view.dialogs.PetPicker;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetFormMediator extends Mediator {

    [Inject]
    public var view:PetFormView;
    [Inject]
    public var petFormModel:PetFormModel;
    [Inject]
    public var reskinPetRequest:ReskinPetRequestSignal;
    [Inject]
    public var updateSelectedPetForm:UpdateSelectedPetForm;
    [Inject]
    public var petsModel:PetsModel;
    [Inject]
    public var picker:PetPicker;
    private var skinGroups:Vector.<PetSkinGroup>;

    public function PetFormMediator() {
        this.skinGroups = new Vector.<PetSkinGroup>();
        super();
    }

    override public function initialize():void {
        var _local_1:Vector.<PetVO> = this.petsModel.getAllPets();
        this.picker.petPicked.add(this.onPetPicked);
        this.view.skinGroupsInitialized.add(this.onSkinGroupsInitialized);
        this.view.reskinRequest.add(this.onPetReskinRequest);
        this.view.init();
        this.view.createPetPicker(this.picker, _local_1);
        this.view.setState(ReskinViewState.PETPICKER);
    }

    private function onSkinGroupsInitialized():void {
        this.updateSelectedPetForm.dispatch();
    }

    private function initSkinGroups():void {
        var _local_1:uint;
        var _local_2:uint = 3;
        _local_1 = 0;
        while (_local_1 < _local_2) {
            this.createPetSkinGroup(_local_1);
            _local_1++;
        }
    }

    private function createPetSkinGroup(_arg_1:uint):void {
        var _local_2:PetSkinGroup = new PetSkinGroup(_arg_1);
        _local_2.skinSelected.add(this.onPetReskinSelected);
        this.skinGroups.push(_local_2);
    }

    private function onPetReskinSelected(_arg_1:int):void {
    }

    private function onPetReskinRequest():void {
        var _local_1:ReskinPetVO = new ReskinPetVO();
        _local_1.petInstanceId = this.petFormModel.getSelectedPet().getID();
        _local_1.pickedNewPetType = this.petFormModel.getSelectedSkin();
        this.reskinPetRequest.dispatch(_local_1);
    }

    private function onPetPicked(_arg_1:PetVO):void {
        this.petFormModel.setSelectedPet(_arg_1);
        this.petFormModel.setSelectedSkin(_arg_1.getSkinID());
        this.petFormModel.createPetFamilyTree();
        this.initSkinGroups();
        this.view.createSkinGroups(this.skinGroups);
        this.view.setState(ReskinViewState.SKINPICKER);
    }


}
}//package kabam.rotmg.pets.view
