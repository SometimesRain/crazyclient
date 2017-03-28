package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;

public class ContainerGrid extends ItemGrid {

    private const NUM_SLOTS:uint = 8;

    private var tiles:Vector.<InteractiveItemTile>;

    public function ContainerGrid(_arg_1:GameObject, _arg_2:Player) {
        var _local_4:InteractiveItemTile;
        super(_arg_1, _arg_2, 0);
        this.tiles = new Vector.<InteractiveItemTile>(this.NUM_SLOTS);
        var _local_3:int;
        while (_local_3 < this.NUM_SLOTS) {
            _local_4 = new InteractiveItemTile((_local_3 + indexOffset), this, interactive);
            addToGrid(_local_4, 2, _local_3);
            this.tiles[_local_3] = _local_4;
            _local_3++;
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
