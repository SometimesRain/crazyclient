package kabam.rotmg.pets.util {
import flash.utils.Dictionary;

import kabam.rotmg.pets.data.PetRarityEnum;

public class FeedFuseCostModel {

    private static const feedCosts:Dictionary = makeFeedDictionary();
    private static const fuseCosts:Dictionary = makeFuseDictionary();


    private static function makeFuseDictionary():Dictionary {
        var _local_1:Dictionary = new Dictionary();
        _local_1[PetRarityEnum.COMMON] = {
            "gold": 100,
            "fame": 300
        };
        _local_1[PetRarityEnum.UNCOMMON] = {
            "gold": 240,
            "fame": 1000
        };
        _local_1[PetRarityEnum.RARE] = {
            "gold": 600,
            "fame": 4000
        };
        _local_1[PetRarityEnum.LEGENDARY] = {
            "gold": 1800,
            "fame": 15000
        };
        return (_local_1);
    }

    private static function makeFeedDictionary():Dictionary {
        var _local_1:Dictionary = new Dictionary();
        _local_1[PetRarityEnum.COMMON] = {
            "gold": 5,
            "fame": 10
        };
        _local_1[PetRarityEnum.UNCOMMON] = {
            "gold": 12,
            "fame": 30
        };
        _local_1[PetRarityEnum.RARE] = {
            "gold": 30,
            "fame": 100
        };
        _local_1[PetRarityEnum.LEGENDARY] = {
            "gold": 60,
            "fame": 350
        };
        _local_1[PetRarityEnum.DIVINE] = {
            "gold": 150,
            "fame": 1000
        };
        return (_local_1);
    }

    public static function getFuseGoldCost(_arg_1:PetRarityEnum):int {
        return (((fuseCosts[_arg_1]) ? fuseCosts[_arg_1].gold : 0));
    }

    public static function getFuseFameCost(_arg_1:PetRarityEnum):int {
        return (((fuseCosts[_arg_1]) ? fuseCosts[_arg_1].fame : 0));
    }

    public static function getFeedGoldCost(_arg_1:PetRarityEnum):int {
        return (feedCosts[_arg_1].gold);
    }

    public static function getFeedFameCost(_arg_1:PetRarityEnum):int {
        return (feedCosts[_arg_1].fame);
    }


}
}//package kabam.rotmg.pets.util
