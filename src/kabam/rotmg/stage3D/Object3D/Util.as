package kabam.rotmg.stage3D.Object3D {
import flash.geom.Matrix3D;
import flash.utils.ByteArray;

public class Util {


    public static function perspectiveProjection(_arg_1:Number = 90, _arg_2:Number = 1, _arg_3:Number = 1, _arg_4:Number = 0x0800):Matrix3D {
        var _local_5:Number = (_arg_3 * Math.tan(((_arg_1 * Math.PI) / 360)));
        var _local_6:Number = -(_local_5);
        var _local_7:Number = (_local_6 * _arg_2);
        var _local_8:Number = (_local_5 * _arg_2);
        var _local_9:Number = ((2 * _arg_3) / (_local_8 - _local_7));
        var _local_10:Number = ((2 * _arg_3) / (_local_5 - _local_6));
        var _local_11:Number = ((_local_8 + _local_7) / (_local_8 - _local_7));
        var _local_12:Number = ((_local_5 + _local_6) / (_local_5 - _local_6));
        var _local_13:Number = (-((_arg_4 + _arg_3)) / (_arg_4 - _arg_3));
        var _local_14:Number = ((-2 * (_arg_4 * _arg_3)) / (_arg_4 - _arg_3));
        return (new Matrix3D(Vector.<Number>([_local_9, 0, 0, 0, 0, _local_10, 0, 0, _local_11, _local_12, _local_13, -1, 0, 0, _local_14, 0])));
    }

    public static function readString(_arg_1:ByteArray, _arg_2:int):String {
        var _local_5:uint;
        var _local_3:String = "";
        var _local_4:int;
        while (_local_4 < _arg_2) {
            _local_5 = _arg_1.readUnsignedByte();
            if (_local_5 === 0) {
                _arg_1.position = (_arg_1.position + Math.max(0, (_arg_2 - (_local_4 + 1))));
                break;
            }
            _local_3 = (_local_3 + String.fromCharCode(_local_5));
            _local_4++;
        }
        return (_local_3);
    }

    public static function upperPowerOfTwo(_arg_1:uint):uint {
        _arg_1--;
        _arg_1 = (_arg_1 | (_arg_1 >> 1));
        _arg_1 = (_arg_1 | (_arg_1 >> 2));
        _arg_1 = (_arg_1 | (_arg_1 >> 4));
        _arg_1 = (_arg_1 | (_arg_1 >> 8));
        _arg_1 = (_arg_1 | (_arg_1 >> 16));
        return ((_arg_1 + 1));
    }


}
}//package kabam.rotmg.stage3D.Object3D
