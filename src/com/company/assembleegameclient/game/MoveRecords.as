package com.company.assembleegameclient.game {
import kabam.rotmg.messaging.impl.data.MoveRecord;

public class MoveRecords {

    public var lastClearTime_:int = -1;
    public var records_:Vector.<MoveRecord>;

    public function MoveRecords() {
        this.records_ = new Vector.<MoveRecord>();
        super();
    }

    public function addRecord(_arg_1:int, _arg_2:Number, _arg_3:Number):void {
        if (this.lastClearTime_ < 0) {
            return;
        }
        var _local_4:int = this.getId(_arg_1);
        if ((((_local_4 < 1)) || ((_local_4 > 10)))) {
            return;
        }
        if (this.records_.length == 0) {
            this.records_.push(new MoveRecord(_arg_1, _arg_2, _arg_3));
            return;
        }
        var _local_5:MoveRecord = this.records_[(this.records_.length - 1)];
        var _local_6:int = this.getId(_local_5.time_);
        if (_local_4 != _local_6) {
            this.records_.push(new MoveRecord(_arg_1, _arg_2, _arg_3));
            return;
        }
        var _local_7:int = this.getScore(_local_4, _arg_1);
        var _local_8:int = this.getScore(_local_4, _local_5.time_);
        if (_local_7 < _local_8) {
            _local_5.time_ = _arg_1;
            _local_5.x_ = _arg_2;
            _local_5.y_ = _arg_3;
            return;
        }
    }

    private function getId(_arg_1:int):int {
        return ((((_arg_1 - this.lastClearTime_) + 50) / 100));
    }

    private function getScore(_arg_1:int, _arg_2:int):int {
        return (Math.abs(((_arg_2 - this.lastClearTime_) - (_arg_1 * 100))));
    }

    public function clear(_arg_1:int):void {
        this.records_.length = 0;
        this.lastClearTime_ = _arg_1;
    }


}
}//package com.company.assembleegameclient.game
