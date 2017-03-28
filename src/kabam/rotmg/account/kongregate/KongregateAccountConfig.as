package kabam.rotmg.account.kongregate {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.model.MoneyConfig;
import kabam.rotmg.account.core.services.LoadAccountTask;
import kabam.rotmg.account.core.services.LoginTask;
import kabam.rotmg.account.core.services.MakePaymentTask;
import kabam.rotmg.account.core.services.PurchaseGoldTask;
import kabam.rotmg.account.core.services.RegisterAccountTask;
import kabam.rotmg.account.core.services.RelayLoginTask;
import kabam.rotmg.account.core.signals.CharListDataSignal;
import kabam.rotmg.account.core.signals.OpenAccountInfoSignal;
import kabam.rotmg.account.core.signals.RegisterAccountSignal;
import kabam.rotmg.account.core.view.RegisterWebAccountDialog;
import kabam.rotmg.account.kongregate.commands.KongregateHandleAlreadyRegisteredCommand;
import kabam.rotmg.account.kongregate.commands.KongregateOpenAccountInfoCommand;
import kabam.rotmg.account.kongregate.commands.KongregateRegisterAccountCommand;
import kabam.rotmg.account.kongregate.commands.KongregateRelayApiLoginCommand;
import kabam.rotmg.account.kongregate.model.KongregateMoneyConfig;
import kabam.rotmg.account.kongregate.services.KongregateLoadAccountTask;
import kabam.rotmg.account.kongregate.services.KongregateLoadApiTask;
import kabam.rotmg.account.kongregate.services.KongregateLoginTask;
import kabam.rotmg.account.kongregate.services.KongregateMakePaymentTask;
import kabam.rotmg.account.kongregate.services.KongregatePurchaseGoldTask;
import kabam.rotmg.account.kongregate.services.KongregateRegisterAccountTask;
import kabam.rotmg.account.kongregate.services.KongregateRelayAPILoginTask;
import kabam.rotmg.account.kongregate.services.KongregateSharedObject;
import kabam.rotmg.account.kongregate.signals.KongregateAlreadyRegisteredSignal;
import kabam.rotmg.account.kongregate.signals.RelayApiLoginSignal;
import kabam.rotmg.account.kongregate.view.KongregateAccountDetailDialog;
import kabam.rotmg.account.kongregate.view.KongregateAccountDetailMediator;
import kabam.rotmg.account.kongregate.view.KongregateAccountInfoMediator;
import kabam.rotmg.account.kongregate.view.KongregateAccountInfoView;
import kabam.rotmg.account.kongregate.view.KongregateApi;
import kabam.rotmg.account.kongregate.view.KongregateRegisterWebAccountMediator;
import kabam.rotmg.account.kongregate.view.LiveKongregateApi;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class KongregateAccountConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;


    public function configure():void {
        this.mapModel();
        this.mapCommands();
        this.mapServices();
        this.mapMediators();
    }

    protected function mapModel():void {
        this.injector.map(Account).toSingleton(KongregateAccount);
        this.injector.map(KongregateSharedObject).asSingleton();
        this.injector.map(MoneyConfig).toSingleton(KongregateMoneyConfig);
        this.injector.map(CharListDataSignal).asSingleton();
    }

    protected function mapCommands():void {
        this.commandMap.map(OpenAccountInfoSignal).toCommand(KongregateOpenAccountInfoCommand);
        this.commandMap.map(RegisterAccountSignal).toCommand(KongregateRegisterAccountCommand);
        this.commandMap.map(RelayApiLoginSignal).toCommand(KongregateRelayApiLoginCommand);
        this.commandMap.map(KongregateAlreadyRegisteredSignal).toCommand(KongregateHandleAlreadyRegisteredCommand);
    }

    protected function mapMediators():void {
        this.mediatorMap.map(KongregateAccountInfoView).toMediator(KongregateAccountInfoMediator);
        this.mediatorMap.map(KongregateAccountDetailDialog).toMediator(KongregateAccountDetailMediator);
        this.mediatorMap.map(RegisterWebAccountDialog).toMediator(KongregateRegisterWebAccountMediator);
    }

    protected function mapServices():void {
        this.injector.map(KongregateApi).toSingleton(LiveKongregateApi);
        this.injector.map(LoadAccountTask).toType(KongregateLoadAccountTask);
        this.injector.map(KongregateLoadApiTask);
        this.injector.map(LoginTask).toType(KongregateLoginTask);
        this.injector.map(RelayLoginTask).toType(KongregateRelayAPILoginTask);
        this.injector.map(MakePaymentTask).toType(KongregateMakePaymentTask);
        this.injector.map(PurchaseGoldTask).toType(KongregatePurchaseGoldTask);
        this.injector.map(RegisterAccountTask).toType(KongregateRegisterAccountTask);
    }


}
}//package kabam.rotmg.account.kongregate
