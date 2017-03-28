package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.map.RegionLibrary;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;
import flash.utils.Dictionary;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;

public class GroupDivider {

    public static const GROUP_LABELS:Vector.<String> = new <String>["Ground", "Basic Objects", "Enemies", "Walls", "3D Objects", "All Objects", "Regions", "Dungeons"];
    public static var GROUPS:Dictionary = new Dictionary(true);
    public static var DEFAULT_DUNGEON:String = "AbyssOfDemons";
    public static var HIDE_OBJECTS_IDS:Vector.<String> = new <String>["Gothic Wiondow Light", "Statue of Oryx Base", "AbyssExitGuarder", "AbyssIdolDead", "AbyssTreasureLavaBomb", "Area 1 Controller", "Area 2 Controller", "Area 3 Controller", "Area 4 Controller", "Area 5 Controller", "Arena Horseman Anchor", "FireMakerUp", "FireMakerLf", "FireMakerRt", "FireMakerDn", "Group Wall Observer", "LavaTrigger", "Mad Gas Controller", "Mad Lab Open Wall", "Maggot Sack", "NM Black Open Wall", "NM Blue Open Wall", "NM Green Open Wall", "NM Red Open Wall", "NM Green Dragon Shield Counter", "NM Green Dragon Shield Counter Deux", "NM Red Dragon Lava Bomb", "NM Red Dragon Lava Trigger", "Pirate King Healer", "Puppet Theatre Boss Spawn", "Puppet Treasure Chest", "Skuld Apparition", "Sorc Bomb Thrower", "Tempest Cloud", "Treasure Dropper", "Treasure Flame Trap 1.7 Sec", "Treasure Flame Trap 1.2 Sec", "Zombie Rise", "destnex Observer 1", "destnex Observer 2", "destnex Observer 3", "destnex Observer 4", "drac floor black", "drac floor blue", "drac floor green", "drac floor red", "drac wall black", "drac wall blue", "drac wall red", "drac wall green", "ic boss manager", "ic boss purifier generator", "ic boss spawner live", "md1 Governor", "md1 Lava Makers", "md1 Left Burst", "md1 Right Burst", "md1 Mid Burst", "md1 Left Hand spawner", "md1 Right Hand spawner", "md1 RightHandSmash", "md1 LeftHandSmash", "shtrs Add Lava", "shtrs Bird Check", "shtrs BirdSpawn 1", "shtrs BirdSpawn 2", "shtrs Bridge Closer", "shtrs Mage Closer 1", "shtrs Monster Cluster", "shtrs Mage Bridge Check", "shtrs Bridge Review Board", "shtrs Crystal Check", "shtrs Final Fight Check", "shtrs Final Mediator Lava", "shtrs KillWall 1", "shtrs KillWall 2", "shtrs KillWall 3", "shtrs KillWall 4", "shtrs KillWall 5", "shtrs KillWall 6", "shtrs KillWall 7", "shtrs Laser1", "shtrs Laser2", "shtrs Laser3", "shtrs Laser4", "shtrs Laser5", "shtrs Laser6", "shtrs Pause Watcher", "shtrs Player Check", "shtrs Player Check Archmage", "shtrs Spawn Bridge", "shtrs The Cursed Crown", "shtrs blobomb maker", "shtrs portal maker", "vlntns Governor", "vlntns Planter"];

    public static function divideObjects():void
    {
        var _local_9:int;
        var _local_10:String;
        var _local_11:Boolean;
        var _local_12:XML;
        var _local_13:XML;
        var _local_14:PlayerModel;
        var _local_15:String;
        var _local_16:XML;
        var _local_1:Dictionary = new Dictionary(true);
        var _local_2:Dictionary = new Dictionary(true);
        var _local_3:Dictionary = new Dictionary(true);
        var _local_4:Dictionary = new Dictionary(true);
        var _local_5:Dictionary = new Dictionary(true);
        var _local_6:Dictionary = new Dictionary(true);
        var _local_7:Dictionary = new Dictionary(true);
        var _local_8:Dictionary = new Dictionary(true);
        for each(_local_12 in ObjectLibrary.xmlLibrary_)
        {
            _local_10 = _local_12.@id;
            _local_9 = int(_local_12.@type);
            _local_14 = StaticInjectorContext.getInjector().getInstance(PlayerModel);
            if(!(_local_12.hasOwnProperty("Item") || _local_12.hasOwnProperty("Player") || _local_12.Class == "Projectile" || _local_12.Class == "PetSkin" || _local_12.Class == "Pet" || _local_10.search("Spawner") >= 0 && !_local_14.isAdmin()))
            {
                if(!(!_local_14.isAdmin() && HIDE_OBJECTS_IDS.indexOf(_local_10) >= 0))
                {
                    _local_11 = false;
                    if(_local_12.hasOwnProperty("Class") && String(_local_12.Class).match(/wall$/i))
                    {
                        _local_6[_local_9] = _local_12;
                        _local_7[_local_9] = _local_12;
                        _local_11 = true;
                    }
                    else if(_local_12.hasOwnProperty("Model"))
                    {
                        _local_5[_local_9] = _local_12;
                        _local_7[_local_9] = _local_12;
                        _local_11 = true;
                    }
                    else if(_local_12.hasOwnProperty("Enemy"))
                    {
                        _local_4[_local_9] = _local_12;
                        _local_7[_local_9] = _local_12;
                        _local_11 = true;
                    }
                    else if(_local_12.hasOwnProperty("Static") && !_local_12.hasOwnProperty("Price"))
                    {
                        _local_3[_local_9] = _local_12;
                        _local_7[_local_9] = _local_12;
                        _local_11 = true;
                    }
                    else if(_local_14.isAdmin())
                    {
                        _local_7[_local_9] = _local_12;
                    }
                    _local_15 = ObjectLibrary.propsLibrary_[_local_9].belonedDungeon;
                    if(_local_11 && _local_15 != "")
                    {
                        if(_local_8[_local_15] == null)
                        {
                            _local_8[_local_15] = new Dictionary(true);
                        }
                        _local_8[_local_15][_local_9] = _local_12;
                    }
                }
            }
        }
        for each(_local_13 in GroundLibrary.xmlLibrary_)
        {
            _local_1[int(_local_13.@type)] = _local_13;
        }
        if(_local_14.isAdmin())
        {
            for each(_local_16 in RegionLibrary.xmlLibrary_)
            {
                _local_2[int(_local_16.@type)] = _local_16;
            }
        }
        else
        {
            _local_2[RegionLibrary.idToType_["Spawn"]] = RegionLibrary.xmlLibrary_[RegionLibrary.idToType_["Spawn"]];
            _local_2[RegionLibrary.idToType_["User Dungeon End"]] = RegionLibrary.xmlLibrary_[RegionLibrary.idToType_["User Dungeon End"]];
        }
        GROUPS[GROUP_LABELS[0]] = _local_1;
        GROUPS[GROUP_LABELS[1]] = _local_3;
        GROUPS[GROUP_LABELS[2]] = _local_4;
        GROUPS[GROUP_LABELS[3]] = _local_6;
        GROUPS[GROUP_LABELS[4]] = _local_5;
        GROUPS[GROUP_LABELS[5]] = _local_7;
        GROUPS[GROUP_LABELS[6]] = _local_2;
        GROUPS[GROUP_LABELS[7]] = _local_8;
    }

    public static function getDungeonsLabel():Vector.<String>
    {
        var _local_2:*;
        var _local_1:Vector.<String> = new Vector.<String>();
        for(_local_2 in ObjectLibrary.dungeonsXMLLibrary_)
        {
            _local_1.push(_local_2);
        }
        _local_1.sort(MoreStringUtil.cmp);
        return _local_1;
    }

    public static function getDungeonsXML(_arg_1:String):Dictionary
    {
        return GROUPS[GROUP_LABELS[7]][_arg_1];
    }

    public static function getCategoryByType(_arg_1:int, _arg_2:int):String
    {
        var _local_4:XML = null;
        var _local_3:PlayerModel = StaticInjectorContext.getInjector().getInstance(PlayerModel);
        if(_arg_2 == Layer.REGION)
        {
            return GROUP_LABELS[6];
        }
        if(_arg_2 == Layer.GROUND)
        {
            return GROUP_LABELS[0];
        }
        if(_local_3.isAdmin())
        {
            return GROUP_LABELS[5];
        }
        _local_4 = ObjectLibrary.xmlLibrary_[_arg_1];
        if(_local_4.hasOwnProperty("Item") || _local_4.hasOwnProperty("Player") || _local_4.Class == "Projectile" || _local_4.Class == "PetSkin" || _local_4.Class == "Pet")
        {
            return "";
        }
        if(_local_4.hasOwnProperty("Enemy"))
        {
            return GROUP_LABELS[2];
        }
        if(_local_4.hasOwnProperty("Model"))
        {
            return GROUP_LABELS[4];
        }
        if(_local_4.hasOwnProperty("Class") && String(_local_4.Class).match(/wall$/i))
        {
            return GROUP_LABELS[3];
        }
        if(_local_4.hasOwnProperty("Static") && !_local_4.hasOwnProperty("Price"))
        {
            return GROUP_LABELS[1];
        }
        return "";
    }

}
}
