package com.company.assembleegameclient.util {
import com.company.util.AssetLibrary;

import flash.display.BitmapData;

import kabam.rotmg.text.model.TextKey;

public class GuildUtil {

    public static const INITIATE:int = 0;
    public static const MEMBER:int = 10;
    public static const OFFICER:int = 20;
    public static const LEADER:int = 30;
    public static const FOUNDER:int = 40;
    public static const MAX_MEMBERS:int = 50;


    public static function rankToString(_arg_1:int):String {
        switch (_arg_1) {
            case INITIATE:
                return (wrapInBraces(TextKey.GUILD_RANK_INITIATE));
            case MEMBER:
                return (wrapInBraces(TextKey.GUILD_RANK_MEMBER));
            case OFFICER:
                return (wrapInBraces(TextKey.GUILD_RANK_OFFICER));
            case LEADER:
                return (wrapInBraces(TextKey.GUILD_RANK_LEADER));
            case FOUNDER:
                return (wrapInBraces(TextKey.GUILD_RANK_FOUNDER));
        }
        return (wrapInBraces(TextKey.GUILD_RANK_UNKNOWN));
    }

    private static function wrapInBraces(_arg_1:String):String {
        return ((("{" + _arg_1) + "}"));
    }

    public static function rankToIcon(_arg_1:int, _arg_2:int):BitmapData {
        var _local_3:BitmapData;
        switch (_arg_1) {
            case INITIATE:
                _local_3 = AssetLibrary.getImageFromSet("lofiInterfaceBig", 20);
                break;
            case MEMBER:
                _local_3 = AssetLibrary.getImageFromSet("lofiInterfaceBig", 19);
                break;
            case OFFICER:
                _local_3 = AssetLibrary.getImageFromSet("lofiInterfaceBig", 18);
                break;
            case LEADER:
                _local_3 = AssetLibrary.getImageFromSet("lofiInterfaceBig", 17);
                break;
            case FOUNDER:
                _local_3 = AssetLibrary.getImageFromSet("lofiInterfaceBig", 16);
                break;
        }
        return (TextureRedrawer.redraw(_local_3, _arg_2, true, 0, true));
    }

    public static function guildFameIcon(_arg_1:int):BitmapData {
        var _local_2:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 226);
        return (TextureRedrawer.redraw(_local_2, _arg_1, true, 0, true));
    }

    public static function allowedChange(_arg_1:int, _arg_2:int, _arg_3:int):Boolean {
        if (_arg_2 == _arg_3) {
            return (false);
        }
        if ((((((_arg_1 == FOUNDER)) && ((_arg_2 < FOUNDER)))) && ((_arg_3 < FOUNDER)))) {
            return (true);
        }
        if ((((((_arg_1 == LEADER)) && ((_arg_2 < LEADER)))) && ((_arg_3 <= LEADER)))) {
            return (true);
        }
        if ((((((_arg_1 == OFFICER)) && ((_arg_2 < OFFICER)))) && ((_arg_3 < OFFICER)))) {
            return (true);
        }
        return (false);
    }

    public static function promotedRank(_arg_1:int):int {
        switch (_arg_1) {
            case INITIATE:
                return (MEMBER);
            case MEMBER:
                return (OFFICER);
            case OFFICER:
                return (LEADER);
        }
        return (FOUNDER);
    }

    public static function canPromote(_arg_1:int, _arg_2:int):Boolean {
        var _local_3:int = promotedRank(_arg_2);
        return (allowedChange(_arg_1, _arg_2, _local_3));
    }

    public static function demotedRank(_arg_1:int):int {
        switch (_arg_1) {
            case OFFICER:
                return (MEMBER);
            case LEADER:
                return (OFFICER);
            case FOUNDER:
                return (LEADER);
        }
        return (INITIATE);
    }

    public static function canDemote(_arg_1:int, _arg_2:int):Boolean {
        var _local_3:int = demotedRank(_arg_2);
        return (allowedChange(_arg_1, _arg_2, _local_3));
    }

    public static function canRemove(_arg_1:int, _arg_2:int):Boolean {
        return ((((_arg_1 >= OFFICER)) && ((_arg_2 < _arg_1))));
    }


}
}//package com.company.assembleegameclient.util
