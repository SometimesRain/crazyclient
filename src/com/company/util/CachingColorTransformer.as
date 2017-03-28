package com.company.util {
import flash.display.BitmapData;
import flash.filters.BitmapFilter;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.utils.Dictionary;

public class CachingColorTransformer {

    private static var bds_:Dictionary = new Dictionary();


    public static function transformBitmapData(_arg_1:BitmapData, _arg_2:ColorTransform):BitmapData {
        var _local_3:BitmapData;
        var _local_4:Object = bds_[_arg_1];
        if (_local_4 != null) {
            _local_3 = _local_4[_arg_2];
        }
        else {
            _local_4 = {};
            bds_[_arg_1] = _local_4;
        }
        if (_local_3 == null) {
            _local_3 = _arg_1.clone();
            _local_3.colorTransform(_local_3.rect, _arg_2);
            _local_4[_arg_2] = _local_3;
        }
        return (_local_3);
    }

    public static function filterBitmapData(_arg_1:BitmapData, _arg_2:BitmapFilter):BitmapData {
        var _local_3:BitmapData;
        var _local_4:Object = bds_[_arg_1];
        if (_local_4 != null) {
            _local_3 = _local_4[_arg_2];
        }
        else {
            _local_4 = {};
            bds_[_arg_1] = _local_4;
        }
        if (_local_3 == null) {
            _local_3 = _arg_1.clone();
            _local_3.applyFilter(_local_3, _local_3.rect, new Point(), _arg_2);
            _local_4[_arg_2] = _local_3;
        }
        return (_local_3);
    }

    public static function alphaBitmapData(_arg_1:BitmapData, _arg_2:Number):BitmapData {
        var _local_3:int = int((_arg_2 * 100));
        var _local_4:ColorTransform = new ColorTransform(1, 1, 1, (_local_3 / 100));
        return (transformBitmapData(_arg_1, _local_4));
    }

    public static function clear():void {
        var _local_1:Object;
        var _local_2:BitmapData;
        for each (_local_1 in bds_) {
            for each (_local_2 in _local_1) {
                _local_2.dispose();
            }
        }
        bds_ = new Dictionary();
    }


}
}//package com.company.util
