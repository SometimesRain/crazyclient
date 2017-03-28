package com.company.assembleegameclient.util {
import flash.system.Capabilities;

public class GUID {

    private static var counter:Number = 0;


    public static function create():String {
        var _local_1:Date = new Date();
        var _local_2:Number = _local_1.getTime();
        var _local_3:Number = (Math.random() * Number.MAX_VALUE);
        var _local_4:String = Capabilities.serverString;
        return (calculate((((_local_2 + _local_4) + _local_3) + counter++)).toUpperCase());
    }

    private static function calculate(_arg_1:String):String {
        return (hex_sha1(_arg_1));
    }

    private static function hex_sha1(_arg_1:String):String {
        return (binb2hex(core_sha1(str2binb(_arg_1), (_arg_1.length * 8))));
    }

    private static function core_sha1(_arg_1:Array, _arg_2:Number):Array {
        var _local_10:Number;
        var _local_11:Number;
        var _local_12:Number;
        var _local_13:Number;
        var _local_14:Number;
        var _local_15:Number;
        var _local_16:Number;
        _arg_1[(_arg_2 >> 5)] = (_arg_1[(_arg_2 >> 5)] | (128 << (24 - (_arg_2 % 32))));
        _arg_1[((((_arg_2 + 64) >> 9) << 4) + 15)] = _arg_2;
        var _local_3:Array = new Array(80);
        var _local_4:Number = 1732584193;
        var _local_5:Number = -271733879;
        var _local_6:Number = -1732584194;
        var _local_7:Number = 271733878;
        var _local_8:Number = -1009589776;
        var _local_9:Number = 0;
        while (_local_9 < _arg_1.length) {
            _local_10 = _local_4;
            _local_11 = _local_5;
            _local_12 = _local_6;
            _local_13 = _local_7;
            _local_14 = _local_8;
            _local_15 = 0;
            while (_local_15 < 80) {
                if (_local_15 < 16) {
                    _local_3[_local_15] = _arg_1[(_local_9 + _local_15)];
                }
                else {
                    _local_3[_local_15] = rol((((_local_3[(_local_15 - 3)] ^ _local_3[(_local_15 - 8)]) ^ _local_3[(_local_15 - 14)]) ^ _local_3[(_local_15 - 16)]), 1);
                }
                _local_16 = safe_add(safe_add(rol(_local_4, 5), sha1_ft(_local_15, _local_5, _local_6, _local_7)), safe_add(safe_add(_local_8, _local_3[_local_15]), sha1_kt(_local_15)));
                _local_8 = _local_7;
                _local_7 = _local_6;
                _local_6 = rol(_local_5, 30);
                _local_5 = _local_4;
                _local_4 = _local_16;
                _local_15++;
            }
            _local_4 = safe_add(_local_4, _local_10);
            _local_5 = safe_add(_local_5, _local_11);
            _local_6 = safe_add(_local_6, _local_12);
            _local_7 = safe_add(_local_7, _local_13);
            _local_8 = safe_add(_local_8, _local_14);
            _local_9 = (_local_9 + 16);
        }
        return ([_local_4, _local_5, _local_6, _local_7, _local_8]);
    }

    private static function sha1_ft(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Number {
        if (_arg_1 < 20) {
            return (((_arg_2 & _arg_3) | (~(_arg_2) & _arg_4)));
        }
        if (_arg_1 < 40) {
            return (((_arg_2 ^ _arg_3) ^ _arg_4));
        }
        if (_arg_1 < 60) {
            return ((((_arg_2 & _arg_3) | (_arg_2 & _arg_4)) | (_arg_3 & _arg_4)));
        }
        return (((_arg_2 ^ _arg_3) ^ _arg_4));
    }

    private static function sha1_kt(_arg_1:Number):Number {
        return ((((_arg_1) < 20) ? 1518500249 : (((_arg_1) < 40) ? 1859775393 : (((_arg_1) < 60) ? -1894007588 : -899497514))));
    }

    private static function safe_add(_arg_1:Number, _arg_2:Number):Number {
        var _local_3:Number = ((_arg_1 & 0xFFFF) + (_arg_2 & 0xFFFF));
        var _local_4:Number = (((_arg_1 >> 16) + (_arg_2 >> 16)) + (_local_3 >> 16));
        return (((_local_4 << 16) | (_local_3 & 0xFFFF)));
    }

    private static function rol(_arg_1:Number, _arg_2:Number):Number {
        return (((_arg_1 << _arg_2) | (_arg_1 >>> (32 - _arg_2))));
    }

    private static function str2binb(_arg_1:String):Array {
        var _local_2:Array = [];
        var _local_3:Number = ((1 << 8) - 1);
        var _local_4:Number = 0;
        while (_local_4 < (_arg_1.length * 8)) {
            _local_2[(_local_4 >> 5)] = (_local_2[(_local_4 >> 5)] | ((_arg_1.charCodeAt((_local_4 / 8)) & _local_3) << (24 - (_local_4 % 32))));
            _local_4 = (_local_4 + 8);
        }
        return (_local_2);
    }

    private static function binb2hex(_arg_1:Array):String {
        var _local_2:String = String("");
        var _local_3:String = String("0123456789abcdef");
        var _local_4:Number = 0;
        while (_local_4 < (_arg_1.length * 4)) {
            _local_2 = (_local_2 + (_local_3.charAt(((_arg_1[(_local_4 >> 2)] >> (((3 - (_local_4 % 4)) * 8) + 4)) & 15)) + _local_3.charAt(((_arg_1[(_local_4 >> 2)] >> ((3 - (_local_4 % 4)) * 8)) & 15))));
            _local_4++;
        }
        return (_local_2);
    }


}
}//package com.company.assembleegameclient.util
