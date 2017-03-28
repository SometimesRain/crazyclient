package com.company.assembleegameclient.map {
import com.company.assembleegameclient.objects.BasicObject;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.particles.ConfettiEffect;
import com.company.assembleegameclient.objects.particles.LightningEffect;
import com.company.assembleegameclient.objects.particles.NovaEffect;

import flash.display.IGraphicsData;
import flash.events.Event;
import flash.utils.Dictionary;
import flash.utils.getTimer;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class ParticleModalMap extends Map {

    public static const MODE_SNOW:int = 1;
    public static const MODE_AUTO_UPDATE:int = 2;
    public static const PSCALE:Number = 16;

    private var inUpdate_:Boolean = false;
    private var objsToAdd_:Vector.<BasicObject>;
    private var idsToRemove_:Vector.<int>;
    private var dt:uint = 0;
    private var dtBuildup:uint = 0;
    private var time:uint = 0;
    private var graphicsData_:Vector.<IGraphicsData>;

    public function ParticleModalMap(_arg_1:int = -1) {
        this.objsToAdd_ = new Vector.<BasicObject>();
        this.idsToRemove_ = new Vector.<int>();
        this.graphicsData_ = new Vector.<IGraphicsData>();
        super(null);
        if (_arg_1 == MODE_SNOW) {
            addEventListener(Event.ENTER_FRAME, this.activateModeSnow);
        }
        if (_arg_1 == MODE_AUTO_UPDATE) {
            addEventListener(Event.ENTER_FRAME, this.updater);
        }
    }

    public static function getLocalPos(_arg_1:Number):Number {
        return ((_arg_1 / PSCALE));
    }


    override public function addObj(_arg_1:BasicObject, _arg_2:Number, _arg_3:Number):void {
        _arg_1.x_ = _arg_2;
        _arg_1.y_ = _arg_3;
        if (this.inUpdate_) {
            this.objsToAdd_.push(_arg_1);
        }
        else {
            this.internalAddObj(_arg_1);
        }
    }

    override public function internalAddObj(_arg_1:BasicObject):void {
        var _local_2:Dictionary = boDict_;
        if (_local_2[_arg_1.objectId_] != null) {
            return;
        }
        _arg_1.map_ = this;
        _local_2[_arg_1.objectId_] = _arg_1;
    }

    override public function internalRemoveObj(_arg_1:int):void {
        var _local_2:Dictionary = boDict_;
        var _local_3:BasicObject = _local_2[_arg_1];
        if (_local_3 == null) {
            return;
        }
        _local_3.removeFromMap();
        delete _local_2[_arg_1];
    }

    override public function update(_arg_1:int, _arg_2:int):void {
        var _local_3:BasicObject;
        var _local_4:int;
        this.inUpdate_ = true;
        for each (_local_3 in boDict_) {
            if (!_local_3.update(_arg_1, _arg_2)) {
                this.idsToRemove_.push(_local_3.objectId_);
            }
        }
        this.inUpdate_ = false;
        for each (_local_3 in this.objsToAdd_) {
            this.internalAddObj(_local_3);
        }
        this.objsToAdd_.length = 0;
        for each (_local_4 in this.idsToRemove_) {
            this.internalRemoveObj(_local_4);
        }
        this.idsToRemove_.length = 0;
    }

    override public function draw(_arg_1:Camera, _arg_2:int):void {
        var _local_3:BasicObject;
        this.graphicsData_.length = 0;
        var _local_4:int;
        for each (_local_3 in boDict_) {
            _local_4++;
            _local_3.computeSortValNoCamera(PSCALE);
            _local_3.draw(this.graphicsData_, _arg_1, _arg_2);
        }
        graphics.clear();
        if (this.graphicsData_.length > 0) {
            graphics.drawGraphicsData(this.graphicsData_);
        }
    }

    private function activateModeSnow(_arg_1:Event):void {
        var _local_2:int = 600;
        var _local_3:int = 600;
        if (this.time != 0) {
            this.dt = (getTimer() - this.time);
        }
        this.dtBuildup = (this.dtBuildup + this.dt);
        this.time = getTimer();
        if (this.dtBuildup > 500) {
            this.dtBuildup = 0;
            this.doSnow((Math.random() * 600), -100);
        }
        this.update(this.time, this.dt);
        this.draw(null, this.time);
    }

    private function updater(_arg_1:Event):void {
        if (this.time != 0) {
            this.dt = (getTimer() - this.time);
        }
        this.time = getTimer();
        this.update(this.time, this.dt);
        this.draw(null, this.time);
    }

    public function doNova(_arg_1:Number, _arg_2:Number, _arg_3:int = 20, _arg_4:int = 12447231):void {
        var _local_5:GameObject = new GameObject(null);
        _local_5.x_ = getLocalPos(_arg_1);
        _local_5.y_ = getLocalPos(_arg_2);
        var _local_6:NovaEffect = new NovaEffect(_local_5, _arg_3, _arg_4);
        this.addObj(_local_6, _local_5.x_, _local_5.y_);
    }

    private function doSnow(_arg_1:Number, _arg_2:Number, _arg_3:int = 20, _arg_4:int = 12447231):void {
        var _local_5:WorldPosData = new WorldPosData();
        var _local_6:WorldPosData = new WorldPosData();
        _local_5.x_ = getLocalPos(_arg_1);
        _local_5.y_ = getLocalPos(_arg_2);
        _local_6.x_ = getLocalPos(_arg_1);
        _local_6.y_ = getLocalPos(600);
        var _local_7:ConfettiEffect = new ConfettiEffect(_local_5, _local_6, _arg_4, _arg_3, true);
        this.addObj(_local_7, _local_5.x_, _local_5.y_);
    }

    public function doLightning(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:int = 200, _arg_6:int = 12447231, _arg_7:Number = 1):void {
        var _local_8:GameObject = new GameObject(null);
        _local_8.x_ = getLocalPos(_arg_1);
        _local_8.y_ = getLocalPos(_arg_2);
        var _local_9:WorldPosData = new WorldPosData();
        _local_9.x_ = getLocalPos(_arg_3);
        _local_9.y_ = getLocalPos(_arg_4);
        var _local_10:LightningEffect = new LightningEffect(_local_8, _local_9, _arg_6, _arg_5, _arg_7);
        this.addObj(_local_10, _local_8.x_, _local_8.y_);
    }


}
}//package com.company.assembleegameclient.map
