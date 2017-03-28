package com.company.assembleegameclient.tutorial {
import com.company.assembleegameclient.objects.ObjectLibrary;

public class Requirement {

    public var type_:String;
    public var slot_:int = -1;
    public var objectType_:int = -1;
    public var objectName_:String = "";
    public var radius_:Number = 1;

    public function Requirement(_arg_1:XML) {
        this.type_ = String(_arg_1);
        var _local_2:String = String(_arg_1.@objectId);
        if (((!((_local_2 == null))) && (!((_local_2 == ""))))) {
            this.objectType_ = ObjectLibrary.idToType_[_local_2];
        }
        this.objectName_ = String(_arg_1.@objectName).replace("tutorial_script", "tutorial");
        if (this.objectName_ == null) {
            this.objectName_ = "";
        }
        this.slot_ = int(_arg_1.@slot);
        this.radius_ = Number(_arg_1.@radius);
    }

}
}//package com.company.assembleegameclient.tutorial
