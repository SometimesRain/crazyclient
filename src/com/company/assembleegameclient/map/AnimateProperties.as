package com.company.assembleegameclient.map {
public class AnimateProperties {

    public static const NO_ANIMATE:int = 0;
    public static const WAVE_ANIMATE:int = 1;
    public static const FLOW_ANIMATE:int = 2;

    public var type_:int = 0;
    public var dx_:Number = 0;
    public var dy_:Number = 0;


    public function parseXML(_arg_1:XML):void {
        switch (String(_arg_1)) {
            case "Wave":
                this.type_ = WAVE_ANIMATE;
                break;
            case "Flow":
                this.type_ = FLOW_ANIMATE;
                break;
        }
        this.dx_ = _arg_1.@dx;
        this.dy_ = _arg_1.@dy;
    }


}
}//package com.company.assembleegameclient.map
