package kabam.lib.ui.impl {
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;

import kabam.lib.ui.api.Layout;
import kabam.lib.ui.api.List;
import kabam.lib.ui.api.Size;

import org.osflash.signals.Signal;

public class LayoutList extends Sprite implements List {

    private static const NULL_LAYOUT:Layout = new NullLayout();
    private static const ZERO_SIZE:Size = new Size(0, 0);

    public const itemsChanged:Signal = new Signal();
    private const list:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
    private const container:Sprite = new Sprite();
    private const containerMask:Shape = new Shape();

    private var layout:Layout;
    private var size:Size;
    private var offset:int = 0;

    public function LayoutList() {
        this.layout = NULL_LAYOUT;
        this.size = ZERO_SIZE;
        super();
        addChild(this.container);
        addChild(this.containerMask);
    }

    public function getLayout():Layout {
        return (this.layout);
    }

    public function setLayout(_arg_1:Layout):void {
        this.layout = ((_arg_1) || (NULL_LAYOUT));
        _arg_1.layout(this.list, -(this.offset));
    }

    public function getSize():Size {
        return (this.size);
    }

    public function setSize(_arg_1:Size):void {
        this.size = ((_arg_1) || (ZERO_SIZE));
        this.applySizeToMask();
    }

    public function getSizeOfItems():Size {
        var _local_1:Rectangle = this.container.getRect(this.container);
        return (new Size(_local_1.width, _local_1.height));
    }

    private function applySizeToMask():void {
        var _local_1:Graphics = this.containerMask.graphics;
        _local_1.clear();
        _local_1.beginFill(0x9900FF);
        _local_1.drawRect(0, 0, this.size.width, this.size.height);
        _local_1.endFill();
        this.container.mask = this.containerMask;
    }

    public function addItem(_arg_1:DisplayObject):void {
        this.addToListAndContainer(_arg_1);
        this.updateLayout();
        this.itemsChanged.dispatch();
    }

    public function getItemAt(_arg_1:int):DisplayObject {
        return (this.list[_arg_1]);
    }

    public function setItems(_arg_1:Vector.<DisplayObject>):void {
        this.clearList();
        this.addItemsToListAndContainer(_arg_1);
        this.offset = 0;
        this.updateLayout();
        this.itemsChanged.dispatch();
    }

    public function getItemCount():int {
        return (this.list.length);
    }

    private function clearList():void {
        var _local_1:int = this.list.length;
        while (_local_1--) {
            this.container.removeChild(this.list[_local_1]);
        }
        this.list.length = 0;
    }

    private function addItemsToListAndContainer(_arg_1:Vector.<DisplayObject>):void {
        var _local_2:DisplayObject;
        for each (_local_2 in _arg_1) {
            this.addToListAndContainer(_local_2);
        }
    }

    private function addToListAndContainer(_arg_1:DisplayObject):void {
        this.list.push(_arg_1);
        this.container.addChild(_arg_1);
    }

    public function setOffset(_arg_1:int):void {
        this.offset = _arg_1;
        this.updateLayout();
    }

    public function getOffset():int {
        return (this.offset);
    }

    public function updateLayout():void {
        this.layout.layout(this.list, -(this.offset));
    }


}
}//package kabam.lib.ui.impl
