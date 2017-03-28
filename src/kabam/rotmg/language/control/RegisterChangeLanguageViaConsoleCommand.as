package kabam.rotmg.language.control {
import kabam.lib.console.signals.RegisterConsoleActionSignal;
import kabam.lib.console.vo.ConsoleAction;

public class RegisterChangeLanguageViaConsoleCommand {

    [Inject]
    public var registerConsoleAction:RegisterConsoleActionSignal;
    [Inject]
    public var setLanguage:SetLanguageSignal;


    public function execute():void {
        var _local_1:ConsoleAction;
        _local_1 = new ConsoleAction();
        _local_1.name = "setlang";
        _local_1.description = "Sets the locale language (defaults to en-US)";
        this.registerConsoleAction.dispatch(_local_1, this.setLanguage);
    }


}
}//package kabam.rotmg.language.control
