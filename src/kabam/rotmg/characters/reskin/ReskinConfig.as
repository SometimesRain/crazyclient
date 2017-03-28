package kabam.rotmg.characters.reskin {
import kabam.lib.net.api.MessageMap;
import kabam.rotmg.characters.reskin.control.AddReskinConsoleActionCommand;
import kabam.rotmg.characters.reskin.control.AddReskinConsoleActionSignal;
import kabam.rotmg.characters.reskin.control.OpenReskinDialogCommand;
import kabam.rotmg.characters.reskin.control.OpenReskinDialogSignal;
import kabam.rotmg.characters.reskin.control.ReskinCharacterCommand;
import kabam.rotmg.characters.reskin.control.ReskinCharacterSignal;
import kabam.rotmg.characters.reskin.control.ReskinHandler;
import kabam.rotmg.characters.reskin.view.ReskinCharacterMediator;
import kabam.rotmg.characters.reskin.view.ReskinCharacterView;
import kabam.rotmg.characters.reskin.view.ReskinPanel;
import kabam.rotmg.characters.reskin.view.ReskinPanelMediator;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.messaging.impl.outgoing.Reskin;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

public class ReskinConfig implements IConfig {

    [Inject]
    public var context:IContext;
    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var messageMap:MessageMap;


    public function configure():void {
        this.mediatorMap.map(ReskinCharacterView).toMediator(ReskinCharacterMediator);
        this.mediatorMap.map(ReskinPanel).toMediator(ReskinPanelMediator);
        this.commandMap.map(AddReskinConsoleActionSignal).toCommand(AddReskinConsoleActionCommand);
        this.commandMap.map(OpenReskinDialogSignal).toCommand(OpenReskinDialogCommand);
        this.commandMap.map(ReskinCharacterSignal).toCommand(ReskinCharacterCommand);
        this.messageMap.map(GameServerConnection.RESKIN).toMessage(Reskin).toHandler(ReskinHandler);
        this.context.lifecycle.afterInitializing(this.onInit);
    }

    private function onInit():void {
        this.injector.getInstance(AddReskinConsoleActionSignal).dispatch();
    }


}
}//package kabam.rotmg.characters.reskin
