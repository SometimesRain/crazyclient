package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.game.AGameSprite;
import com.company.ui.BaseSimpleText;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.messaging.impl.data.TradeItem;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class TradeInventory extends Sprite {

    private static const NO_CUT:Array = [0, 0, 0, 0];
    private static const cuts:Array = [[1, 0, 0, 1], NO_CUT, NO_CUT, [0, 1, 1, 0], [1, 0, 0, 0], NO_CUT, NO_CUT, [0, 1, 0, 0], [0, 0, 0, 1], NO_CUT, NO_CUT, [0, 0, 1, 0]];
    public static const CLICKITEMS_MESSAGE:int = 0;
    public static const NOTENOUGHSPACE_MESSAGE:int = 1;
    public static const TRADEACCEPTED_MESSAGE:int = 2;
    public static const TRADEWAITING_MESSAGE:int = 3;

    public var gs_:AGameSprite;
    public var playerName_:String;
    private var message_:int;
    private var nameText_:BaseSimpleText;
    private var taglineText_:TextFieldDisplayConcrete;
    public var slots_:Vector.<TradeSlot>;

    public function TradeInventory(_arg_1:AGameSprite, _arg_2:String, _arg_3:Vector.<TradeItem>, _arg_4:Boolean) {
        var _local_6:TradeItem;
        var _local_7:TradeSlot;
        this.slots_ = new Vector.<TradeSlot>();
        super();
        this.gs_ = _arg_1;
        this.playerName_ = _arg_2;
        this.nameText_ = new BaseSimpleText(20, 0xB3B3B3, false, 0, 0);
        this.nameText_.setBold(true);
        this.nameText_.x = 0;
        this.nameText_.y = 0;
        this.nameText_.text = this.playerName_;
        this.nameText_.updateMetrics();
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.nameText_);
        this.taglineText_ = new TextFieldDisplayConcrete().setSize(12).setColor(0xB3B3B3);
        this.taglineText_.x = 0;
        this.taglineText_.y = 22;
        this.taglineText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.taglineText_);
        var _local_5:int;
        while (_local_5 < (GeneralConstants.NUM_EQUIPMENT_SLOTS + GeneralConstants.NUM_INVENTORY_SLOTS)) {
            _local_6 = _arg_3[_local_5];
            _local_7 = new TradeSlot(_local_6.item_, _local_6.tradeable_, _local_6.included_, _local_6.slotType_, (_local_5 - 3), cuts[_local_5], _local_5);
            _local_7.setPlayer(this.gs_.map.player_);
            _local_7.x = (int((_local_5 % 4)) * (Slot.WIDTH + 4));
            _local_7.y = ((int((_local_5 / 4)) * (Slot.HEIGHT + 4)) + 46);
            if (((_arg_4) && (_local_6.tradeable_))) {
                _local_7.addEventListener(MouseEvent.MOUSE_DOWN, this.onSlotClick);
            }
            this.slots_.push(_local_7);
            addChild(_local_7);
            _local_5++;
        }
    }

    public function getOffer():Vector.<Boolean> {
        var _local_1:Vector.<Boolean> = new Vector.<Boolean>();
        var _local_2:int;
        while (_local_2 < this.slots_.length) {
            _local_1.push(this.slots_[_local_2].included_);
            _local_2++;
        }
        return (_local_1);
    }

    public function setOffer(_arg_1:Vector.<Boolean>):void {
        var _local_2:int;
        while (_local_2 < this.slots_.length) {
            this.slots_[_local_2].setIncluded(_arg_1[_local_2]);
            _local_2++;
        }
    }

    public function isOffer(_arg_1:Vector.<Boolean>):Boolean {
        var _local_2:int;
        while (_local_2 < this.slots_.length) {
            if (_arg_1[_local_2] != this.slots_[_local_2].included_) {
                return (false);
            }
            _local_2++;
        }
        return (true);
    }

    public function numIncluded():int {
        var _local_1:int;
        var _local_2:int;
        while (_local_2 < this.slots_.length) {
            if (this.slots_[_local_2].included_) {
                _local_1++;
            }
            _local_2++;
        }
        return (_local_1);
    }

    public function numEmpty():int {
        var _local_1:int;
        var _local_2:int = 4;
        while (_local_2 < this.slots_.length) {
            if (this.slots_[_local_2].isEmpty()) {
                _local_1++;
            }
            _local_2++;
        }
        return (_local_1);
    }

    public function setMessage(_arg_1:int):void {
        var _local_2:String = "";
        switch (_arg_1) {
            case CLICKITEMS_MESSAGE:
                this.nameText_.setColor(0xB3B3B3);
                this.taglineText_.setColor(0xB3B3B3);
                _local_2 = TextKey.TRADEINVENTORY_CLICKITEMSTOTRADE;
                break;
            case NOTENOUGHSPACE_MESSAGE:
                this.nameText_.setColor(0xFF0000);
                this.taglineText_.setColor(0xFF0000);
                _local_2 = TextKey.TRADEINVENTORY_NOTENOUGHSPACE;
                break;
            case TRADEACCEPTED_MESSAGE:
                this.nameText_.setColor(9022300);
                this.taglineText_.setColor(9022300);
                _local_2 = TextKey.TRADEINVENTORY_TRADEACCEPTED;
                break;
            case TRADEWAITING_MESSAGE:
                this.nameText_.setColor(0xB3B3B3);
                this.taglineText_.setColor(0xB3B3B3);
                _local_2 = TextKey.TRADEINVENTORY_PLAYERISSELECTINGITEMS;
                break;
        }
        this.taglineText_.setStringBuilder(new LineBuilder().setParams(_local_2));
    }

    private function onSlotClick(_arg_1:MouseEvent):void {
        var _local_2:TradeSlot = (_arg_1.currentTarget as TradeSlot);
        _local_2.setIncluded(!(_local_2.included_));
        dispatchEvent(new Event(Event.CHANGE));
    }


}
}//package com.company.assembleegameclient.ui
