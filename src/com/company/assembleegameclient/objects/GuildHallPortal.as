package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.GuildHallPortalPanel;
import com.company.assembleegameclient.ui.panels.Panel;

public class GuildHallPortal extends GameObject implements IInteractiveObject {

    public function GuildHallPortal(_arg_1:XML) {
        super(_arg_1);
        isInteractive_ = true;
    }

    public function getPanel(_arg_1:GameSprite):Panel {
        return (new GuildHallPortalPanel(_arg_1, this));
    }


}
}//package com.company.assembleegameclient.objects
