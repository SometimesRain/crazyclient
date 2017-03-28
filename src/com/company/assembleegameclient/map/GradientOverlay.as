package com.company.assembleegameclient.map {
import com.company.util.GraphicsUtil;

import flash.display.GradientType;
import flash.display.GraphicsGradientFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.display.Shape;

public class GradientOverlay extends Shape {

    private const gradientFill_:GraphicsGradientFill = new GraphicsGradientFill(GradientType.LINEAR, [0, 0], [0, 1], [0, 0xFF], GraphicsUtil.getGradientMatrix(10, 600));
    private const gradientPath_:GraphicsPath = GraphicsUtil.getRectPath(0, 0, 10, 600);
    private const gradientGraphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[gradientFill_, gradientPath_, GraphicsUtil.END_FILL];

    public function GradientOverlay() {
        //graphics.drawGraphicsData(this.gradientGraphicsData_);
        visible = false;
    }

}
}//package com.company.assembleegameclient.map
