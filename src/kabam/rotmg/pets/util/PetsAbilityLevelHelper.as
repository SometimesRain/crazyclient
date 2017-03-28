package kabam.rotmg.pets.util {
import kabam.rotmg.util.GeometricSeries;

public class PetsAbilityLevelHelper {

    private static const levelToPoints:GeometricSeries = new GeometricSeries(20, 1.08);


    public static function getTotalAbilityPointsForLevel(_arg_1:int):Number {
        return (levelToPoints.getSummation(_arg_1));
    }

    public static function getCurrentPointsForLevel(_arg_1:int, _arg_2:int):Number {
        var _local_3:Number = getTotalAbilityPointsForLevel((_arg_2 - 1));
        return ((_arg_1 - _local_3));
    }

    public static function getAbilityPointsforLevel(_arg_1:int):Number {
        return (levelToPoints.getTerm((_arg_1 - 1)));
    }


}
}//package kabam.rotmg.pets.util
