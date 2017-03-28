package kabam.lib.net.impl {
import kabam.lib.net.api.MessageMap;
import kabam.lib.net.api.MessageMapping;
import kabam.lib.net.api.MessageProvider;

import org.swiftsuspenders.Injector;

public class MessageCenter implements MessageMap, MessageProvider {

    private static const MAX_ID:int = 0x0100;

    private const maps:Vector.<MessageCenterMapping> = new Vector.<MessageCenterMapping>(MAX_ID, true);
    private const pools:Vector.<MessagePool> = new Vector.<MessagePool>(MAX_ID, true);

    private var injector:Injector;


    public function setInjector(_arg_1:Injector):MessageCenter {
        this.injector = _arg_1;
        return (this);
    }

    public function map(_arg_1:int):MessageMapping {
        return ((this.maps[_arg_1] = ((this.maps[_arg_1]) || (this.makeMapping(_arg_1)))));
    }

    public function unmap(_arg_1:int):void {
        ((this.pools[_arg_1]) && (this.pools[_arg_1].dispose()));
        this.pools[_arg_1] = null;
        this.maps[_arg_1] = null;
    }

    private function makeMapping(_arg_1:int):MessageCenterMapping {
        return ((new MessageCenterMapping().setInjector(this.injector).setID(_arg_1) as MessageCenterMapping));
    }

    public function require(_arg_1:int):Message {
        var _local_2:MessagePool = (this.pools[_arg_1] = ((this.pools[_arg_1]) || (this.makePool(_arg_1))));
        return (_local_2.require());
    }

    private function makePool(_arg_1:uint):MessagePool {
        var _local_2:MessageCenterMapping = this.maps[_arg_1];
        return (((_local_2) ? _local_2.makePool() : null));
    }


}
}//package kabam.lib.net.impl
