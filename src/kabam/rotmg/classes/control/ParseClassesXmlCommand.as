package kabam.rotmg.classes.control {
import kabam.rotmg.assets.model.CharacterTemplate;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterClassStat;
import kabam.rotmg.classes.model.CharacterClassUnlock;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.CharacterSkinState;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.text.model.TextKey;

public class ParseClassesXmlCommand {

    [Inject]
    public var data:XML;
    [Inject]
    public var classes:ClassesModel;


    public function execute():void {
        var _local_2:XML;
        var _local_1:XMLList = this.data.Object;
        for each (_local_2 in _local_1) {
            this.parseCharacterClass(_local_2);
        }
    }

    private function parseCharacterClass(_arg_1:XML):void {
        var _local_2:int = int(_arg_1.@type);
        var _local_3:CharacterClass = this.classes.getCharacterClass(_local_2);
        this.populateCharacter(_local_3, _arg_1);
    }

    private function populateCharacter(_arg_1:CharacterClass, _arg_2:XML):void {
        var _local_3:XML;
        _arg_1.id = _arg_2.@type;
        _arg_1.name = _arg_2.DisplayId == undefined ? _arg_2.@id : _arg_2.DisplayId;
        _arg_1.description = _arg_2.Description;
        _arg_1.hitSound = _arg_2.HitSound;
        _arg_1.deathSound = _arg_2.DeathSound;
        _arg_1.bloodProb = _arg_2.BloodProb;
        _arg_1.slotTypes = this.parseIntList(_arg_2.SlotTypes);
        _arg_1.defaultEquipment = this.parseIntList(_arg_2.Equipment);
        _arg_1.hp = this.parseCharacterStat(_arg_2, "MaxHitPoints");
        _arg_1.mp = this.parseCharacterStat(_arg_2, "MaxMagicPoints");
        _arg_1.attack = this.parseCharacterStat(_arg_2, "Attack");
        _arg_1.defense = this.parseCharacterStat(_arg_2, "Defense");
        _arg_1.speed = this.parseCharacterStat(_arg_2, "Speed");
        _arg_1.dexterity = this.parseCharacterStat(_arg_2, "Dexterity");
        _arg_1.hpRegeneration = this.parseCharacterStat(_arg_2, "HpRegen");
        _arg_1.mpRegeneration = this.parseCharacterStat(_arg_2, "MpRegen");
        _arg_1.unlockCost = _arg_2.UnlockCost;
        for each (_local_3 in _arg_2.UnlockLevel) {
            _arg_1.unlocks.push(this.parseUnlock(_local_3));
        }
        _arg_1.skins.addSkin(this.makeDefaultSkin(_arg_2), true);
    }

    private function makeDefaultSkin(_arg_1:XML):CharacterSkin {
        var _local_2:String = _arg_1.AnimatedTexture.File;
        var _local_3:int = _arg_1.AnimatedTexture.Index;
        var _local_4:CharacterSkin = new CharacterSkin();
        _local_4.id = 0;
        _local_4.name = TextKey.CLASSIC_SKIN;
        _local_4.template = new CharacterTemplate(_local_2, _local_3);
        _local_4.setState(CharacterSkinState.OWNED);
        _local_4.setIsSelected(true);
        return (_local_4);
    }

    private function parseUnlock(_arg_1:XML):CharacterClassUnlock {
        var _local_2:CharacterClassUnlock = new CharacterClassUnlock();
        _local_2.level = _arg_1.@level;
        _local_2.character = this.classes.getCharacterClass(_arg_1.@type);
        return (_local_2);
    }

    private function parseCharacterStat(_arg_1:XML, _arg_2:String):CharacterClassStat {
        var _local_4:XML;
        var _local_5:XML;
        var _local_6:CharacterClassStat;
        var _local_3:XML = _arg_1[_arg_2][0];
        for each (_local_5 in _arg_1.LevelIncrease) {
            if (_local_5.text() == _arg_2) {
                _local_4 = _local_5;
            }
        }
        _local_6 = new CharacterClassStat();
        _local_6.initial = int(_local_3.toString());
        _local_6.max = _local_3.@max;
        _local_6.rampMin = ((_local_4) ? int(_local_4.@min) : 0);
        _local_6.rampMax = ((_local_4) ? int(_local_4.@max) : 0);
        return (_local_6);
    }

    private function parseIntList(_arg_1:String):Vector.<int> {
        var _local_2:Array = _arg_1.split(",");
        var _local_3:int = _local_2.length;
        var _local_4:Vector.<int> = new Vector.<int>(_local_3, true);
        var _local_5:int;
        while (_local_5 < _local_3) {
            _local_4[_local_5] = int(_local_2[_local_5]);
            _local_5++;
        }
        return (_local_4);
    }


}
}//package kabam.rotmg.classes.control
