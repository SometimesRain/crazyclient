package com.company.assembleegameclient.screens.charrects {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.assets.services.IconFactory;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class BuyCharacterRect extends CharacterRect {

    public static const BUY_CHARACTER_RECT_CLASS_NAME_TEXT:String = "BuyCharacterRect.classNameText";

    private var model:PlayerModel;

    public function BuyCharacterRect(_arg_1:PlayerModel) {
        this.model = _arg_1;
        super.color = 0x1F1F1F;
        super.overColor = 0x424242;
		var nextSlot:int = _arg_1.getMaxCharacters() + 1;
        className = new LineBuilder().setParams("Buy Slot #"+nextSlot);
        super.init();
        this.makeIcon();
        this.makeTagline();
        this.makePriceText();
        this.makeCoin();
    }

    private function makeCoin():void {
        var _local_2:Bitmap;
        var _local_1:BitmapData = IconFactory.makeCoin();
        _local_2 = new Bitmap(_local_1);
        _local_2.x = WIDTH - 96;//(WIDTH - 43);
        _local_2.y = 22;//(((HEIGHT - _local_2.height) * 0.5) - 1);
        selectContainer.addChild(_local_2);
    }

    private function makePriceText():void {
        var _local_1:TextFieldDisplayConcrete;
        _local_1 = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setAutoSize(TextFieldAutoSize.RIGHT);
        _local_1.setStringBuilder(new StaticStringBuilder(this.model.getNextCharSlotPrice().toString()));
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        _local_1.x = WIDTH - 96;//(WIDTH - 43);
        _local_1.y = 22; //19
        selectContainer.addChild(_local_1);
    }

    private function makeTagline():void {
        //var _local_1:int = (100 - (this.model.getNextCharSlotPrice() / 10));
        //var _local_2:String = String(_local_1);
        //if (_local_1 != 0) makeTaglineText(new LineBuilder().setParams(TextKey.BUY_CHARACTER_RECT_TAGLINE_TEXT, {"percentage": _local_2}));
    }

    private function makeIcon():void {
        var _local_1:Shape;
        _local_1 = this.buildIcon();
        _local_1.x = (CharacterRectConstants.ICON_POS_X + 5);
        _local_1.y = 0; //((HEIGHT - _local_1.height) * 0.5);
        addChild(_local_1);
    }

    private function buildIcon():Shape {
        var _local_1:Shape = new Shape();
        _local_1.graphics.beginFill(3880246);
        _local_1.graphics.lineStyle(1, 4603457);
        _local_1.graphics.drawCircle(19, 19, 19);
        _local_1.graphics.lineStyle();
        _local_1.graphics.endFill();
        _local_1.graphics.beginFill(0x1F1F1F);
        _local_1.graphics.drawRect(11, 17, 16, 4);
        _local_1.graphics.endFill();
        _local_1.graphics.beginFill(0x1F1F1F);
        _local_1.graphics.drawRect(17, 11, 4, 16);
        _local_1.graphics.endFill();
        return (_local_1);
    }


}
}//package com.company.assembleegameclient.screens.charrects
