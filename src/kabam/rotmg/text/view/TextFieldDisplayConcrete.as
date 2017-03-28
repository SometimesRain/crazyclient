package kabam.rotmg.text.view {
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextLineMetrics;

import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.text.model.FontInfo;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

import org.osflash.signals.Signal;

public class TextFieldDisplayConcrete extends Sprite implements TextFieldDisplay {

    public static const MIDDLE:String = "middle";
    public static const BOTTOM:String = "bottom";
    private static const GUTTER:int = 2;

    public const textChanged:Signal = new Signal();

    public var textField:TextField;
    private var stringMap:StringMap;
    private var stringBuilder:StringBuilder;
    private var size:int = 12;
    private var color:uint;
    private var font:FontInfo;
    private var bold:Boolean;
    private var autoSize:String = "left";
    private var horizontalAlign:String = "left";
    private var verticalAlign:String;
    private var multiline:Boolean;
    private var wordWrap:Boolean;
    private var textWidth:Number = 0;
    private var textHeight:Number = 0;
    private var html:Boolean;
    private var displayAsPassword:Boolean;
    private var debugName:String;
    private var leftMargin:int = 0;
    private var indent:int = 0;
    private var leading:int = 0;


    private static function getOnlyTextHeight(_arg_1:TextLineMetrics):Number {
        return ((_arg_1.height - _arg_1.leading));
    }


    public function setIndent(_arg_1:int):TextFieldDisplayConcrete {
        this.indent = _arg_1;
        this.setPropertiesIfHasTextField();
        return (this);
    }

    public function setLeading(_arg_1:int):TextFieldDisplayConcrete {
        this.leading = _arg_1;
        this.setPropertiesIfHasTextField();
        return (this);
    }

    public function setLeftMargin(_arg_1:int):TextFieldDisplayConcrete {
        this.leftMargin = _arg_1;
        this.setPropertiesIfHasTextField();
        return (this);
    }

    public function setDisplayAsPassword(_arg_1:Boolean):TextFieldDisplayConcrete {
        this.displayAsPassword = _arg_1;
        this.setPropertiesIfHasTextField();
        return (this);
    }

    public function setDebugName(_arg_1:String):TextFieldDisplayConcrete {
        this.debugName = _arg_1;
        ((this.textField) && ((this.textField.name = this.debugName)));
        return (this);
    }

    public function setSize(_arg_1:int):TextFieldDisplayConcrete {
        this.size = _arg_1;
        this.setPropertiesIfHasTextField();
        return (this);
    }

    public function setColor(_arg_1:uint):TextFieldDisplayConcrete {
        this.color = _arg_1;
        this.setPropertiesIfHasTextField();
        return (this);
    }

    public function setBold(_arg_1:Boolean):TextFieldDisplayConcrete {
        this.bold = _arg_1;
        this.setPropertiesIfHasTextField();
        return (this);
    }

    public function setHorizontalAlign(_arg_1:String):TextFieldDisplayConcrete {
        this.horizontalAlign = _arg_1;
        this.setPropertiesIfHasTextField();
        return (this);
    }

    public function setAutoSize(_arg_1:String):TextFieldDisplayConcrete {
        this.autoSize = _arg_1;
        this.setPropertiesIfHasTextField();
        return (this);
    }

    public function setMultiLine(_arg_1:Boolean):TextFieldDisplayConcrete {
        this.multiline = _arg_1;
        this.setPropertiesIfHasTextField();
        return (this);
    }

    public function setWordWrap(_arg_1:Boolean):TextFieldDisplayConcrete {
        this.wordWrap = _arg_1;
        this.setPropertiesIfHasTextField();
        return (this);
    }

    public function setTextWidth(_arg_1:Number):TextFieldDisplayConcrete {
        this.textWidth = _arg_1;
        this.setPropertiesIfHasTextField();
        return (this);
    }

    public function setTextHeight(_arg_1:Number):TextFieldDisplayConcrete {
        this.textHeight = _arg_1;
        this.setPropertiesIfHasTextField();
        return (this);
    }

    public function setHTML(_arg_1:Boolean):TextFieldDisplayConcrete {
        this.html = _arg_1;
        return (this);
    }

    public function setStringBuilder(_arg_1:StringBuilder):TextFieldDisplayConcrete {
        this.stringBuilder = _arg_1;
        this.setTextIfAble();
        return (this);
    }

    public function getStringBuilder():StringBuilder {
        return (this.stringBuilder);
    }

    public function setPosition(_arg_1:Number, _arg_2:Number):TextFieldDisplayConcrete {
        this.x = _arg_1;
        this.y = _arg_2;
        return (this);
    }

    public function setVerticalAlign(_arg_1:String):TextFieldDisplayConcrete {
        this.verticalAlign = _arg_1;
        return (this);
    }

    public function update():void {
        this.setTextIfAble();
    }

    public function setFont(_arg_1:FontInfo):void {
        this.font = _arg_1;
    }

    public function setStringMap(_arg_1:StringMap):void {
        this.stringMap = _arg_1;
        this.setTextIfAble();
    }

    public function setTextField(_arg_1:TextField):void {
        _arg_1.width = this.textWidth;
        _arg_1.height = this.textHeight;
        ((this.debugName) && ((_arg_1.name = this.debugName)));
        this.updateTextOfInjectedTextField(_arg_1);
        this.textField = _arg_1;
        this.setProperties();
        addChild(this.textField);
    }

    private function setPropertiesIfHasTextField():void {
        if (this.textField) {
            this.setProperties();
        }
    }

    private function setProperties():void {
        this.setFormatProperties();
        this.setTextFieldProperties();
    }

    private function setTextFieldProperties():void {
        if (this.textWidth != 0) {
            this.textField.width = this.textWidth;
        }
        if (this.textHeight != 0) {
            this.textField.height = this.textHeight;
        }
        this.textField.selectable = false;
        this.textField.textColor = this.color;
        this.textField.autoSize = this.autoSize;
        this.textField.multiline = this.multiline;
        this.textField.wordWrap = this.wordWrap;
        this.textField.displayAsPassword = this.displayAsPassword;
        this.textField.embedFonts = true;
    }

    private function setFormatProperties():void {
        var _local_1:TextFormat = new TextFormat();
        _local_1.size = this.size;
        _local_1.font = this.font.getName();
        _local_1.bold = this.bold;
        _local_1.align = this.horizontalAlign;
        _local_1.leftMargin = this.leftMargin;
        _local_1.indent = this.indent;
        _local_1.leading = this.leading;
        this.setTextFormat(_local_1);
    }

    private function updateTextOfInjectedTextField(_arg_1:TextField):void {
        if (this.textField) {
            _arg_1.text = this.textField.text;
            removeChild(this.textField);
        }
    }

    private function setTextIfAble():void {
        var _local_1:String;
        if (this.isAble()) {
            this.stringBuilder.setStringMap(this.stringMap);
            _local_1 = this.stringBuilder.getString();
            this.setText(_local_1);
            this.alignVertically();
            this.invalidateTextField();
            this.textChanged.dispatch();
        }
    }

    private function invalidateTextField():void {
        this.textField.height;
    }

    public function setText(_arg_1:String):void {
        if (this.html) {
            this.textField.htmlText = _arg_1;
        }
        else {
            this.textField.text = _arg_1;
        }
    }

    private function alignVertically():void {
        var _local_1:TextLineMetrics;
        if (this.verticalAlign == MIDDLE) {
            this.setYToMiddle();
        }
        else {
            if (this.verticalAlign == BOTTOM) {
                _local_1 = this.textField.getLineMetrics(0);
                this.textField.y = -(getOnlyTextHeight(_local_1));
            }
        }
    }

    public function getTextHeight():Number
    {
        return this.textField ? Number(this.textField.height) : Number(0);
    }

    private function setYToMiddle():void {
        this.textField.height;
        var _local_1:TextFormat = this.textField.getTextFormat();
        var _local_2:Number = this.getSpecificXHeight(_local_1);
        var _local_3:Number = this.getSpecificVerticalSpace(_local_1);
        this.textField.y = -((this.textField.height - (((_local_2 / 2) + _local_3) + GUTTER)));
    }

    private function getSpecificXHeight(_arg_1:TextFormat):Number {
        return (this.font.getXHeight(Number(_arg_1.size)));
    }

    private function getSpecificVerticalSpace(_arg_1:TextFormat):Number {
        return (this.font.getVerticalSpace(Number(_arg_1.size)));
    }

    public function setTextFormat(_arg_1:TextFormat, _arg_2:int = -1, _arg_3:int = -1):void {
        this.textField.defaultTextFormat = _arg_1;
        this.textField.setTextFormat(_arg_1, _arg_2, _arg_3);
    }

    private function isAble():Boolean {
        return (((((this.stringMap) && (this.stringBuilder))) && (this.textField)));
    }

    public function getVerticalSpace():Number {
        return (this.font.getVerticalSpace(Number(this.textField.getTextFormat().size)));
    }

    public function getText():String {
        return (((this.textField) ? this.textField.text : "null"));
    }

    public function getColor():uint {
        return (this.color);
    }

    public function getSize():int {
        return (this.size);
    }

    public function hasTextField():Boolean {
        return (!((this.textField == null)));
    }

    public function hasStringMap():Boolean {
        return (!((this.stringMap == null)));
    }

    public function hasFont():Boolean {
        return (!((this.font == null)));
    }

    public function getTextFormat(_arg_1:int = -1, _arg_2:int = -1):TextFormat {
        return (this.textField.getTextFormat(_arg_1, _arg_2));
    }


}
}//package kabam.rotmg.text.view
