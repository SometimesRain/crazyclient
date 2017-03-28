package kabam.rotmg.friends {
import kabam.rotmg.friends.controller.FriendActionCommand;
import kabam.rotmg.friends.controller.FriendActionSignal;
import kabam.rotmg.friends.model.FriendModel;
import kabam.rotmg.friends.service.FriendDataRequestTask;
import kabam.rotmg.friends.view.FriendListMediator;
import kabam.rotmg.friends.view.FriendListView;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class FriendConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;


    public function configure():void {
        this.injector.map(FriendDataRequestTask);
        this.injector.map(FriendModel).asSingleton();
        this.mediatorMap.map(FriendListView).toMediator(FriendListMediator);
        this.commandMap.map(FriendActionSignal).toCommand(FriendActionCommand);
    }


}
}//package kabam.rotmg.friends
