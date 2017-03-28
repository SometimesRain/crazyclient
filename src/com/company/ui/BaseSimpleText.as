package com.company.ui {
import flash.events.Event;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextLineMetrics;

public class BaseSimpleText extends TextField {

    public static const MyriadPro:Class = BaseSimpleText_MyriadPro;

    public var inputWidth_:int;
    public var inputHeight_:int;
    public var actualWidth_:int;
    public var actualHeight_:int;

    public function BaseSimpleText(_arg_1:int, _arg_2:uint, _arg_3:Boolean = false, _arg_4:int = 0, _arg_5:int = 0) {
        this.inputWidth_ = _arg_4;
        if (this.inputWidth_ != 0) {
            width = _arg_4;
        }
        this.inputHeight_ = _arg_5;
        if (this.inputHeight_ != 0) {
            height = _arg_5;
        }
        Font.registerFont(MyriadPro);
        var _local_6:Font = new MyriadPro();
        var _local_7:TextFormat = this.defaultTextFormat;
        _local_7.font = _local_6.fontName;
        _local_7.bold = false;
        _local_7.size = _arg_1;
        _local_7.color = _arg_2;
        defaultTextFormat = _local_7;
        if (_arg_3) {
            selectable = true;
            mouseEnabled = true;
            type = TextFieldType.INPUT;
            embedFonts = true;
            border = true;
            borderColor = _arg_2;
            setTextFormat(_local_7);
            addEventListener(Event.CHANGE, this.onChange);
        }
        else {
            selectable = false;
            mouseEnabled = false;
        }
    }

    public function setFont(_arg_1:String):void {
        var _local_2:TextFormat = defaultTextFormat;
        _local_2.font = _arg_1;
        defaultTextFormat = _local_2;
    }

    public function setSize(_arg_1:int):void {
        var _local_2:TextFormat = defaultTextFormat;
        _local_2.size = _arg_1;
        this.applyFormat(_local_2);
    }

    public function setColor(_arg_1:uint):void {
        var _local_2:TextFormat = defaultTextFormat;
        _local_2.color = _arg_1;
        this.applyFormat(_local_2);
    }

    public function setBold(_arg_1:Boolean):void {
        var _local_2:TextFormat = defaultTextFormat;
        _local_2.bold = _arg_1;
        this.applyFormat(_local_2);
    }

    public function setAlignment(_arg_1:String):void {
        var _local_2:TextFormat = defaultTextFormat;
        _local_2.align = _arg_1;
        this.applyFormat(_local_2);
    }

    public function setText(_arg_1:String):void {
        this.text = _arg_1;
    }

    public function setMultiLine(_arg_1:Boolean):void
    {
        multiline = _arg_1;
        wordWrap = _arg_1;
    }

    private function applyFormat(_arg_1:TextFormat):void {
        setTextFormat(_arg_1);
        defaultTextFormat = _arg_1;
    }

    private function onChange(_arg_1:Event):void {
        this.updateMetrics();
    }

    public function updateMetrics():void {
        var _local_2:TextLineMetrics;
        var _local_3:int;
        var _local_4:int;
        this.actualWidth_ = 0;
        this.actualHeight_ = 0;
        var _local_1:int;
        while (_local_1 < numLines) {
            _local_2 = getLineMetrics(_local_1);
            _local_3 = (_local_2.width + 4);
            _local_4 = (_local_2.height + 4);
            if (_local_3 > this.actualWidth_) {
                this.actualWidth_ = _local_3;
            }
            this.actualHeight_ = (this.actualHeight_ + _local_4);
            _local_1++;
        }
        width = (((this.inputWidth_) == 0) ? this.actualWidth_ : this.inputWidth_);
        height = (((this.inputHeight_) == 0) ? this.actualHeight_ : this.inputHeight_);
    }

    public function useTextDimensions():void {
        width = (((this.inputWidth_) == 0) ? (textWidth + 4) : this.inputWidth_);
        height = (((this.inputHeight_) == 0) ? (textHeight + 4) : this.inputHeight_);
    }


}
}//package com.company.ui
