package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.editor.Command;

public class MEObjectNameCommand extends Command {

    private var map_:MEMap;
    private var x_:int;
    private var y_:int;
    private var oldName_:String;
    private var newName_:String;

    public function MEObjectNameCommand(_arg_1:MEMap, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:String) {
        this.map_ = _arg_1;
        this.x_ = _arg_2;
        this.y_ = _arg_3;
        this.oldName_ = _arg_4;
        this.newName_ = _arg_5;
    }

    override public function execute():void {
        this.map_.modifyObjectName(this.x_, this.y_, this.newName_);
    }

    override public function unexecute():void {
        this.map_.modifyObjectName(this.x_, this.y_, this.oldName_);
    }


}
}//package com.company.assembleegameclient.mapeditor
