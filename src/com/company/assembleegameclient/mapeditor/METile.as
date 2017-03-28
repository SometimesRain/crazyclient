package com.company.assembleegameclient.mapeditor {
public class METile {

    public var types_:Vector.<int>;
    public var objName_:String = null;
    public var layerNumber:int;

    public function METile() {
        this.types_ = new <int>[-1, -1, -1];
        this.layerNumber = 0;
    }

    public function clone():METile {
        var _local_1:METile = new METile();
        _local_1.types_ = this.types_.concat();
        _local_1.objName_ = this.objName_;
        return (_local_1);
    }

    public function isEmpty():Boolean {
        var _local_1:int = 0;
        while (_local_1 < Layer.NUM_LAYERS) {
            if (this.types_[_local_1] != -1) {
                return (false);
            }
            _local_1++;
        }
        return (true);
    }


}
}//package com.company.assembleegameclient.mapeditor
