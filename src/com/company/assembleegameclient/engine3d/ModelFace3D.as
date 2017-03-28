package com.company.assembleegameclient.engine3d {
public class ModelFace3D {

    public var model_:Model3D;
    public var indicies_:Vector.<int>;
    public var useTexture_:Boolean;

    public function ModelFace3D(_arg_1:Model3D, _arg_2:Vector.<int>, _arg_3:Boolean) {
        this.model_ = _arg_1;
        this.indicies_ = _arg_2;
        this.useTexture_ = _arg_3;
    }

    public static function compare(_arg_1:ModelFace3D, _arg_2:ModelFace3D):Number {
        var _local_3:Number;
        var _local_4:int;
        var _local_5:Number = Number.MAX_VALUE;
        var _local_6:Number = Number.MIN_VALUE;
        _local_4 = 0;
        while (_local_4 < _arg_1.indicies_.length) {
            _local_3 = _arg_2.model_.vL_[((_arg_1.indicies_[_local_4] * 3) + 2)];
            _local_5 = (((_local_3 < _local_5)) ? _local_3 : _local_5);
            _local_6 = (((_local_3 > _local_6)) ? _local_3 : _local_6);
            _local_4++;
        }
        var _local_7:Number = Number.MAX_VALUE;
        var _local_8:Number = Number.MIN_VALUE;
        _local_4 = 0;
        while (_local_4 < _arg_2.indicies_.length) {
            _local_3 = _arg_2.model_.vL_[((_arg_2.indicies_[_local_4] * 3) + 2)];
            _local_7 = (((_local_3 < _local_7)) ? _local_3 : _local_7);
            _local_8 = (((_local_3 > _local_8)) ? _local_3 : _local_8);
            _local_4++;
        }
        if (_local_7 > _local_5) {
            return (-1);
        }
        if (_local_7 < _local_5) {
            return (1);
        }
        if (_local_8 > _local_6) {
            return (-1);
        }
        if (_local_8 < _local_6) {
            return (1);
        }
        return (0);
    }


}
}//package com.company.assembleegameclient.engine3d
