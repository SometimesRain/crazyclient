package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;

import flash.display.IGraphicsData;

public class SpiderWeb extends GameObject {

    private var wallFound_:Boolean = false;

    public function SpiderWeb(_arg_1:XML) {
        super(_arg_1);
    }

    override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        if (!this.wallFound_) {
            this.wallFound_ = this.findWall();
        }
        if (this.wallFound_) {
            super.draw(_arg_1, _arg_2, _arg_3);
        }
    }

    private function findWall():Boolean {
        var _local_1:Square;
        _local_1 = map_.lookupSquare((x_ - 1), y_);
        if (((!((_local_1 == null))) && ((_local_1.obj_ is Wall)))) {
            return (true);
        }
        _local_1 = map_.lookupSquare(x_, (y_ - 1));
        if (((!((_local_1 == null))) && ((_local_1.obj_ is Wall)))) {
            obj3D_.setPosition(x_, y_, 0, 90);
            return (true);
        }
        _local_1 = map_.lookupSquare((x_ + 1), y_);
        if (((!((_local_1 == null))) && ((_local_1.obj_ is Wall)))) {
            obj3D_.setPosition(x_, y_, 0, 180);
            return (true);
        }
        _local_1 = map_.lookupSquare(x_, (y_ + 1));
        if (((!((_local_1 == null))) && ((_local_1.obj_ is Wall)))) {
            obj3D_.setPosition(x_, y_, 0, 270);
            return (true);
        }
        return (false);
    }


}
}//package com.company.assembleegameclient.objects
