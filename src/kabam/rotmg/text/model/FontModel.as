package kabam.rotmg.text.model {
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

public class FontModel {

    public static const MyriadPro:Class = FontModel_MyriadPro;
    public static const MyriadPro_Bold:Class = FontModel_MyriadPro_Bold;

    private var fontInfo:FontInfo;

    public function FontModel() {
        Font.registerFont(MyriadPro);
        Font.registerFont(MyriadPro_Bold);
        var _local_1:Font = new MyriadPro();
        this.fontInfo = new FontInfo();
        this.fontInfo.setName(_local_1.fontName);
    }

    public function getFont():FontInfo {
        return (this.fontInfo);
    }

    public function apply(_arg_1:TextField, _arg_2:int, _arg_3:uint, _arg_4:Boolean, _arg_5:Boolean = false):TextFormat {
        var _local_6:TextFormat = _arg_1.defaultTextFormat;
        _local_6.size = _arg_2;
        _local_6.color = _arg_3;
        _local_6.font = this.getFont().getName();
        _local_6.bold = _arg_4;
        if (_arg_5) {
            _local_6.align = "center";
        }
        _arg_1.defaultTextFormat = _local_6;
        _arg_1.setTextFormat(_local_6);
        return (_local_6);
    }

    public function getFormat(_arg_1:TextField, _arg_2:int, _arg_3:uint, _arg_4:Boolean):TextFormat {
        var _local_5:TextFormat = _arg_1.defaultTextFormat;
        _local_5.size = _arg_2;
        _local_5.color = _arg_3;
        _local_5.font = this.getFont().getName();
        _local_5.bold = _arg_4;
        return (_local_5);
    }


}
}//package kabam.rotmg.text.model
