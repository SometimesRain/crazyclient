package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
import kabam.rotmg.text.view.BitmapTextFactory;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ItemTileSpriteMediator extends Mediator {

    [Inject]
    public var bitmapFactor:BitmapTextFactory;
    [Inject]
    public var view:ItemTileSprite;


    override public function initialize():void {
        this.view.setBitmapFactory(this.bitmapFactor);
        this.view.drawTile();
    }


}
}//package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles
