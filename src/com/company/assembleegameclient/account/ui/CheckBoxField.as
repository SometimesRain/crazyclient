package com.company.assembleegameclient.account.ui {
import flash.display.CapsStyle;
import flash.display.Graphics;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class CheckBoxField extends Sprite {

    private static const BOX_SIZE:int = 20;

    public var checkBox_:Sprite;
    public var text_:TextFieldDisplayConcrete;
    public var errorText_:TextFieldDisplayConcrete;
    private var checked_:Boolean;
    private var hasError:Boolean;

    public function CheckBoxField(_arg_1:String, _arg_2:Boolean, _arg_3:uint = 16) {
        this.checked_ = _arg_2;
        this.checkBox_ = new Sprite();
        this.checkBox_.x = 2;
        this.checkBox_.y = 2;
        this.redrawCheckBox();
        this.checkBox_.addEventListener(MouseEvent.CLICK, this.onClick);
        addChild(this.checkBox_);
        this.text_ = new TextFieldDisplayConcrete().setSize(_arg_3).setColor(0xB3B3B3);
        this.text_.setTextWidth(243);
        this.text_.x = ((this.checkBox_.x + BOX_SIZE) + 8);
        this.text_.setBold(true);
        this.text_.setMultiLine(true);
        this.text_.setWordWrap(true);
        this.text_.setHTML(true);
        this.text_.setStringBuilder(new LineBuilder().setParams(_arg_1));
        this.text_.mouseEnabled = true;
        this.text_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.text_);
        this.errorText_ = new TextFieldDisplayConcrete().setSize(12).setColor(16549442);
        this.errorText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.errorText_);
        this.text_.textChanged.addOnce(this.onTextChanged);
    }

    public function isChecked():Boolean {
        return (this.checked_);
    }

    public function setChecked():void
    {
        this.checked_ = true;
        this.redrawCheckBox();
    }

    public function setUnchecked():void
    {
        this.checked_ = false;
        this.redrawCheckBox();
    }

    public function setError(_arg_1:String):void {
        this.errorText_.setStringBuilder(new LineBuilder().setParams(_arg_1));
    }

    public function setTextStringBuilder(_arg_1:StringBuilder):void {
        this.text_.setStringBuilder(_arg_1);
    }

    private function onTextChanged():void {
        this.errorText_.x = this.text_.x;
        this.errorText_.y = (this.text_.y + 20);
    }

    private function onClick(_arg_1:MouseEvent):void {
        this.errorText_.setStringBuilder(new StaticStringBuilder(""));
        this.checked_ = !(this.checked_);
        this.redrawCheckBox();
    }

    public function setErrorHighlight(_arg_1:Boolean):void {
        this.hasError = _arg_1;
        this.redrawCheckBox();
    }

    private function redrawCheckBox():void {
        var _local_2:Number;
        var _local_1:Graphics = this.checkBox_.graphics;
        _local_1.clear();
        _local_1.beginFill(0x333333, 1);
        _local_1.drawRect(0, 0, BOX_SIZE, BOX_SIZE);
        _local_1.endFill();
        if (this.checked_) {
            _local_1.lineStyle(4, 0xB3B3B3, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND);
            _local_1.moveTo(2, 2);
            _local_1.lineTo((BOX_SIZE - 2), (BOX_SIZE - 2));
            _local_1.moveTo(2, (BOX_SIZE - 2));
            _local_1.lineTo((BOX_SIZE - 2), 2);
            _local_1.lineStyle();
            this.hasError = false;
        }
        if (this.hasError) {
            _local_2 = 16549442;
        }
        else {
            _local_2 = 0x454545;
        }
        _local_1.lineStyle(2, _local_2, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND);
        _local_1.drawRect(0, 0, BOX_SIZE, BOX_SIZE);
        _local_1.lineStyle();
    }


}
}//package com.company.assembleegameclient.account.ui
