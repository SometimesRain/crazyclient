package kabam.rotmg.language {
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.language.control.RegisterChangeLanguageViaConsoleCommand;
import kabam.rotmg.language.control.RegisterChangeLanguageViaConsoleSignal;
import kabam.rotmg.language.control.ReloadCurrentScreenCommand;
import kabam.rotmg.language.control.ReloadCurrentScreenSignal;
import kabam.rotmg.language.control.SetLanguageCommand;
import kabam.rotmg.language.control.SetLanguageSignal;
import kabam.rotmg.language.model.CookieLanguageModel;
import kabam.rotmg.language.model.LanguageModel;
import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.language.model.StringMapConcrete;
import kabam.rotmg.language.service.GetLanguageService;
import kabam.rotmg.startup.control.StartupSequence;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class LanguageConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var startup:StartupSequence;
    [Inject]
    public var applicationSetup:ApplicationSetup;


    public function configure():void {
        this.injector.map(LanguageModel).toValue(new CookieLanguageModel());
        this.injector.map(StringMap).toSingleton(StringMapConcrete);
        this.injector.map(GetLanguageService);
        this.startup.addTask(GetLanguageService, -999);
        this.commandMap.map(ReloadCurrentScreenSignal).toCommand(ReloadCurrentScreenCommand);
        this.commandMap.map(SetLanguageSignal).toCommand(SetLanguageCommand);
        this.commandMap.map(RegisterChangeLanguageViaConsoleSignal).toCommand(RegisterChangeLanguageViaConsoleCommand);
        this.registerChangeViaConsole();
    }

    private function registerChangeViaConsole():void {
        this.injector.getInstance(RegisterChangeLanguageViaConsoleSignal).dispatch();
    }


}
}//package kabam.rotmg.language
