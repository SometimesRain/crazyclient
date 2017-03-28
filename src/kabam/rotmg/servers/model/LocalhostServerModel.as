package kabam.rotmg.servers.model {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.servers.api.Server;
import kabam.rotmg.servers.api.ServerModel;

public class LocalhostServerModel implements ServerModel {

    private var localhost:Server;

    public function LocalhostServerModel() {
        this.localhost = new Server().setName("localhost").setAddress("localhost").setPort(Parameters.PORT);
    }

    public function getServers():Vector.<Server> {
        return (new <Server>[this.localhost]);
    }

    public function getServer():Server {
        return (this.localhost);
    }

    public function isServerAvailable():Boolean {
        return (true);
    }

    public function setServers(_arg_1:Vector.<Server>):void {
    }


}
}//package kabam.rotmg.servers.model
