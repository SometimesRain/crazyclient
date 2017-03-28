package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class MapInfo extends IncomingMessage {

    public var width_:int;
    public var height_:int;
    public var name_:String;
    public var displayName_:String;
    public var difficulty_:int;
    public var fp_:uint;
    public var background_:int;
    public var allowPlayerTeleport_:Boolean;
    public var showDisplays_:Boolean;
    public var clientXML_:Vector.<String>;
    public var extraXML_:Vector.<String>;

    public function MapInfo(_arg_1:uint, _arg_2:Function) {
        this.clientXML_ = new Vector.<String>();
        this.extraXML_ = new Vector.<String>();
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.parseProperties(_arg_1);
        this.parseXML(_arg_1);
    }

    private function parseProperties(_arg_1:IDataInput):void {
        this.width_ = _arg_1.readInt();
        this.height_ = _arg_1.readInt();
        this.name_ = _arg_1.readUTF();
        this.displayName_ = _arg_1.readUTF();
        this.fp_ = _arg_1.readUnsignedInt();
        this.background_ = _arg_1.readInt();
        this.difficulty_ = _arg_1.readInt();
        this.allowPlayerTeleport_ = _arg_1.readBoolean();
        this.showDisplays_ = _arg_1.readBoolean();
    }

    private function parseXML(_arg_1:IDataInput):void {
        var _local_2:int;
        var _local_3:int;
        var _local_4:int;
        _local_2 = _arg_1.readShort();
        this.clientXML_.length = 0;
        _local_3 = 0;
        while (_local_3 < _local_2) {
            _local_4 = _arg_1.readInt();
            this.clientXML_.push(_arg_1.readUTFBytes(_local_4));
            _local_3++;
        }
        _local_2 = _arg_1.readShort();
        this.extraXML_.length = 0;
        _local_3 = 0;
        while (_local_3 < _local_2) {
            _local_4 = _arg_1.readInt();
            this.extraXML_.push(_arg_1.readUTFBytes(_local_4));
            _local_3++;
        }
    }

    override public function toString():String {
        return (formatToString("MAPINFO", "width_", "height_", "name_", "fp_", "background_", "allowPlayerTeleport_", "showDisplays_", "clientXML_", "extraXML_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
