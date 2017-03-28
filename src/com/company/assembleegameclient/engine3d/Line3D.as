package com.company.assembleegameclient.engine3d {
import flash.geom.Vector3D;

public class Line3D {

    public var v0_:Vector3D;
    public var v1_:Vector3D;

    public function Line3D(_arg_1:Vector3D, _arg_2:Vector3D) {
        this.v0_ = _arg_1;
        this.v1_ = _arg_2;
    }

    public static function unitTest():Boolean {
        return (UnitTest.run());
    }


    public function crossZ(_arg_1:Line3D):int {
        var _local_2:Number = (((_arg_1.v1_.y - _arg_1.v0_.y) * (this.v1_.x - this.v0_.x)) - ((_arg_1.v1_.x - _arg_1.v0_.x) * (this.v1_.y - this.v0_.y)));
        if ((((_local_2 < 0.001)) && ((_local_2 > -0.001)))) {
            return (Order.NEITHER);
        }
        var _local_3:Number = (((_arg_1.v1_.x - _arg_1.v0_.x) * (this.v0_.y - _arg_1.v0_.y)) - ((_arg_1.v1_.y - _arg_1.v0_.y) * (this.v0_.x - _arg_1.v0_.x)));
        var _local_4:Number = (((this.v1_.x - this.v0_.x) * (this.v0_.y - _arg_1.v0_.y)) - ((this.v1_.y - this.v0_.y) * (this.v0_.x - _arg_1.v0_.x)));
        if ((((((((_local_3 < 0.001)) && ((_local_3 > -0.001)))) && ((_local_4 < 0.001)))) && ((_local_4 > -0.001)))) {
            return (Order.NEITHER);
        }
        var _local_5:Number = (_local_3 / _local_2);
        var _local_6:Number = (_local_4 / _local_2);
        if ((((((((_local_5 > 1)) || ((_local_5 < 0)))) || ((_local_6 > 1)))) || ((_local_6 < 0)))) {
            return (Order.NEITHER);
        }
        var _local_7:Number = ((this.v0_.z + (_local_5 * (this.v1_.z - this.v0_.z))) - (_arg_1.v0_.z + (_local_6 * (_arg_1.v1_.z - _arg_1.v0_.z))));
        if ((((_local_7 < 0.001)) && ((_local_7 > -0.001)))) {
            return (Order.NEITHER);
        }
        if (_local_7 > 0) {
            return (Order.IN_FRONT);
        }
        return (Order.BEHIND);
    }

    public function lerp(_arg_1:Number):Vector3D {
        return (new Vector3D((this.v0_.x + ((this.v1_.x - this.v0_.x) * _arg_1)), (this.v0_.y + ((this.v1_.y - this.v0_.y) * _arg_1)), (this.v0_.z + ((this.v1_.z - this.v0_.z) * _arg_1))));
    }

    public function toString():String {
        return ((((("(" + this.v0_) + ", ") + this.v1_) + ")"));
    }


}
}//package com.company.assembleegameclient.engine3d

import com.company.assembleegameclient.engine3d.Line3D;
import com.company.assembleegameclient.engine3d.Order;

import flash.geom.Vector3D;

class UnitTest {
	
    private static function testCrossZ():Boolean {
        var _local_1:Line3D = new Line3D(new Vector3D(0, 0, 0), new Vector3D(0, 100, 0));
        var _local_2:Line3D = new Line3D(new Vector3D(10, 0, 10), new Vector3D(-10, 100, -100));
        if (_local_1.crossZ(_local_2) != Order.IN_FRONT) {
            return (false);
        }
        if (_local_2.crossZ(_local_1) != Order.BEHIND) {
            return (false);
        }
        _local_1 = new Line3D(new Vector3D(1, 1, 200), new Vector3D(6, 6, 200));
        _local_2 = new Line3D(new Vector3D(3, 1, -100), new Vector3D(1, 3, -100));
        if (_local_1.crossZ(_local_2) != Order.IN_FRONT) {
            return (false);
        }
        if (_local_2.crossZ(_local_1) != Order.BEHIND) {
            return (false);
        }
        return (true);
    }

    public static function run():Boolean {
        if (!testCrossZ()) {
            return (false);
        }
        return (true);
    }


}
