package com.company.assembleegameclient.account.ui {
import com.company.ui.BaseSimpleText;

import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class TextInputField extends Sprite {

    public static const BACKGROUND_COLOR:uint = 0x333333;
    public static const ERROR_BORDER_COLOR:uint = 0xFC8642;
    public static const NORMAL_BORDER_COLOR:uint = 0x454545;

    public var nameText_:TextFieldDisplayConcrete;
    public var inputText_:BaseSimpleText;
    public var errorText_:TextFieldDisplayConcrete;
    private var textInputFieldWidth:int = 0;

    public function TextInputField(_arg_1:String, _arg_2:Boolean = false, _arg_3:Number = 238, _arg_4:Number = 30, _arg_5:Number = 18, _arg_6:int = -1, _arg_7:Boolean = false)
    {
        this.textInputFieldWidth = this.textInputFieldWidth;
        this.nameText_ = new TextFieldDisplayConcrete().setSize(18).setColor(0xB3B3B3);
        this.inputText_ = new BaseSimpleText(_arg_5, 0xB3B3B3, true, _arg_3, _arg_4);
        if(_arg_1 != "")
        {
            this.nameText_.setBold(true);
            this.nameText_.setStringBuilder(new LineBuilder().setParams(_arg_1));
            this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
            addChild(this.nameText_);
            this.inputText_.y = 30;
        }
        else
        {
            this.inputText_.y = 0;
        }
        if(this.textInputFieldWidth != 0)
        {
            this.nameText_.setTextWidth(this.textInputFieldWidth);
            this.nameText_.setMultiLine(true);
            this.nameText_.setWordWrap(true);
            this.nameText_.textChanged.add(this.textFieldWasCreatedHandler);
        }
        this.nameText_.setBold(true);
        this.nameText_.setStringBuilder(new LineBuilder().setParams(_arg_1));
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.nameText_);
        this.inputText_ = new BaseSimpleText(20, 0xB3B3B3, true, 238, 30);
        this.inputText_.y = 30;
        this.inputText_.x = 6;
        this.inputText_.border = false;
        this.inputText_.displayAsPassword = _arg_2;
        this.inputText_.updateMetrics();
        this.inputText_.setMultiLine(_arg_7);
        if(_arg_6 > 1)
        {
            this.inputText_.maxChars = _arg_6;
        }
        addChild(this.inputText_);
        graphics.lineStyle(2, 0x454545, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND);
        graphics.beginFill(0x333333, 1);
        graphics.drawRect(0, this.inputText_.y, _arg_3, _arg_4);
        graphics.endFill();
        graphics.lineStyle();
        this.drawInputBorders(false);
        this.inputText_.addEventListener(Event.CHANGE, this.onInputChange);
        this.errorText_ = new TextFieldDisplayConcrete().setSize(12).setColor(16549442);
        this.errorText_.setMultiLine(true);
        this.errorText_.y = this.inputText_.y + _arg_4 + 1;
        this.errorText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.errorText_);
    }

    public function text():String {
        return (this.inputText_.text);
    }

    public function clearText():void {
        this.inputText_.text = "";
    }

    override public function get height() : Number
    {
        return this.errorText_.y + this.errorText_.height + 10;
    }

    private function drawInputBorders(_arg_1:Boolean):void
    {
        var _local_2:uint = _arg_1 ? ERROR_BORDER_COLOR : NORMAL_BORDER_COLOR;
        graphics.clear();
        graphics.lineStyle(2, _local_2, 1, false,LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND);
        graphics.beginFill(BACKGROUND_COLOR, 1);
        graphics.drawRect(0, this.inputText_.y, 238, 30);
        graphics.endFill();
        graphics.lineStyle();
    }

    public function setErrorHighlight(_arg_1:Boolean):void
    {
        this.drawInputBorders(_arg_1);
    }

    private function textFieldWasCreatedHandler():void
    {
        if(this.textInputFieldWidth != 0)
        {
            this.inputText_.y = this.nameText_.getTextHeight() + 8;
            this.drawInputBorders(false);
        }
    }

    public function onInputChange(_arg_1:Event):void
    {
        this.errorText_.setStringBuilder(new StaticStringBuilder(""));
    }

    public function setError(_arg_1:String, _arg_2:Object = null):void {
        this.errorText_.setStringBuilder(new LineBuilder().setParams(_arg_1, _arg_2));
        this.inputText_.addEventListener(Event.CHANGE, this.onClearError);
    }

    public function onClearError(_arg_1:Event):void {
        this.inputText_.removeEventListener(Event.CHANGE, this.onClearError);
        this.clearError();
    }

    public function clearError():void {
        this.errorText_.setStringBuilder(new StaticStringBuilder(""));
    }


}
}//package com.company.assembleegameclient.account.ui
