package com.company.assembleegameclient.editor {
public class CommandQueue {

    private var list_:Vector.<CommandList>;
    private var currPos:int = 0;

    public function CommandQueue() {
        this.list_ = new Vector.<CommandList>();
        super();
    }

    public function addCommandList(_arg_1:CommandList):void {
        this.list_.length = this.currPos;
        _arg_1.execute();
        this.list_.push(_arg_1);
        this.currPos++;
    }

    public function undo():void {
        if (this.currPos == 0) {
            return;
        }
        this.list_[--this.currPos].unexecute();
    }

    public function redo():void {
        if (this.currPos == this.list_.length) {
            return;
        }
        this.list_[this.currPos++].execute();
    }

    public function clear():void {
        this.currPos = 0;
        this.list_.length = 0;
    }


}
}//package com.company.assembleegameclient.editor
