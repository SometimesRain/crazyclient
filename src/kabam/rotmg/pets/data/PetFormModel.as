package kabam.rotmg.pets.data {
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;

import flash.utils.Dictionary;

import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.text.model.TextKey;

public class PetFormModel {

    private var Data:Class;
    private var petsXML:XML;
    private var branches:Dictionary;
    private var selectedPet:PetVO;
    private var selectedSkin:int;
    public var slotObjectData:SlotObjectData;

    public function PetFormModel() {
        this.Data = PetFormModel_Data;
        this.petsXML = XML(new this.Data());
        super();
    }

    public function get petSkinGroupVOs():Array {
        var _local_1:Array = [];
        _local_1[0] = new PetSkinGroupVO(TextKey.PET_RARITY_COMMON, this.getIconGroup("Common"), PetRarityEnum.COMMON, this.selectedPet.getSkinID());
        _local_1[1] = new PetSkinGroupVO(TextKey.PET_RARITY_RARE, this.getIconGroup("Rare"), PetRarityEnum.RARE, this.selectedPet.getSkinID());
        _local_1[2] = new PetSkinGroupVO(TextKey.PET_RARITY_DIVINE, this.getIconGroup("Divine"), PetRarityEnum.DIVINE, this.selectedPet.getSkinID());
        return (_local_1);
    }

    public function createPetFamilyTree():void {
        var _local_1:uint;
        var _local_3:XML;
        var _local_2:uint = this.petsXML.Object.length();
        this.branches = new Dictionary();
        _local_1 = 0;
        while (_local_1 < _local_2) {
            _local_3 = this.petsXML.Object[_local_1];
            if (this.petIsInFamilyTree(_local_3)) {
                this.addPetToAppropriateRarityList(_local_3);
            }
            _local_1++;
        }
    }

    private function addPetToAppropriateRarityList(_arg_1:XML):void {
        var _local_2:String = XMLList(_arg_1.Rarity).valueOf();
        var _local_3:PetVO = this.convertXMLToPetVOForReskin(_arg_1);
        if (this.branches[_local_2]) {
            this.branches[_local_2].push(_local_3);
        }
        else {
            this.branches[_local_2] = [_local_3];
        }
    }

    public function setSelectedPet(_arg_1:PetVO):void {
        this.selectedPet = _arg_1;
    }

    private function convertXMLToPetVOForReskin(_arg_1:XML):PetVO {
        var _local_2:PetVO = new PetVO();
        _local_2.setType(_arg_1.@type);
        _local_2.setID(_arg_1.@id);
        _local_2.setSkin(this.fetchSkinTypeByID(_arg_1.DefaultSkin[0]));
        return (_local_2);
    }

    private function fetchSkinTypeByID(_arg_1:String):int {
        var _local_2:uint;
        var _local_4:XML;
        var _local_5:String;
        var _local_3:uint = this.petsXML.Object.length();
        _local_2 = 0;
        while (_local_2 < _local_3) {
            _local_4 = this.petsXML.Object[_local_2];
            _local_5 = _local_4.@id;
            if (this.petNodeIsSkin(_local_4)) {
                if (_local_5 == _arg_1) {
                    return (int(_local_4.@type));
                }
            }
            _local_2++;
        }
        return (-1);
    }

    private function petIsInFamilyTree(_arg_1:XML):Boolean {
        return (((_arg_1.hasOwnProperty("Pet")) && ((_arg_1.Family == this.selectedPet.getFamily()))));
    }

    private function petNodeIsSkin(_arg_1:XML):Boolean {
        return (_arg_1.hasOwnProperty("PetSkin"));
    }

    public function getSelectedPet():PetVO {
        return (this.selectedPet);
    }

    public function getIconGroup(_arg_1:String):Array {
        return (this.branches[_arg_1]);
    }

    public function setSlotObject(_arg_1:InteractiveItemTile):void {
        this.slotObjectData = new SlotObjectData();
        this.slotObjectData.objectId_ = _arg_1.ownerGrid.owner.objectId_;
        this.slotObjectData.objectType_ = _arg_1.getItemId();
        this.slotObjectData.slotId_ = _arg_1.tileId;
    }

    public function getSelectedSkin():int {
        return (this.selectedSkin);
    }

    public function setSelectedSkin(_arg_1:int):void {
        this.selectedSkin = _arg_1;
    }

    public function getpetTypeFromSkinID(_arg_1:int):int {
        var _local_2:uint;
        var _local_4:XML;
        var _local_5:int;
        var _local_3:uint = this.petsXML.Object.length();
        _local_2 = 0;
        while (_local_2 < _local_3) {
            _local_4 = this.petsXML.Object[_local_2];
            _local_5 = int(_local_4.@type);
            if (_local_5 == _arg_1) {
                return (this.fetchPetTypeBySkinID(_local_4.@id));
            }
            _local_2++;
        }
        return (-1);
    }

    private function fetchPetTypeBySkinID(_arg_1:String):int {
        var _local_2:uint;
        var _local_4:XML;
        var _local_5:String;
        var _local_3:uint = this.petsXML.Object.length();
        _local_2 = 0;
        while (_local_2 < _local_3) {
            _local_4 = this.petsXML.Object[_local_2];
            _local_5 = _local_4.DefaultSkin;
            if (_local_5 == _arg_1) {
                return (_local_4.@type);
            }
            _local_2++;
        }
        return (-1);
    }


}
}//package kabam.rotmg.pets.data
