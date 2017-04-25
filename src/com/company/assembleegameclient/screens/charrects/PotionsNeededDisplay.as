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

import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;

import org.swiftsuspenders.Injector;

public class PotionsNeededDisplay extends Sprite {

    private var classes:ClassesModel;
    private var model:PlayerModel;
	private var needed:Array = new Array(0,0,0,0,0,0,0,0); //life, mana, att, def, spd, dex, vit, wis
	private var potions:Array = new Array(0xae9,0xaea,0xa1f,0xa20,0xa21,0xa4c,0xa34,0xa35);

    public function PotionsNeededDisplay() {
        var curChar:SavedCharacter;
        var curClass:CharacterClass;
        super(); //is this necessary?
        var _local_1:Injector = StaticInjectorContext.getInjector();
        this.classes = _local_1.getInstance(ClassesModel);
        this.model = _local_1.getInstance(PlayerModel);
        var charlist:Vector.<SavedCharacter> = this.model.getSavedCharacters();
		//
		var max:int;
		var stat:int;
		var maxstats:Array;
		var stats:Array
		var i:int;
		var need:int;
        for each (curChar in charlist) { //loop through all characters
            curClass = this.classes.getCharacterClass(curChar.objectType());
			maxstats = new Array(curClass.hp.max, curClass.mp.max, curClass.attack.max, curClass.defense.max, curClass.speed.max, curClass.dexterity.max, curClass.hpRegeneration.max, curClass.mpRegeneration.max);
			stats = new Array(curChar.charXML_.MaxHitPoints, curChar.charXML_.MaxMagicPoints, curChar.charXML_.Attack, curChar.charXML_.Defense, curChar.charXML_.Speed, curChar.charXML_.Dexterity, curChar.charXML_.HpRegen, curChar.charXML_.MpRegen);
			for (i = 0; i < 8; i++) {
				max = maxstats[i];
				stat = stats[i];
				if (max > stat) {
					if (i > 1) { //att, def, spd, dex, vit, wis
						needed[i] += max - stat;
					}
					else { //life, mana
						need = max - stat;
						if (need % 5 == 0) {
							needed[i] += int((max - stat) / 5);
						}
						else {
							needed[i] += int((max - stat) / 5) + 1;
						}
					}
				}
			}
        }
		drawDisplay();
    }
	
	private function drawDisplay():void {
		var display:PotionNeededDisplay;
		var pad:int = 70;
		for (var i:int = 0; i < 8; i++) {
			display = new PotionNeededDisplay(potions[i], needed[i]);
			display.x = pad * i;
			addChild(display);
		}
	}
}
}//package com.company.assembleegameclient.screens.charrects