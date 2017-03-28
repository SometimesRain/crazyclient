package com.company.util {
import flash.geom.Point;

public class LineSegmentUtil {


    public static function intersection(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number):Point {
        var _local_9:Number = (((_arg_8 - _arg_6) * (_arg_3 - _arg_1)) - ((_arg_7 - _arg_5) * (_arg_4 - _arg_2)));
        if (_local_9 == 0) {
            return (null);
        }
        var _local_10:Number = ((((_arg_7 - _arg_5) * (_arg_2 - _arg_6)) - ((_arg_8 - _arg_6) * (_arg_1 - _arg_5))) / _local_9);
        var _local_11:Number = ((((_arg_3 - _arg_1) * (_arg_2 - _arg_6)) - ((_arg_4 - _arg_2) * (_arg_1 - _arg_5))) / _local_9);
        if ((((((((_local_10 > 1)) || ((_local_10 < 0)))) || ((_local_11 > 1)))) || ((_local_11 < 0)))) {
            return (null);
        }
        var _local_12:Point = new Point((_arg_1 + (_local_10 * (_arg_3 - _arg_1))), (_arg_2 + (_local_10 * (_arg_4 - _arg_2))));
        return (_local_12);
    }

    public static function pointDistance(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number):Number {
        var _local_10:Number;
        var _local_11:Number;
        var _local_12:Number;
        var _local_7:Number = (_arg_5 - _arg_3);
        var _local_8:Number = (_arg_6 - _arg_4);
        var _local_9:Number = ((_local_7 * _local_7) + (_local_8 * _local_8));
        if (_local_9 < 0.001) {
            _local_10 = _arg_3;
            _local_11 = _arg_4;
        }
        else {
            _local_12 = ((((_arg_1 - _arg_3) * _local_7) + ((_arg_2 - _arg_4) * _local_8)) / _local_9);
            if (_local_12 < 0) {
                _local_10 = _arg_3;
                _local_11 = _arg_4;
            }
            else {
                if (_local_12 > 1) {
                    _local_10 = _arg_5;
                    _local_11 = _arg_6;
                }
                else {
                    _local_10 = (_arg_3 + (_local_12 * _local_7));
                    _local_11 = (_arg_4 + (_local_12 * _local_8));
                }
            }
        }
        _local_7 = (_arg_1 - _local_10);
        _local_8 = (_arg_2 - _local_11);
        return (Math.sqrt(((_local_7 * _local_7) + (_local_8 * _local_8))));
    }


}
}//package com.company.util
