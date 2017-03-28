package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class InventoryTile extends InteractiveItemTile {

    private static const IDENTITY_MATRIX:Matrix = new Matrix();

    public var hotKey:int;
    private var hotKeyBMP:Bitmap;

    public function InventoryTile(_arg_1:int, _arg_2:ItemGrid, _arg_3:Boolean) {
        super(_arg_1, _arg_2, _arg_3);
    }

    public function addTileNumber(_arg_1:int):void {
        this.hotKey = _arg_1;
        this.buildHotKeyBMP();
    }

    public function buildHotKeyBMP():void {
        var _local_1:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
        var _local_2:BitmapData = _local_1.make(new StaticStringBuilder(String(this.hotKey)), 26, 0x363636, true, IDENTITY_MATRIX, false);
        this.hotKeyBMP = new Bitmap(_local_2);
        this.hotKeyBMP.x = ((WIDTH / 2) - (this.hotKeyBMP.width / 2));
        this.hotKeyBMP.y = ((HEIGHT / 2) - 14);
        addChildAt(this.hotKeyBMP, 0);
    }

    override public function setItemSprite(_arg_1:ItemTileSprite):void {
        super.setItemSprite(_arg_1);
        _arg_1.setDim(false);
    }

    override public function setItem(_arg_1:int):Boolean {
        var _local_2:Boolean = super.setItem(_arg_1);
        if (_local_2) {
            this.hotKeyBMP.visible = (itemSprite.itemId <= 0);
        }
        return (_local_2);
    }

    override protected function beginDragCallback():void {
        this.hotKeyBMP.visible = true;
    }

    override protected function endDragCallback():void {
        this.hotKeyBMP.visible = (itemSprite.itemId <= 0);
    }


}
}//package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles
