package com.company.util {
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.geom.Vector3D;

public class ConversionUtil {

    public function ConversionUtil(_arg_1:StaticEnforcer) {
    }

    public static function toIntArray(_arg_1:Object, _arg_2:String = ","):Array {
        if (_arg_1 == null) {
            return ([]);
        }
        return (_arg_1.toString().split(_arg_2).map(mapParseInt));
    }

    public static function toNumberArray(_arg_1:Object, _arg_2:String = ","):Array {
        if (_arg_1 == null) {
            return ([]);
        }
        return (_arg_1.toString().split(_arg_2).map(mapParseFloat));
    }

    public static function toIntVector(_arg_1:Object, _arg_2:String = ","):Vector.<int> {
        if (_arg_1 == null) {
            return (new Vector.<int>());
        }
        return (Vector.<int>(_arg_1.toString().split(_arg_2).map(mapParseInt)));
    }

    public static function toNumberVector(_arg_1:Object, _arg_2:String = ","):Vector.<Number> {
        if (_arg_1 == null) {
            return (new Vector.<Number>());
        }
        return (Vector.<Number>(_arg_1.toString().split(_arg_2).map(mapParseFloat)));
    }

    public static function toStringArray(_arg_1:Object, _arg_2:String = ","):Array {
        if (_arg_1 == null) {
            return ([]);
        }
        return (_arg_1.toString().split(_arg_2));
    }

    public static function toRectangle(_arg_1:Object, _arg_2:String = ","):Rectangle {
        if (_arg_1 == null) {
            return (new Rectangle());
        }
        var _local_3:Array = _arg_1.toString().split(_arg_2).map(mapParseFloat);
        return ((((((_local_3 == null)) || ((_local_3.length < 4)))) ? new Rectangle() : new Rectangle(_local_3[0], _local_3[1], _local_3[2], _local_3[3])));
    }

    public static function toPoint(_arg_1:Object, _arg_2:String = ","):Point {
        if (_arg_1 == null) {
            return (new Point());
        }
        var _local_3:Array = _arg_1.toString().split(_arg_2).map(ConversionUtil.mapParseFloat);
        return ((((((_local_3 == null)) || ((_local_3.length < 2)))) ? new Point() : new Point(_local_3[0], _local_3[1])));
    }

    public static function toPointPair(_arg_1:Object, _arg_2:String = ","):Array {
        var _local_3:Array = [];
        if (_arg_1 == null) {
            _local_3.push(new Point());
            _local_3.push(new Point());
            return (_local_3);
        }
        var _local_4:Array = _arg_1.toString().split(_arg_2).map(ConversionUtil.mapParseFloat);
        if ((((_local_4 == null)) || ((_local_4.length < 4)))) {
            _local_3.push(new Point());
            _local_3.push(new Point());
            return (_local_3);
        }
        _local_3.push(new Point(_local_4[0], _local_4[1]));
        _local_3.push(new Point(_local_4[2], _local_4[3]));
        return (_local_3);
    }

    public static function toVector3D(_arg_1:Object, _arg_2:String = ","):Vector3D {
        if (_arg_1 == null) {
            return (new Vector3D());
        }
        var _local_3:Array = _arg_1.toString().split(_arg_2).map(ConversionUtil.mapParseFloat);
        return ((((((_local_3 == null)) || ((_local_3.length < 3)))) ? new Vector3D() : new Vector3D(_local_3[0], _local_3[1], _local_3[2])));
    }

    public static function toCharCodesVector(_arg_1:Object, _arg_2:String = ","):Vector.<int> {
        if (_arg_1 == null) {
            return (new Vector.<int>());
        }
        return (Vector.<int>(_arg_1.toString().split(_arg_2).map(mapParseCharCode)));
    }

    public static function addToNumberVector(_arg_1:Object, _arg_2:Vector.<Number>, _arg_3:String = ","):void {
        var _local_5:Number;
        if (_arg_1 == null) {
            return;
        }
        var _local_4:Array = _arg_1.toString().split(_arg_3).map(mapParseFloat);
        for each (_local_5 in _local_4) {
            _arg_2.push(_local_5);
        }
    }

    public static function addToIntVector(_arg_1:Object, _arg_2:Vector.<int>, _arg_3:String = ","):void {
        var _local_5:int;
        if (_arg_1 == null) {
            return;
        }
        var _local_4:Array = _arg_1.toString().split(_arg_3).map(mapParseFloat);
        for each (_local_5 in _local_4) {
            _arg_2.push(_local_5);
        }
    }

    public static function mapParseFloat(_arg_1:*, ... rest):Number {
        return (parseFloat(_arg_1));
    }

    public static function mapParseInt(_arg_1:*, ... rest):Number {
        return (parseInt(_arg_1));
    }

    public static function mapParseCharCode(_arg_1:*, ... rest):Number {
        return (String(_arg_1).charCodeAt());
    }

    public static function vector3DToShaderParameter(_arg_1:Vector3D):Array {
        return ([_arg_1.x, _arg_1.y, _arg_1.z]);
    }


}
}//package com.company.util

class StaticEnforcer {


}
