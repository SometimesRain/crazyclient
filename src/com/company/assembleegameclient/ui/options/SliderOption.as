package com.company.assembleegameclient.ui.options {
import com.company.assembleegameclient.parameters.Parameters;

import flash.events.Event;

public class SliderOption extends BaseOption {

    private var sliderBar:VolumeSliderBar;
    private var disabled_:Boolean;
    private var callbackFunc:Function;

    public function SliderOption(_arg_1:String, _arg_2:Function = null, _arg_3:Boolean = false) {
        super(_arg_1, "", "");
        this.sliderBar = new VolumeSliderBar(Parameters.data_[paramName_]);
        this.sliderBar.addEventListener(Event.CHANGE, this.onChange);
        this.callbackFunc = _arg_2;
        addChild(this.sliderBar);
        this.setDisabled(_arg_3);
    }

    public function setDisabled(_arg_1:Boolean):void {
        this.disabled_ = _arg_1;
        mouseEnabled = !(this.disabled_);
        mouseChildren = !(this.disabled_);
    }

    override public function refresh():void {
        this.sliderBar.currentVolume = Parameters.data_[paramName_];
    }

    private function onChange(_arg_1:Event):void {
        Parameters.data_[paramName_] = this.sliderBar.currentVolume;
        if (this.callbackFunc != null) {
            this.callbackFunc(this.sliderBar.currentVolume);
        }
        Parameters.save();
    }


}
}//package com.company.assembleegameclient.ui.options
