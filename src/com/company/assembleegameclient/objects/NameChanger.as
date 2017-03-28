package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;

import kabam.rotmg.game.view.NameChangerPanel;

public class NameChanger extends GameObject implements IInteractiveObject {

    public var rankRequired_:int = 0;

    public function NameChanger(_arg_1:XML) {
        super(_arg_1);
        isInteractive_ = true;
    }

    public function setRankRequired(_arg_1:int):void {
        this.rankRequired_ = _arg_1;
    }

    public function getPanel(_arg_1:GameSprite):Panel {
        return (new NameChangerPanel(_arg_1, this.rankRequired_));
    }


}
}//package com.company.assembleegameclient.objects
