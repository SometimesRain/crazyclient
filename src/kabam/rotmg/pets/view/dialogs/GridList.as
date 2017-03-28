package kabam.rotmg.pets.view.dialogs {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.lib.ui.api.Size;
import kabam.rotmg.util.components.VerticalScrollingList;

public class GridList extends Sprite {

    public var list:VerticalScrollingList;
    private var size:Size;
    private var row:Sprite;
    private var rows:Vector.<DisplayObject>;
    private var items:Array;
    private var lastItemRight:int;
    private var padding:int;
    private var grid:Array;
    private var maxItemsPerRow:int;

    public function GridList() {
        this.list = new VerticalScrollingList();
        super();
    }

    public function setSize(_arg_1:Size):void {
        this.size = _arg_1;
        this.list.setSize(_arg_1);
        addChild(this.list);
    }

    public function setPadding(_arg_1:int):void {
        this.padding = _arg_1;
        this.list.setPadding(_arg_1);
    }

    public function setItems(_arg_1:Vector.<PetItem>):void {
        var _local_2:DisplayObject;
        this.makeNewList();
        for each (_local_2 in _arg_1) {
            this.addItem(_local_2);
        }
        this.list.setItems(this.rows);
        if (!_arg_1.length) {
            return;
        }
        var _local_3:DisplayObject = _arg_1[0];
        this.maxItemsPerRow = (this.maxRowWidth() / _local_3.width);
    }

    public function getSize():Size {
        return (this.size);
    }

    public function getItems():Array {
        return (this.items);
    }

    public function getItem(_arg_1:int):DisplayObject {
        return (this.items[_arg_1]);
    }

    private function makeNewList():void {
        this.grid = [];
        this.items = [];
        this.rows = new Vector.<DisplayObject>();
        this.lastItemRight = 0;
        this.addRow();
    }

    private function addItem(_arg_1:DisplayObject):void {
        this.position(_arg_1);
        this.row.addChild(_arg_1);
        this.items.push(_arg_1);
        this.grid[(this.grid.length - 1)].push(_arg_1);
    }

    private function position(_arg_1:DisplayObject):void {
        if (this.exceedsWidthFor(_arg_1)) {
            _arg_1.x = 0;
            this.addRow();
        }
        else {
            this.positionRightOfPrevious(_arg_1);
        }
        this.lastItemRight = (_arg_1.x + _arg_1.width);
        this.lastItemRight = (this.lastItemRight + this.padding);
    }

    private function addRow():void {
        this.row = new Sprite();
        this.rows.push(this.row);
        this.grid.push([]);
    }

    private function positionRightOfPrevious(_arg_1:DisplayObject):void {
        _arg_1.x = this.lastItemRight;
    }

    private function exceedsWidthFor(_arg_1:DisplayObject):Boolean {
        return (((this.lastItemRight + _arg_1.width) > this.maxRowWidth()));
    }

    private function maxRowWidth():int {
        return ((this.size.width - VerticalScrollingList.SCROLLBAR_GUTTER));
    }

    public function getTopLeft():DisplayObject {
        if (this.items.length) {
            return (this.items[0]);
        }
        return (null);
    }

    public function getTopRight():DisplayObject {
        var _local_1:Array;
        if (this.grid.length) {
            _local_1 = this.grid[0];
            return (_local_1[(this.maxItemsPerRow - 1)]);
        }
        return (null);
    }

    public function getBottomLeft():DisplayObject {
        var _local_1:Array;
        if (this.grid.length >= 2) {
            _local_1 = this.grid[(this.grid.length - 1)];
            return (_local_1[0]);
        }
        return (null);
    }

    public function getBottomRight():DisplayObject {
        var _local_1:Array;
        if (this.grid.length >= 2) {
            _local_1 = this.grid[(this.grid.length - 1)];
            return (_local_1[(this.maxItemsPerRow - 1)]);
        }
        return (null);
    }


}
}//package kabam.rotmg.pets.view.dialogs
