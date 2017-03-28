package com.company.util {
public class Trig {

    public static const toDegrees:Number = (180 / Math.PI);//57.2957795130823
    public static const toRadians:Number = (Math.PI / 180);//0.0174532925199433

    public function Trig(_arg_1:StaticEnforcer) {
    }

    public static function slerp(_arg_1:Number, _arg_2:Number, _arg_3:Number):Number {
        var _local_4:Number = Number.MAX_VALUE;
        if (_arg_1 > _arg_2) {
            if ((_arg_1 - _arg_2) > Math.PI) {
                _local_4 = ((_arg_1 * (1 - _arg_3)) + ((_arg_2 + (2 * Math.PI)) * _arg_3));
            }
            else {
                _local_4 = ((_arg_1 * (1 - _arg_3)) + (_arg_2 * _arg_3));
            }
        }
        else {
            if ((_arg_2 - _arg_1) > Math.PI) {
                _local_4 = (((_arg_1 + (2 * Math.PI)) * (1 - _arg_3)) + (_arg_2 * _arg_3));
            }
            else {
                _local_4 = ((_arg_1 * (1 - _arg_3)) + (_arg_2 * _arg_3));
            }
        }
        if ((((_local_4 < -(Math.PI))) || ((_local_4 > Math.PI)))) {
            _local_4 = boundToPI(_local_4);
        }
        return (_local_4);
    }

    public static function angleDiff(_arg_1:Number, _arg_2:Number):Number {
        if (_arg_1 > _arg_2) {
            if ((_arg_1 - _arg_2) > Math.PI) {
                return (((_arg_2 + (2 * Math.PI)) - _arg_1));
            }
            return ((_arg_1 - _arg_2));
        }
        if ((_arg_2 - _arg_1) > Math.PI) {
            return (((_arg_1 + (2 * Math.PI)) - _arg_2));
        }
        return ((_arg_2 - _arg_1));
    }

    public static function sin(_arg_1:Number):Number {
        var _local_2:Number;
        if ((((_arg_1 < -(Math.PI))) || ((_arg_1 > Math.PI)))) {
            _arg_1 = boundToPI(_arg_1);
        }
        if (_arg_1 < 0) {
            _local_2 = ((1.27323954 * _arg_1) + ((0.405284735 * _arg_1) * _arg_1));
            if (_local_2 < 0) {
                _local_2 = ((0.225 * ((_local_2 * -(_local_2)) - _local_2)) + _local_2);
            }
            else {
                _local_2 = ((0.225 * ((_local_2 * _local_2) - _local_2)) + _local_2);
            }
        }
        else {
            _local_2 = ((1.27323954 * _arg_1) - ((0.405284735 * _arg_1) * _arg_1));
            if (_local_2 < 0) {
                _local_2 = ((0.225 * ((_local_2 * -(_local_2)) - _local_2)) + _local_2);
            }
            else {
                _local_2 = ((0.225 * ((_local_2 * _local_2) - _local_2)) + _local_2);
            }
        }
        return (_local_2);
    }

    public static function cos(_arg_1:Number):Number {
        return (sin((_arg_1 + (Math.PI / 2))));
    }

    public static function atan2(_arg_1:Number, _arg_2:Number):Number {
        var _local_3:Number;
        if (_arg_2 == 0) {
            if (_arg_1 < 0) {
                return ((-(Math.PI) / 2));
            }
            if (_arg_1 > 0) {
                return ((Math.PI / 2));
            }
            return (undefined);
        }
        if (_arg_1 == 0) {
            if (_arg_2 < 0) {
                return (Math.PI);
            }
            return (0);
        }
        if ((((_arg_2 > 0)) ? _arg_2 : -(_arg_2)) > (((_arg_1 > 0)) ? _arg_1 : -(_arg_1))) {
            _local_3 = ((((_arg_2 < 0)) ? -(Math.PI) : 0) + atan2Helper(_arg_1, _arg_2));
        }
        else {
            _local_3 = ((((_arg_1 > 0)) ? (Math.PI / 2) : (-(Math.PI) / 2)) - atan2Helper(_arg_2, _arg_1));
        }
        if ((((_local_3 < -(Math.PI))) || ((_local_3 > Math.PI)))) {
            _local_3 = boundToPI(_local_3);
        }
        return (_local_3);
    }

    public static function atan2Helper(_arg_1:Number, _arg_2:Number):Number {
        var _local_3:Number = (_arg_1 / _arg_2);
        var _local_4:Number = _local_3;
        var _local_5:Number = _local_3;
        var _local_6:Number = 1;
        var _local_7:int = 1;
        do {
            _local_6 = (_local_6 + 2);
            _local_7 = (((_local_7 > 0)) ? -1 : 1);
            _local_5 = ((_local_5 * _local_3) * _local_3);
            _local_4 = (_local_4 + ((_local_7 * _local_5) / _local_6));
        } while ((((((_local_5 > 0.01)) || ((_local_5 < -0.01)))) && ((_local_6 <= 11))));
        return (_local_4);
    }

    public static function boundToPI(_arg_1:Number):Number {
        var _local_2:int;
        if (_arg_1 < -(Math.PI)) {
            _local_2 = ((int((_arg_1 / -(Math.PI))) + 1) / 2);
            _arg_1 = (_arg_1 + ((_local_2 * 2) * Math.PI));
        }
        else {
            if (_arg_1 > Math.PI) {
                _local_2 = ((int((_arg_1 / Math.PI)) + 1) / 2);
                _arg_1 = (_arg_1 - ((_local_2 * 2) * Math.PI));
            }
        }
        return (_arg_1);
    }

    public static function boundTo180(_arg_1:Number):Number {
        var _local_2:int;
        if (_arg_1 < -180) {
            _local_2 = ((int((_arg_1 / -180)) + 1) / 2);
            _arg_1 = (_arg_1 + (_local_2 * 360));
        }
        else {
            if (_arg_1 > 180) {
                _local_2 = ((int((_arg_1 / 180)) + 1) / 2);
                _arg_1 = (_arg_1 - (_local_2 * 360));
            }
        }
        return (_arg_1);
    }

    public static function unitTest():Boolean {
        trace("STARTING UNITTEST: Trig");
        var _local_1:Boolean = ((((testFunc1(Math.sin, sin)) && (testFunc1(Math.cos, cos)))) && (testFunc2(Math.atan2, atan2)));
        if (!_local_1) {
            trace("Trig Unit Test FAILED!");
        }
        trace("FINISHED UNITTEST: Trig");
        return (_local_1);
    }

    public static function testFunc1(_arg_1:Function, _arg_2:Function):Boolean {
        var _local_5:Number;
        var _local_6:Number;
        var _local_3:Random = new Random();
        var _local_4:int;
        while (_local_4 < 1000) {
            _local_5 = (((_local_3.nextInt() % 2000) - 1000) + _local_3.nextDouble());
            _local_6 = Math.abs((_arg_1(_local_5) - _arg_2(_local_5)));
            if (_local_6 > 0.1) {
                return (false);
            }
            _local_4++;
        }
        return (true);
    }

    public static function testFunc2(_arg_1:Function, _arg_2:Function):Boolean {
        var _local_5:Number;
        var _local_6:Number;
        var _local_7:Number;
        var _local_3:Random = new Random();
        var _local_4:int;
        while (_local_4 < 1000) {
            _local_5 = (((_local_3.nextInt() % 2000) - 1000) + _local_3.nextDouble());
            _local_6 = (((_local_3.nextInt() % 2000) - 1000) + _local_3.nextDouble());
            _local_7 = Math.abs((_arg_1(_local_5, _local_6) - _arg_2(_local_5, _local_6)));
            if (_local_7 > 0.1) {
                return (false);
            }
            _local_4++;
        }
        return (true);
    }


}
}//package com.company.util

class StaticEnforcer {


}
