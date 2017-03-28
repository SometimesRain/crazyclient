package com.company.assembleegameclient.editor {
public class CommandList {

    private var list_:Vector.<Command>;

    public function CommandList() {
        this.list_ = new Vector.<Command>();
        super();
    }

    public function empty():Boolean {
        return ((this.list_.length == 0));
    }

    public function addCommand(_arg_1:Command):void {
        this.list_.push(_arg_1);
    }

    public function execute():void {
        var _local_1:Command;
        for each (_local_1 in this.list_) {
            _local_1.execute();
        }
    }

    public function unexecute():void {
        var _local_1:Command;
        for each (_local_1 in this.list_) {
            _local_1.unexecute();
        }
    }


}
}//package com.company.assembleegameclient.editor
