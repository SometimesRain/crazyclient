package kabam.lib.console.controller {
import kabam.lib.console.signals.ClearConsoleSignal;
import kabam.lib.console.signals.CopyConsoleTextSignal;
import kabam.lib.console.signals.ListActionsSignal;
import kabam.lib.console.signals.RegisterConsoleActionSignal;
import kabam.lib.console.signals.RemoveConsoleSignal;
import kabam.lib.console.vo.ConsoleAction;

public class AddDefaultConsoleActionsCommand {

    [Inject]
    public var register:RegisterConsoleActionSignal;
    [Inject]
    public var listActions:ListActionsSignal;
    [Inject]
    public var clearConsole:ClearConsoleSignal;
    [Inject]
    public var removeConsole:RemoveConsoleSignal;
    [Inject]
    public var copyConsoleText:CopyConsoleTextSignal;


    public function execute():void {
        var _local_1:ConsoleAction;
        _local_1 = new ConsoleAction();
        _local_1.name = "list";
        _local_1.description = "lists available console commands";
        var _local_2:ConsoleAction = new ConsoleAction();
        _local_2.name = "clear";
        _local_2.description = "clears the console";
        var _local_3:ConsoleAction = new ConsoleAction();
        _local_3.name = "exit";
        _local_3.description = "closes the console";
        var _local_4:ConsoleAction = new ConsoleAction();
        _local_4.name = "copy";
        _local_4.description = "copies the contents of the console to the clipboard";
        this.register.dispatch(_local_1, this.listActions);
        this.register.dispatch(_local_2, this.clearConsole);
        this.register.dispatch(_local_3, this.removeConsole);
        this.register.dispatch(_local_4, this.copyConsoleText);
    }


}
}//package kabam.lib.console.controller
