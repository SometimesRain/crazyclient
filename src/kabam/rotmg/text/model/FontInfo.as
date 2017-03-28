package kabam.rotmg.text.model {
import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class FontInfo {

    private static const renderingFontSize:Number = 200;
    private static const GUTTER:Number = 2;

    protected var name:String;
    private var textColor:uint = 0;
    private var xHeightRatio:Number;
    private var verticalSpaceRatio:Number;


    public function setName(_arg_1:String):void {
        this.name = _arg_1;
        this.computeRatiosByRendering();
    }

    public function getName():String {
        return (this.name);
    }

    public function getXHeight(_arg_1:Number):Number {
        return ((this.xHeightRatio * _arg_1));
    }

    public function getVerticalSpace(_arg_1:Number):Number {
        return ((this.verticalSpaceRatio * _arg_1));
    }

    private function computeRatiosByRendering():void {
        var _local_1:TextField = this.makeTextField();
        var _local_2:BitmapData = new BitmapDataSpy(_local_1.width, _local_1.height);
        _local_2.draw(_local_1);
        var _local_3:uint = 0xFFFFFF;
        var _local_4:Rectangle = _local_2.getColorBoundsRect(_local_3, this.textColor, true);
        this.xHeightRatio = this.deNormalize(_local_4.height);
        this.verticalSpaceRatio = this.deNormalize(((_local_1.height - _local_4.bottom) - GUTTER));
    }

    private function makeTextField():TextField {
        var _local_1:TextField = new TextField();
        _local_1.autoSize = TextFieldAutoSize.LEFT;
        _local_1.text = "x";
        _local_1.textColor = this.textColor;
        _local_1.setTextFormat(new TextFormat(this.name, renderingFontSize));
        return (_local_1);
    }

    private function deNormalize(_arg_1:Number):Number {
        return ((_arg_1 / renderingFontSize));
    }


}
}//package kabam.rotmg.text.model
