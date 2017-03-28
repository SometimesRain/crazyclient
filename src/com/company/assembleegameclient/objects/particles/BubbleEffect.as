package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.FreeList;

public class BubbleEffect extends ParticleEffect {

    private static const PERIOD_MAX:Number = 400;

    private var poolID:String;
    public var go_:GameObject;
    public var lastUpdate_:int = -1;
    public var rate_:Number;
    private var fxProps:EffectProperties;

    public function BubbleEffect(_arg_1:GameObject, _arg_2:EffectProperties) {
        this.go_ = _arg_1;
        this.fxProps = _arg_2;
        this.rate_ = (((1 - _arg_2.rate) * PERIOD_MAX) + 1);
        this.poolID = ("BubbleEffect_" + Math.random());
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_3:int;
        var _local_5:int;
        var _local_6:Number;
        var _local_7:Number;
        var _local_8:Number;
        var _local_9:Number;
        var _local_11:BubbleParticle;
        var _local_12:Number;
        var _local_13:Number;
        if (this.go_.map_ == null) {
            return (false);
        }
        if (!this.lastUpdate_) {
            this.lastUpdate_ = _arg_1;
            return (true);
        }
        _local_3 = int((this.lastUpdate_ / this.rate_));
        var _local_4:int = int((_arg_1 / this.rate_));
        _local_8 = this.go_.x_;
        _local_9 = this.go_.y_;
        if (this.lastUpdate_ < 0) {
            this.lastUpdate_ = Math.max(0, (_arg_1 - PERIOD_MAX));
        }
        x_ = _local_8;
        y_ = _local_9;
        var _local_10:int = _local_3;
        while (_local_10 < _local_4) {
            _local_5 = (_local_10 * this.rate_);
            _local_11 = BubbleParticle.create(this.poolID, this.fxProps.color, this.fxProps.speed, this.fxProps.life, this.fxProps.lifeVariance, this.fxProps.speedVariance, this.fxProps.spread);
            _local_11.restart(_local_5, _arg_1);
            _local_6 = (Math.random() * Math.PI);
            _local_7 = (Math.random() * 0.4);
            _local_12 = (_local_8 + (_local_7 * Math.cos(_local_6)));
            _local_13 = (_local_9 + (_local_7 * Math.sin(_local_6)));
            map_.addObj(_local_11, _local_12, _local_13);
            _local_10++;
        }
        this.lastUpdate_ = _arg_1;
        return (true);
    }

    override public function removeFromMap():void {
        super.removeFromMap();
        FreeList.dump(this.poolID);
    }


}
}//package com.company.assembleegameclient.objects.particles
