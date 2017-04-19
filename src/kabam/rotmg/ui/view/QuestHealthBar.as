package kabam.rotmg.ui.view {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.ui.ExperienceBoostTimerPopup;
import com.company.assembleegameclient.ui.StatusBar;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.Sprite;
import flash.events.Event;
import flash.utils.getTimer;

public class QuestHealthBar extends Sprite {

    private var questBar:StatusBar;
    private var questBar2:StatusBar;
    private var questBar3:StatusBar;
	private var nextUpdate:int = 0;
	private var showstr:String;

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
	
	private function genClosest(p:Player):String {
		var go:GameObject;
		var closest:GameObject;
		var dist:int = int.MAX_VALUE;
		var temp:int;
		for each(go in p.map_.goDict_) {
			if (go is Player) {
				//temp = Math.abs(go.x_ - p.questMob.x_) + Math.abs(go.y_ - p.questMob.y_); //wtf
				temp = (go.x_ - p.questMob.x_) * (go.x_ - p.questMob.x_) + (go.y_ - p.questMob.y_) * (go.y_ - p.questMob.y_);
				if (temp < dist) {
					dist = temp;
					closest = go;
				}
			}
		}
		return " - " + closest.name_ + ": " + dist;
	}

    public function update(_arg_1:Player):void {
		var active:String = "";
		if (_arg_1.questMob != null || _arg_1.questMob1 != null) {
			var whichMob:GameObject = _arg_1.questMob1 || _arg_1.questMob;
			questBar.draw(whichMob.hp_, whichMob.maxHP_, 0);
			var type:int = whichMob.objectType_;
			if (type == 3368) {
				active = (Parameters.data_.tombHack && Parameters.data_.curBoss == 3368 && whichMob == _arg_1.questMob1) ? ": Active" : "";
			}
			if (Parameters.data_.questClosest && _arg_1.questMob != null) {
				//trace("will update:", nextUpdate <= getTimer(), nextUpdate, "<=", getTimer());
				if (nextUpdate <= getTimer()) {
					showstr = genClosest(_arg_1);
					nextUpdate = getTimer() + 500;
				}
				active = showstr;
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