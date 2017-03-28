package com.company.assembleegameclient.objects.particles {
public class EffectProperties {

    public var id:String;
    public var particle:String;
    public var cooldown:Number;
    public var color:uint;
    public var rate:Number;
    public var speed:Number;
    public var speedVariance:Number;
    public var spread:Number;
    public var life:Number;
    public var lifeVariance:Number;
    public var size:int;
    public var friction:Number;
    public var rise:Number;
    public var riseVariance:Number;
    public var riseAcc:Number;
    public var rangeX:int;
    public var rangeY:int;
    public var zOffset:Number;
    public var bitmapFile:String;
    public var bitmapIndex:uint;

    public function EffectProperties(_arg_1:XML) {
        this.id = _arg_1.toString();
        this.particle = _arg_1.@particle;
        this.cooldown = _arg_1.@cooldown;
        this.color = _arg_1.@color;
        this.rate = ((Number(_arg_1.@rate)) || (5));
        this.speed = ((Number(_arg_1.@speed)) || (0));
        this.speedVariance = ((Number(_arg_1.@speedVariance)) || (0.5));
        this.spread = ((Number(_arg_1.@spread)) || (0));
        this.life = ((Number(_arg_1.@life)) || (1));
        this.lifeVariance = ((Number(_arg_1.@lifeVariance)) || (0));
        this.size = ((int(_arg_1.@size)) || (3));
        this.rise = ((Number(_arg_1.@rise)) || (3));
        this.riseVariance = ((Number(_arg_1.@riseVariance)) || (0));
        this.riseAcc = ((Number(_arg_1.@riseAcc)) || (0));
        this.rangeX = ((int(_arg_1.@rangeX)) || (0));
        this.rangeY = ((int(_arg_1.@rangeY)) || (0));
        this.zOffset = ((Number(_arg_1.@zOffset)) || (0));
        this.bitmapFile = _arg_1.@bitmapFile;
        this.bitmapIndex = _arg_1.@bitmapIndex;
    }

}
}//package com.company.assembleegameclient.objects.particles
