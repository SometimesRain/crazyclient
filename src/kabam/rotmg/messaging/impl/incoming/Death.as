package kabam.rotmg.messaging.impl.incoming {
import flash.display.BitmapData;
import flash.utils.IDataInput;

public class Death extends IncomingMessage {

    public var accountId_:String;
    public var charId_:int;
    public var killedBy_:String;
    public var zombieId:int;
    public var zombieType:int;
    public var isZombie:Boolean;
    public var background:BitmapData;

    public function Death(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    public function disposeBackground():void {
        ((this.background) && (this.background.dispose()));
        this.background = null;
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.accountId_ = _arg_1.readUTF();
        this.charId_ = _arg_1.readInt();
        this.killedBy_ = _arg_1.readUTF();
        this.zombieType = _arg_1.readInt();
        this.zombieId = _arg_1.readInt();
        this.isZombie = !((this.zombieId == -1));
    }

    override public function toString():String {
        return (formatToString("DEATH", "accountId_", "charId_", "killedBy_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
