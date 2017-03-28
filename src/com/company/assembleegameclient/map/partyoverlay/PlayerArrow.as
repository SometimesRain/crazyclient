package com.company.assembleegameclient.map.partyoverlay {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.menu.Menu;
import com.company.assembleegameclient.ui.menu.PlayerGroupMenu;
import com.company.assembleegameclient.ui.tooltip.PlayerGroupToolTip;

import flash.events.MouseEvent;

public class PlayerArrow extends GameObjectArrow {

    public function PlayerArrow() {
        super(0xFFFFFF, 4179794, false);
    }

    override protected function onMouseOver(_arg_1:MouseEvent):void {
        super.onMouseOver(_arg_1);
        setToolTip(new PlayerGroupToolTip(this.getFullPlayerVec(), false));
    }

    override protected function onMouseOut(_arg_1:MouseEvent):void {
        super.onMouseOut(_arg_1);
        setToolTip(null);
    }

    override protected function onMouseDown(_arg_1:MouseEvent):void {
        super.onMouseDown(_arg_1);
        removeMenu();
        setMenu(this.getMenu());
    }

    protected function getMenu():Menu {
        var _local_1:Player = (go_ as Player);
        if ((((_local_1 == null)) || ((_local_1.map_ == null)))) {
            return (null);
        }
        var _local_2:Player = _local_1.map_.player_;
        if (_local_2 == null) {
            return (null);
        }
        return (new PlayerGroupMenu(_local_1.map_, this.getFullPlayerVec()));
    }

    private function getFullPlayerVec():Vector.<Player> {
        var _local_2:GameObject;
        var _local_1:Vector.<Player> = new <Player>[(go_ as Player)];
        for each (_local_2 in extraGOs_) {
            _local_1.push((_local_2 as Player));
        }
        return (_local_1);
    }


}
}//package com.company.assembleegameclient.map.partyoverlay
