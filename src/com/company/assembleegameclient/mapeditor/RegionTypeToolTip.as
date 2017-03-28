package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.ui.BaseSimpleText;

import flash.filters.DropShadowFilter;

public class RegionTypeToolTip extends ToolTip {

    private static const MAX_WIDTH:int = 180;

    private var titleText_:BaseSimpleText;

    public function RegionTypeToolTip(_arg_1:XML) {
        super(0x363636, 1, 0x9B9B9B, 1, true);
        this.titleText_ = new BaseSimpleText(16, 0xFFFFFF, false, (MAX_WIDTH - 4), 0);
        this.titleText_.setBold(true);
        this.titleText_.wordWrap = true;
        this.titleText_.text = String(_arg_1.@id);
        this.titleText_.useTextDimensions();
        this.titleText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.titleText_.x = 0;
        this.titleText_.y = 0;
        addChild(this.titleText_);
    }

}
}//package com.company.assembleegameclient.mapeditor
