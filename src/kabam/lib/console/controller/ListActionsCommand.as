package kabam.lib.console.controller {
import kabam.lib.console.model.Console;
import kabam.lib.console.signals.ConsoleLogSignal;

public final class ListActionsCommand {

    [Inject]
    public var console:Console;
    [Inject]
    public var log:ConsoleLogSignal;


    public function execute():void {
        var _local_1:String = ("  " + this.console.getNames().join("\r  "));
        this.log.dispatch(_local_1);
    }


}
}//package kabam.lib.console.controller
