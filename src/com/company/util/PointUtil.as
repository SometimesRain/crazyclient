package com.company.util {
import flash.geom.Point;

public class PointUtil {

    public static const ORIGIN:Point = new Point(0, 0);

    public function PointUtil(_arg_1:StaticEnforcer) {
    }

    public static function roundPoint(_arg_1:Point):Point {
        var _local_2:Point = _arg_1.clone();
        _local_2.x = Math.round(_local_2.x);
        _local_2.y = Math.round(_local_2.y);
        return (_local_2);
    }

    public static function distanceSquared(_arg_1:Point, _arg_2:Point):Number {
        return (distanceSquaredXY(_arg_1.x, _arg_1.y, _arg_2.x, _arg_2.y));
    }

    public static function distanceSquaredXY(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Number {
        var _local_5:Number = (_arg_3 - _arg_1);
        var _local_6:Number = (_arg_4 - _arg_2);
        return (((_local_5 * _local_5) + (_local_6 * _local_6)));
    }

    public static function distanceXY(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Number {
        var _local_5:Number = (_arg_3 - _arg_1);
        var _local_6:Number = (_arg_4 - _arg_2);
        return (Math.sqrt(((_local_5 * _local_5) + (_local_6 * _local_6))));
    }

    public static function lerpXY(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number):Point {
        return (new Point((_arg_1 + ((_arg_3 - _arg_1) * _arg_5)), (_arg_2 + ((_arg_4 - _arg_2) * _arg_5))));
    }

    public static function angleTo(_arg_1:Point, _arg_2:Point):Number {
        return (Math.atan2((_arg_2.y - _arg_1.y), (_arg_2.x - _arg_1.x)));
    }

    public static function pointAt(_arg_1:Point, _arg_2:Number, _arg_3:Number):Point {
        var _local_4:Point = new Point();
        _local_4.x = (_arg_1.x + (_arg_3 * Math.cos(_arg_2)));
        _local_4.y = (_arg_1.y + (_arg_3 * Math.sin(_arg_2)));
        return (_local_4);
    }


}
}//package com.company.util

class StaticEnforcer {


}
