package com.company.util {
public class Random {

    public var seed:uint;

    public function Random(_arg_1:uint = 1) {
        this.seed = _arg_1;
    }

    public static function randomSeed():uint {
        return (Math.round(((Math.random() * (uint.MAX_VALUE - 1)) + 1)));
    }


    public function nextInt():uint {
        return (this.gen());
    }

    public function nextDouble():Number {
        return ((this.gen() / 2147483647));
    }

    public function nextNormal(_arg_1:Number = 0, _arg_2:Number = 1):Number {
        var _local_3:Number = (this.gen() / 2147483647);
        var _local_4:Number = (this.gen() / 2147483647);
        var _local_5:Number = (Math.sqrt((-2 * Math.log(_local_3))) * Math.cos(((2 * _local_4) * Math.PI)));
        return ((_arg_1 + (_local_5 * _arg_2)));
    }

    public function nextIntRange(_arg_1:uint, _arg_2:uint):uint {
        return ((((_arg_1) == _arg_2) ? _arg_1 : (_arg_1 + (this.gen() % (_arg_2 - _arg_1)))));
    }

    public function nextDoubleRange(_arg_1:Number, _arg_2:Number):Number {
        return ((_arg_1 + ((_arg_2 - _arg_1) * this.nextDouble())));
    }

    private function gen():uint {
        var _local_1:uint;
        var _local_2:uint;
        _local_2 = (16807 * (this.seed & 0xFFFF));
        _local_1 = (16807 * (this.seed >> 16));
        _local_2 = (_local_2 + ((_local_1 & 32767) << 16));
        _local_2 = (_local_2 + (_local_1 >> 15));
        if (_local_2 > 2147483647) {
            _local_2 = (_local_2 - 2147483647);
        }
        return ((this.seed = _local_2));
    }


}
}//package com.company.util
