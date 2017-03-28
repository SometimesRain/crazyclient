package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;

public class InventoryGrid extends ItemGrid {

    private const NUM_SLOTS:uint = 8;

    private var tiles:Vector.<InventoryTile>;
    private var isBackpack:Boolean;

    public function InventoryGrid(_arg_1:GameObject, _arg_2:Player, _arg_3:int = 0, _arg_4:Boolean = false) {
        var _local_6:InventoryTile;
        super(_arg_1, _arg_2, _arg_3);
        this.tiles = new Vector.<InventoryTile>(this.NUM_SLOTS);
        this.isBackpack = _arg_4;
        var _local_5:int;
        while (_local_5 < this.NUM_SLOTS) {
            _local_6 = new InventoryTile((_local_5 + indexOffset), this, interactive);
            _local_6.addTileNumber((_local_5 + 1));
            addToGrid(_local_6, 2, _local_5);
            this.tiles[_local_5] = _local_6;
            _local_5++;
        }
    }

    override public function setItems(_arg_1:Vector.<int>, _arg_2:int = 0):void {
        var _local_3:Boolean;
        var _local_4:int;
        var _local_5:int;
        if (_arg_1) {
            _local_3 = false;
            _local_4 = _arg_1.length;
            _local_5 = 0;
            while (_local_5 < this.NUM_SLOTS) {
                if ((_local_5 + indexOffset) < _local_4) {
                    if (this.tiles[_local_5].setItem(_arg_1[(_local_5 + indexOffset)])) {
                        _local_3 = true;
                    }
                }
                else {
                    if (this.tiles[_local_5].setItem(-1)) {
                        _local_3 = true;
                    }
                }
                _local_5++;
            }
            if (_local_3) {
                refreshTooltip();
            }
        }
    }


}
}//package com.company.assembleegameclient.ui.panels.itemgrids
