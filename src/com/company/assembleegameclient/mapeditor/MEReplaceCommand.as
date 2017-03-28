package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.editor.Command;

public class MEReplaceCommand extends Command {

    private var map_:MEMap;
    private var x_:int;
    private var y_:int;
    private var oldTile_:METile;
    private var newTile_:METile;

    public function MEReplaceCommand(_arg_1:MEMap, _arg_2:int, _arg_3:int, _arg_4:METile, _arg_5:METile) {
        this.map_ = _arg_1;
        this.x_ = _arg_2;
        this.y_ = _arg_3;
        if (_arg_4 != null) {
            this.oldTile_ = _arg_4.clone();
        }
        if (_arg_5 != null) {
            this.newTile_ = _arg_5.clone();
        }
    }

    override public function execute():void {
        if (this.newTile_ == null) {
            this.map_.eraseTile(this.x_, this.y_);
        }
        else {
            this.map_.setTile(this.x_, this.y_, this.newTile_);
        }
    }

    override public function unexecute():void {
        if (this.oldTile_ == null) {
            this.map_.eraseTile(this.x_, this.y_);
        }
        else {
            this.map_.setTile(this.x_, this.y_, this.oldTile_);
        }
    }


}
}//package com.company.assembleegameclient.mapeditor
