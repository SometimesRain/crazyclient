package kabam.lib.console.model {
import kabam.lib.console.vo.ConsoleAction;

import org.osflash.signals.Signal;

public final class Console {

    private var hash:ActionHash;
    private var history:ActionHistory;

    public function Console() {
        this.hash = new ActionHash();
        this.history = new ActionHistory();
    }

    public function register(_arg_1:ConsoleAction, _arg_2:Signal):void {
        this.hash.register(_arg_1.name, _arg_1.description, _arg_2);
    }

    public function hasAction(_arg_1:String):Boolean {
        return (this.hash.has(_arg_1));
    }

    public function execute(_arg_1:String):void {
        this.history.add(_arg_1);
        this.hash.execute(_arg_1);
    }

    public function getNames():Vector.<String> {
        return (this.hash.getNames());
    }

    public function getPreviousAction():String {
        return (this.history.getPrevious());
    }

    public function getNextAction():String {
        return (this.history.getNext());
    }


}
}//package kabam.lib.console.model
