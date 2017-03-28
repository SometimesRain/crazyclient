package kabam.rotmg.servers {
import kabam.rotmg.account.core.signals.CharListDataSignal;
import kabam.rotmg.build.api.BuildData;
import kabam.rotmg.build.api.BuildEnvironment;
import kabam.rotmg.servers.api.ServerModel;
import kabam.rotmg.servers.control.ParseServerDataCommand;
import kabam.rotmg.servers.model.FixedIPServerModel;
import kabam.rotmg.servers.model.LiveServerModel;
import kabam.rotmg.servers.model.LocalhostServerModel;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class ServersConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var data:BuildData;
    [Inject]
    public var commandMap:ISignalCommandMap;


    public function configure():void {
        var _local_1:BuildEnvironment = this.data.getEnvironment();
        switch (_local_1) {
            case BuildEnvironment.FIXED_IP:
                this.configureFixedIP();
                return;
            case BuildEnvironment.LOCALHOST:
            case BuildEnvironment.PRIVATE:
                this.configureLocalhost();
                return;
            default:
                this.configureLiveServers();
        }
    }

    private function configureLocalhost():void {
        this.injector.map(ServerModel).toSingleton(LocalhostServerModel);
    }

    private function configureFixedIP():void {
        this.injector.map(ServerModel).toValue(this.makeFixedIPServerModel());
    }

    private function makeFixedIPServerModel():FixedIPServerModel {
        return (new FixedIPServerModel().setIP(this.data.getEnvironmentString()));
    }

    private function configureLiveServers():void {
        this.injector.map(ServerModel).toSingleton(LiveServerModel);
        this.commandMap.map(CharListDataSignal).toCommand(ParseServerDataCommand);
    }


}
}//package kabam.rotmg.servers
