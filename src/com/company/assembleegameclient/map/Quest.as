package com.company.assembleegameclient.map {
import com.company.assembleegameclient.objects.GameObject;

import flash.utils.getTimer;

public class Quest {

    public var map_:Map;
    public var objectId_:int = -1;
    private var questAvailableAt_:int = 0;
    private var questOldAt_:int = 0;

    public function Quest(_arg_1:Map) {
        this.map_ = _arg_1;
    }

    public function setObject(_arg_1:int):void {
        if ((((this.objectId_ == -1)) && (!((_arg_1 == -1))))) {
            this.questAvailableAt_ = getTimer();
            this.questOldAt_ = this.questAvailableAt_;
        }
        this.objectId_ = _arg_1;
    }

    public function completed():void {
        this.questAvailableAt_ = getTimer();
        this.questOldAt_ = this.questAvailableAt_;
    }

    public function getObject(_arg_1:int):GameObject {
        return (this.map_.goDict_[this.objectId_]);
    }

    public function isNew(_arg_1:int):Boolean {
        return ((_arg_1 < this.questOldAt_));
    }


}
}//package com.company.assembleegameclient.map
