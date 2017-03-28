package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class Element extends Sprite {

    public static const WIDTH:int = 50;
    public static const HEIGHT:int = 50;
    protected static var toolTip_:ToolTip = null;

    public var type_:int;
    protected var selected_:Boolean = false;
    protected var mouseOver_:Boolean = false;

    public function Element(_arg_1:int) {
        this.type_ = _arg_1;
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    public function setSelected(_arg_1:Boolean):void {
        this.selected_ = _arg_1;
        this.draw();
    }

    private function onAddedToStage(_arg_1:Event):void {
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
    }

    private function onMouseOver(_arg_1:Event):void {
        this.mouseOver_ = true;
        this.draw();
        this.setToolTip(this.getToolTip());
    }

    private function onRollOut(_arg_1:Event):void {
        this.mouseOver_ = false;
        this.draw();
        this.removeTooltip();
    }

    protected function setToolTip(_arg_1:ToolTip):void {
        this.removeTooltip();
        toolTip_ = _arg_1;
        if (toolTip_ != null) {
            stage.addChild(toolTip_);
        }
    }

    protected function removeTooltip():void {
        if (toolTip_ != null) {
            if (toolTip_.parent != null) {
                toolTip_.parent.removeChild(toolTip_);
            }
            toolTip_ = null;
        }
    }

    protected function getToolTip():ToolTip {
        return (null);
    }

    private function draw():void {
        graphics.clear();
        var _local_1:uint = 0x363636;
        if (this.selected_) {
            graphics.lineStyle(1, 0xFFFFFF);
            _local_1 = 0x7F7F7F;
        }
        graphics.beginFill(((this.mouseOver_) ? 0x565656 : 0x363636), 1);
        graphics.drawRect(2, 2, (WIDTH - 4), (HEIGHT - 4));
        if (this.selected_) {
            graphics.lineStyle();
        }
        graphics.endFill();
    }


}
}//package com.company.assembleegameclient.mapeditor
