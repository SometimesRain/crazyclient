package kabam.rotmg.util.components {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.lib.ui.api.List;
import kabam.lib.ui.api.Size;
import kabam.lib.ui.impl.LayoutList;
import kabam.lib.ui.impl.VerticalLayout;

import org.osflash.signals.Signal;

public class VerticalScrollingList extends Sprite implements List {

    public static const SCROLLBAR_PADDING:int = 2;
    public static const SCROLLBAR_GUTTER:int = (VerticalScrollbar.WIDTH + SCROLLBAR_PADDING);

    public const scrollStateChanged:Signal = new Signal(Boolean);

    private var layout:VerticalLayout;
    private var list:LayoutList;
    private var scrollbar:VerticalScrollbar;
    private var isEnabled:Boolean = true;
    private var size:Size;

    public function VerticalScrollingList() {
        this.makeLayout();
        this.makeVerticalList();
        this.makeScrollbar();
    }

    public function getIsEnabled():Boolean {
        return (this.isEnabled);
    }

    public function setIsEnabled(_arg_1:Boolean):void {
        this.isEnabled = _arg_1;
        this.scrollbar.setIsEnabled(_arg_1);
    }

    public function setSize(_arg_1:Size):void {
        this.size = _arg_1;
        if (this.isScrollbarVisible()) {
            _arg_1 = new Size((_arg_1.width - SCROLLBAR_GUTTER), _arg_1.height);
        }
        this.list.setSize(_arg_1);
        this.refreshScrollbar();
    }

    public function getSize():Size {
        return (this.size);
    }

    public function setPadding(_arg_1:int):void {
        this.layout.setPadding(_arg_1);
        this.list.updateLayout();
        this.refreshScrollbar();
    }

    public function addItem(_arg_1:DisplayObject):void {
        this.list.addItem(_arg_1);
    }

    public function setItems(_arg_1:Vector.<DisplayObject>):void {
        this.list.setItems(_arg_1);
    }

    public function getItemAt(_arg_1:int):DisplayObject {
        return (this.list.getItemAt(_arg_1));
    }

    public function getItemCount():int {
        return (this.list.getItemCount());
    }

    public function getListHeight():int {
        return (this.list.getSizeOfItems().height);
    }

    private function makeLayout():void {
        this.layout = new VerticalLayout();
    }

    public function isScrollbarVisible():Boolean {
        return (this.scrollbar.visible);
    }

    private function makeVerticalList():void {
        this.list = new LayoutList();
        this.list.itemsChanged.add(this.refreshScrollbar);
        this.list.setLayout(this.layout);
        addChild(this.list);
    }

    private function refreshScrollbar():void {
        var _local_1:Size = this.list.getSize();
        var _local_2:int = _local_1.height;
        var _local_3:int = this.list.getSizeOfItems().height;
        var _local_4:Boolean = (_local_3 > _local_2);
        var _local_5:Boolean = this.scrollbar.visible != _local_4;
        this.scrollbar.setIsEnabled(false);
        this.scrollbar.visible = _local_4;
        ((_local_4) && (this.scrollbar.setIsEnabled(true)));
        ((_local_4) && (this.updateScrollbarSize(_local_2, _local_3)));
        ((_local_5) && (this.updateUiAndDispatchStateChange(_local_4)));
    }

    private function updateUiAndDispatchStateChange(_arg_1:Boolean):void {
        this.setSize(this.size);
        this.scrollStateChanged.dispatch(_arg_1);
    }

    private function updateScrollbarSize(_arg_1:int, _arg_2:int):void {
        var _local_3:int = (_arg_1 * (_arg_1 / _arg_2));
        this.scrollbar.setSize(_local_3, _arg_1);
        this.scrollbar.x = (this.list.getSize().width + SCROLLBAR_PADDING);
    }

    private function makeScrollbar():void {
        this.scrollbar = new VerticalScrollbar();
        this.scrollbar.positionChanged.add(this.onPositionChanged);
        this.scrollbar.visible = false;
        addChild(this.scrollbar);
    }

    private function onPositionChanged(_arg_1:Number):void {
        var _local_2:int = (this.list.getSizeOfItems().height - this.list.getSize().height);
        this.list.setOffset((_local_2 * _arg_1));
    }


}
}//package kabam.rotmg.util.components
