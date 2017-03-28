package kabam.lib.net {
import flash.net.Socket;

import kabam.lib.net.api.MessageMap;
import kabam.lib.net.api.MessageProvider;
import kabam.lib.net.impl.MessageCenter;
import kabam.lib.net.impl.SocketServer;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.IConfig;

public class NetConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    private var messageCenter:MessageCenter;


    public function configure():void {
        this.messageCenter = new MessageCenter().setInjector(this.injector);
        this.injector.map(Socket);
        this.injector.map(MessageMap).toValue(this.messageCenter);
        this.injector.map(MessageProvider).toValue(this.messageCenter);
        this.injector.map(SocketServer).asSingleton();
    }


}
}//package kabam.lib.net
