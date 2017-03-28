package kabam.rotmg.appengine.impl {
import kabam.lib.console.signals.ConsoleWatchSignal;

public class AppEngineRequestStats {

    private const nameMap:Object = {};

    [Inject]
    public var watch:ConsoleWatchSignal;


    public function recordStats(_arg_1:String, _arg_2:Boolean, _arg_3:int):void {
        var _local_4:StatsWatch = (this.nameMap[_arg_1] = ((this.nameMap[_arg_1]) || (new StatsWatch(_arg_1))));
        _local_4.addResponse(_arg_2, _arg_3);
        this.watch.dispatch(_local_4);
    }


}
}//package kabam.rotmg.appengine.impl

import kabam.lib.console.model.Watch;

class StatsWatch extends Watch {

    private static const STATS_PATTERN:String = "[APPENGINE STATS] [0xFFEE00:{/x={MEAN}ms, ok={OK}/{COUNT}} {NAME}]";
    private static const MEAN:String = "{MEAN}";
    private static const COUNT:String = "{COUNT}";
    private static const OK:String = "{OK}";
    private static const NAME:String = "{NAME}";

    private var count:int;
    private var time:int;
    private var mean:int;
    private var ok:int;

    public function StatsWatch(_arg_1:String) {
        super(_arg_1, "");
        this.count = 0;
        this.ok = 0;
        this.time = 0;
    }

    public function addResponse(_arg_1:Boolean, _arg_2:int):void {
        ((_arg_1) && (++this.ok));
        this.time = (this.time + _arg_2);
        this.mean = (this.time / ++this.count);
        data = this.report();
    }

    private function report():String {
        return (STATS_PATTERN.replace(MEAN, this.mean).replace(COUNT, this.count).replace(OK, this.ok).replace(NAME, name));
    }


}
