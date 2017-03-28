package kabam.rotmg.account.kabam {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.model.MoneyConfig;
import kabam.rotmg.account.core.services.LoadAccountTask;
import kabam.rotmg.account.core.services.MakePaymentTask;
import kabam.rotmg.account.core.services.PurchaseGoldTask;
import kabam.rotmg.account.core.signals.CharListDataSignal;
import kabam.rotmg.account.core.signals.OpenAccountInfoSignal;
import kabam.rotmg.account.kabam.commands.KabamOpenAccountInfoCommand;
import kabam.rotmg.account.kabam.model.KabamMoneyConfig;
import kabam.rotmg.account.kabam.model.KabamParameters;
import kabam.rotmg.account.kabam.model.LoaderInfoKabamParameters;
import kabam.rotmg.account.kabam.services.KabamLoadAccountTask;
import kabam.rotmg.account.kabam.view.AccountLoadErrorDialog;
import kabam.rotmg.account.kabam.view.AccountLoadErrorMediator;
import kabam.rotmg.account.kabam.view.KabamAccountDetailDialog;
import kabam.rotmg.account.kabam.view.KabamAccountDetailMediator;
import kabam.rotmg.account.web.services.WebMakePaymentTask;
import kabam.rotmg.account.web.services.WebPurchaseGoldTask;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class KabamAccountConfig implements IConfig {

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
        this.injector.map(KabamParameters).toSingleton(LoaderInfoKabamParameters);
        this.injector.map(Account).toSingleton(KabamAccount);
        this.injector.map(MoneyConfig).toSingleton(KabamMoneyConfig);
        this.injector.map(CharListDataSignal).asSingleton();
    }

    private function mapCommands():void {
        this.commandMap.map(OpenAccountInfoSignal).toCommand(KabamOpenAccountInfoCommand);
    }

    protected function mapMediators():void {
        this.mediatorMap.map(KabamAccountDetailDialog).toMediator(KabamAccountDetailMediator);
        this.mediatorMap.map(AccountLoadErrorDialog).toMediator(AccountLoadErrorMediator);
    }

    protected function mapServices():void {
        this.injector.map(MakePaymentTask).toType(WebMakePaymentTask);
        this.injector.map(LoadAccountTask).toType(KabamLoadAccountTask);
        this.injector.map(PurchaseGoldTask).toType(WebPurchaseGoldTask);
    }


}
}//package kabam.rotmg.account.kabam
