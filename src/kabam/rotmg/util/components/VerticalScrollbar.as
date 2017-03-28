package kabam.rotmg.util.components {
import flash.display.Sprite;

import kabam.lib.ui.api.Scrollbar;

import org.osflash.signals.Signal;

public class VerticalScrollbar extends Sprite implements Scrollbar {

    public static const WIDTH:int = 20;
    public static const BEVEL:int = 4;
    public static const PADDING:int = 0;

    public const groove:VerticalScrollbarGroove = new VerticalScrollbarGroove();
    public const bar:VerticalScrollbarBar = new VerticalScrollbarBar();

    private var _positionChanged:Signal;
    private var position:Number = 0;
    private var range:int;
    private var invRange:Number;
    private var isEnabled:Boolean = true;

    public function VerticalScrollbar() {
        addChild(this.groove);
        addChild(this.bar);
        this.addMouseListeners();
    }

    public function get positionChanged():Signal {
        return ((this._positionChanged = ((this._positionChanged) || (new Signal(Number)))));
    }

    public function getIsEnabled():Boolean {
        return (this.isEnabled);
    }

    public function setIsEnabled(_arg_1:Boolean):void {
        if (this.isEnabled != _arg_1) {
            this.isEnabled = _arg_1;
            if (_arg_1) {
                this.addMouseListeners();
            }
            else {
                this.removeMouseListeners();
            }
        }
    }

    private function addMouseListeners():void {
        this.groove.addMouseListeners();
        this.groove.clicked.add(this.onGrooveClicked);
        this.bar.addMouseListeners();
        this.bar.dragging.add(this.onBarDrag);
        this.bar.scrolling.add(this.scrollPosition);
    }

    private function removeMouseListeners():void {
        this.groove.removeMouseListeners();
        this.groove.clicked.remove(this.onGrooveClicked);
        this.bar.removeMouseListeners();
        this.bar.dragging.remove(this.onBarDrag);
        this.bar.scrolling.remove(this.scrollPosition);
    }

    public function setSize(_arg_1:int, _arg_2:int):void {
        this.bar.rect.height = _arg_1;
        this.groove.rect.height = _arg_2;
        this.range = ((_arg_2 - _arg_1) - (PADDING * 2));
        this.invRange = (1 / this.range);
        this.groove.redraw();
        this.bar.redraw();
        this.setPosition(this.getPosition());
    }

    public function getBarSize():int {
        return (this.bar.rect.height);
    }

    public function getGrooveSize():int {
        return (this.groove.rect.height);
    }

    public function getPosition():Number {
        return (this.position);
    }

    public function setPosition(_arg_1:Number):void {
        if (_arg_1 < 0) {
            _arg_1 = 0;
        }
        else {
            if (_arg_1 > 1) {
                _arg_1 = 1;
            }
        }
        this.position = _arg_1;
        this.bar.y = (PADDING + (this.range * this.position));
        ((this._positionChanged) && (this._positionChanged.dispatch(this.position)));
    }

    public function scrollPosition(_arg_1:Number):void {
        var _local_2:Number = (this.position + _arg_1);
        this.setPosition(_local_2);
    }

    private function onBarDrag(_arg_1:int):void {
        this.setPosition(((_arg_1 - PADDING) * this.invRange));
    }

    private function onGrooveClicked(_arg_1:int):void {
        var _local_2:int = this.bar.rect.height;
        var _local_3:int = (_arg_1 - (_local_2 * 0.5));
        var _local_4:int = (this.groove.rect.height - _local_2);
        this.setPosition((_local_3 / _local_4));
    }


}
}//package kabam.rotmg.util.components
