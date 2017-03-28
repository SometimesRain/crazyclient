package com.company.assembleegameclient.util {
import flash.display.BitmapData;
import flash.utils.Dictionary;

public class BloodComposition {

    private static var idDict_:Dictionary = new Dictionary();
    private static var imageDict_:Dictionary = new Dictionary();


    public static function getBloodComposition(_arg_1:int, _arg_2:BitmapData, _arg_3:Number, _arg_4:uint):Vector.<uint> {
        var _local_5:Vector.<uint> = idDict_[_arg_1];
        if (_local_5 != null) {
            return (_local_5);
        }
        _local_5 = new Vector.<uint>();
        var _local_6:Vector.<uint> = getColors(_arg_2);
        var _local_7:int;
        while (_local_7 < _local_6.length) {
            if (Math.random() < _arg_3) {
                _local_5.push(_arg_4);
            }
            else {
                _local_5.push(_local_6[int((_local_6.length * Math.random()))]);
            }
            _local_7++;
        }
        return (_local_5);
    }

    public static function getColors(_arg_1:BitmapData):Vector.<uint> {
        var _local_2:Vector.<uint> = imageDict_[_arg_1];
        if (_local_2 == null) {
            _local_2 = buildColors(_arg_1);
            imageDict_[_arg_1] = _local_2;
        }
        return (_local_2);
    }

    private static function buildColors(_arg_1:BitmapData):Vector.<uint> {
        var _local_4:int;
        var _local_5:uint;
        var _local_2:Vector.<uint> = new Vector.<uint>();
        var _local_3:int;
        while (_local_3 < _arg_1.width) {
            _local_4 = 0;
            while (_local_4 < _arg_1.height) {
                _local_5 = _arg_1.getPixel32(_local_3, _local_4);
                if ((_local_5 & 0xFF000000) != 0) {
                    _local_2.push(_local_5);
                }
                _local_4++;
            }
            _local_3++;
        }
        return (_local_2);
    }


}
}//package com.company.assembleegameclient.util
