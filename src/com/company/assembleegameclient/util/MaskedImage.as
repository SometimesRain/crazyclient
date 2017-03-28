package com.company.assembleegameclient.util {
import com.company.util.BitmapUtil;

import flash.display.BitmapData;

public class MaskedImage {

    public var image_:BitmapData;
    public var mask_:BitmapData;

    public function MaskedImage(_arg_1:BitmapData, _arg_2:BitmapData) {
        this.image_ = _arg_1;
        this.mask_ = _arg_2;
    }

    public function width():int {
        return (this.image_.width);
    }

    public function height():int {
        return (this.image_.height);
    }

    public function mirror(_arg_1:int = 0):MaskedImage {
        var _local_2:BitmapData = BitmapUtil.mirror(this.image_, _arg_1);
        var _local_3:BitmapData = (((this.mask_ == null)) ? null : BitmapUtil.mirror(this.mask_, _arg_1));
        return (new MaskedImage(_local_2, _local_3));
    }

    public function amountTransparent():Number {
        return (BitmapUtil.amountTransparent(this.image_));
    }


}
}//package com.company.assembleegameclient.util
