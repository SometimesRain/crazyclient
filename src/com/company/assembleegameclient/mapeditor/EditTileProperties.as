package com.company.assembleegameclient.mapeditor {
import com.company.util.IntPoint;

import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;

public class EditTileProperties extends Sprite {

    public var tiles_:Vector.<IntPoint>;
    private var darkBox_:Shape;
    private var frame_:EditTilePropertiesFrame;

    public function EditTileProperties(_arg_1:Vector.<IntPoint>, _arg_2:String) {
        this.tiles_ = _arg_1;
        this.darkBox_ = new Shape();
        var _local_3:Graphics = this.darkBox_.graphics;
        _local_3.clear();
        _local_3.beginFill(0, 0.8);
        _local_3.drawRect(0, 0, 800, 600);
        _local_3.endFill();
        addChild(this.darkBox_);
        this.frame_ = new EditTilePropertiesFrame(_arg_2);
        this.frame_.addEventListener(Event.COMPLETE, this.onComplete);
        this.frame_.addEventListener(Event.CANCEL, this.onCancel);
        addChild(this.frame_);
    }

    public function getObjectName():String {
        if (this.frame_.objectName_.text() == "") {
            return (null);
        }
        return (this.frame_.objectName_.text());
    }

    public function onComplete(_arg_1:Event):void {
        dispatchEvent(new Event(Event.COMPLETE));
        parent.removeChild(this);
    }

    public function onCancel(_arg_1:Event):void {
        parent.removeChild(this);
    }


}
}//package com.company.assembleegameclient.mapeditor
