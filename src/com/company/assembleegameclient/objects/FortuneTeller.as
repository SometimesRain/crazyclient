package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.map.Camera;

import flash.display.IGraphicsData;

import kabam.rotmg.fortune.services.FortuneModel;

public class FortuneTeller extends Character {

    public function FortuneTeller(_arg_1:XML) {
        super(_arg_1);
    }

    override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        if (FortuneModel.HAS_FORTUNES) {
            super.draw(_arg_1, _arg_2, _arg_3);
        }
    }

    override public function drawShadow(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        if (FortuneModel.HAS_FORTUNES) {
            super.drawShadow(_arg_1, _arg_2, _arg_3);
        }
    }


}
}//package com.company.assembleegameclient.objects
