package kabam.lib.net.impl {
import kabam.lib.net.api.MessageHandlerProxy;
import kabam.lib.net.api.MessageMapping;

import org.swiftsuspenders.Injector;

public class MessageCenterMapping implements MessageMapping {

    private const nullHandler:NullHandlerProxy = new NullHandlerProxy();

    private var id:int;
    private var injector:Injector;
    private var messageType:Class;
    private var population:int = 1;
    private var handler:MessageHandlerProxy;

    public function MessageCenterMapping() {
        this.handler = this.nullHandler;
        super();
    }

    public function setID(_arg_1:int):MessageMapping {
        this.id = _arg_1;
        return (this);
    }

    public function setInjector(_arg_1:Injector):MessageCenterMapping {
        this.injector = _arg_1;
        return (this);
    }

    public function toMessage(_arg_1:Class):MessageMapping {
        this.messageType = _arg_1;
        return (this);
    }

    public function toHandler(_arg_1:Class):MessageMapping {
        this.handler = new ClassHandlerProxy().setType(_arg_1).setInjector(this.injector);
        return (this);
    }

    public function toMethod(_arg_1:Function):MessageMapping {
        this.handler = new MethodHandlerProxy().setMethod(_arg_1);
        return (this);
    }

    public function setPopulation(_arg_1:int):MessageMapping {
        this.population = _arg_1;
        return (this);
    }

    public function makePool():MessagePool {
        var _local_1:MessagePool = new MessagePool(this.id, this.messageType, this.handler.getMethod());
        _local_1.populate(this.population);
        return (_local_1);
    }


}
}//package kabam.lib.net.impl

import kabam.lib.net.api.MessageHandlerProxy;

class NullHandlerProxy implements MessageHandlerProxy {


    public function getMethod():Function {
        return (null);
    }


}
