package com.company.assembleegameclient.util {
import flash.utils.Dictionary;

public class FreeList {

    private static var dict_:Dictionary = new Dictionary();


    public static function newObject(_arg_1:Class):Object {
        var _local_2:Vector.<Object> = dict_[_arg_1];
        if (_local_2 == null) {
            _local_2 = new Vector.<Object>();
            dict_[_arg_1] = _local_2;
        }
        else {
            if (_local_2.length > 0) {
                return (_local_2.pop());
            }
        }
        return (new (_arg_1)());
    }

    public static function storeObject(_arg_1:*, _arg_2:Object):void {
        var _local_3:Vector.<Object> = dict_[_arg_1];
        if (_local_3 == null) {
            _local_3 = new Vector.<Object>();
            dict_[_arg_1] = _local_3;
        }
        _local_3.push(_arg_2);
    }

    public static function getObject(_arg_1:*):Object {
        var _local_2:Vector.<Object> = dict_[_arg_1];
        if (((!((_local_2 == null))) && ((_local_2.length > 0)))) {
            return (_local_2.pop());
        }
        return (null);
    }

    public static function dump(_arg_1:*):void {
        delete dict_[_arg_1];
    }

    public static function deleteObject(_arg_1:Object):void {
        var _local_2:Class = Object(_arg_1).constructor;
        var _local_3:Vector.<Object> = dict_[_local_2];
        if (_local_3 == null) {
            _local_3 = new Vector.<Object>();
            dict_[_local_2] = _local_3;
        }
        _local_3.push(_arg_1);
    }


}
}//package com.company.assembleegameclient.util
