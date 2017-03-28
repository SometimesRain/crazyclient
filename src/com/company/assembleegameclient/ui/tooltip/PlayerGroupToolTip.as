package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.GameObjectListItem;

import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class PlayerGroupToolTip extends ToolTip {

    public var players_:Vector.<Player> = null;
    private var playerPanels_:Vector.<GameObjectListItem>;
    private var clickMessage_:TextFieldDisplayConcrete;

    public function PlayerGroupToolTip(_arg_1:Vector.<Player>, _arg_2:Boolean = true) {
        this.playerPanels_ = new Vector.<GameObjectListItem>();
        super(0x363636, 0.5, 0xFFFFFF, 1, _arg_2);
        this.clickMessage_ = new TextFieldDisplayConcrete().setSize(12).setColor(0xB3B3B3);
        this.clickMessage_.setStringBuilder(new LineBuilder().setParams(TextKey.PLAYER_TOOL_TIP_CLICK_MESSAGE));
        this.clickMessage_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.clickMessage_);
        this.setPlayers(_arg_1);
        if (!_arg_2) {
            filters = [];
        }
        waiter.push(this.clickMessage_.textChanged);
    }

    public function setPlayers(_arg_1:Vector.<Player>):void {
        var _local_3:Player;
        var _local_4:GameObjectListItem;
        this.clear();
        this.players_ = _arg_1.slice();
        if ((((this.players_ == null)) || ((this.players_.length == 0)))) {
            return;
        }
        var _local_2:int;
        for each (_local_3 in _arg_1) {
            _local_4 = new GameObjectListItem(0xB3B3B3, true, _local_3);
            _local_4.x = 0;
            _local_4.y = _local_2;
            addChild(_local_4);
            this.playerPanels_.push(_local_4);
            _local_2 = (_local_2 + 32);
        }
        this.clickMessage_.x = ((width / 2) - (this.clickMessage_.width / 2));
        this.clickMessage_.y = _local_2;
        draw();
    }

    private function clear():void {
        var _local_1:GameObjectListItem;
        graphics.clear();
        for each (_local_1 in this.playerPanels_) {
            removeChild(_local_1);
        }
        this.playerPanels_.length = 0;
    }


}
}//package com.company.assembleegameclient.ui.tooltip
