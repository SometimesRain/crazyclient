package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class Damage extends IncomingMessage {

    public var targetId_:int;
    public var effects_:Vector.<uint>;
    public var damageAmount_:int;
    public var kill_:Boolean;
    public var bulletId_:uint;
    public var objectId_:int;

    public function Damage(_arg_1:uint, _arg_2:Function) {
        this.effects_ = new Vector.<uint>();
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.targetId_ = _arg_1.readInt();
        this.effects_.length = 0;
        var _local_2:int = _arg_1.readUnsignedByte();
        var _local_3:uint;
        while (_local_3 < _local_2) {
            this.effects_.push(_arg_1.readUnsignedByte());
            _local_3++;
        }
        this.damageAmount_ = _arg_1.readUnsignedShort();
        this.kill_ = _arg_1.readBoolean();
        this.bulletId_ = _arg_1.readUnsignedByte();
        this.objectId_ = _arg_1.readInt();
    }

    override public function toString():String {
        return (formatToString("DAMAGE", "targetId_", "effects_", "damageAmount_", "kill_", "bulletId_", "objectId_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
