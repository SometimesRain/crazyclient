package com.company.assembleegameclient.screens.charrects {
import com.company.assembleegameclient.appengine.CharacterStats;
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.objects.ObjectLibrary;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;

import org.swiftsuspenders.Injector;

public class PotionNeededDisplay extends Sprite {
	
	private var text:TextFieldDisplayConcrete;
	private var icon:DisplayObject;

    public function PotionNeededDisplay(potion:int, count:int) {
		icon = getItemIcon(potion);
		icon.y = -13;
		text = new TextFieldDisplayConcrete().setSize(20).setColor(0xB3B3B3);
        text.setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        text.setStringBuilder(new StaticStringBuilder(count.toString()));
        text.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
		text.x = 52;
        addChild(this.text);
        addChild(this.icon);
    }

    private function getItemIcon(itemid:int):DisplayObject { //DisplayObject
        return new Bitmap(ObjectLibrary.getRedrawnTextureFromType(itemid, 60, true));
    }
}
}//package com.company.assembleegameclient.screens.charrects