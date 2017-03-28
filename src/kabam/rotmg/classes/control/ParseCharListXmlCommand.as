package kabam.rotmg.classes.control {
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.CharacterSkinState;
import kabam.rotmg.classes.model.ClassesModel;

import robotlegs.bender.framework.api.ILogger;

public class ParseCharListXmlCommand {

    [Inject]
    public var data:XML;
    [Inject]
    public var model:ClassesModel;
    [Inject]
    public var logger:ILogger;


    public function execute():void {
        this.parseMaxLevelsAchieved();
        this.parseItemCosts();
        this.parseOwnership();
    }

    private function parseMaxLevelsAchieved():void {
        var _local_2:XML;
        var _local_3:CharacterClass;
        var _local_1:XMLList = this.data.MaxClassLevelList.MaxClassLevel;
        for each (_local_2 in _local_1) {
            _local_3 = this.model.getCharacterClass(_local_2.@classType);
            _local_3.setMaxLevelAchieved(_local_2.@maxLevel);
        }
    }

    private function parseItemCosts():void {
        var _local_2:XML;
        var _local_3:CharacterSkin;
        var _local_1:XMLList = this.data.ItemCosts.ItemCost;
        for each (_local_2 in _local_1) {
            _local_3 = this.model.getCharacterSkin(_local_2.@type);
            if (_local_3) {
                _local_3.cost = int(_local_2);
                _local_3.limited = Boolean(int(_local_2.@expires));
                if (!Boolean(int(_local_2.@purchasable))) {
                    _local_3.setState(CharacterSkinState.UNLISTED);
                }
            }
            else {
                this.logger.warn("Cannot set Character Skin cost: type {0} not found", [_local_2.@type]);
            }
        }
    }

    private function parseOwnership():void {
        var _local_2:int;
        var _local_3:CharacterSkin;
        var _local_1:Array = ((this.data.OwnedSkins.length()) ? this.data.OwnedSkins.split(",") : []);
        for each (_local_2 in _local_1) {
            _local_3 = this.model.getCharacterSkin(_local_2);
            if (_local_3) {
                _local_3.setState(CharacterSkinState.OWNED);
            }
            else {
                this.logger.warn("Cannot set Character Skin ownership: type {0} not found", [_local_2]);
            }
        }
    }


}
}//package kabam.rotmg.classes.control
