package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.engine3d.ObjectFace3D;
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.BitmapData;
import flash.geom.Vector3D;

import kabam.rotmg.stage3D.GraphicsFillExtra;

public class CaveWall extends ConnectedObject {

    public function CaveWall(_arg_1:XML) {
        super(_arg_1);
    }

    override protected function buildDot():void {
        var _local_6:ObjectFace3D;
        var _local_1:Vector3D = new Vector3D((-0.25 - (Math.random() * 0.25)), (-0.25 - (Math.random() * 0.25)), 0);
        var _local_2:Vector3D = new Vector3D((0.25 + (Math.random() * 0.25)), (-0.25 - (Math.random() * 0.25)), 0);
        var _local_3:Vector3D = new Vector3D((0.25 + (Math.random() * 0.25)), (0.25 + (Math.random() * 0.25)), 0);
        var _local_4:Vector3D = new Vector3D((-0.25 - (Math.random() * 0.25)), (0.25 + (Math.random() * 0.25)), 0);
        var _local_5:Vector3D = new Vector3D((-0.25 + (Math.random() * 0.5)), (-0.25 + (Math.random() * 0.5)), 1);
        this.faceHelper(null, texture_, _local_5, _local_1, _local_2);
        this.faceHelper(null, texture_, _local_5, _local_2, _local_3);
        this.faceHelper(null, texture_, _local_5, _local_3, _local_4);
        this.faceHelper(null, texture_, _local_5, _local_4, _local_1);
        if (Parameters.isGpuRender()) {
            for each (_local_6 in obj3D_.faces_) {
                GraphicsFillExtra.setSoftwareDraw(_local_6.bitmapFill_, true);
            }
        }
    }

    override protected function buildShortLine():void {
        var _local_9:ObjectFace3D;
        var _local_1:Vector3D = this.getVertex(0, 0);
        var _local_2:Vector3D = this.getVertex(0, 3);
        var _local_3:Vector3D = new Vector3D((0.25 + (Math.random() * 0.25)), (0.25 + (Math.random() * 0.25)), 0);
        var _local_4:Vector3D = new Vector3D((-0.25 - (Math.random() * 0.25)), (0.25 + (Math.random() * 0.25)), 0);
        var _local_5:Vector3D = this.getVertex(0, 1);
        var _local_6:Vector3D = this.getVertex(0, 2);
        var _local_7:Vector3D = new Vector3D((Math.random() * 0.25), (Math.random() * 0.25), 0.5);
        var _local_8:Vector3D = new Vector3D((Math.random() * -0.25), (Math.random() * 0.25), 0.5);
        this.faceHelper(null, texture_, _local_5, _local_8, _local_4, _local_1);
        this.faceHelper(null, texture_, _local_8, _local_7, _local_3, _local_4);
        this.faceHelper(null, texture_, _local_7, _local_6, _local_2, _local_3);
        this.faceHelper(null, texture_, _local_5, _local_6, _local_7, _local_8);
        if (Parameters.isGpuRender()) {
            for each (_local_9 in obj3D_.faces_) {
                GraphicsFillExtra.setSoftwareDraw(_local_9.bitmapFill_, true);
            }
        }
    }

    override protected function buildL():void {
        var _local_11:ObjectFace3D;
        var _local_1:Vector3D = this.getVertex(0, 0);
        var _local_2:Vector3D = this.getVertex(0, 3);
        var _local_3:Vector3D = this.getVertex(1, 0);
        var _local_4:Vector3D = this.getVertex(1, 3);
        var _local_5:Vector3D = new Vector3D((-(Math.random()) * 0.25), (Math.random() * 0.25), 0);
        var _local_6:Vector3D = this.getVertex(0, 1);
        var _local_7:Vector3D = this.getVertex(0, 2);
        var _local_8:Vector3D = this.getVertex(1, 1);
        var _local_9:Vector3D = this.getVertex(1, 2);
        var _local_10:Vector3D = new Vector3D((Math.random() * 0.25), (-(Math.random()) * 0.25), 1);
        this.faceHelper(null, texture_, _local_6, _local_10, _local_5, _local_1);
        this.faceHelper(null, texture_, _local_10, _local_9, _local_4, _local_5);
        this.faceHelper(N2, texture_, _local_8, _local_7, _local_2, _local_3);
        this.faceHelper(null, texture_, _local_6, _local_7, _local_8, _local_9, _local_10);
        if (Parameters.isGpuRender()) {
            for each (_local_11 in obj3D_.faces_) {
                GraphicsFillExtra.setSoftwareDraw(_local_11.bitmapFill_, true);
            }
        }
    }

    override protected function buildLine():void {
        var _local_9:ObjectFace3D;
        var _local_1:Vector3D = this.getVertex(0, 0);
        var _local_2:Vector3D = this.getVertex(0, 3);
        var _local_3:Vector3D = this.getVertex(2, 3);
        var _local_4:Vector3D = this.getVertex(2, 0);
        var _local_5:Vector3D = this.getVertex(0, 1);
        var _local_6:Vector3D = this.getVertex(0, 2);
        var _local_7:Vector3D = this.getVertex(2, 2);
        var _local_8:Vector3D = this.getVertex(2, 1);
        this.faceHelper(N7, texture_, _local_5, _local_8, _local_4, _local_1);
        this.faceHelper(N3, texture_, _local_7, _local_6, _local_2, _local_3);
        this.faceHelper(null, texture_, _local_5, _local_6, _local_7, _local_8);
        if (Parameters.isGpuRender()) {
            for each (_local_9 in obj3D_.faces_) {
                GraphicsFillExtra.setSoftwareDraw(_local_9.bitmapFill_, true);
            }
        }
    }

    override protected function buildT():void {
        var _local_13:ObjectFace3D;
        var _local_1:Vector3D = this.getVertex(0, 0);
        var _local_2:Vector3D = this.getVertex(0, 3);
        var _local_3:Vector3D = this.getVertex(1, 0);
        var _local_4:Vector3D = this.getVertex(1, 3);
        var _local_5:Vector3D = this.getVertex(3, 3);
        var _local_6:Vector3D = this.getVertex(3, 0);
        var _local_7:Vector3D = this.getVertex(0, 1);
        var _local_8:Vector3D = this.getVertex(0, 2);
        var _local_9:Vector3D = this.getVertex(1, 1);
        var _local_10:Vector3D = this.getVertex(1, 2);
        var _local_11:Vector3D = this.getVertex(3, 2);
        var _local_12:Vector3D = this.getVertex(3, 1);
        this.faceHelper(N2, texture_, _local_9, _local_8, _local_2, _local_3);
        this.faceHelper(null, texture_, _local_11, _local_10, _local_4, _local_5);
        this.faceHelper(N0, texture_, _local_7, _local_12, _local_6, _local_1);
        this.faceHelper(null, texture_, _local_7, _local_8, _local_9, _local_10, _local_11, _local_12);
        if (Parameters.isGpuRender()) {
            for each (_local_13 in obj3D_.faces_) {
                GraphicsFillExtra.setSoftwareDraw(_local_13.bitmapFill_, true);
            }
        }
    }

    override protected function buildCross():void {
        var _local_17:ObjectFace3D;
        var _local_1:Vector3D = this.getVertex(0, 0);
        var _local_2:Vector3D = this.getVertex(0, 3);
        var _local_3:Vector3D = this.getVertex(1, 0);
        var _local_4:Vector3D = this.getVertex(1, 3);
        var _local_5:Vector3D = this.getVertex(2, 3);
        var _local_6:Vector3D = this.getVertex(2, 0);
        var _local_7:Vector3D = this.getVertex(3, 3);
        var _local_8:Vector3D = this.getVertex(3, 0);
        var _local_9:Vector3D = this.getVertex(0, 1);
        var _local_10:Vector3D = this.getVertex(0, 2);
        var _local_11:Vector3D = this.getVertex(1, 1);
        var _local_12:Vector3D = this.getVertex(1, 2);
        var _local_13:Vector3D = this.getVertex(2, 2);
        var _local_14:Vector3D = this.getVertex(2, 1);
        var _local_15:Vector3D = this.getVertex(3, 2);
        var _local_16:Vector3D = this.getVertex(3, 1);
        this.faceHelper(N2, texture_, _local_11, _local_10, _local_2, _local_3);
        this.faceHelper(N4, texture_, _local_13, _local_12, _local_4, _local_5);
        this.faceHelper(N6, texture_, _local_15, _local_14, _local_6, _local_7);
        this.faceHelper(N0, texture_, _local_9, _local_16, _local_8, _local_1);
        this.faceHelper(null, texture_, _local_9, _local_10, _local_11, _local_12, _local_13, _local_14, _local_15, _local_16);
        if (Parameters.isGpuRender()) {
            for each (_local_17 in obj3D_.faces_) {
                GraphicsFillExtra.setSoftwareDraw(_local_17.bitmapFill_, true);
            }
        }
    }

    protected function getVertex(_arg_1:int, _arg_2:int):Vector3D {
        var _local_6:int;
        var _local_7:Number;
        var _local_8:Number;
        var _local_3:int = x_;
        var _local_4:int = y_;
        var _local_5:int = ((_arg_1 + rotation_) % 4);
        switch (_local_5) {
            case 1:
                _local_3++;
                break;
            case 2:
                _local_4++;
                break;
        }
        switch (_arg_2) {
            case 0:
            case 3:
                _local_6 = (15 + (((_local_3 * 1259) ^ (_local_4 * 2957)) % 35));
                break;
            case 1:
            case 2:
                _local_6 = (3 + (((_local_3 * 2179) ^ (_local_4 * 1237)) % 35));
                break;
        }
        switch (_arg_2) {
            case 0:
                _local_7 = (-(_local_6) / 100);
                _local_8 = 0;
                break;
            case 1:
                _local_7 = (-(_local_6) / 100);
                _local_8 = 1;
                break;
            case 2:
                _local_7 = (_local_6 / 100);
                _local_8 = 1;
                break;
            case 3:
                _local_7 = (_local_6 / 100);
                _local_8 = 0;
                break;
        }
        switch (_arg_1) {
            case 0:
                return (new Vector3D(_local_7, -0.5, _local_8));
            case 1:
                return (new Vector3D(0.5, _local_7, _local_8));
            case 2:
                return (new Vector3D(_local_7, 0.5, _local_8));
            case 3:
                return (new Vector3D(-0.5, _local_7, _local_8));
        }
        return (null);
    }

    protected function faceHelper(_arg_1:Vector3D, _arg_2:BitmapData, ... rest):void {
        var _local_5:Vector3D;
        var _local_6:int;
        var _local_7:int;
        var _local_4:int = (obj3D_.vL_.length / 3);
        for each (_local_5 in rest) {
            obj3D_.vL_.push(_local_5.x, _local_5.y, _local_5.z);
        }
        _local_6 = obj3D_.faces_.length;
        if (rest.length == 4) {
            obj3D_.uvts_.push(0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0);
            if (Math.random() < 0.5) {
                obj3D_.faces_.push(new ObjectFace3D(obj3D_, new <int>[_local_4, (_local_4 + 1), (_local_4 + 3)]), new ObjectFace3D(obj3D_, new <int>[(_local_4 + 1), (_local_4 + 2), (_local_4 + 3)]));
            }
            else {
                obj3D_.faces_.push(new ObjectFace3D(obj3D_, new <int>[_local_4, (_local_4 + 2), (_local_4 + 3)]), new ObjectFace3D(obj3D_, new <int>[_local_4, (_local_4 + 1), (_local_4 + 2)]));
            }
        }
        else {
            if (rest.length == 3) {
                obj3D_.uvts_.push(0, 0, 0, 0, 1, 0, 1, 1, 0);
                obj3D_.faces_.push(new ObjectFace3D(obj3D_, new <int>[_local_4, (_local_4 + 1), (_local_4 + 2)]));
            }
            else {
                if (rest.length == 5) {
                    obj3D_.uvts_.push(0.2, 0, 0, 0.8, 0, 0, 1, 0.2, 0, 1, 0.8, 0, 0, 0.8, 0);
                    obj3D_.faces_.push(new ObjectFace3D(obj3D_, new <int>[_local_4, (_local_4 + 1), (_local_4 + 2), (_local_4 + 3), (_local_4 + 4)]));
                }
                else {
                    if (rest.length == 6) {
                        obj3D_.uvts_.push(0, 0, 0, 0.2, 0, 0, 1, 0.2, 0, 1, 0.8, 0, 0, 0.8, 0, 0, 0.2, 0);
                        obj3D_.faces_.push(new ObjectFace3D(obj3D_, new <int>[_local_4, (_local_4 + 1), (_local_4 + 2), (_local_4 + 3), (_local_4 + 4), (_local_4 + 5)]));
                    }
                    else {
                        if (rest.length == 8) {
                            obj3D_.uvts_.push(0, 0, 0, 0.2, 0, 0, 1, 0.2, 0, 1, 0.8, 0, 0.8, 1, 0, 0.2, 1, 0, 0, 0.8, 0, 0, 0.2, 0);
                            obj3D_.faces_.push(new ObjectFace3D(obj3D_, new <int>[_local_4, (_local_4 + 1), (_local_4 + 2), (_local_4 + 3), (_local_4 + 4), (_local_4 + 5), (_local_4 + 6), (_local_4 + 7)]));
                        }
                    }
                }
            }
        }
        if (((!((_arg_1 == null))) || (!((_arg_2 == null))))) {
            _local_7 = _local_6;
            while (_local_7 < obj3D_.faces_.length) {
                obj3D_.faces_[_local_7].normalL_ = _arg_1;
                obj3D_.faces_[_local_7].texture_ = _arg_2;
                _local_7++;
            }
        }
    }


}
}//package com.company.assembleegameclient.objects
