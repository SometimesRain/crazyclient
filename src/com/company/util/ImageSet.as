package com.company.util {
import flash.display.BitmapData;

public class ImageSet {

    public var images_:Vector.<BitmapData>;

    public function ImageSet() {
        this.images_ = new Vector.<BitmapData>();
    }

    public function add(_arg_1:BitmapData):void {
        this.images_.push(_arg_1);
    }

    public function random():BitmapData {
        return (this.images_[int((Math.random() * this.images_.length))]);
    }

    public function addFromBitmapData(_arg_1:BitmapData, _arg_2:int, _arg_3:int):void {
        var _local_7:int;
        var _local_4:int = (_arg_1.width / _arg_2);
        var _local_5:int = (_arg_1.height / _arg_3);
        var _local_6:int;
        while (_local_6 < _local_5) {
            _local_7 = 0;
            while (_local_7 < _local_4) {
                this.images_.push(BitmapUtil.cropToBitmapData(_arg_1, (_local_7 * _arg_2), (_local_6 * _arg_3), _arg_2, _arg_3));
                _local_7++;
            }
            _local_6++;
        }
    }


}
}//package com.company.util
