package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.ui.panels.ArenaPortalPanel;
import com.company.assembleegameclient.ui.panels.Panel;

import flash.display.BitmapData;
import flash.display.IGraphicsData;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class ArenaPortal extends Portal implements IInteractiveObject {

    public function ArenaPortal(_arg_1:XML) {
        super(_arg_1);
        isInteractive_ = true;
        name_ = "";
    }

    override public function getPanel(_arg_1:GameSprite):Panel {
        return (new ArenaPortalPanel(_arg_1, this));
    }

    override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        super.draw(_arg_1, _arg_2, _arg_3);
        drawName(_arg_1, _arg_2);
    }

    override protected function makeNameBitmapData():BitmapData {
        var _local_1:StringBuilder = new StaticStringBuilder(name_);
        var _local_2:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
        return (_local_2.make(_local_1, 16, 0xFFFFFF, true, IDENTITY_MATRIX, true));
    }


}
}//package com.company.assembleegameclient.objects
