package kabam.rotmg.pets.data {
public class PetSkinGroupVO {

    public var textKey:String;
    public var icons:Array;
    public var petRarityEnum:PetRarityEnum;
    public var selectedPetSkinID:int;

    public function PetSkinGroupVO(_arg_1:String, _arg_2:Array, _arg_3:PetRarityEnum, _arg_4:int) {
        this.textKey = _arg_1;
        this.icons = _arg_2;
        this.petRarityEnum = _arg_3;
        this.selectedPetSkinID = _arg_4;
    }

}
}//package kabam.rotmg.pets.data
