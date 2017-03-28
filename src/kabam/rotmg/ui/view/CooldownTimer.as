package kabam.rotmg.ui.view {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.parameters.Parameters;
import flash.display.Graphics;
import flash.utils.getTimer;

import flash.display.Sprite;
import flash.events.Event;

public class CooldownTimer extends Sprite {
	
	private var percentage:Number = 1;
	private var tper:Number = 0;
	private var circleToMask:Sprite;
	private var circleMask:Sprite;
	private var cd:int = 500;

    public function CooldownTimer() {
		circleToMask = new Sprite();
		circleToMask.graphics.beginFill(0, 0.7);
		circleToMask.graphics.drawRect(0,0,40,40);
		circleToMask.graphics.endFill();
		addChild(circleToMask);
		
		circleMask = new Sprite();
		circleMask.x = 20;
		circleMask.y = 20;
		circleToMask.mask = circleMask;
		addChild(circleMask);
    }

    public function update(_arg_1:Player):void {
		percentage = (getTimer() - _arg_1.lastAltAttack_) / cd;
		if (percentage < 1) {
			//draw the masked circle
			circleMask.graphics.clear();
			circleMask.graphics.beginFill(0);
			drawPieMask(circleMask.graphics, percentage, 20 * Math.sqrt(2) , 0, 0, -(Math.PI) / 2, 3);
			circleMask.graphics.endFill();
		}
		else {
			circleMask.graphics.clear();
			cd = 500;
			var abilXML:XML = ObjectLibrary.xmlLibrary_[_arg_1.equipment_[1]];
			if (abilXML != null && abilXML.hasOwnProperty("Cooldown")) {
				cd = (Number(abilXML.Cooldown) * 1000);
				_arg_1.lastAltAttack_ = getTimer() - cd; //may have negative side effects
			}
		}
    }
	
	private function drawPieMask(graphics:Graphics, p:Number, radius:Number, x:Number = 0, y:Number = 0, rotation:Number = 0, sides:int = 6):void {
		p = 1 - p;
		//graphics should have its beginFill function already called by now
		graphics.moveTo(x, y);
		if (sides < 3) sides = 3; //3 sides minimum
		//increase the length of the radius to cover the whole target
		radius /= Math.cos(1/sides * Math.PI);
		//shortcut function
		var lineToRadians:Function = function(rads:Number):void {
			rads = Math.PI - rads;
			graphics.lineTo(Math.cos(rads) * radius + x, Math.sin(rads) * radius + y);
		};
		//find how many sides we have to draw
		var sidesToDraw:int = Math.floor(p * sides);
		for (var i:int = 0; i <= sidesToDraw; i++)
			lineToRadians((i / sides) * (Math.PI * 2) + rotation);
		//draw the last fractioned side
		if (p * sides != sidesToDraw) {
			//trace("degrees "+180/Math.PI*(p * (Math.PI * 2) + rotation));
			lineToRadians(p * (Math.PI * 2) + rotation);
		}
	} 
}
}//package kabam.rotmg.ui.view