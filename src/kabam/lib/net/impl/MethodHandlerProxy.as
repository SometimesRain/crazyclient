package kabam.lib.net.impl {
import kabam.lib.net.api.MessageHandlerProxy;

public class MethodHandlerProxy implements MessageHandlerProxy {

    private var method:Function;


    public function setMethod(_arg_1:Function):MethodHandlerProxy {
        this.method = _arg_1;
        return (this);
    }

    public function getMethod():Function {
        return (this.method);
    }


}
}//package kabam.lib.net.impl
