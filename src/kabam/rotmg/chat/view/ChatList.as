package kabam.rotmg.chat.view {
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.utils.Timer;

import kabam.rotmg.chat.model.ChatModel;

public class ChatList extends Sprite {

    private const timer:Timer = new Timer(1000);
    private const itemsToRemove:Vector.<ChatListItem> = new Vector.<ChatListItem>();

    private var listItems:Vector.<ChatListItem>;
    private var visibleItems:Vector.<ChatListItem>;
    private var visibleItemCount:int;
    private var index:int;
    private var isCurrent:Boolean;
    private var ignoreTimeOuts:Boolean = false;
    private var maxLength:int;

    public function ChatList(_arg_1:int = 7, _arg_2:uint = 150) {
        mouseEnabled = true;
        mouseChildren = true;
        this.listItems = new Vector.<ChatListItem>();
        this.visibleItems = new Vector.<ChatListItem>();
        this.visibleItemCount = _arg_1;
        this.maxLength = _arg_2;
        this.index = 0;
        this.isCurrent = true;
        this.timer.addEventListener(TimerEvent.TIMER, this.onCheckTimeout);
        this.timer.start();
    }

    private function onCheckTimeout(_arg_1:TimerEvent):void {
        var _local_2:ChatListItem;
        var _local_3:ChatListItem;
        for each (_local_2 in this.visibleItems) {
            if (((_local_2.isTimedOut()) && (!(this.ignoreTimeOuts)))) {
                this.itemsToRemove.push(_local_2);
            }
            else {
                break;
            }
        }
        while (this.itemsToRemove.length > 0) {
            this.onItemTimedOut(this.itemsToRemove.pop());
            if (!this.isCurrent) {
                _local_3 = this.listItems[this.index++];
                if (!_local_3.isTimedOut()) {
                    this.addNewItem(_local_3);
                    this.isCurrent = (this.index == this.listItems.length);
                    this.positionItems();
                }
            }
        }
    }

    public function setup(_arg_1:ChatModel):void {
        this.visibleItemCount = _arg_1.visibleItemCount;
    }

    public function addMessage(_arg_1:ChatListItem):void {
        var _local_2:ChatListItem;
        if (this.listItems.length > this.maxLength) {
            _local_2 = this.listItems.shift();
            this.onItemTimedOut(_local_2);
            this.index--;
            if (((!(this.isCurrent)) && ((this.index < this.visibleItemCount)))) {
                this.pageDown();
            }
        }
        this.listItems.push(_arg_1);
        if (this.isCurrent) {
            this.displayNewItem(_arg_1);
        }
    }

    private function onItemTimedOut(_arg_1:ChatListItem):void {
        var _local_2:int = this.visibleItems.indexOf(_arg_1);
        if (_local_2 != -1) {
            removeChild(_arg_1);
            this.visibleItems.splice(_local_2, 1);
            this.isCurrent = (this.index == this.listItems.length);
        }
    }

    private function displayNewItem(_arg_1:ChatListItem):void {
        this.index++;
        this.addNewItem(_arg_1);
        this.removeOldestVisibleIfNeeded();
        this.positionItems();
    }

    public function scrollUp():void {
        if (((this.ignoreTimeOuts) && (this.canScrollUp()))) {
            this.scrollItemsUp();
        }
        else {
            this.showAvailable();
        }
        this.ignoreTimeOuts = true;
    }

    public function showAvailable():void {
        var _local_4:ChatListItem;
        var _local_1:int = ((this.index - this.visibleItems.length) - 1);
        var _local_2:int = Math.max(0, ((this.index - this.visibleItemCount) - 1));
        var _local_3:int = _local_1;
        while (_local_3 > _local_2) {
            _local_4 = this.listItems[_local_3];
            if (this.visibleItems.indexOf(_local_4) == -1) {
                this.addOldItem(_local_4);
            }
            _local_3--;
        }
        this.positionItems();
    }

    public function scrollDown():void {
        if (this.ignoreTimeOuts) {
            this.ignoreTimeOuts = false;
            this.scrollToCurrent();
            this.onCheckTimeout(null);
        }
        if (!this.isCurrent) {
            this.scrollItemsDown();
        }
        else {
            if (this.ignoreTimeOuts) {
                this.ignoreTimeOuts = false;
            }
        }
    }

    public function scrollToCurrent():void {
        while (!(this.isCurrent)) {
            this.scrollItemsDown();
        }
    }

    public function pageUp():void {
        var _local_1:int;
        if (!this.ignoreTimeOuts) {
            this.showAvailable();
            this.ignoreTimeOuts = true;
        }
        else {
            _local_1 = 0;
            while (_local_1 < this.visibleItemCount) {
                if (this.canScrollUp()) {
                    this.scrollItemsUp();
                }
                else {
                    return;
                }
                _local_1++;
            }
        }
    }

    public function pageDown():void {
        var _local_1:int;
        while (_local_1 < this.visibleItemCount) {
            if (!this.isCurrent) {
                this.scrollItemsDown();
            }
            else {
                this.ignoreTimeOuts = false;
                return;
            }
            _local_1++;
        }
    }

    private function addNewItem(_arg_1:ChatListItem):void {
        this.visibleItems.push(_arg_1);
        addChild(_arg_1);
    }

    private function removeOldestVisibleIfNeeded():void {
        if (this.visibleItems.length > this.visibleItemCount) {
            removeChild(this.visibleItems.shift());
        }
    }

    private function canScrollUp():Boolean {
        return ((this.index > this.visibleItemCount));
    }

    private function scrollItemsUp():void {
        var _local_1:ChatListItem = this.listItems[(--this.index - this.visibleItemCount)];
        this.addOldItem(_local_1);
        this.removeNewestVisibleIfNeeded();
        this.positionItems();
        this.isCurrent = false;
    }

    private function scrollItemsDown():void {
        if (this.index < 0) {
            this.index = 0;
        }
        var _local_1:ChatListItem = this.listItems[this.index];
        this.index++;
        this.addNewItem(_local_1);
        this.removeOldestVisibleIfNeeded();
        this.isCurrent = (this.index == this.listItems.length);
        this.positionItems();
    }

    private function addOldItem(_arg_1:ChatListItem):void {
        this.visibleItems.unshift(_arg_1);
        addChild(_arg_1);
    }

    private function removeNewestVisibleIfNeeded():void {
        if (this.visibleItems.length > this.visibleItemCount) {
            removeChild(this.visibleItems.pop());
        }
    }

    private function positionItems():void {
        var _local_3:ChatListItem;
        var _local_1:int;
        var _local_2:int = this.visibleItems.length;
        while (_local_2--) {
            _local_3 = this.visibleItems[_local_2];
            _local_3.y = _local_1;
            _local_1 = (_local_1 - _local_3.height);
        }
    }


}
}//package kabam.rotmg.chat.view
