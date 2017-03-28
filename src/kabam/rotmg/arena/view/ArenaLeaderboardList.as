package kabam.rotmg.arena.view {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.lib.ui.api.Size;
import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
import kabam.rotmg.util.components.VerticalScrollingList;

public class ArenaLeaderboardList extends Sprite {

    private const MAX_SIZE:int = 20;

    private var listItemPool:Vector.<DisplayObject>;
    private var scrollList:VerticalScrollingList;

    public function ArenaLeaderboardList() {
        this.listItemPool = new Vector.<DisplayObject>(this.MAX_SIZE);
        this.scrollList = new VerticalScrollingList();
        super();
        var _local_1:int;
        while (_local_1 < this.MAX_SIZE) {
            this.listItemPool[_local_1] = new ArenaLeaderboardListItem();
            _local_1++;
        }
        this.scrollList.setSize(new Size(786, 400));
        addChild(this.scrollList);
    }

    public function setItems(_arg_1:Vector.<ArenaLeaderboardEntry>, _arg_2:Boolean):void {
        var _local_4:ArenaLeaderboardEntry;
        var _local_5:ArenaLeaderboardListItem;
        var _local_3:int;
        while (_local_3 < this.listItemPool.length) {
            _local_4 = (((_local_3 < _arg_1.length)) ? _arg_1[_local_3] : null);
            _local_5 = (this.listItemPool[_local_3] as ArenaLeaderboardListItem);
            _local_5.apply(_local_4, _arg_2);
            _local_3++;
        }
        this.scrollList.setItems(this.listItemPool);
    }


}
}//package kabam.rotmg.arena.view
