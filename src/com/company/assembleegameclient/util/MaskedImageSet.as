package com.company.assembleegameclient.util {
import com.company.util.ImageSet;

import flash.display.BitmapData;

public class MaskedImageSet {

    public var images_:Vector.<MaskedImage>;

    public function MaskedImageSet() {
        this.images_ = new Vector.<MaskedImage>();
        super();
    }

    public function addFromBitmapData(_arg_1:BitmapData, _arg_2:BitmapData, _arg_3:int, _arg_4:int):void {
        var _local_5:ImageSet = new ImageSet();
        _local_5.addFromBitmapData(_arg_1, _arg_3, _arg_4);
        var _local_6:ImageSet;
        if (_arg_2 != null) {
            _local_6 = new ImageSet();
            _local_6.addFromBitmapData(_arg_2, _arg_3, _arg_4);
            if(_local_5.images_.length > _local_5.images_.length)
            {
            }
        }
        var _local_7:int = 0;
        while (_local_7 < _local_5.images_.length) {
            this.images_.push(new MaskedImage(_local_5.images_[_local_7], _local_6 == null ? null : _local_7 >= _local_6.images_.length ? null : _local_6.images_[_local_7]));
            _local_7++;
        }
    }

    public function addFromMaskedImage(_arg_1:MaskedImage, _arg_2:int, _arg_3:int):void {
        this.addFromBitmapData(_arg_1.image_, _arg_1.mask_, _arg_2, _arg_3);
    }


}
}//package com.company.assembleegameclient.util
