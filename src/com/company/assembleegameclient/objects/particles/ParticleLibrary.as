package com.company.assembleegameclient.objects.particles {
public class ParticleLibrary {

    public static const propsLibrary_:Object = {};


    public static function parseFromXML(_arg_1:XML):void {
        var _local_2:XML;
        for each (_local_2 in _arg_1.Particle) {
            propsLibrary_[_local_2.@id] = new ParticleProperties(_local_2);
        }
    }


}
}//package com.company.assembleegameclient.objects.particles
