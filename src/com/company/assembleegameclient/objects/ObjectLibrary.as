package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.animation.AnimationsData;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.ConversionUtil;
import kabam.rotmg.assets.EmbeddedData;

import flash.display.BitmapData;
import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;

import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.messaging.impl.data.StatData;

public class ObjectLibrary {

    public static var textureDataFactory:TextureDataFactory = new TextureDataFactory();
    public static const IMAGE_SET_NAME:String = "lofiObj3";
    public static const IMAGE_ID:int = 0xFF;
    public static var playerChars_:Vector.<XML> = new Vector.<XML>();
    public static var hexTransforms_:Vector.<XML> = new Vector.<XML>();
    public static var playerClassAbbr_:Dictionary = new Dictionary();
    public static const propsLibrary_:Dictionary = new Dictionary();
    public static const xmlLibrary_:Dictionary = new Dictionary();
	public static const setLibrary_:Dictionary = new Dictionary();
    public static const idToType_:Dictionary = new Dictionary();
    public static const itemLib:Vector.<String> = new <String>[];
    public static const typeToDisplayId_:Dictionary = new Dictionary();
    public static const typeToTextureData_:Dictionary = new Dictionary();
    public static const typeToTopTextureData_:Dictionary = new Dictionary();
    public static const typeToAnimationsData_:Dictionary = new Dictionary();
    public static const petXMLDataLibrary_:Dictionary = new Dictionary();
    public static const skinSetXMLDataLibrary_:Dictionary = new Dictionary();
    public static const dungeonsXMLLibrary_:Dictionary = new Dictionary(true);
    public static const ENEMY_FILTER_LIST:Vector.<String> = new <String>["None", "Hp", "Defense"];
    public static const TILE_FILTER_LIST:Vector.<String> = new <String>["ALL", "Walkable", "Unwalkable", "Slow", "Speed=1"];
    public static const defaultProps_:ObjectProperties = new ObjectProperties(null);
    public static const TYPE_MAP:Object = {
        "ArenaGuard": ArenaGuard, 
        "ArenaPortal": ArenaPortal, 
        "CaveWall": CaveWall, 
        "Character": Character, 
        "CharacterChanger": CharacterChanger, 
        "ClosedGiftChest": ClosedGiftChest, 
        "ClosedVaultChest": ClosedVaultChest, 
        "ConnectedWall": ConnectedWall, 
        "Container": Container, 
        "DoubleWall": DoubleWall, 
        "FortuneGround": FortuneGround, 
        "FortuneTeller": FortuneTeller, 
        "GameObject": GameObject, 
        "GuildBoard": GuildBoard, 
        "GuildChronicle": GuildChronicle, 
        "GuildHallPortal": GuildHallPortal, 
        "GuildMerchant": GuildMerchant, 
        "GuildRegister": GuildRegister, 
        "Merchant": Merchant, 
        "MoneyChanger": MoneyChanger, 
        "MysteryBoxGround": MysteryBoxGround, 
        "NameChanger": NameChanger, 
        "ReskinVendor": ReskinVendor, 
        "OneWayContainer": OneWayContainer, 
        "Player": Player, 
        "Portal": Portal, 
        "Projectile": Projectile, 
        "QuestRewards": QuestRewards, 
        "DailyLoginRewards":DailyLoginRewards,
        "Sign": Sign, 
        "SpiderWeb": SpiderWeb, 
        "Stalagmite": Stalagmite, 
        "Wall": Wall, 
        "Pet": Pet, 
        "PetUpgrader": PetUpgrader, 
        "YardUpgrader": YardUpgrader
    };
    private static var currentDungeon:String = "";


    public static function parseDungeonXML(_arg_1:String, _arg_2:XML):void
    {
        var _local_3:int = _arg_1.indexOf("_") + 1;
        var _local_4:int = _arg_1.indexOf("CXML");
        currentDungeon = _arg_1.substr(_local_3, _local_4 - _local_3);
        dungeonsXMLLibrary_[currentDungeon] = new Dictionary(true);
        parseFromXML(_arg_2, parseDungeonCallbak);
		/*if () {
			
		}*/
    }

    private static function parseDungeonCallbak(_arg_1:int, _arg_2:XML):void
    {
        if(currentDungeon != "" && dungeonsXMLLibrary_[currentDungeon] != null)
        {
            dungeonsXMLLibrary_[currentDungeon][_arg_1] = _arg_2;
            propsLibrary_[_arg_1].belonedDungeon = currentDungeon;
        }
    }

    public static function parseFromXML(_arg_1:XML, _arg_2:Function = null):void
    {
        var _local_3:XML;
        var _local_4:String;
        var _local_5:String;
        var _local_6:int;
        var _local_7:Boolean = false;
        var _local_8:int;
        for each(_local_3 in _arg_1.Object)
        {
            _local_4 = String(_local_3.@id);
            _local_5 = _local_4;
            if(_local_3.hasOwnProperty("DisplayId"))
            {
                _local_5 = _local_3.DisplayId;
            }
            if(_local_3.hasOwnProperty("Group"))
            {
                if(_local_3.Group == "Hexable")
                {
                    hexTransforms_.push(_local_3);
                }
            }
            _local_6 = int(_local_3.@type);
            if (_local_3.hasOwnProperty("SlotType"))
            {
				itemLib.push(_local_4);
            }
            if(_local_3.hasOwnProperty("PetBehavior") || _local_3.hasOwnProperty("PetAbility"))
            {
                petXMLDataLibrary_[_local_6] = _local_3;
            }
            else
            {
                propsLibrary_[_local_6] = new ObjectProperties(_local_3);
                xmlLibrary_[_local_6] = _local_3;
                idToType_[_local_4] = _local_6;
                typeToDisplayId_[_local_6] = _local_5;
                if(_arg_2 != null)
                {
                    _arg_2(_local_6, _local_3);
                }
                if(String(_local_3.Class) == "Player")
                {
                    playerClassAbbr_[_local_6] = String(_local_3.@id).substr(0, 2);
                    _local_7 = false;
                    _local_8 = 0;
                    while(_local_8 < playerChars_.length)
                    {
                        if(int(playerChars_[_local_8].@type) == _local_6)
                        {
                            playerChars_[_local_8] = _local_3;
                            _local_7 = true;
                        }
                        _local_8++;
                    }
                    if(!_local_7)
                    {
                        playerChars_.push(_local_3);
                    }
                }
                typeToTextureData_[_local_6] = textureDataFactory.create(_local_3);
                if(_local_3.hasOwnProperty("Top"))
                {
                    typeToTopTextureData_[_local_6] = textureDataFactory.create(XML(_local_3.Top));
                }
                if(_local_3.hasOwnProperty("Animation"))
                {
                    typeToAnimationsData_[_local_6] = new AnimationsData(_local_3);
                }
            }
        }
    }

    public static function getIdFromType(_arg_1:int):String {
        var _local_2:XML = xmlLibrary_[_arg_1];
        if (_local_2 == null) {
            return (null);
        }
        return (String(_local_2.@id));
    }
      
	public static function getSetXMLFromType(param1:int):XML {
		var _loc2_:XML = null;
		var _loc3_:int = 0;
		if (setLibrary_[param1] != undefined) {
			return setLibrary_[param1];
		}
		for each(_loc2_ in EmbeddedData.skinsEquipmentSetsXML.EquipmentSet) {
			_loc3_ = int(_loc2_.@type);
			setLibrary_[_loc3_] = _loc2_;
		}
		return setLibrary_[param1];
	}

    public static function getPropsFromId(_arg_1:String):ObjectProperties {
        var _local_2:int = idToType_[_arg_1];
        return (propsLibrary_[_local_2]);
    }

    public static function getXMLfromId(_arg_1:String):XML {
        var _local_2:int = idToType_[_arg_1];
        return (xmlLibrary_[_local_2]);
    }

    public static function getObjectFromType(_arg_1:int):GameObject {
        var _local_2:XML = xmlLibrary_[_arg_1];
		if (_local_2 == null) { //added to prevent crashing on new items
			return null;
		}
        var _local_3:String = _local_2.Class;
        var _local_4:Class = ((TYPE_MAP[_local_3]) || (makeClass(_local_3)));
        return (new (_local_4)(_local_2));
    }

    private static function makeClass(_arg_1:String):Class {
        var _local_2:String = ("com.company.assembleegameclient.objects." + _arg_1);
        return ((getDefinitionByName(_local_2) as Class));
    }

    public static function getTextureFromType(_arg_1:int):BitmapData {
        var _local_2:TextureData = typeToTextureData_[_arg_1];
        if (_local_2 == null) {
            return (null);
        }
        return (_local_2.getTexture());
    }

    public static function getBitmapData(_arg_1:int):BitmapData {
        var _local_2:TextureData = typeToTextureData_[_arg_1];
        var _local_3:BitmapData = ((_local_2) ? _local_2.getTexture() : null);
        if (_local_3) {
            return (_local_3);
        }
        return (AssetLibrary.getImageFromSet(IMAGE_SET_NAME, IMAGE_ID));
    }

    public static function getRedrawnTextureFromType(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean = true, _arg_5:Number = 5):BitmapData {
        var _local_6:BitmapData = getBitmapData(_arg_1);
        if (Parameters.itemTypes16.indexOf(_arg_1) != -1) {
            _arg_2 = (_arg_2 * 0.5);
        }
        var _local_7:TextureData = typeToTextureData_[_arg_1];
        var _local_8:BitmapData = ((_local_7) ? _local_7.mask_ : null);
        if (_local_8 == null) {
            return (TextureRedrawer.redraw(_local_6, _arg_2, _arg_3, 0, _arg_4, _arg_5));
        }
        var _local_9:XML = xmlLibrary_[_arg_1];
        var _local_10:int = ((_local_9.hasOwnProperty("Tex1")) ? int(_local_9.Tex1) : 0);
        var _local_11:int = ((_local_9.hasOwnProperty("Tex2")) ? int(_local_9.Tex2) : 0);
        _local_6 = TextureRedrawer.resize(_local_6, _local_8, _arg_2, _arg_3, _local_10, _local_11, _arg_5);
        _local_6 = GlowRedrawer.outlineGlow(_local_6, 0);
        return (_local_6);
    }

    public static function getSizeFromType(_arg_1:int):int {
        var _local_2:XML = xmlLibrary_[_arg_1];
        if (!_local_2.hasOwnProperty("Size")) {
            return (100);
        }
        return (int(_local_2.Size));
    }

    public static function getSlotTypeFromType(_arg_1:int):int {
        var _local_2:XML = xmlLibrary_[_arg_1];
        if (!_local_2.hasOwnProperty("SlotType")) {
            return (-1);
        }
        return (int(_local_2.SlotType));
    }

    public static function isEquippableByPlayer(_arg_1:int, _arg_2:Player):Boolean {
        if (_arg_1 == ItemConstants.NO_ITEM) {
            return (false);
        }
        var _local_3:XML = xmlLibrary_[_arg_1];
        var _local_4:int = int(_local_3.SlotType.toString());
        var _local_5:uint;
        while (_local_5 < GeneralConstants.NUM_EQUIPMENT_SLOTS) {
            if (_arg_2.slotTypes_[_local_5] == _local_4) {
                return (true);
            }
            _local_5++;
        }
        return (false);
    }

    public static function getMatchingSlotIndex(_arg_1:int, _arg_2:Player):int {
        var _local_3:XML;
        var _local_4:int;
        var _local_5:uint;
        if (_arg_1 != ItemConstants.NO_ITEM) {
            _local_3 = xmlLibrary_[_arg_1];
            _local_4 = int(_local_3.SlotType);
            _local_5 = 0;
            while (_local_5 < GeneralConstants.NUM_EQUIPMENT_SLOTS) {
                if (_arg_2.slotTypes_[_local_5] == _local_4) {
                    return (_local_5);
                }
                _local_5++;
            }
        }
        return (-1);
    }

    public static function isUsableByPlayer(_arg_1:int, _arg_2:Player):Boolean {
        if (_arg_2 == null || _arg_2.slotTypes_ == null) {
            return (true);
        }
        var _local_3:XML = xmlLibrary_[_arg_1];
        if ((((_local_3 == null)) || (!(_local_3.hasOwnProperty("SlotType"))))) {
            return (false);
        }
        var _local_4:int = _local_3.SlotType;
        if ((((_local_4 == ItemConstants.POTION_TYPE)) || ((_local_4 == ItemConstants.EGG_TYPE)))) {
            return (true);
        }
        var _local_5:int;
        while (_local_5 < _arg_2.slotTypes_.length) {
            if (_arg_2.slotTypes_[_local_5] == _local_4) {
                return (true);
            }
            _local_5++;
        }
        return (false);
    }

    public static function isSoulbound(_arg_1:int):Boolean {
        var _local_2:XML = xmlLibrary_[_arg_1];
        return (((!((_local_2 == null))) && (_local_2.hasOwnProperty("Soulbound"))));
    }

    public static function usableBy(_arg_1:int):Vector.<String> {
        var _local_5:XML;
        var _local_6:Vector.<int>;
        var _local_7:int;
        var _local_2:XML = xmlLibrary_[_arg_1];
        if ((((_local_2 == null)) || (!(_local_2.hasOwnProperty("SlotType"))))) {
            return (null);
        }
        var _local_3:int = _local_2.SlotType;
        if ((((((_local_3 == ItemConstants.POTION_TYPE)) || ((_local_3 == ItemConstants.RING_TYPE)))) || ((_local_3 == ItemConstants.EGG_TYPE)))) {
            return (null);
        }
        var _local_4:Vector.<String> = new Vector.<String>();
        for each (_local_5 in playerChars_) {
            _local_6 = ConversionUtil.toIntVector(_local_5.SlotTypes);
            _local_7 = 0;
            while (_local_7 < _local_6.length) {
                if (_local_6[_local_7] == _local_3) {
                    _local_4.push(typeToDisplayId_[int(_local_5.@type)]);
                    break;
                }
                _local_7++;
            }
        }
        return (_local_4);
    }

    public static function playerMeetsRequirements(_arg_1:int, _arg_2:Player):Boolean {
        var _local_4:XML;
        if (_arg_2 == null) {
            return (true);
        }
        var _local_3:XML = xmlLibrary_[_arg_1];
        for each (_local_4 in _local_3.EquipRequirement) {
            if (!playerMeetsRequirement(_local_4, _arg_2)) {
                return (false);
            }
        }
        return (true);
    }

    public static function playerMeetsRequirement(_arg_1:XML, _arg_2:Player):Boolean {
        var _local_3:int;
        if (_arg_1.toString() == "Stat") {
            _local_3 = int(_arg_1.@value);
            switch (int(_arg_1.@stat)) {
                case StatData.MAX_HP_STAT:
                    return ((_arg_2.maxHP_ >= _local_3));
                case StatData.MAX_MP_STAT:
                    return ((_arg_2.maxMP_ >= _local_3));
                case StatData.LEVEL_STAT:
                    return ((_arg_2.level_ >= _local_3));
                case StatData.ATTACK_STAT:
                    return ((_arg_2.attack_ >= _local_3));
                case StatData.DEFENSE_STAT:
                    return ((_arg_2.defense_ >= _local_3));
                case StatData.SPEED_STAT:
                    return ((_arg_2.speed_ >= _local_3));
                case StatData.VITALITY_STAT:
                    return ((_arg_2.vitality_ >= _local_3));
                case StatData.WISDOM_STAT:
                    return ((_arg_2.wisdom_ >= _local_3));
                case StatData.DEXTERITY_STAT:
                    return ((_arg_2.dexterity_ >= _local_3));
            }
        }
        return (false);
    }

    public static function getPetDataXMLByType(_arg_1:int):XML {
        return (petXMLDataLibrary_[_arg_1]);
    }


}
}//package com.company.assembleegameclient.objects
