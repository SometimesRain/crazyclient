package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import kabam.rotmg.pets.view.components.YardUpgraderPanel;
import kabam.rotmg.text.model.TextKey;

public class YardUpgrader extends GameObject implements IInteractiveObject {

    public function YardUpgrader(_arg_1:XML) {
        super(_arg_1);
        isInteractive_ = true;
    }

    public function getTooltip():ToolTip {
        return (new TextToolTip(0x363636, 0x9B9B9B, TextKey.CLOSEDGIFTCHEST_TITLE, TextKey.TEXTPANEL_GIFTCHESTISEMPTY, 200));
    }

    public function getPanel(_arg_1:GameSprite):Panel {
        return (new YardUpgraderPanel(_arg_1, objectType_));
    }


}
}//package com.company.assembleegameclient.objects
