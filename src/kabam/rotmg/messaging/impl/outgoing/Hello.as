package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class Hello extends OutgoingMessage {

    public var buildVersion_:String;
    public var gameId_:int = 0;
    public var guid_:String;
    public var password_:String;
    public var secret_:String;
    public var keyTime_:int = 0;
    public var key_:ByteArray;
    public var mapJSON_:String;
    public var entrytag_:String = "";
    public var gameNet:String = "";
    public var gameNetUserId:String = "";
    public var playPlatform:String = "";
    public var platformToken:String = "";
    public var userToken:String = "";

    public function Hello(_arg_1:uint, _arg_2:Function) {
        this.buildVersion_ = new String();
        this.guid_ = new String();
        this.password_ = new String();
        this.secret_ = new String();
        this.key_ = new ByteArray();
        this.mapJSON_ = new String();
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeUTF(this.buildVersion_);
        _arg_1.writeInt(this.gameId_);
        _arg_1.writeUTF(this.guid_);
        _arg_1.writeInt(int(Math.floor((Math.random() * 0x3B9ACA00))));
        _arg_1.writeUTF(this.password_);
        _arg_1.writeInt(int(Math.floor((Math.random() * 0x3B9ACA00))));
        _arg_1.writeUTF(this.secret_);
        _arg_1.writeInt(this.keyTime_);
        _arg_1.writeShort(this.key_.length);
        _arg_1.writeBytes(this.key_);
        _arg_1.writeInt(this.mapJSON_.length);
        _arg_1.writeUTFBytes(this.mapJSON_);
        _arg_1.writeUTF(this.entrytag_);
        _arg_1.writeUTF(this.gameNet);
        _arg_1.writeUTF(this.gameNetUserId);
        _arg_1.writeUTF(this.playPlatform);
        _arg_1.writeUTF(this.platformToken);
        _arg_1.writeUTF(this.userToken);
    }

    override public function toString():String {
        return (formatToString("HELLO", "buildVersion_", "gameId_", "guid_", "password_", "secret_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
