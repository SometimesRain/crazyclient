package kabam.lib.loopedprocs {
public class LoopedCallback extends LoopedProcess {

    public var callback:Function;
    public var parameters:Array;

    public function LoopedCallback(_arg_1:int, _arg_2:Function, ... rest) {
        super(_arg_1);
        this.callback = _arg_2;
        this.parameters = rest;
    }

    override protected function run():void {
        this.callback.apply(this.parameters);
    }

    override protected function onDestroyed():void {
        this.callback = null;
        this.parameters = null;
    }


}
}//package kabam.lib.loopedprocs
