package kabam.lib.console.model {
public final class ActionHistory {

    private var stack:Vector.<String>;
    private var index:int;

    public function ActionHistory() {
        this.stack = new Vector.<String>();
        this.index = 0;
    }

    public function add(_arg_1:String):void {
        this.index = this.stack.push(_arg_1);
    }

    public function get length():int {
        return (this.stack.length);
    }

    public function getPrevious():String {
        return ((((this.index > 0)) ? this.stack[--this.index] : ""));
    }

    public function getNext():String {
        return ((((this.index < (this.stack.length - 1))) ? this.stack[++this.index] : ""));
    }


}
}//package kabam.lib.console.model
