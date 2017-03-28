package kabam.rotmg.account.steam {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.model.MoneyConfig;
import kabam.rotmg.account.core.services.LoadAccountTask;
import kabam.rotmg.account.core.services.MakePaymentTask;
import kabam.rotmg.account.core.services.PurchaseGoldTask;
import kabam.rotmg.account.core.services.RegisterAccountTask;
import kabam.rotmg.account.core.signals.CharListDataSignal;
import kabam.rotmg.account.core.signals.OpenAccountInfoSignal;
import kabam.rotmg.account.core.signals.RegisterAccountSignal;
import kabam.rotmg.account.core.view.RegisterWebAccountDialog;
import kabam.rotmg.account.steam.commands.SteamOpenAccountInfoCommand;
import kabam.rotmg.account.steam.commands.SteamRegisterAccountCommand;
import kabam.rotmg.account.steam.model.SteamMoneyConfig;
import kabam.rotmg.account.steam.services.LiveSteamApi;
import kabam.rotmg.account.steam.services.SteamLoadAccountTask;
import kabam.rotmg.account.steam.services.SteamLoadApiTask;
import kabam.rotmg.account.steam.services.SteamMakePaymentTask;
import kabam.rotmg.account.steam.services.SteamPurchaseGoldTask;
import kabam.rotmg.account.steam.services.SteamRegisterAccountTask;
import kabam.rotmg.account.steam.view.SteamAccountDetailDialog;
import kabam.rotmg.account.steam.view.SteamAccountDetailMediator;
import kabam.rotmg.account.steam.view.SteamRegisterWebAccountMediator;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class SteamAccountConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;


    public function configure():void {
        this.mapModel();
        this.mapCommands();
        this.mapMediators();
        this.mapServices();
    }

    protected function mapModel():void {
        this.injector.map(Account).toSingleton(SteamAccount);
        this.injector.map(MoneyConfig).toSingleton(SteamMoneyConfig);
        this.injector.map(CharListDataSignal).asSingleton();
    }

    protected function mapCommands():void {
        this.commandMap.map(OpenAccountInfoSignal).toCommand(SteamOpenAccountInfoCommand);
        this.commandMap.map(RegisterAccountSignal).toCommand(SteamRegisterAccountCommand);
    }

    protected function mapMediators():void {
        this.mediatorMap.map(SteamAccountDetailDialog).toMediator(SteamAccountDetailMediator);
        this.mediatorMap.map(RegisterWebAccountDialog).toMediator(SteamRegisterWebAccountMediator);
    }

    protected function mapServices():void {
        this.injector.map(SteamApi).toSingleton(LiveSteamApi);
        this.injector.map(LoadAccountTask).toType(SteamLoadAccountTask);
        this.injector.map(SteamLoadApiTask);
        this.injector.map(MakePaymentTask).toType(SteamMakePaymentTask);
        this.injector.map(PurchaseGoldTask).toType(SteamPurchaseGoldTask);
        this.injector.map(RegisterAccountTask).toType(SteamRegisterAccountTask);
    }


}
}//package kabam.rotmg.account.steam
