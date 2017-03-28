package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;

import kabam.rotmg.game.view.MoneyChangerPanel;

public class MoneyChanger extends GameObject implements IInteractiveObject {

    public function MoneyChanger(_arg_1:XML) {
        super(_arg_1);
        isInteractive_ = true;
    }

    public function getPanel(_arg_1:GameSprite):Panel {
        return (new MoneyChangerPanel(_arg_1));
    }


}
}//package com.company.assembleegameclient.objects
