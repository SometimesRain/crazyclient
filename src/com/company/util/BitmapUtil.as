package com.company.util {
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

public class BitmapUtil {

    public function BitmapUtil(_arg_1:StaticEnforcer) {
    }

    public static function mirror(_arg_1:BitmapData, _arg_2:int = 0):BitmapData {
        var _local_5:int;
        if (_arg_2 == 0) {
            _arg_2 = _arg_1.width;
        }
        var _local_3:BitmapData = new BitmapData(_arg_1.width, _arg_1.height, true, 0);
        var _local_4:int;
        while (_local_4 < _arg_2) {
            _local_5 = 0;
            while (_local_5 < _arg_1.height) {
                _local_3.setPixel32(((_arg_2 - _local_4) - 1), _local_5, _arg_1.getPixel32(_local_4, _local_5));
                _local_5++;
            }
            _local_4++;
        }
        return (_local_3);
    }

    public static function rotateBitmapData(_arg_1:BitmapData, _arg_2:int):BitmapData {
        var _local_3:Matrix = new Matrix();
        _local_3.translate((-(_arg_1.width) / 2), (-(_arg_1.height) / 2));
        _local_3.rotate(((_arg_2 * Math.PI) / 2));
        _local_3.translate((_arg_1.height / 2), (_arg_1.width / 2));
        var _local_4:BitmapData = new BitmapData(_arg_1.height, _arg_1.width, true, 0);
        _local_4.draw(_arg_1, _local_3);
        return (_local_4);
    }

    public static function cropToBitmapData(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):BitmapData {
        var _local_6:BitmapData = new BitmapData(_arg_4, _arg_5);
        _local_6.copyPixels(_arg_1, new Rectangle(_arg_2, _arg_3, _arg_4, _arg_5), new Point(0, 0));
        return (_local_6);
    }

    public static function amountTransparent(_arg_1:BitmapData):Number {
        var _local_4:int;
        var _local_5:int;
        var _local_2:int;
        var _local_3:int;
        while (_local_3 < _arg_1.width) {
            _local_4 = 0;
            while (_local_4 < _arg_1.height) {
                _local_5 = (_arg_1.getPixel32(_local_3, _local_4) & 0xFF000000);
                if (_local_5 == 0) {
                    _local_2++;
                }
                _local_4++;
            }
            _local_3++;
        }
        return ((_local_2 / (_arg_1.width * _arg_1.height)));
    }

    public static function mostCommonColor(_arg_1:BitmapData):uint {
        var _local_3:*;
        var _local_7:String;
        var _local_8:int;
        var _local_9:int;
        var _local_2:Dictionary = new Dictionary();
        var _local_4:int;
        while (_local_4 < _arg_1.width) {
            _local_8 = 0;
            while (_local_8 < _arg_1.width) {
                _local_3 = _arg_1.getPixel32(_local_4, _local_8);
                if ((_local_3 & 0xFF000000) != 0) {
                    if (!_local_2.hasOwnProperty(_local_3)) {
                        _local_2[_local_3] = 1;
                    }
                    else {
                        var _local_10:Dictionary = _local_2;
                        var _local_11:* = _local_3;
                        var _local_12:int = _local_10[_local_11] + 1;
                        _local_10[_local_11] = _local_12;
                    }
                }
                _local_8++;
            }
            _local_4++;
        }
        var _local_5:uint;
        var _local_6:uint;
        for (_local_7 in _local_2) {
            _local_3 = uint(_local_7);
            _local_9 = _local_2[_local_7];
            if ((((_local_9 > _local_6)) || ((((_local_9 == _local_6)) && ((_local_3 > _local_5)))))) {
                _local_5 = _local_3;
                _local_6 = _local_9;
            }
        }
        return (_local_5);
    }

    public static function lineOfSight(_arg_1:BitmapData, _arg_2:IntPoint, _arg_3:IntPoint):Boolean {
        var _local_11:int;
        var _local_19:int;
        var _local_20:int;
        var _local_21:int;
        var _local_4:int = _arg_1.width;
        var _local_5:int = _arg_1.height;
        var _local_6:int = _arg_2.x();
        var _local_7:int = _arg_2.y();
        var _local_8:int = _arg_3.x();
        var _local_9:int = _arg_3.y();
        var _local_10:Boolean = ((((_local_7 > _local_9)) ? (_local_7 - _local_9) : (_local_9 - _local_7)) > (((_local_6 > _local_8)) ? (_local_6 - _local_8) : (_local_8 - _local_6)));
        if (_local_10) {
            _local_11 = _local_6;
            _local_6 = _local_7;
            _local_7 = _local_11;
            _local_11 = _local_8;
            _local_8 = _local_9;
            _local_9 = _local_11;
            _local_11 = _local_4;
            _local_4 = _local_5;
            _local_5 = _local_11;
        }
        if (_local_6 > _local_8) {
            _local_11 = _local_6;
            _local_6 = _local_8;
            _local_8 = _local_11;
            _local_11 = _local_7;
            _local_7 = _local_9;
            _local_9 = _local_11;
        }
        var _local_12:int = (_local_8 - _local_6);
        var _local_13:int = (((_local_7 > _local_9)) ? (_local_7 - _local_9) : (_local_9 - _local_7));
        var _local_14:int = (-((_local_12 + 1)) / 2);
        var _local_15:int = (((_local_7) > _local_9) ? -1 : 1);
        var _local_16:int = (((_local_8 > (_local_4 - 1))) ? (_local_4 - 1) : _local_8);
        var _local_17:int = _local_7;
        var _local_18:int = _local_6;
        if (_local_18 < 0) {
            _local_14 = (_local_14 + (_local_13 * -(_local_18)));
            if (_local_14 >= 0) {
                _local_19 = ((_local_14 / _local_12) + 1);
                _local_17 = (_local_17 + (_local_15 * _local_19));
                _local_14 = (_local_14 - (_local_19 * _local_12));
            }
            _local_18 = 0;
        }
        if ((((((_local_15 > 0)) && ((_local_17 < 0)))) || ((((_local_15 < 0)) && ((_local_17 >= _local_5)))))) {
            _local_20 = (((_local_15 > 0)) ? (-(_local_17) - 1) : (_local_17 - _local_5));
            _local_14 = (_local_14 - (_local_12 * _local_20));
            _local_21 = (-(_local_14) / _local_13);
            _local_18 = (_local_18 + _local_21);
            _local_14 = (_local_14 + (_local_21 * _local_13));
            _local_17 = (_local_17 + (_local_20 * _local_15));
        }
        while (_local_18 <= _local_16) {
            if ((((((_local_15 > 0)) && ((_local_17 >= _local_5)))) || ((((_local_15 < 0)) && ((_local_17 < 0)))))) break;
            if (_local_10) {
                if ((((((_local_17 >= 0)) && ((_local_17 < _local_5)))) && ((_arg_1.getPixel(_local_17, _local_18) == 0)))) {
                    return (false);
                }
            }
            else {
                if ((((((_local_17 >= 0)) && ((_local_17 < _local_5)))) && ((_arg_1.getPixel(_local_18, _local_17) == 0)))) {
                    return (false);
                }
            }
            _local_14 = (_local_14 + _local_13);
            if (_local_14 >= 0) {
                _local_17 = (_local_17 + _local_15);
                _local_14 = (_local_14 - _local_12);
            }
            _local_18++;
        }
        return (true);
    }


}
}//package com.company.util

class StaticEnforcer {


}
