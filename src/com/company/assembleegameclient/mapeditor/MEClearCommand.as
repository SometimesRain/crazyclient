package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.editor.Command;

public class MEClearCommand extends Command {

    private var map_:MEMap;
    private var x_:int;
    private var y_:int;
    private var oldTile_:METile;

    public function MEClearCommand(_arg_1:MEMap, _arg_2:int, _arg_3:int, _arg_4:METile) {
        this.map_ = _arg_1;
        this.x_ = _arg_2;
        this.y_ = _arg_3;
        this.oldTile_ = _arg_4.clone();
    }

    override public function execute():void {
        this.map_.eraseTile(this.x_, this.y_);
    }

    override public function unexecute():void {
        this.map_.setTile(this.x_, this.y_, this.oldTile_);
    }


}
}//package com.company.assembleegameclient.mapeditor
