package kabam.rotmg.account.web {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.model.MoneyConfig;
import kabam.rotmg.account.core.services.ChangePasswordTask;
import kabam.rotmg.account.core.services.LoadAccountTask;
import kabam.rotmg.account.core.services.LoginTask;
import kabam.rotmg.account.core.services.MakePaymentTask;
import kabam.rotmg.account.core.services.PurchaseGoldTask;
import kabam.rotmg.account.core.services.RegisterAccountTask;
import kabam.rotmg.account.core.services.SendConfirmEmailAddressTask;
import kabam.rotmg.account.core.services.SendPasswordReminderTask;
import kabam.rotmg.account.core.signals.CharListDataSignal;
import kabam.rotmg.account.core.signals.LoginSignal;
import kabam.rotmg.account.core.signals.LogoutSignal;
import kabam.rotmg.account.core.signals.OpenAccountInfoSignal;
import kabam.rotmg.account.core.signals.RegisterSignal;
import kabam.rotmg.account.core.signals.SendPasswordReminderSignal;
import kabam.rotmg.account.web.commands.WebChangePasswordCommand;
import kabam.rotmg.account.web.commands.WebLoginCommand;
import kabam.rotmg.account.web.commands.WebLogoutCommand;
import kabam.rotmg.account.web.commands.WebOpenAccountInfoCommand;
import kabam.rotmg.account.web.commands.WebRegisterAccountCommand;
import kabam.rotmg.account.web.commands.WebSendPasswordReminderCommand;
import kabam.rotmg.account.web.commands.WebSetPaymentDataCommand;
import kabam.rotmg.account.web.model.WebMoneyConfig;
import kabam.rotmg.account.web.services.WebChangePasswordTask;
import kabam.rotmg.account.web.services.WebLoadAccountTask;
import kabam.rotmg.account.web.services.WebLoginTask;
import kabam.rotmg.account.web.services.WebMakePaymentTask;
import kabam.rotmg.account.web.services.WebPurchaseGoldTask;
import kabam.rotmg.account.web.services.WebRegisterAccountTask;
import kabam.rotmg.account.web.services.WebSendPasswordReminderTask;
import kabam.rotmg.account.web.services.WebSendVerificationEmailTask;
import kabam.rotmg.account.web.signals.WebChangePasswordSignal;
import kabam.rotmg.account.web.view.WebAccountDetailDialog;
import kabam.rotmg.account.web.view.WebAccountDetailMediator;
import kabam.rotmg.account.web.view.WebAccountInfoMediator;
import kabam.rotmg.account.web.view.WebAccountInfoView;
import kabam.rotmg.account.web.view.WebChangePasswordDialog;
import kabam.rotmg.account.web.view.WebChangePasswordDialogForced;
import kabam.rotmg.account.web.view.WebChangePasswordMediator;
import kabam.rotmg.account.web.view.WebChangePasswordMediatorForced;
import kabam.rotmg.account.web.view.WebForgotPasswordDialog;
import kabam.rotmg.account.web.view.WebForgotPasswordMediator;
import kabam.rotmg.account.web.view.WebLoginDialog;
import kabam.rotmg.account.web.view.WebLoginDialogForced;
import kabam.rotmg.account.web.view.WebLoginMediator;
import kabam.rotmg.account.web.view.WebLoginMediatorForced;
import kabam.rotmg.account.web.view.WebRegisterDialog;
import kabam.rotmg.account.web.view.WebRegisterMediator;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class WebAccountConfig implements IConfig {

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
        this.mapTasks();
    }

    protected function mapModel():void {
        this.injector.map(Account).toSingleton(WebAccount);
        this.injector.map(MoneyConfig).toSingleton(WebMoneyConfig);
    }

    protected function mapCommands():void {
        this.commandMap.map(OpenAccountInfoSignal).toCommand(WebOpenAccountInfoCommand);
        this.commandMap.map(LoginSignal).toCommand(WebLoginCommand);
        this.commandMap.map(LogoutSignal).toCommand(WebLogoutCommand);
        this.commandMap.map(WebChangePasswordSignal).toCommand(WebChangePasswordCommand);
        this.commandMap.map(SendPasswordReminderSignal).toCommand(WebSendPasswordReminderCommand);
        this.commandMap.map(RegisterSignal).toCommand(WebRegisterAccountCommand);
        this.commandMap.map(CharListDataSignal).toCommand(WebSetPaymentDataCommand);
    }

    protected function mapMediators():void {
        this.mediatorMap.map(WebAccountInfoView).toMediator(WebAccountInfoMediator);
        this.mediatorMap.map(WebChangePasswordDialog).toMediator(WebChangePasswordMediator);
        this.mediatorMap.map(WebForgotPasswordDialog).toMediator(WebForgotPasswordMediator);
        this.mediatorMap.map(WebAccountDetailDialog).toMediator(WebAccountDetailMediator);
        this.mediatorMap.map(WebRegisterDialog).toMediator(WebRegisterMediator);
        this.mediatorMap.map(WebLoginDialog).toMediator(WebLoginMediator);
        this.mediatorMap.map(WebLoginDialogForced).toMediator(WebLoginMediatorForced);
        this.mediatorMap.map(WebChangePasswordDialogForced).toMediator(WebChangePasswordMediatorForced);
    }

    protected function mapTasks():void {
        this.injector.map(ChangePasswordTask).toType(WebChangePasswordTask);
        this.injector.map(LoadAccountTask).toType(WebLoadAccountTask);
        this.injector.map(LoginTask).toType(WebLoginTask);
        this.injector.map(MakePaymentTask).toType(WebMakePaymentTask);
        this.injector.map(PurchaseGoldTask).toType(WebPurchaseGoldTask);
        this.injector.map(RegisterAccountTask).toType(WebRegisterAccountTask);
        this.injector.map(SendPasswordReminderTask).toType(WebSendPasswordReminderTask);
        this.injector.map(SendConfirmEmailAddressTask).toType(WebSendVerificationEmailTask);
    }


}
}//package kabam.rotmg.account.web
