package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.IGraphicsData;

public class ParticleEffect extends GameObject {

    public var reducedDrawEnabled:Boolean;

    public function ParticleEffect() {
        super(null);
        objectId_ = getNextFakeObjectId();
        hasShadow_ = false;
        this.reducedDrawEnabled = false;
    }

    public static function fromProps(_arg_1:EffectProperties, _arg_2:GameObject):ParticleEffect {
		if (Parameters.data_["AntiLag"] && _arg_1.id != "Vent") {
			return null;
		}
        switch (_arg_1.id) {
            case "Healing":
                return (new HealingEffect(_arg_2));
            case "Fountain":
                return (new FountainEffect(_arg_2, _arg_1));
            case "FountainSnowy":
                return new FountainSnowyEffect(_arg_2, _arg_1);
            case "Gas":
                return (new GasEffect(_arg_2, _arg_1));
            case "Vent":
                return (new VentEffect(_arg_2));
            case "Bubbles":
                return (new BubbleEffect(_arg_2, _arg_1));
            case "XMLEffect":
                return (new XMLEffect(_arg_2, _arg_1));
            case "CustomParticles":
                return (ParticleGenerator.attachParticleGenerator(_arg_1, _arg_2));
        }
        return (null);
    }


    override public function update(_arg_1:int, _arg_2:int):Boolean {
        if (this.reducedDrawEnabled) {
            return (this.runEasyRendering(_arg_1, _arg_2));
        }
        return (this.runNormalRendering(_arg_1, _arg_2));
    }

    public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean {
        return (false);
    }

    public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean {
        return (false);
    }

    override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
    }


}
}//package com.company.assembleegameclient.objects.particles
