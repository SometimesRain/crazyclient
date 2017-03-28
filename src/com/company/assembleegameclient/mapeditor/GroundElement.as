package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.map.AnimateProperties;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.map.SquareFace;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.BitmapData;
import flash.display.IGraphicsData;
import flash.display.Shape;
import flash.geom.Rectangle;

public class GroundElement extends Element {

    private static const VIN:Vector.<Number> = new <Number>[0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0];
    private static const SCALE:Number = 0.6;

    public var groundXML_:XML;
    private var tileShape_:Shape;

    public function GroundElement(_arg_1:XML) {
        super(int(_arg_1.@type));
        this.groundXML_ = _arg_1;
        var _local_2:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
        var _local_3:Camera = new Camera();
        _local_3.configure(0.5, 0.5, 12, (Math.PI / 4), new Rectangle(-100, -100, 200, 200));
        var _local_4:BitmapData = GroundLibrary.getBitmapData(type_);
        var _local_5:SquareFace = new SquareFace(_local_4, VIN, 0, 0, AnimateProperties.NO_ANIMATE, 0, 0);
        _local_5.draw(_local_2, _local_3, 0);
        this.tileShape_ = new Shape();
        this.tileShape_.graphics.drawGraphicsData(_local_2);
        this.tileShape_.scaleX = (this.tileShape_.scaleY = SCALE);
        this.tileShape_.x = (WIDTH / 2);
        this.tileShape_.y = (HEIGHT / 2);
        addChild(this.tileShape_);
    }

    override protected function getToolTip():ToolTip {
        return (new GroundTypeToolTip(this.groundXML_));
    }


}
}//package com.company.assembleegameclient.mapeditor
