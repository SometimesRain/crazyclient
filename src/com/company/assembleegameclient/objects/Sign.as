package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.util.TextureRedrawer;

import flash.display.BitmapData;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.text.model.FontModel;

public class Sign extends GameObject {

    private var stringMap:StringMap;
    private var fontModel:FontModel;

    public function Sign(_arg_1:XML) {
        super(_arg_1);
        texture_ = null;
        this.stringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
        this.fontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
    }

    override protected function getTexture(_arg_1:Camera, _arg_2:int):BitmapData {
        if (texture_ != null) {
            return (texture_);
        }
        var _local_3:TextField = new TextField();
        _local_3.multiline = true;
        _local_3.wordWrap = false;
        _local_3.autoSize = TextFieldAutoSize.LEFT;
        _local_3.textColor = 0xFFFFFF;
        _local_3.embedFonts = true;
        var _local_4:TextFormat = new TextFormat();
        _local_4.align = TextFormatAlign.CENTER;
        _local_4.font = this.fontModel.getFont().getName();
        _local_4.size = 24;
        _local_4.color = 0xFFFFFF;
        _local_4.bold = true;
        _local_3.defaultTextFormat = _local_4;
        var _local_5:String = this.stringMap.getValue(this.stripCurlyBrackets(name_));
		if (_local_5 == null)
        {
			_local_5 = "null";
        }
        _local_3.text = _local_5.split("|").join("\n");
        var _local_6:BitmapData = new BitmapDataSpy(_local_3.width, _local_3.height, true, 0);
        _local_6.draw(_local_3);
        texture_ = TextureRedrawer.redraw(_local_6, size_, false, 0);
        return (texture_);
    }

    private function stripCurlyBrackets(_arg_1:String):String {
        var _local_2:Boolean = ((((!((_arg_1 == null))) && ((_arg_1.charAt(0) == "{")))) && ((_arg_1.charAt((_arg_1.length - 1)) == "}")));
        return (((_local_2) ? _arg_1.substr(1, (_arg_1.length - 2)) : _arg_1));
    }


}
}//package com.company.assembleegameclient.objects
