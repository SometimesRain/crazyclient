package kabam.rotmg.pets.data {
public class PetYardEnum {

    public static const PET_YARD_ONE:PetYardEnum = new PetYardEnum("Yard Upgrader 1", 1, PetRarityEnum.COMMON);
    public static const PET_YARD_TWO:PetYardEnum = new PetYardEnum("Yard Upgrader 2", 2, PetRarityEnum.UNCOMMON);
    public static const PET_YARD_THREE:PetYardEnum = new PetYardEnum("Yard Upgrader 3", 3, PetRarityEnum.RARE);
    public static const PET_YARD_FOUR:PetYardEnum = new PetYardEnum("Yard Upgrader 4", 4, PetRarityEnum.LEGENDARY);
    public static const PET_YARD_FIVE:PetYardEnum = new PetYardEnum("Yard Upgrader 5", 5, PetRarityEnum.DIVINE);
    public static const MAX_ORDINAL:int = 5;

    public var value:String;
    public var ordinal:int;
    public var rarity:PetRarityEnum;

    public function PetYardEnum(_arg_1:*, _arg_2:int, _arg_3:PetRarityEnum) {
        this.value = _arg_1;
        this.ordinal = _arg_2;
        this.rarity = _arg_3;
    }

    public static function get list():Array {
        return ([PET_YARD_ONE, PET_YARD_TWO, PET_YARD_THREE, PET_YARD_FOUR, PET_YARD_FIVE]);
    }

    public static function selectByValue(_arg_1:String):PetYardEnum {
        var _local_2:PetYardEnum;
        var _local_3:PetYardEnum;
        for each (_local_3 in PetYardEnum.list) {
            if (_arg_1 == _local_3.value) {
                _local_2 = _local_3;
            }
        }
        return (_local_2);
    }

    public static function selectByOrdinal(_arg_1:int):PetYardEnum {
        var _local_2:PetYardEnum;
        var _local_3:PetYardEnum;
        for each (_local_3 in PetYardEnum.list) {
            if (_arg_1 == _local_3.ordinal) {
                _local_2 = _local_3;
            }
        }
        return (_local_2);
    }


}
}//package kabam.rotmg.pets.data
