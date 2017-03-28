package kabam.rotmg.arena.view {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.arena.model.ArenaLeaderboardFilter;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;

public class ArenaLeaderboardTab extends Sprite {

    private static const OVER_COLOR:int = 16567065;
    private static const DOWN_COLOR:int = 0xFFFFFF;
    private static const OUT_COLOR:int = 0xB2B2B2;

    public var label:StaticTextDisplay = makeLabel();

    private var filter:ArenaLeaderboardFilter;
    private var isOver:Boolean;
    private var isDown:Boolean;
    private var isSelected:Boolean = false;

    public const readyToAlign:Signal = label.textChanged;
    public const selected:Signal = new Signal(ArenaLeaderboardTab);

    public function ArenaLeaderboardTab(_arg_1:ArenaLeaderboardFilter) {
        super();
        this.filter = _arg_1;
        this.label.setStringBuilder(new LineBuilder().setParams(_arg_1.getName()));
        addChild(this.label);
        this.addMouseListeners();
    }

    public function destroy():void {
        this.removeMouseListeners();
    }

    public function getFilter():ArenaLeaderboardFilter {
        return (this.filter);
    }

    public function setSelected(_arg_1:Boolean):void {
        this.isSelected = _arg_1;
        this.redraw();
    }

    private function addMouseListeners():void {
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function removeMouseListeners():void {
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        removeEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(_arg_1:MouseEvent):void {
        if (!this.isSelected) {
            this.selected.dispatch(this);
        }
    }

    private function redraw():void {
        if (this.isOver) {
            this.label.setColor(OVER_COLOR);
        }
        else {
            if (((this.isSelected) || (this.isDown))) {
                this.label.setColor(DOWN_COLOR);
            }
            else {
                this.label.setColor(OUT_COLOR);
            }
        }
    }

    private function onMouseUp(_arg_1:MouseEvent):void {
        this.isDown = false;
        this.redraw();
    }

    private function onMouseDown(_arg_1:MouseEvent):void {
        this.isDown = true;
        this.redraw();
    }

    private function onMouseOut(_arg_1:MouseEvent):void {
        this.isOver = false;
        this.isDown = false;
        this.redraw();
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.isOver = true;
        this.redraw();
    }

    private function makeLabel():StaticTextDisplay {
        var _local_1:StaticTextDisplay;
        _local_1 = new StaticTextDisplay();
        _local_1.setBold(true).setColor(0xB3B3B3).setSize(20);
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        return (_local_1);
    }


}
}//package kabam.rotmg.arena.view
