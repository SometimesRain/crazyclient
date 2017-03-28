package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.util.FreeList;

public class BubbleParticle extends Particle {

    private const SPREAD_DAMPER:Number = 0.0025;

    public var startTime:int;
    public var speed:Number;
    public var spread:Number;
    public var dZ:Number;
    public var life:Number;
    public var lifeVariance:Number;
    public var speedVariance:Number;
    public var timeLeft:Number;
    public var frequencyX:Number;
    public var frequencyY:Number;

    public function BubbleParticle(_arg_1:uint, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number) {
        super(_arg_1, 0, (75 + (Math.random() * 50)));
        this.dZ = _arg_2;
        this.life = (_arg_3 * 1000);
        this.lifeVariance = _arg_4;
        this.speedVariance = _arg_5;
        this.spread = _arg_6;
        this.frequencyX = 0;
        this.frequencyY = 0;
    }

    public static function create(_arg_1:*, _arg_2:uint, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number):BubbleParticle {
        var _local_8:BubbleParticle = (FreeList.getObject(_arg_1) as BubbleParticle);
        if (!_local_8) {
            _local_8 = new (BubbleParticle)(_arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
        }
        return (_local_8);
    }


    public function restart(_arg_1:int, _arg_2:int):void {
        this.startTime = _arg_1;
        var _local_3:Number = Math.random();
        this.speed = ((this.dZ - (this.dZ * (_local_3 * (1 - this.speedVariance)))) * 10);
        if (this.spread > 0) {
            this.frequencyX = ((Math.random() * this.spread) - 0.1);
            this.frequencyY = ((Math.random() * this.spread) - 0.1);
        }
        var _local_4:Number = ((_arg_2 - _arg_1) / 1000);
        this.timeLeft = (this.life - (this.life * (_local_3 * (1 - this.lifeVariance))));
        z_ = (this.speed * _local_4);
    }

    override public function removeFromMap():void {
        super.removeFromMap();
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_3:Number = ((_arg_1 - this.startTime) / 1000);
        this.timeLeft = (this.timeLeft - _arg_2);
        if (this.timeLeft <= 0) {
            return (false);
        }
        z_ = (this.speed * _local_3);
        if (this.spread > 0) {
            moveTo((x_ + ((this.frequencyX * _arg_2) * this.SPREAD_DAMPER)), (y_ + ((this.frequencyY * _arg_2) * this.SPREAD_DAMPER)));
        }
        return (true);
    }


}
}//package com.company.assembleegameclient.objects.particles
