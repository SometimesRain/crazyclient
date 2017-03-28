package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;

public class ParticleGenerator extends ParticleEffect {

    private var particlePool:Vector.<BaseParticle>;
    private var liveParticles:Vector.<BaseParticle>;
    private var targetGO:GameObject;
    private var generatedParticles:Number = 0;
    private var totalTime:Number = 0;
    private var effectProps:EffectProperties;
    private var bitmapData:BitmapData;
    private var friction:Number;

    public function ParticleGenerator(_arg_1:EffectProperties, _arg_2:GameObject) {
        this.targetGO = _arg_2;
        this.particlePool = new Vector.<BaseParticle>();
        this.liveParticles = new Vector.<BaseParticle>();
        this.effectProps = _arg_1;
        if (this.effectProps.bitmapFile) {
            this.bitmapData = AssetLibrary.getImageFromSet(this.effectProps.bitmapFile, this.effectProps.bitmapIndex);
            this.bitmapData = TextureRedrawer.redraw(this.bitmapData, this.effectProps.size, true, 0);
        }
        else {
            this.bitmapData = TextureRedrawer.redrawSolidSquare(this.effectProps.color, this.effectProps.size);
        }
    }

    public static function attachParticleGenerator(_arg_1:EffectProperties, _arg_2:GameObject):ParticleGenerator {
        return (new (ParticleGenerator)(_arg_1, _arg_2));
    }


    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_4:Number;
        var _local_9:BaseParticle;
        var _local_10:BaseParticle;
        var _local_3:Number = (_arg_1 / 1000);
        _local_4 = (_arg_2 / 1000);
        if (this.targetGO.map_ == null) {
            return (false);
        }
        x_ = this.targetGO.x_;
        y_ = this.targetGO.y_;
        z_ = (this.targetGO.z_ + this.effectProps.zOffset);
        this.totalTime = (this.totalTime + _local_4);
        var _local_5:Number = (this.effectProps.rate * this.totalTime);
        var _local_6:int = (_local_5 - this.generatedParticles);
        var _local_7:int;
        while (_local_7 < _local_6) {
            if (this.particlePool.length) {
                _local_9 = this.particlePool.pop();
            }
            else {
                _local_9 = new BaseParticle(this.bitmapData);
            }
            _local_9.initialize((this.effectProps.life + (this.effectProps.lifeVariance * ((2 * Math.random()) - 1))), (this.effectProps.speed + (this.effectProps.speedVariance * ((2 * Math.random()) - 1))), (this.effectProps.speed + (this.effectProps.speedVariance * ((2 * Math.random()) - 1))), (this.effectProps.rise + (this.effectProps.riseVariance * ((2 * Math.random()) - 1))), z_);
            map_.addObj(_local_9, (x_ + (this.effectProps.rangeX * ((2 * Math.random()) - 1))), (y_ + (this.effectProps.rangeY * ((2 * Math.random()) - 1))));
            this.liveParticles.push(_local_9);
            _local_7++;
        }
        this.generatedParticles = (this.generatedParticles + _local_6);
        var _local_8:int;
        while (_local_8 < this.liveParticles.length) {
            _local_10 = this.liveParticles[_local_8];
            _local_10.timeLeft = (_local_10.timeLeft - _local_4);
            if (_local_10.timeLeft <= 0) {
                this.liveParticles.splice(_local_8, 1);
                map_.removeObj(_local_10.objectId_);
                _local_8--;
                this.particlePool.push(_local_10);
            }
            else {
                _local_10.spdZ = (_local_10.spdZ + (this.effectProps.riseAcc * _local_4));
                _local_10.x_ = (_local_10.x_ + (_local_10.spdX * _local_4));
                _local_10.y_ = (_local_10.y_ + (_local_10.spdY * _local_4));
                _local_10.z_ = (_local_10.z_ + (_local_10.spdZ * _local_4));
            }
            _local_8++;
        }
        return (true);
    }

    override public function removeFromMap():void {
        var _local_1:BaseParticle;
        for each (_local_1 in this.liveParticles) {
            map_.removeObj(_local_1.objectId_);
        }
        this.liveParticles = null;
        this.particlePool = null;
        super.removeFromMap();
    }


}
}//package com.company.assembleegameclient.objects.particles
