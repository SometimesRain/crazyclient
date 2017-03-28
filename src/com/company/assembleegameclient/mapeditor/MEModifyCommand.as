package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.editor.Command;

public class MEModifyCommand extends Command {

    private var map_:MEMap;
    private var x_:int;
    private var y_:int;
    private var layer_:int;
    private var oldType_:int;
    private var newType_:int;

    public function MEModifyCommand(_arg_1:MEMap, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int) {
        this.map_ = _arg_1;
        this.x_ = _arg_2;
        this.y_ = _arg_3;
        this.layer_ = _arg_4;
        this.oldType_ = _arg_5;
        this.newType_ = _arg_6;
    }

    override public function execute():void {
        this.map_.modifyTile(this.x_, this.y_, this.layer_, this.newType_);
    }

    override public function unexecute():void {
        this.map_.modifyTile(this.x_, this.y_, this.layer_, this.oldType_);
    }


}
}//package com.company.assembleegameclient.mapeditor
