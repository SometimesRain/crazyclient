package kabam.rotmg.pets.data {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;

import flash.display.Bitmap;
import flash.display.BitmapData;

import org.osflash.signals.Signal;

public class PetVO {

    public const updated:Signal = new Signal();

    private var staticData:XML;
    private var id:int;
    private var type:int;
    private var rarity:String;
    private var name:String;
    private var maxAbilityPower:int;
    public var abilityList:Array;
    private var skinID:int;
    private var skin:AnimatedChar;

    public function PetVO(_arg_1:int = undefined) {
        this.abilityList = [new AbilityVO(), new AbilityVO(), new AbilityVO()];
        super();
        this.id = _arg_1;
        this.staticData = <data/>
        ;
        this.listenToAbilities();
    }

    private static function getPetDataDescription(_arg_1:int):String {
        return (ObjectLibrary.getPetDataXMLByType(_arg_1).Description);
    }

    private static function getPetDataDisplayId(_arg_1:int):String {
		return ObjectLibrary.getPetDataXMLByType(_arg_1).@id;
    }

    public static function clone(_arg_1:PetVO):PetVO {
        return (new PetVO(_arg_1.id));
    }


    private function listenToAbilities():void {
        var _local_1:AbilityVO;
        for each (_local_1 in this.abilityList) {
            _local_1.updated.add(this.onAbilityUpdate);
        }
    }

    public function maxedAllAbilities():Boolean {
        var _local_2:AbilityVO;
        var _local_1:int;
        for each (_local_2 in this.abilityList) {
            if (_local_2.level == 100) {
                _local_1++;
            }
        }
        return ((_local_1 == this.abilityList.length));
    }

    private function onAbilityUpdate(_arg_1:AbilityVO):void {
        this.updated.dispatch();
    }

    public function apply(_arg_1:XML):void {
        this.extractBasicData(_arg_1);
        this.extractAbilityData(_arg_1);
    }

    private function extractBasicData(_arg_1:XML):void {
        ((_arg_1.@instanceId) && (this.setID(_arg_1.@instanceId)));
        ((_arg_1.@type) && (this.setType(_arg_1.@type)));
        ((_arg_1.@name) && (this.setName(_arg_1.@name)));
        ((_arg_1.@skin) && (this.setSkin(_arg_1.@skin)));
        ((_arg_1.@rarity) && (this.setRarity(_arg_1.@rarity)));
    }

    public function extractAbilityData(_arg_1:XML):void {
        var _local_2:uint;
        var _local_4:AbilityVO;
        var _local_5:int;
        var _local_3:uint = this.abilityList.length;
        _local_2 = 0;
        while (_local_2 < _local_3) {
            _local_4 = this.abilityList[_local_2];
            _local_5 = int(_arg_1.Abilities.Ability[_local_2].@type);
            _local_4.name = getPetDataDisplayId(_local_5);
            _local_4.description = getPetDataDescription(_local_5);
            _local_4.level = _arg_1.Abilities.Ability[_local_2].@power;
            _local_4.points = _arg_1.Abilities.Ability[_local_2].@points;
            _local_2++;
        }
    }

    public function getFamily():String {
        return (this.staticData.Family);
    }

    public function setID(_arg_1:int):void {
        this.id = _arg_1;
    }

    public function getID():int {
        return (this.id);
    }

    public function setType(_arg_1:int):void {
        this.type = _arg_1;
        this.staticData = ObjectLibrary.xmlLibrary_[this.type];
    }

    public function getType():int {
        return (this.type);
    }

    public function setRarity(_arg_1:uint):void {
        this.rarity = PetRarityEnum.selectByOrdinal(_arg_1).value;
        this.unlockAbilitiesBasedOnPetRarity(_arg_1);
        this.updated.dispatch();
    }

    private function unlockAbilitiesBasedOnPetRarity(_arg_1:uint):void {
        this.abilityList[0].setUnlocked(true);
        this.abilityList[1].setUnlocked((_arg_1 >= PetRarityEnum.UNCOMMON.ordinal));
        this.abilityList[2].setUnlocked((_arg_1 >= PetRarityEnum.LEGENDARY.ordinal));
    }

    public function getRarity():String {
        return (this.rarity);
    }

    public function setName(_arg_1:String):void {
		this.name = ObjectLibrary.typeToDisplayId_[this.skinID];
		if (this.name == null || this.name == "") {
			this.name = ObjectLibrary.typeToDisplayId_[this.getType()];
		}
        this.updated.dispatch();
    }

    public function getName():String {
        return (this.name);
    }

    public function setMaxAbilityPower(_arg_1:int):void {
        this.maxAbilityPower = _arg_1;
        this.updated.dispatch();
    }

    public function getMaxAbilityPower():int {
        return (this.maxAbilityPower);
    }

    public function setSkin(_arg_1:int):void {
        this.skinID = _arg_1;
        this.updated.dispatch();
    }

    public function getSkinID():int {
        return (this.skinID);
    }

    public function getSkin(scale:Number = 1.0):Bitmap {
        this.makeSkin();
        var _local_1:MaskedImage = this.skin.imageFromAngle(0, AnimatedChar.STAND, 0);
        var _local_2:int = (((this.rarity == PetRarityEnum.DIVINE.value)) ? 40 : 80) * scale;
        var _local_3:BitmapData = TextureRedrawer.resize(_local_1.image_, _local_1.mask_, _local_2, true, 0, 0);
        _local_3 = GlowRedrawer.outlineGlow(_local_3, 0);
        return (new Bitmap(_local_3));
    }

    public function getSkinMaskedImage():MaskedImage {
        this.makeSkin();
        return (((this.skin) ? this.skin.imageFromAngle(0, AnimatedChar.STAND, 0) : null));
    }

    private function makeSkin():void {
        var _local_1:XML = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(this.skinID));
        var _local_2:String = _local_1.AnimatedTexture.File;
        var _local_3:int = _local_1.AnimatedTexture.Index;
        this.skin = AnimatedChars.getAnimatedChar(_local_2, _local_3);
    }


}
}//package kabam.rotmg.pets.data
