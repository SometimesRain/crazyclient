package kabam.rotmg.death {
import com.company.assembleegameclient.game.GameSprite;

import kabam.rotmg.death.control.HandleDeathCommand;
import kabam.rotmg.death.control.HandleDeathSignal;
import kabam.rotmg.death.control.HandleNormalDeathCommand;
import kabam.rotmg.death.control.HandleNormalDeathSignal;
import kabam.rotmg.death.control.ResurrectPlayerCommand;
import kabam.rotmg.death.control.ResurrectPlayerSignal;
import kabam.rotmg.death.control.ZombifyCommand;
import kabam.rotmg.death.control.ZombifySignal;
import kabam.rotmg.death.model.DeathModel;
import kabam.rotmg.death.view.ZombifyDialog;
import kabam.rotmg.death.view.ZombifyDialogMediator;
import kabam.rotmg.death.view.ZombifyGameMediator;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class DeathConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var mediatorMap:IMediatorMap;


    public function configure():void {
        this.injector.map(DeathModel).asSingleton();
        this.commandMap.map(HandleDeathSignal).toCommand(HandleDeathCommand);
        this.commandMap.map(HandleNormalDeathSignal).toCommand(HandleNormalDeathCommand);
        this.commandMap.map(ZombifySignal).toCommand(ZombifyCommand);
        this.commandMap.map(ResurrectPlayerSignal).toCommand(ResurrectPlayerCommand);
        this.mediatorMap.map(GameSprite).toMediator(ZombifyGameMediator);
        this.mediatorMap.map(ZombifyDialog).toMediator(ZombifyDialogMediator);
    }


}
}//package kabam.rotmg.death
