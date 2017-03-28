package com.company.assembleegameclient.objects.animation {
public class AnimationsData {

    public var animations:Vector.<AnimationData>;

    public function AnimationsData(_arg_1:XML) {
        var _local_2:XML;
        this.animations = new Vector.<AnimationData>();
        super();
        for each (_local_2 in _arg_1.Animation) {
            this.animations.push(new AnimationData(_local_2));
        }
    }

}
}//package com.company.assembleegameclient.objects.animation
