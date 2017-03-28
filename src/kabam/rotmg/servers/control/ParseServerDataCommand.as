package kabam.rotmg.servers.control {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.servers.api.Server;
import kabam.rotmg.servers.api.ServerModel;

public class ParseServerDataCommand {

    [Inject]
    public var servers:ServerModel;
    [Inject]
    public var data:XML;

    public function execute():void {
        this.servers.setServers(this.makeListOfServers());
    }

    private function makeListOfServers():Vector.<Server> {
        var _local_3:XML;
        var _local_1:XMLList = this.data.child("Servers").child("Server");
        var _local_2:Vector.<Server> = new Vector.<Server>(0);
        _local_2.push(LocalhostServer());
        for each (_local_3 in _local_1) {
            _local_2.push(this.makeServer(_local_3));
        }
        return (_local_2);
    }
      
    private function LocalhostServer():Server
    {
        return new Server().setName("Proxy").setAddress("127.0.0.1").setPort(Parameters.PORT).setLatLong(Number(50000),Number(50000)).setUsage(0).setIsAdminOnly(false);
    }

    private function makeServer(_arg_1:XML):Server {
        return (new Server().setName(_arg_1.Name).setAddress(_arg_1.DNS).setPort(Parameters.PORT).setLatLong(Number(_arg_1.Lat), Number(_arg_1.Long)).setUsage(_arg_1.Usage).setIsAdminOnly(_arg_1.hasOwnProperty("AdminOnly")));
    }


}
}//package kabam.rotmg.servers.control
