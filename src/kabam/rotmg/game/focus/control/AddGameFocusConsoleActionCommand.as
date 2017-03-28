package kabam.rotmg.game.focus.control {
import kabam.lib.console.signals.RegisterConsoleActionSignal;
import kabam.lib.console.vo.ConsoleAction;

public class AddGameFocusConsoleActionCommand {

    [Inject]
    public var register:RegisterConsoleActionSignal;
    [Inject]
    public var setFocus:SetGameFocusSignal;


    public function execute():void {
        var _local_1:ConsoleAction;
        _local_1 = new ConsoleAction();
        _local_1.name = "follow";
        _local_1.description = "follow a game object (by name)";
        this.register.dispatch(_local_1, this.setFocus);
    }


}
}//package kabam.rotmg.game.focus.control
