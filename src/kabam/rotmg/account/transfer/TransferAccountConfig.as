package kabam.rotmg.account.transfer {
import kabam.rotmg.account.core.services.MigrateAccountTask;
import kabam.rotmg.account.transfer.commands.CheckKabamAccountCommand;
import kabam.rotmg.account.transfer.commands.TransferAccountCommand;
import kabam.rotmg.account.transfer.services.TransferAccountTask;
import kabam.rotmg.account.transfer.signals.CheckKabamAccountSignal;
import kabam.rotmg.account.transfer.signals.TransferAccountSignal;
import kabam.rotmg.account.transfer.view.KabamLoginMediator;
import kabam.rotmg.account.transfer.view.KabamLoginView;
import kabam.rotmg.account.transfer.view.TransferAccountMediator;
import kabam.rotmg.account.transfer.view.TransferAccountView;
import kabam.rotmg.core.signals.TaskErrorSignal;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class TransferAccountConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;


    public function configure():void {
        this.mapModels();
        this.mapCommands();
        this.mapMediators();
        this.mapServices();
    }

    protected function mapModels():void {
    }

    private function mapCommands():void {
        this.commandMap.map(TransferAccountSignal).toCommand(TransferAccountCommand);
        this.commandMap.map(CheckKabamAccountSignal).toCommand(CheckKabamAccountCommand);
        this.injector.map(TaskErrorSignal).asSingleton();
    }

    protected function mapMediators():void {
        this.mediatorMap.map(TransferAccountView).toMediator(TransferAccountMediator);
        this.mediatorMap.map(KabamLoginView).toMediator(KabamLoginMediator);
    }

    protected function mapServices():void {
        this.injector.map(MigrateAccountTask).toType(TransferAccountTask);
    }


}
}//package kabam.rotmg.account.transfer
