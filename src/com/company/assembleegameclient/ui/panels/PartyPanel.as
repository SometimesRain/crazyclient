package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Party;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.GameObjectListItem;
import com.company.assembleegameclient.ui.PlayerGameObjectListItem;
import com.company.assembleegameclient.ui.menu.PlayerMenu;
import com.company.util.MoreColorUtil;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.utils.getTimer;

public class PartyPanel extends Panel {

    public var menuLayer:DisplayObjectContainer;
    public var memberPanels:Vector.<PlayerGameObjectListItem>;
    public var mouseOver_:Boolean;
    public var menu:PlayerMenu;

    public function PartyPanel(_arg_1:GameSprite) {
        this.memberPanels = new Vector.<PlayerGameObjectListItem>(Party.NUM_MEMBERS, true);
        super(_arg_1);
        this.memberPanels[0] = this.createPartyMemberPanel(-4, -4); //original x = 0/100 y = 0/32/64
        this.memberPanels[1] = this.createPartyMemberPanel(96, -4);
        this.memberPanels[2] = this.createPartyMemberPanel(-4, 28);
        this.memberPanels[3] = this.createPartyMemberPanel(96, 28);
        this.memberPanels[4] = this.createPartyMemberPanel(-4, 60);
        this.memberPanels[5] = this.createPartyMemberPanel(96, 60);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function createPartyMemberPanel(_arg_1:int, _arg_2:int):PlayerGameObjectListItem {
        var _local_3:PlayerGameObjectListItem = new PlayerGameObjectListItem(0xFFFFFF, false, null);
        addChild(_local_3);
        _local_3.x = _arg_1;
        _local_3.y = _arg_2;
        return (_local_3);
    }

    private function onAddedToStage(_arg_1:Event):void {
        var _local_2:PlayerGameObjectListItem;
        for each (_local_2 in this.memberPanels) {
            _local_2.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            _local_2.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            _local_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        }
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        var _local_2:PlayerGameObjectListItem;
        this.removeMenu();
        for each (_local_2 in this.memberPanels) {
            _local_2.removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            _local_2.removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            _local_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        }
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        if (((!((this.menu == null))) && (!((this.menu.parent == null))))) {
            return;
        }
        var _local_2:PlayerGameObjectListItem = (_arg_1.currentTarget as PlayerGameObjectListItem);
        var _local_3:Player = (_local_2.go as Player);
        if ((((_local_3 == null)) || ((_local_3.texture_ == null)))) {
            return;
        }
        this.mouseOver_ = true;
    }

    private function onMouseOut(_arg_1:MouseEvent):void {
        this.mouseOver_ = false;
    }

    private function onMouseDown(_arg_1:MouseEvent):void {
        this.removeMenu();
        var _local_2:PlayerGameObjectListItem = (_arg_1.currentTarget as PlayerGameObjectListItem);
        _local_2.setEnabled(false);
        this.menu = new PlayerMenu();
        this.menu.init(gs_, (_local_2.go as Player));
        this.menuLayer.addChild(this.menu);
        this.menu.addEventListener(Event.REMOVED_FROM_STAGE, this.onMenuRemoved);
    }

    private function onMenuRemoved(_arg_1:Event):void {
        var _local_2:GameObjectListItem;
        var _local_3:PlayerGameObjectListItem;
        for each (_local_2 in this.memberPanels) {
            _local_3 = (_local_2 as PlayerGameObjectListItem);
            if (_local_3) {
                _local_3.setEnabled(true); //enable panel
            }
        }
        _arg_1.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, this.onMenuRemoved);
    }

    private function removeMenu():void {
        if (this.menu != null) {
            this.menu.remove();
            this.menu = null;
        }
    }

    override public function draw():void {
        var _local_4:GameObjectListItem;
        var _local_5:Player;
        var _local_6:ColorTransform;
        var _local_7:Number;
        var _local_8:int;
        var _local_1:Party = gs_.map.party_;
        if (_local_1 == null) {
            for each (_local_4 in this.memberPanels) {
                _local_4.clear();
            }
            return;
        }
        var _local_2:int;
        var _local_3:int;
        while (_local_3 < Party.NUM_MEMBERS) {
            if (((this.mouseOver_) || (((!((this.menu == null))) && (!((this.menu.parent == null))))))) {
                _local_5 = (this.memberPanels[_local_3].go as Player);
            }
            else {
                _local_5 = _local_1.members_[_local_3];
            }
            if (((!((_local_5 == null))) && ((_local_5.map_ == null)))) {
                _local_5 = null;
            }
            _local_6 = null;
            if (_local_5 != null) {
                if (_local_5.hp_ < (_local_5.maxHP_ * 0.2)) {
                    if (_local_2 == 0) {
                        _local_2 = getTimer();
                    }
                    _local_7 = (int((Math.abs(Math.sin((_local_2 / 200))) * 10)) / 10);
                    _local_8 = 128;
                    _local_6 = new ColorTransform(1, 1, 1, 1, (_local_7 * _local_8), (-(_local_7) * _local_8), (-(_local_7) * _local_8));
                }
                if (!_local_5.starred_) {
                    if (_local_6 != null) {
                        _local_6.concat(MoreColorUtil.darkCT);
                    }
                    else {
                        _local_6 = MoreColorUtil.darkCT;
                    }
                }
            }
            this.memberPanels[_local_3].draw(_local_5, _local_6);
            _local_3++;
        }
    }


}
}//package com.company.assembleegameclient.ui.panels
