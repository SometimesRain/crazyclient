package com.company.assembleegameclient.ui.options {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.MoreColorUtil;

import flash.events.Event;

import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class ChoiceOption extends BaseOption {

    private var callback_:Function;
    private var choiceBox_:ChoiceBox;
    private var color:Number = 0xFFFFFF;
    private var showRed:Boolean = false;

    public function ChoiceOption(_arg_1:String, _arg_2:Vector.<StringBuilder>, _arg_3:Array, _arg_4:String, _arg_5:String, _arg_6:Function, _arg_7:Number = 0xFFFFFF, showRed_:Boolean = false) {
        super(_arg_1, _arg_4, _arg_5);
		color = _arg_7;
		this.showRed = showRed_;
        desc_.setColor(color);
        tooltip_.tipText_.setColor(0xFFFFFF); //color
        this.callback_ = _arg_6;
        this.choiceBox_ = new ChoiceBox(_arg_2, _arg_3, Parameters.data_[paramName_], color, showRed);
        this.choiceBox_.addEventListener(Event.CHANGE, this.onChange);
        addChild(this.choiceBox_);
    }
      
    public function enable(param1:Boolean) : void
    {
        transform.colorTransform = param1 ? MoreColorUtil.darkCT : MoreColorUtil.identity;
        mouseEnabled = !param1;
		mouseChildren = !param1;
    }

    override public function refresh():void {
        this.choiceBox_.setValue(Parameters.data_[paramName_]);
    }

    public function refreshNoCallback():void {
        this.choiceBox_.setValue(Parameters.data_[paramName_], false);
    }

    private function onChange(_arg_1:Event):void {
		if (showRed) {
			color = color == 0xFFFFFF ? 0xFF0000 : 0xFFFFFF; //color hack
			desc_.setColor(color);
		}
        Parameters.data_[paramName_] = this.choiceBox_.value();
        if (this.callback_ != null) {
            this.callback_();
        }
        Parameters.save();
    }


}
}//package com.company.assembleegameclient.ui.options
