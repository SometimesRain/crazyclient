package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.objects.GameObject;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;

public class PortraitToolTip extends ToolTip {

    private var portrait_:Bitmap;

    public function PortraitToolTip(_arg_1:GameObject) {
        super(6036765, 1, 16549442, 1, false);
        this.portrait_ = new Bitmap();
        this.portrait_.x = 0;
        this.portrait_.y = 0;
        var _local_2:BitmapData = _arg_1.getPortrait();
        _local_2 = BitmapUtil.cropToBitmapData(_local_2, 10, 10, (_local_2.width - 20), (_local_2.height - 20));
        this.portrait_.bitmapData = _local_2;
        addChild(this.portrait_);
        filters = [];
    }

}
}//package com.company.assembleegameclient.ui.tooltip
