package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;

import kabam.rotmg.questrewards.view.QuestRewardsPanel;

public class QuestRewards extends GameObject implements IInteractiveObject {

    public function QuestRewards(_arg_1:XML) {
        super(_arg_1);
        isInteractive_ = true;
    }

    public function getPanel(_arg_1:GameSprite):Panel {
        return (new QuestRewardsPanel(_arg_1));
    }


}
}//package com.company.assembleegameclient.objects
