package kabam.rotmg.pets.view.components {
import com.company.util.GraphicsUtil;

import flash.display.GraphicsPath;
import flash.display.GraphicsPathWinding;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.geom.ColorTransform;

public class FeedFuseArrow extends Sprite {

    private var designFill_:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
    private var designPath_:GraphicsPath = new GraphicsPath(
            new Vector.<int>(), new Vector.<Number>(), GraphicsPathWinding.NON_ZERO
    );
    private const designGraphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[
        designFill_, designPath_, GraphicsUtil.END_FILL
    ];

    public function FeedFuseArrow() {
        super();
        this.setColor(0x666666);
    }

    public function setColor(_arg_1:uint):void {
        graphics.clear();
        GraphicsUtil.clearPath(this.designPath_);
        this.designFill_.color = _arg_1;
        this.drawArrow();
        GraphicsUtil.drawRect(26, 11.5, 24, 19, this.designPath_);
        graphics.drawGraphicsData(this.designGraphicsData_);
    }

    public function highlight(_arg_1:Boolean):void {
        var _local_2:ColorTransform = transform.colorTransform;
        _local_2.color = ((_arg_1) ? 16777103 : 0x545454);
        transform.colorTransform = _local_2;
    }

    private function drawArrow():void {
        this.designPath_.moveTo(0, 20);
        this.designPath_.lineTo(26, 0);
        this.designPath_.lineTo(26, 40);
        this.designPath_.lineTo(0, 20);
        graphics.drawGraphicsData(this.designGraphicsData_);
    }


}
}//package kabam.rotmg.pets.view.components
