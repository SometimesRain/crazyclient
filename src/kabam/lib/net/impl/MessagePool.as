package kabam.lib.net.impl {
public class MessagePool {

    public var type:Class;
    public var callback:Function;
    public var id:int;
    private var tail:Message;
    private var count:int = 0;

    public function MessagePool(_arg_1:int, _arg_2:Class, _arg_3:Function) {
        this.type = _arg_2;
        this.id = _arg_1;
        this.callback = _arg_3;
    }

    public function populate(_arg_1:int):MessagePool {
        var _local_2:Message;
        this.count = (this.count + _arg_1);
        while (_arg_1--) {
            _local_2 = new this.type(this.id, this.callback);
            _local_2.pool = this;
            ((this.tail) && ((this.tail.next = _local_2)));
            _local_2.prev = this.tail;
            this.tail = _local_2;
        }
        return (this);
    }

    public function require():Message {
        var _local_1:Message = this.tail;
        if (_local_1) {
            this.tail = this.tail.prev;
            _local_1.prev = null;
            _local_1.next = null;
        }
        else {
            _local_1 = new this.type(this.id, this.callback);
            _local_1.pool = this;
            this.count++;
        }
        return (_local_1);
    }

    public function getCount():int {
        return (this.count);
    }

    public function append(_arg_1:Message):void {
        ((this.tail) && ((this.tail.next = _arg_1)));
        _arg_1.prev = this.tail;
        this.tail = _arg_1;
    }

    public function dispose():void {
        this.tail = null;
    }


}
}//package kabam.lib.net.impl
