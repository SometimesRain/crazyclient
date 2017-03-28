package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.map.RegionLibrary;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Shape;

public class RegionElement extends Element {

    public var regionXML_:XML;

    public function RegionElement(_arg_1:XML) {
        super(int(_arg_1.@type));
        this.regionXML_ = _arg_1;
        var _local_2:Shape = new Shape();
        _local_2.graphics.beginFill(RegionLibrary.getColor(type_), 0.5);
        _local_2.graphics.drawRect(0, 0, (WIDTH - 8), (HEIGHT - 8));
        _local_2.graphics.endFill();
        _local_2.x = ((WIDTH / 2) - (_local_2.width / 2));
        _local_2.y = ((HEIGHT / 2) - (_local_2.height / 2));
        addChild(_local_2);
    }

    override protected function getToolTip():ToolTip {
        return (new RegionTypeToolTip(this.regionXML_));
    }


}
}//package com.company.assembleegameclient.mapeditor
