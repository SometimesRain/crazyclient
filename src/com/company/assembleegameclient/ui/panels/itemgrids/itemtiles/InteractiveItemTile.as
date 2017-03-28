package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

public class InteractiveItemTile extends ItemTile {

    private static const DOUBLE_CLICK_PAUSE:uint = 250;
    private static const DRAG_DIST:int = 3;

    private var doubleClickTimer:Timer;
    private var dragStart:Point;
    private var pendingSecondClick:Boolean;
    private var isDragging:Boolean;

    public function InteractiveItemTile(_arg_1:int, _arg_2:ItemGrid, _arg_3:Boolean) {
        super(_arg_1, _arg_2);
        mouseChildren = false;
        this.doubleClickTimer = new Timer(DOUBLE_CLICK_PAUSE, 1);
        this.doubleClickTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onDoubleClickTimerComplete);
        this.setInteractive(_arg_3);
    }

    public function setInteractive(_arg_1:Boolean):void {
        if (_arg_1) {
            addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }
        else {
            removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        }
    }

    public function getDropTarget():DisplayObject {
        return (itemSprite.dropTarget);
    }

    protected function beginDragCallback():void {
    }

    protected function endDragCallback():void {
    }

    private function onMouseOut(_arg_1:MouseEvent):void {
        this.setPendingDoubleClick(false);
    }

    private function onMouseUp(_arg_1:MouseEvent):void {
        if (this.isDragging) {
            return;
        }
        if (_arg_1.shiftKey) {
            this.setPendingDoubleClick(false);
            dispatchEvent(new ItemTileEvent(ItemTileEvent.ITEM_SHIFT_CLICK, this));
        }
        else {
            if (_arg_1.ctrlKey) {
                this.setPendingDoubleClick(false);
                dispatchEvent(new ItemTileEvent(ItemTileEvent.ITEM_CTRL_CLICK, this));
            }
            else {
                if (!this.pendingSecondClick) {
                    this.setPendingDoubleClick(true);
                }
                else {
                    this.setPendingDoubleClick(false);
                    dispatchEvent(new ItemTileEvent(ItemTileEvent.ITEM_DOUBLE_CLICK, this));
                }
            }
        }
    }

    private function onMouseDown(_arg_1:MouseEvent):void {
        this.beginDragCheck(_arg_1);
    }

    private function setPendingDoubleClick(_arg_1:Boolean):void {
        this.pendingSecondClick = _arg_1;
        if (this.pendingSecondClick) {
            this.doubleClickTimer.reset();
            this.doubleClickTimer.start();
        }
        else {
            this.doubleClickTimer.stop();
        }
    }

    private function beginDragCheck(_arg_1:MouseEvent):void {
        this.dragStart = new Point(_arg_1.stageX, _arg_1.stageY);
        addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveCheckDrag);
        addEventListener(MouseEvent.MOUSE_OUT, this.cancelDragCheck);
        addEventListener(MouseEvent.MOUSE_UP, this.cancelDragCheck);
    }

    private function cancelDragCheck(_arg_1:MouseEvent):void {
        removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveCheckDrag);
        removeEventListener(MouseEvent.MOUSE_OUT, this.cancelDragCheck);
        removeEventListener(MouseEvent.MOUSE_UP, this.cancelDragCheck);
    }

    private function onMouseMoveCheckDrag(_arg_1:MouseEvent):void {
        var _local_2:Number = (_arg_1.stageX - this.dragStart.x);
        var _local_3:Number = (_arg_1.stageY - this.dragStart.y);
        var _local_4:Number = Math.sqrt(((_local_2 * _local_2) + (_local_3 * _local_3)));
        if (_local_4 > DRAG_DIST) {
            this.cancelDragCheck(null);
            this.setPendingDoubleClick(false);
            this.beginDrag(_arg_1);
        }
    }

    private function onDoubleClickTimerComplete(_arg_1:TimerEvent):void {
        this.setPendingDoubleClick(false);
        dispatchEvent(new ItemTileEvent(ItemTileEvent.ITEM_CLICK, this));
    }

    private function beginDrag(_arg_1:MouseEvent):void {
        this.isDragging = true;
        stage.addChild(itemSprite);
        itemSprite.startDrag(true);
        itemSprite.x = _arg_1.stageX;
        itemSprite.y = _arg_1.stageY;
        itemSprite.addEventListener(MouseEvent.MOUSE_UP, this.endDrag);
        this.beginDragCallback();
    }

    private function endDrag(_arg_1:MouseEvent):void {
        this.isDragging = false;
        itemSprite.stopDrag();
        itemSprite.removeEventListener(MouseEvent.MOUSE_UP, this.endDrag);
        dispatchEvent(new ItemTileEvent(ItemTileEvent.ITEM_MOVE, this));
        this.endDragCallback();
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        this.setPendingDoubleClick(false);
        this.cancelDragCheck(null);
        if (this.isDragging) {
            itemSprite.stopDrag();
        }
    }


}
}//package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles
