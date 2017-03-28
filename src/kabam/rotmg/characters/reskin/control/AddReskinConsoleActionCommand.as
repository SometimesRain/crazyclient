package kabam.rotmg.characters.reskin.control {
import kabam.lib.console.signals.RegisterConsoleActionSignal;
import kabam.lib.console.vo.ConsoleAction;

public class AddReskinConsoleActionCommand {

    [Inject]
    public var register:RegisterConsoleActionSignal;
    [Inject]
    public var openReskinDialogSignal:OpenReskinDialogSignal;


    public function execute():void {
        var _local_1:ConsoleAction;
        _local_1 = new ConsoleAction();
        _local_1.name = "reskin";
        _local_1.description = "opens the reskin UI";
        this.register.dispatch(_local_1, this.openReskinDialogSignal);
    }


}
}//package kabam.rotmg.characters.reskin.control
