package com.company.assembleegameclient.map.partyoverlay {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.Party;
import com.company.assembleegameclient.objects.Player;

import flash.display.Sprite;
import flash.events.Event;

public class PartyOverlay extends Sprite {

    public var map_:Map;
    public var partyMemberArrows_:Vector.<PlayerArrow> = null;
    public var questArrow_:QuestArrow;

    public function PartyOverlay(_arg_1:Map) {
        var _local_3:PlayerArrow;
        super();
        this.map_ = _arg_1;
        this.partyMemberArrows_ = new Vector.<PlayerArrow>(Party.NUM_MEMBERS, true);
        var _local_2:int;
        while (_local_2 < Party.NUM_MEMBERS) {
            _local_3 = new PlayerArrow();
            this.partyMemberArrows_[_local_2] = _local_3;
            addChild(_local_3);
            _local_2++;
        }
        this.questArrow_ = new QuestArrow(this.map_);
        addChild(this.questArrow_);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        GameObjectArrow.removeMenu();
    }

    public function draw(_arg_1:Camera, _arg_2:int):void {
        var _local_6:PlayerArrow;
        var _local_7:Player;
        var _local_8:int;
        var _local_9:PlayerArrow;
        var _local_10:Number;
        var _local_11:Number;
        if (this.map_.player_ == null) {
            return;
        }
        var _local_3:Party = this.map_.party_;
        var _local_4:Player = this.map_.player_;
        var _local_5:int;
        while (_local_5 < Party.NUM_MEMBERS) {
            _local_6 = this.partyMemberArrows_[_local_5];
            if (!_local_6.mouseOver_) {
                if (_local_5 >= _local_3.members_.length) {
                    _local_6.setGameObject(null);
                }
                else {
                    _local_7 = _local_3.members_[_local_5];
                    if (((((_local_7.drawn_) || ((_local_7.map_ == null)))) || (_local_7.dead_))) {
                        _local_6.setGameObject(null);
                    }
                    else {
                        _local_6.setGameObject(_local_7);
                        _local_8 = 0;
                        while (_local_8 < _local_5) {
                            _local_9 = this.partyMemberArrows_[_local_8];
                            _local_10 = (_local_6.x - _local_9.x);
                            _local_11 = (_local_6.y - _local_9.y);
                            if (((_local_10 * _local_10) + (_local_11 * _local_11)) < 64) {
                                if (!_local_9.mouseOver_) {
                                    _local_9.addGameObject(_local_7);
                                }
                                _local_6.setGameObject(null);
                                break;
                            }
                            _local_8++;
                        }
                        _local_6.draw(_arg_2, _arg_1);
                    }
                }
            }
            _local_5++;
        }
        if (!this.questArrow_.mouseOver_) {
            this.questArrow_.draw(_arg_2, _arg_1);
        }
    }


}
}//package com.company.assembleegameclient.map.partyoverlay
