package kabam.rotmg.util.components {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import kabam.rotmg.util.graphics.BevelRect;
import kabam.rotmg.util.graphics.GraphicsHelper;

import org.osflash.signals.Signal;

public final class VerticalScrollbarBar extends Sprite {

    public static const WIDTH:int = VerticalScrollbar.WIDTH;//20
    public static const BEVEL:int = VerticalScrollbar.BEVEL;//4
    public static const PADDING:int = VerticalScrollbar.PADDING;//0

    public const dragging:Signal = new Signal(int);
    public const scrolling:Signal = new Signal(Number);
    public const rect:BevelRect = new BevelRect((WIDTH - (PADDING * 2)), 0, BEVEL);
    private const helper:GraphicsHelper = new GraphicsHelper();

    private var downOffset:Number;
    private var isOver:Boolean;
    private var isDown:Boolean;


    public function redraw():void {
        var _local_1:int = ((((this.isOver) || (this.isDown))) ? 16767876 : 0xCCCCCC);
        graphics.clear();
        graphics.beginFill(_local_1);
        this.helper.drawBevelRect(PADDING, 0, this.rect, graphics);
        graphics.endFill();
    }

    public function addMouseListeners():void {
        addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        if (((parent) && (parent.parent))) {
            parent.parent.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
        }
        else {
            if (WebMain.STAGE) {
                WebMain.STAGE.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            }
        }
    }

    protected function onMouseWheel(_arg_1:MouseEvent):void {
        if (_arg_1.delta > 0) {
            this.scrolling.dispatch(-0.25);
        }
        else {
            if (_arg_1.delta < 0) {
                this.scrolling.dispatch(0.25);
            }
        }
    }

    public function removeMouseListeners():void {
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        if (((parent) && (parent.parent))) {
            parent.parent.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
        }
        else {
            if (WebMain.STAGE) {
                WebMain.STAGE.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            }
        }
        this.onMouseUp();
    }

    private function onMouseDown(_arg_1:MouseEvent = null):void {
        this.isDown = true;
        this.downOffset = (parent.mouseY - y);
        if (stage != null) {
            stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        addEventListener(Event.ENTER_FRAME, this.iterate);
        this.redraw();
    }

    private function onMouseUp(_arg_1:MouseEvent = null):void {
        this.isDown = false;
        if (stage != null) {
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        removeEventListener(Event.ENTER_FRAME, this.iterate);
        this.redraw();
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.isOver = true;
        this.redraw();
    }

    private function onMouseOut(_arg_1:MouseEvent):void {
        this.isOver = false;
        this.redraw();
    }

    private function iterate(_arg_1:Event):void {
        this.dragging.dispatch(int((parent.mouseY - this.downOffset)));
    }


}
}//package kabam.rotmg.util.components
