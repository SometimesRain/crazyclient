package kabam.rotmg.ui.view {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.ui.ExperienceBoostTimerPopup;
import com.company.assembleegameclient.ui.StatusBar;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.Sprite;
import flash.events.Event;

public class QuestHealthBar extends Sprite {

    private var questBar:StatusBar;
    private var questBar2:StatusBar;
    private var questBar3:StatusBar;

    public function QuestHealthBar() {
        questBar = new StatusBar(194, 16, 0xC52222, 0x545454, "Quest", true);
        questBar2 = new StatusBar(194, 16, 0xC52222, 0x545454, "Quest", true);
        questBar3 = new StatusBar(194, 16, 0xC52222, 0x545454, "Quest", true);
		questBar.visible = false;
		questBar2.visible = false;
		questBar3.visible = false;
		questBar2.x = 198;
		questBar3.x = 396;
        addChild(this.questBar);
        addChild(this.questBar2);
        addChild(this.questBar3);
    }

    public function update(_arg_1:Player):void {
		var active:String = "";
		if (_arg_1.questMob != null || _arg_1.questMob1 != null) {
			var whichMob:GameObject = _arg_1.questMob1 || _arg_1.questMob;
			questBar.draw(whichMob.hp_, whichMob.maxHP_, 0);
			var type:int = whichMob.objectType_;
			if (type != 0x714b && type != 0x715d && type != 0x716f) {
				active = (Parameters.data_.tombHack && Parameters.data_.curBoss == 3368 && whichMob == _arg_1.questMob1) ? ": Active" : "";
			}
			questBar.setLabelText(ObjectLibrary.typeToDisplayId_[whichMob.objectType_]+active);
			questBar.visible = true;
		}
		else {
			questBar.visible = false;
		}
		
		if (_arg_1.questMob2 != null) {
			questBar2.draw(_arg_1.questMob2.hp_, _arg_1.questMob2.maxHP_, 0);
			active = (Parameters.data_.tombHack && Parameters.data_.curBoss == 3366) ? ": Active" : "";
			questBar2.setLabelText(ObjectLibrary.typeToDisplayId_[_arg_1.questMob2.objectType_]+active);
			questBar2.visible = true;
		}
		else {
			questBar2.visible = false;
		}
		
		if (_arg_1.questMob3 != null) {
			questBar3.draw(_arg_1.questMob3.hp_, _arg_1.questMob3.maxHP_, 0);
			active = (Parameters.data_.tombHack && Parameters.data_.curBoss == 3367) ? ": Active" : "";
			questBar3.setLabelText(ObjectLibrary.typeToDisplayId_[_arg_1.questMob3.objectType_]+active);
			questBar3.visible = true;
		}
		else {
			questBar3.visible = false;
		}
    }
}
}//package kabam.rotmg.ui.view