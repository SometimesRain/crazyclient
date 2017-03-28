package kabam.rotmg.mysterybox {
import kabam.rotmg.mysterybox.services.GetMysteryBoxesTask;
import kabam.rotmg.mysterybox.services.MysteryBoxModel;
import kabam.rotmg.startup.control.StartupSequence;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class MysteryBoxConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var sequence:StartupSequence;


    public function configure():void {
        this.injector.map(MysteryBoxModel).asSingleton();
        this.injector.map(GetMysteryBoxesTask).asSingleton();
        this.sequence.addTask(GetMysteryBoxesTask);
    }


}
}//package kabam.rotmg.mysterybox
