package kabam.rotmg.messaging.impl.incoming {
import com.company.assembleegameclient.util.FreeList;

import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.data.GroundTileData;
import kabam.rotmg.messaging.impl.data.ObjectData;

public class Update extends IncomingMessage {

    public var tiles_:Vector.<GroundTileData>;
    public var newObjs_:Vector.<ObjectData>;
    public var drops_:Vector.<int>;

    public function Update(_arg_1:uint, _arg_2:Function) {
        this.tiles_ = new Vector.<GroundTileData>();
        this.newObjs_ = new Vector.<ObjectData>();
        this.drops_ = new Vector.<int>();
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        var _local_2:int;
        var _local_3:int = _arg_1.readShort();
        _local_2 = _local_3;
        while (_local_2 < this.tiles_.length) {
            FreeList.deleteObject(this.tiles_[_local_2]);
            _local_2++;
        }
        this.tiles_.length = Math.min(_local_3, this.tiles_.length);
        while (this.tiles_.length < _local_3) {
            this.tiles_.push((FreeList.newObject(GroundTileData) as GroundTileData));
        }
        _local_2 = 0;
        while (_local_2 < _local_3) {
            this.tiles_[_local_2].parseFromInput(_arg_1);
            _local_2++;
        }
        this.newObjs_.length = 0;
        _local_3 = _arg_1.readShort();
        _local_2 = _local_3;
        while (_local_2 < this.newObjs_.length) {
            FreeList.deleteObject(this.newObjs_[_local_2]);
            _local_2++;
        }
        this.newObjs_.length = Math.min(_local_3, this.newObjs_.length);
        while (this.newObjs_.length < _local_3) {
            this.newObjs_.push((FreeList.newObject(ObjectData) as ObjectData));
        }
        _local_2 = 0;
        while (_local_2 < _local_3) {
            this.newObjs_[_local_2].parseFromInput(_arg_1);
            _local_2++;
        }
        this.drops_.length = 0;
        var _local_4:int = _arg_1.readShort();
        _local_2 = 0;
        while (_local_2 < _local_4) {
            this.drops_.push(_arg_1.readInt());
            _local_2++;
        }
    }

    override public function toString():String {
        return (formatToString("UPDATE", "tiles_", "newObjs_", "drops_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
