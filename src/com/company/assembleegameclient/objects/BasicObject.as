package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Square;

import flash.display.IGraphicsData;

import kabam.rotmg.stage3D.Object3D.Object3DStage3D;

public class BasicObject {

    private static var nextFakeObjectId_:int = 0;

    public var map_:Map;
    public var square_:Square;
    public var objectId_:int;
    public var x_:Number;
    public var y_:Number;
    public var z_:Number;
    public var hasShadow_:Boolean;
    public var drawn_:Boolean;
    public var posW_:Vector.<Number>;
    public var posS_:Vector.<Number>;
    public var sortVal_:Number;

    public function BasicObject() {
        this.posW_ = new Vector.<Number>();
        this.posS_ = new Vector.<Number>();
        super();
        this.clear();
    }

    public static function getNextFakeObjectId():int {
        return ((0x7F000000 | nextFakeObjectId_++));
    }


    public function clear():void {
        this.map_ = null;
        this.square_ = null;
        this.objectId_ = -1;
        this.x_ = 0;
        this.y_ = 0;
        this.z_ = 0;
        this.hasShadow_ = false;
        this.drawn_ = false;
        this.posW_.length = 0;
        this.posS_.length = 0;
        this.sortVal_ = 0;
    }

    public function dispose():void {
        this.map_ = null;
        this.square_ = null;
        this.posW_ = null;
        this.posS_ = null;
    }

    public function update(_arg_1:int, _arg_2:int):Boolean {
        return (true);
    }

    public function draw3d(_arg_1:Vector.<Object3DStage3D>):void {
    }

    public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
    }

    public function drawShadow(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
    }

    public function computeSortVal(_arg_1:Camera):void {
        this.posW_.length = 0;
        this.posW_.push(this.x_, this.y_, 0, this.x_, this.y_, this.z_);
        this.posS_.length = 0;
        _arg_1.wToS_.transformVectors(this.posW_, this.posS_);
        this.sortVal_ = this.posS_[1];
    }

    public function computeSortValNoCamera(_arg_1:Number = 12):void {
        this.posW_.length = 0;
        this.posW_.push(this.x_, this.y_, 0, this.x_, this.y_, this.z_);
        this.posS_.length = 0;
        this.posS_.push((this.x_ * _arg_1), (this.y_ * _arg_1), 0, (this.x_ * _arg_1), (this.y_ * _arg_1), 0);
        this.sortVal_ = this.posS_[1];
    }

    public function addTo(_arg_1:Map, _arg_2:Number, _arg_3:Number):Boolean {
        this.map_ = _arg_1;
        this.square_ = this.map_.getSquare(_arg_2, _arg_3);
        if (this.square_ == null) {
            this.map_ = null;
            return (false);
        }
        this.x_ = _arg_2;
        this.y_ = _arg_3;
        return (true);
    }

    public function removeFromMap():void {
        this.map_ = null;
        this.square_ = null;
    }


}
}//package com.company.assembleegameclient.objects
