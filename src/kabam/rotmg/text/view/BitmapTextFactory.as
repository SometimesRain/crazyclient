package kabam.rotmg.text.view {
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.model.TextAndMapProvider;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class BitmapTextFactory {

    private const glowFilter:GlowFilter = new GlowFilter(0, 1, 3, 3, 2, 1);
    private const spclFilter:GlowFilter = new GlowFilter(0xffffff, 1, 3, 3, 2, 1);

    public var padding:int = 0;
    private var textfield:TextFieldDisplayConcrete;

    public function BitmapTextFactory(_arg_1:FontModel, _arg_2:TextAndMapProvider) {
        this.textfield = new TextFieldDisplayConcrete();
        this.textfield.setFont(_arg_1.getFont());
        this.textfield.setTextField(_arg_2.getTextField());
        this.textfield.setStringMap(_arg_2.getStringMap());
    }

    public function make(_arg_1:StringBuilder, _arg_2:int, _arg_3:uint, _arg_4:Boolean, _arg_5:Matrix, _arg_6:Boolean, spcl:Boolean = false):BitmapData {
        this.configureTextfield(_arg_2, _arg_3, _arg_4, _arg_1);
        return (this.makeBitmapData(_arg_6, _arg_5, spcl));
    }

    private function configureTextfield(_arg_1:int, _arg_2:uint, _arg_3:Boolean, _arg_4:StringBuilder):void {
        this.textfield.setSize(_arg_1).setColor(_arg_2).setBold(_arg_3).setAutoSize(TextFieldAutoSize.LEFT);
        this.textfield.setStringBuilder(_arg_4);
    }

    private function makeBitmapData(_arg_1:Boolean, _arg_2:Matrix, spcl:Boolean):BitmapData {
        var _local_3:int = ((this.textfield.width + this.padding) + _arg_2.tx);
        var _local_4:int = (this.textfield.height + this.padding);
        var _local_5:BitmapData = new BitmapDataSpy(_local_3, _local_4, true, 0);
        _local_5.draw(this.textfield, _arg_2);
		if (spcl) {
			((_arg_1) && (_local_5.applyFilter(_local_5, _local_5.rect, PointUtil.ORIGIN, this.spclFilter)));
		}
		else {
			((_arg_1) && (_local_5.applyFilter(_local_5, _local_5.rect, PointUtil.ORIGIN, this.glowFilter)));
		}
		//trace("BMP_HEIGHT",_local_5.height);
        return (_local_5);
    }


}
}//package kabam.rotmg.text.view
