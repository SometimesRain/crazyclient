package kabam.rotmg.characters.deletion {
import kabam.rotmg.characters.deletion.control.DeleteCharacterCommand;
import kabam.rotmg.characters.deletion.control.DeleteCharacterSignal;
import kabam.rotmg.characters.deletion.service.DeleteCharacterTask;
import kabam.rotmg.characters.deletion.view.ConfirmDeleteCharacterDialog;
import kabam.rotmg.characters.deletion.view.ConfirmDeleteCharacterMediator;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class DeletionConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;


    public function configure():void {
        this.injector.map(DeleteCharacterTask);
        this.mediatorMap.map(ConfirmDeleteCharacterDialog).toMediator(ConfirmDeleteCharacterMediator);
        this.commandMap.map(DeleteCharacterSignal).toCommand(DeleteCharacterCommand);
    }


}
}//package kabam.rotmg.characters.deletion
