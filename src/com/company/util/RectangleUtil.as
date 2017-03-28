package com.company.util {
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class RectangleUtil {


    public static function pointDist(_arg_1:Rectangle, _arg_2:Number, _arg_3:Number):Number {
        var _local_4:Number = _arg_2;
        var _local_5:Number = _arg_3;
        if (_local_4 < _arg_1.x) {
            _local_4 = _arg_1.x;
        }
        else {
            if (_local_4 > _arg_1.right) {
                _local_4 = _arg_1.right;
            }
        }
        if (_local_5 < _arg_1.y) {
            _local_5 = _arg_1.y;
        }
        else {
            if (_local_5 > _arg_1.bottom) {
                _local_5 = _arg_1.bottom;
            }
        }
        if ((((_local_4 == _arg_2)) && ((_local_5 == _arg_3)))) {
            return (0);
        }
        return (PointUtil.distanceXY(_local_4, _local_5, _arg_2, _arg_3));
    }

    public static function closestPoint(_arg_1:Rectangle, _arg_2:Number, _arg_3:Number):Point {
        var _local_4:Number = _arg_2;
        var _local_5:Number = _arg_3;
        if (_local_4 < _arg_1.x) {
            _local_4 = _arg_1.x;
        }
        else {
            if (_local_4 > _arg_1.right) {
                _local_4 = _arg_1.right;
            }
        }
        if (_local_5 < _arg_1.y) {
            _local_5 = _arg_1.y;
        }
        else {
            if (_local_5 > _arg_1.bottom) {
                _local_5 = _arg_1.bottom;
            }
        }
        return (new Point(_local_4, _local_5));
    }

    public static function lineSegmentIntersectsXY(_arg_1:Rectangle, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number):Boolean {
        var _local_8:Number;
        var _local_9:Number;
        var _local_10:Number;
        var _local_11:Number;
        if ((((((((((_arg_1.left > _arg_2)) && ((_arg_1.left > _arg_4)))) || ((((_arg_1.right < _arg_2)) && ((_arg_1.right < _arg_4)))))) || ((((_arg_1.top > _arg_3)) && ((_arg_1.top > _arg_5)))))) || ((((_arg_1.bottom < _arg_3)) && ((_arg_1.bottom < _arg_5)))))) {
            return (false);
        }
        if ((((((((((_arg_1.left < _arg_2)) && ((_arg_2 < _arg_1.right)))) && ((_arg_1.top < _arg_3)))) && ((_arg_3 < _arg_1.bottom)))) || ((((((((_arg_1.left < _arg_4)) && ((_arg_4 < _arg_1.right)))) && ((_arg_1.top < _arg_5)))) && ((_arg_5 < _arg_1.bottom)))))) {
            return (true);
        }
        var _local_6:Number = ((_arg_5 - _arg_3) / (_arg_4 - _arg_2));
        var _local_7:Number = (_arg_3 - (_local_6 * _arg_2));
        if (_local_6 > 0) {
            _local_8 = ((_local_6 * _arg_1.left) + _local_7);
            _local_9 = ((_local_6 * _arg_1.right) + _local_7);
        }
        else {
            _local_8 = ((_local_6 * _arg_1.right) + _local_7);
            _local_9 = ((_local_6 * _arg_1.left) + _local_7);
        }
        if (_arg_3 < _arg_5) {
            _local_11 = _arg_3;
            _local_10 = _arg_5;
        }
        else {
            _local_11 = _arg_5;
            _local_10 = _arg_3;
        }
        var _local_12:Number = (((_local_8 > _local_11)) ? _local_8 : _local_11);
        var _local_13:Number = (((_local_9 < _local_10)) ? _local_9 : _local_10);
        return ((((_local_12 < _local_13)) && (!((((_local_13 < _arg_1.top)) || ((_local_12 > _arg_1.bottom)))))));
    }

    public static function lineSegmentIntersectXY(_arg_1:Rectangle, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Point):Boolean {
        var _local_7:Number;
        var _local_8:Number;
        var _local_9:Number;
        var _local_10:Number;
        if (_arg_4 <= _arg_1.x) {
            _local_7 = ((_arg_5 - _arg_3) / (_arg_4 - _arg_2));
            _local_8 = (_arg_3 - (_arg_2 * _local_7));
            _local_9 = ((_local_7 * _arg_1.x) + _local_8);
            if ((((_local_9 >= _arg_1.y)) && ((_local_9 <= (_arg_1.y + _arg_1.height))))) {
                _arg_6.x = _arg_1.x;
                _arg_6.y = _local_9;
                return (true);
            }
        }
        else {
            if (_arg_4 >= (_arg_1.x + _arg_1.width)) {
                _local_7 = ((_arg_5 - _arg_3) / (_arg_4 - _arg_2));
                _local_8 = (_arg_3 - (_arg_2 * _local_7));
                _local_9 = ((_local_7 * (_arg_1.x + _arg_1.width)) + _local_8);
                if ((((_local_9 >= _arg_1.y)) && ((_local_9 <= (_arg_1.y + _arg_1.height))))) {
                    _arg_6.x = (_arg_1.x + _arg_1.width);
                    _arg_6.y = _local_9;
                    return (true);
                }
            }
        }
        if (_arg_5 <= _arg_1.y) {
            _local_7 = ((_arg_4 - _arg_2) / (_arg_5 - _arg_3));
            _local_8 = (_arg_2 - (_arg_3 * _local_7));
            _local_10 = ((_local_7 * _arg_1.y) + _local_8);
            if ((((_local_10 >= _arg_1.x)) && ((_local_10 <= (_arg_1.x + _arg_1.width))))) {
                _arg_6.x = _local_10;
                _arg_6.y = _arg_1.y;
                return (true);
            }
        }
        else {
            if (_arg_5 >= (_arg_1.y + _arg_1.height)) {
                _local_7 = ((_arg_4 - _arg_2) / (_arg_5 - _arg_3));
                _local_8 = (_arg_2 - (_arg_3 * _local_7));
                _local_10 = ((_local_7 * (_arg_1.y + _arg_1.height)) + _local_8);
                if ((((_local_10 >= _arg_1.x)) && ((_local_10 <= (_arg_1.x + _arg_1.width))))) {
                    _arg_6.x = _local_10;
                    _arg_6.y = (_arg_1.y + _arg_1.height);
                    return (true);
                }
            }
        }
        return (false);
    }

    public static function lineSegmentIntersect(_arg_1:Rectangle, _arg_2:IntPoint, _arg_3:IntPoint):Point {
        var _local_4:Number;
        var _local_5:Number;
        var _local_6:Number;
        var _local_7:Number;
        if (_arg_3.x() <= _arg_1.x) {
            _local_4 = ((_arg_3.y() - _arg_2.y()) / (_arg_3.x() - _arg_2.x()));
            _local_5 = (_arg_2.y() - (_arg_2.x() * _local_4));
            _local_6 = ((_local_4 * _arg_1.x) + _local_5);
            if ((((_local_6 >= _arg_1.y)) && ((_local_6 <= (_arg_1.y + _arg_1.height))))) {
                return (new Point(_arg_1.x, _local_6));
            }
        }
        else {
            if (_arg_3.x() >= (_arg_1.x + _arg_1.width)) {
                _local_4 = ((_arg_3.y() - _arg_2.y()) / (_arg_3.x() - _arg_2.x()));
                _local_5 = (_arg_2.y() - (_arg_2.x() * _local_4));
                _local_6 = ((_local_4 * (_arg_1.x + _arg_1.width)) + _local_5);
                if ((((_local_6 >= _arg_1.y)) && ((_local_6 <= (_arg_1.y + _arg_1.height))))) {
                    return (new Point((_arg_1.x + _arg_1.width), _local_6));
                }
            }
        }
        if (_arg_3.y() <= _arg_1.y) {
            _local_4 = ((_arg_3.x() - _arg_2.x()) / (_arg_3.y() - _arg_2.y()));
            _local_5 = (_arg_2.x() - (_arg_2.y() * _local_4));
            _local_7 = ((_local_4 * _arg_1.y) + _local_5);
            if ((((_local_7 >= _arg_1.x)) && ((_local_7 <= (_arg_1.x + _arg_1.width))))) {
                return (new Point(_local_7, _arg_1.y));
            }
        }
        else {
            if (_arg_3.y() >= (_arg_1.y + _arg_1.height)) {
                _local_4 = ((_arg_3.x() - _arg_2.x()) / (_arg_3.y() - _arg_2.y()));
                _local_5 = (_arg_2.x() - (_arg_2.y() * _local_4));
                _local_7 = ((_local_4 * (_arg_1.y + _arg_1.height)) + _local_5);
                if ((((_local_7 >= _arg_1.x)) && ((_local_7 <= (_arg_1.x + _arg_1.width))))) {
                    return (new Point(_local_7, (_arg_1.y + _arg_1.height)));
                }
            }
        }
        return (null);
    }

    public static function getRotatedRectExtents2D(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number):Extents2D {
        var _local_9:Point;
        var _local_11:int;
        var _local_6:Matrix = new Matrix();
        _local_6.translate((-(_arg_4) / 2), (-(_arg_5) / 2));
        _local_6.rotate(_arg_3);
        _local_6.translate(_arg_1, _arg_2);
        var _local_7:Extents2D = new Extents2D();
        var _local_8:Point = new Point();
        var _local_10:int;
        while (_local_10 <= 1) {
            _local_11 = 0;
            while (_local_11 <= 1) {
                _local_8.x = (_local_10 * _arg_4);
                _local_8.y = (_local_11 * _arg_5);
                _local_9 = _local_6.transformPoint(_local_8);
                _local_7.add(_local_9.x, _local_9.y);
                _local_11++;
            }
            _local_10++;
        }
        return (_local_7);
    }


}
}//package com.company.util
