package kabam.rotmg.pets.data {
public class FusionCalculator {

    private static var ranges:Object = makeRanges();


    private static function makeRanges():Object {
        ranges = {};
        ranges[PetRarityEnum.COMMON.value] = 30;
        ranges[PetRarityEnum.UNCOMMON.value] = 20;
        ranges[PetRarityEnum.RARE.value] = 20;
        ranges[PetRarityEnum.LEGENDARY.value] = 20;
        return (ranges);
    }

    public static function getStrengthPercentage(_arg_1:PetVO, _arg_2:PetVO):Number {
        var _local_3:Number = getRarityPointsPercentage(_arg_1);
        var _local_4:Number = getRarityPointsPercentage(_arg_2);
        return (average(_local_3, _local_4));
    }

    private static function average(_arg_1:Number, _arg_2:Number):Number {
        return (((_arg_1 + _arg_2) / 2));
    }

    private static function getRarityPointsPercentage(_arg_1:PetVO):Number {
        var _local_2:int = ranges[_arg_1.getRarity()];
        var _local_3:int = (_arg_1.getMaxAbilityPower() - _local_2);
        var _local_4:int = (_arg_1.abilityList[0].level - _local_3);
        return ((_local_4 / _local_2));
    }


}
}//package kabam.rotmg.pets.data
