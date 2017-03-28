package com.company.util {
import flash.geom.Point;
import flash.geom.Rectangle;

public class Triangle {

    public var x0_:Number;
    public var y0_:Number;
    public var x1_:Number;
    public var y1_:Number;
    public var x2_:Number;
    public var y2_:Number;
    public var vx1_:Number;
    public var vy1_:Number;
    public var vx2_:Number;
    public var vy2_:Number;

    public function Triangle(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number) {
        this.x0_ = _arg_1;
        this.y0_ = _arg_2;
        this.x1_ = _arg_3;
        this.y1_ = _arg_4;
        this.x2_ = _arg_5;
        this.y2_ = _arg_6;
        this.vx1_ = (this.x1_ - this.x0_);
        this.vy1_ = (this.y1_ - this.y0_);
        this.vx2_ = (this.x2_ - this.x0_);
        this.vy2_ = (this.y2_ - this.y0_);
    }

    public static function containsXY(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number):Boolean {
        var _local_9:Number = (_arg_3 - _arg_1);
        var _local_10:Number = (_arg_4 - _arg_2);
        var _local_11:Number = (_arg_5 - _arg_1);
        var _local_12:Number = (_arg_6 - _arg_2);
        var _local_13:Number = ((((_arg_7 * _local_12) - (_arg_8 * _local_11)) - ((_arg_1 * _local_12) - (_arg_2 * _local_11))) / ((_local_9 * _local_12) - (_local_10 * _local_11)));
        var _local_14:Number = (-((((_arg_7 * _local_10) - (_arg_8 * _local_9)) - ((_arg_1 * _local_10) - (_arg_2 * _local_9)))) / ((_local_9 * _local_12) - (_local_10 * _local_11)));
        return ((((((_local_13 >= 0)) && ((_local_14 >= 0)))) && (((_local_13 + _local_14) <= 1))));
    }

    public static function intersectTriAABB(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number, _arg_9:Number, _arg_10:Number):Boolean {
        if ((((((((((((_arg_7 > _arg_1)) && ((_arg_7 > _arg_3)))) && ((_arg_7 > _arg_5)))) || ((((((_arg_9 < _arg_1)) && ((_arg_9 < _arg_3)))) && ((_arg_9 < _arg_5)))))) || ((((((_arg_8 > _arg_2)) && ((_arg_8 > _arg_4)))) && ((_arg_8 > _arg_6)))))) || ((((((_arg_10 < _arg_2)) && ((_arg_10 < _arg_4)))) && ((_arg_10 < _arg_6)))))) {
            return (false);
        }
        if ((((((((((((_arg_7 < _arg_1)) && ((_arg_1 < _arg_9)))) && ((_arg_8 < _arg_2)))) && ((_arg_2 < _arg_10)))) || ((((((((_arg_7 < _arg_3)) && ((_arg_3 < _arg_9)))) && ((_arg_8 < _arg_4)))) && ((_arg_4 < _arg_10)))))) || ((((((((_arg_7 < _arg_5)) && ((_arg_5 < _arg_9)))) && ((_arg_8 < _arg_6)))) && ((_arg_6 < _arg_10)))))) {
            return (true);
        }
        return (((((lineRectIntersect(_arg_1, _arg_2, _arg_3, _arg_4, _arg_7, _arg_8, _arg_9, _arg_10)) || (lineRectIntersect(_arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10)))) || (lineRectIntersect(_arg_5, _arg_6, _arg_1, _arg_2, _arg_7, _arg_8, _arg_9, _arg_10))));
    }

    private static function lineRectIntersect(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number):Boolean {
        var _local_11:Number;
        var _local_12:Number;
        var _local_13:Number;
        var _local_14:Number;
        var _local_9:Number = ((_arg_4 - _arg_2) / (_arg_3 - _arg_1));
        var _local_10:Number = (_arg_2 - (_local_9 * _arg_1));
        if (_local_9 > 0) {
            _local_11 = ((_local_9 * _arg_5) + _local_10);
            _local_12 = ((_local_9 * _arg_7) + _local_10);
        }
        else {
            _local_11 = ((_local_9 * _arg_7) + _local_10);
            _local_12 = ((_local_9 * _arg_5) + _local_10);
        }
        if (_arg_2 < _arg_4) {
            _local_13 = _arg_2;
            _local_14 = _arg_4;
        }
        else {
            _local_13 = _arg_4;
            _local_14 = _arg_2;
        }
        var _local_15:Number = (((_local_11 > _local_13)) ? _local_11 : _local_13);
        var _local_16:Number = (((_local_12 < _local_14)) ? _local_12 : _local_14);
        return ((((_local_15 < _local_16)) && (!((((_local_16 < _arg_6)) || ((_local_15 > _arg_8)))))));
    }


    public function aabb():Rectangle {
        var _local_1:Number = Math.min(this.x0_, this.x1_, this.x2_);
        var _local_2:Number = Math.max(this.x0_, this.x1_, this.x2_);
        var _local_3:Number = Math.min(this.y0_, this.y1_, this.y2_);
        var _local_4:Number = Math.max(this.y0_, this.y1_, this.y2_);
        return (new Rectangle(_local_1, _local_3, (_local_2 - _local_1), (_local_4 - _local_3)));
    }

    public function area():Number {
        return (Math.abs(((((this.x0_ * (this.y1_ - this.y2_)) + (this.x1_ * (this.y2_ - this.y0_))) + (this.x2_ * (this.y0_ - this.y1_))) / 2)));
    }

    public function incenter(_arg_1:Point):void {
        var _local_2:Number = PointUtil.distanceXY(this.x1_, this.y1_, this.x2_, this.y2_);
        var _local_3:Number = PointUtil.distanceXY(this.x0_, this.y0_, this.x2_, this.y2_);
        var _local_4:Number = PointUtil.distanceXY(this.x0_, this.y0_, this.x1_, this.y1_);
        _arg_1.x = ((((_local_2 * this.x0_) + (_local_3 * this.x1_)) + (_local_4 * this.x2_)) / ((_local_2 + _local_3) + _local_4));
        _arg_1.y = ((((_local_2 * this.y0_) + (_local_3 * this.y1_)) + (_local_4 * this.y2_)) / ((_local_2 + _local_3) + _local_4));
    }

    public function contains(_arg_1:Number, _arg_2:Number):Boolean {
        var _local_3:Number = ((((_arg_1 * this.vy2_) - (_arg_2 * this.vx2_)) - ((this.x0_ * this.vy2_) - (this.y0_ * this.vx2_))) / ((this.vx1_ * this.vy2_) - (this.vy1_ * this.vx2_)));
        var _local_4:Number = (-((((_arg_1 * this.vy1_) - (_arg_2 * this.vx1_)) - ((this.x0_ * this.vy1_) - (this.y0_ * this.vx1_)))) / ((this.vx1_ * this.vy2_) - (this.vy1_ * this.vx2_)));
        return ((((((_local_3 >= 0)) && ((_local_4 >= 0)))) && (((_local_3 + _local_4) <= 1))));
    }

    public function distance(_arg_1:Number, _arg_2:Number):Number {
        if (this.contains(_arg_1, _arg_2)) {
            return (0);
        }
        return (Math.min(LineSegmentUtil.pointDistance(_arg_1, _arg_2, this.x0_, this.y0_, this.x1_, this.y1_), LineSegmentUtil.pointDistance(_arg_1, _arg_2, this.x1_, this.y1_, this.x2_, this.y2_), LineSegmentUtil.pointDistance(_arg_1, _arg_2, this.x0_, this.y0_, this.x2_, this.y2_)));
    }

    public function intersectAABB(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Boolean {
        return (intersectTriAABB(this.x0_, this.y0_, this.x1_, this.y1_, this.x2_, this.y2_, _arg_1, _arg_2, _arg_3, _arg_4));
    }


}
}//package com.company.util
