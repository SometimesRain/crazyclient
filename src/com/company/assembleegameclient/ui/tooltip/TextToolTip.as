package com.company.assembleegameclient.ui.tooltip {
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class TextToolTip extends ToolTip {

    public var titleText_:TextFieldDisplayConcrete;
    public var tipText_:TextFieldDisplayConcrete;

    public function TextToolTip(_arg_1:uint, _arg_2:uint, _arg_3:String, _arg_4:String, _arg_5:int, _arg_6:Object = null) {
        super(_arg_1, 1, _arg_2, 1);
        if (_arg_3 != null) {
            this.titleText_ = new TextFieldDisplayConcrete().setSize(20).setColor(0xFFFFFF);
            this.configureTextFieldDisplayAndAddChild(this.titleText_, _arg_5, _arg_3);
        }
        if (_arg_4 != null) {
            this.tipText_ = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3);
            this.configureTextFieldDisplayAndAddChild(this.tipText_, _arg_5, _arg_4, _arg_6);
        }
    }

    override protected function alignUI():void {
        this.tipText_.y = ((this.titleText_) ? (this.titleText_.height + 8) : 0);
    }

    public function configureTextFieldDisplayAndAddChild(_arg_1:TextFieldDisplayConcrete, _arg_2:int, _arg_3:String, _arg_4:Object = null):void {
        _arg_1.setAutoSize(TextFieldAutoSize.LEFT);
        _arg_1.setWordWrap(true).setTextWidth(_arg_2);
        _arg_1.setStringBuilder(new LineBuilder().setParams(_arg_3, _arg_4));
        _arg_1.filters = [new DropShadowFilter(0, 0, 0)];
        waiter.push(_arg_1.textChanged);
        addChild(_arg_1);
    }

    public function setTitle(_arg_1:StringBuilder):void {
        this.titleText_.setStringBuilder(_arg_1);
        draw();
    }

    public function setText(_arg_1:StringBuilder):void {
        this.tipText_.setStringBuilder(_arg_1);
        draw();
    }


}
}//package com.company.assembleegameclient.ui.tooltip
