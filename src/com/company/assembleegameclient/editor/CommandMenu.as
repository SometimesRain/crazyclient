package com.company.assembleegameclient.editor {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.utils.Dictionary;

public class CommandMenu extends Sprite {

    private var keyCodeDict_:Dictionary;
    private var yOffset_:int = 0;
    private var selected_:CommandMenuItem = null;

    public function CommandMenu() {
        this.keyCodeDict_ = new Dictionary();
        super();
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    public function getCommand():int {
        return (this.selected_.command_);
    }

    public function setCommand(_arg_1:int):void {
        var _local_3:CommandMenuItem;
        var _local_2:int;
        while (_local_2 < numChildren) {
            _local_3 = (getChildAt(_local_2) as CommandMenuItem);
            if (_local_3 != null) {
                if (_local_3.command_ == _arg_1) {
                    this.setSelected(_local_3);
                    return;
                }
            }
            _local_2++;
        }
    }

    protected function setSelected(_arg_1:CommandMenuItem):void {
        if (this.selected_ != null) {
            this.selected_.setSelected(false);
        }
        this.selected_ = _arg_1;
        this.selected_.setSelected(true);
    }

    private function onAddedToStage(_arg_1:Event):void {
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        if (stage.focus != null) {
            return;
        }
        var _local_2:CommandMenuItem = this.keyCodeDict_[_arg_1.keyCode];
        if (_local_2 == null) {
            return;
        }
        _local_2.callback_(_local_2);
    }

    protected function addCommandMenuItem(_arg_1:String, _arg_2:int, _arg_3:Function, _arg_4:int):void {
        var _local_5:CommandMenuItem = new CommandMenuItem(_arg_1, _arg_3, _arg_4);
        _local_5.y = this.yOffset_;
        addChild(_local_5);
        if(_arg_2 != -1)
        {
            this.keyCodeDict_[_arg_2] = _local_5;
        }
        if (this.selected_ == null) {
            this.setSelected(_local_5);
        }
        this.yOffset_ = (this.yOffset_ + 30);
    }

    protected function addBreak():void {
        this.yOffset_ = (this.yOffset_ + 30);
    }


}
}//package com.company.assembleegameclient.editor
