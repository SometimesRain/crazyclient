package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.util.GraphicsUtil;

import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Shape;
import flash.display.Sprite;

import kabam.rotmg.constants.ItemConstants;

public class ItemTile extends Sprite {

    public static const TILE_DOUBLE_CLICK:String = "TILE_DOUBLE_CLICK";
    public static const TILE_SINGLE_CLICK:String = "TILE_SINGLE_CLICK";
    public static const WIDTH:int = 40;
    public static const HEIGHT:int = 40;
    public static const BORDER:int = 4;

    private var fill_:GraphicsSolidFill;
    private var path_:GraphicsPath;
    private var graphicsData_:Vector.<IGraphicsData>;
    private var restrictedUseIndicator:Shape;
    public var itemSprite:ItemTileSprite;
    public var tileId:int;
    public var ownerGrid:ItemGrid;
    public var blockingItemUpdates:Boolean;

    public function ItemTile(_arg_1:int, _arg_2:ItemGrid) {
        this.fill_ = new GraphicsSolidFill(this.getBackgroundColor(), 1);
        this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        this.graphicsData_ = new <IGraphicsData>[this.fill_, this.path_, GraphicsUtil.END_FILL];
        super();
        this.tileId = _arg_1;
        this.ownerGrid = _arg_2;
        this.restrictedUseIndicator = new Shape();
        addChild(this.restrictedUseIndicator);
        this.setItemSprite(new ItemTileSprite());
    }

    public function drawBackground(_arg_1:Array):void {
        GraphicsUtil.clearPath(this.path_);
        GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, HEIGHT, 4, _arg_1, this.path_);
        graphics.clear();
        graphics.drawGraphicsData(this.graphicsData_);
        var _local_2:GraphicsSolidFill = new GraphicsSolidFill(0x5C1D1D, 1); //red bg on items not usable by your class
        GraphicsUtil.clearPath(this.path_);
        var _local_3:Vector.<IGraphicsData> = new <IGraphicsData>[_local_2, this.path_, GraphicsUtil.END_FILL];
        GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, HEIGHT, 4, _arg_1, this.path_);
        this.restrictedUseIndicator.graphics.drawGraphicsData(_local_3);
        this.restrictedUseIndicator.cacheAsBitmap = true;
        this.restrictedUseIndicator.visible = false;
    }

    public function setItem(_arg_1:int):Boolean {
        if (_arg_1 == this.itemSprite.itemId) {
            return (false);
        }
        if (this.blockingItemUpdates) {
            return (true);
        }
        this.itemSprite.setType(_arg_1);
        this.updateUseability(this.ownerGrid.curPlayer);
        return (true);
    }

    public function setItemSprite(_arg_1:ItemTileSprite):void {
        this.itemSprite = _arg_1;
        this.itemSprite.x = (WIDTH / 2);
        this.itemSprite.y = (HEIGHT / 2);
        addChild(this.itemSprite);
    }

    public function updateUseability(_arg_1:Player):void {
        var _local_2:int = this.itemSprite.itemId;
        if(_local_2 >= 0x9000 && _local_2 < 0xF000)
        {
            _local_2 = 0x8FFF;
        }
        if (this.itemSprite.itemId != ItemConstants.NO_ITEM) {
            this.restrictedUseIndicator.visible = !(ObjectLibrary.isUsableByPlayer(_local_2, _arg_1));
        }
        else {
            this.restrictedUseIndicator.visible = false;
        }
    }

    public function canHoldItem(_arg_1:int):Boolean {
        return (true);
    }

    public function resetItemPosition():void {
        this.setItemSprite(this.itemSprite);
    }

    public function getItemId():int {
        if(this.itemSprite.itemId >= 0x9000 && this.itemSprite.itemId < 0xF000)
        {
            return 0x8FFF;
        }
        return (this.itemSprite.itemId);
    }

    protected function getBackgroundColor():int {
        return (0x545454);
    }


}
}//package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles
