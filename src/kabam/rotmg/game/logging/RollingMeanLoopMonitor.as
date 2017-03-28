package kabam.rotmg.game.logging {
import kabam.lib.console.signals.ConsoleWatchSignal;

public class RollingMeanLoopMonitor implements LoopMonitor {

    [Inject]
    public var watch:ConsoleWatchSignal;
    private var watchMap:Object;

    public function RollingMeanLoopMonitor() {
        this.watchMap = {};
    }

    public function recordTime(_arg_1:String, _arg_2:int):void {
        var _local_3:GameSpriteLoopWatch = (this.watchMap[_arg_1] = ((this.watchMap[_arg_1]) || (new GameSpriteLoopWatch(_arg_1))));
        _local_3.logTime(_arg_2);
        this.watch.dispatch(_local_3);
    }


}
}//package kabam.rotmg.game.logging
