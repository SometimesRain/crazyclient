package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.engine3d.Object3D;
import com.company.assembleegameclient.engine3d.ObjectFace3D;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;

import flash.display.BitmapData;
import flash.display.IGraphicsData;
import flash.geom.Utils3D;
import flash.geom.Vector3D;
import flash.utils.Dictionary;

public class ConnectedObject extends GameObject {

    protected static const DOT_TYPE:int = 0;
    protected static const SHORT_LINE_TYPE:int = 1;
    protected static const L_TYPE:int = 2;
    protected static const LINE_TYPE:int = 3;
    protected static const T_TYPE:int = 4;
    protected static const CROSS_TYPE:int = 5;
    private static var dict_:Dictionary = null;
    protected static const N0:Vector3D = new Vector3D(-1, -1, 0);
    protected static const N1:Vector3D = new Vector3D(0, -1, 0);
    protected static const N2:Vector3D = new Vector3D(1, -1, 0);
    protected static const N3:Vector3D = new Vector3D(1, 0, 0);
    protected static const N4:Vector3D = new Vector3D(1, 1, 0);
    protected static const N5:Vector3D = new Vector3D(0, 1, 0);
    protected static const N6:Vector3D = new Vector3D(-1, 1, 0);
    protected static const N7:Vector3D = new Vector3D(-1, 0, 0);
    protected static const N8:Vector3D = new Vector3D(0, 0, 1);

    protected var rotation_:int = 0;

    public function ConnectedObject(_arg_1:XML) {
        super(_arg_1);
        hasShadow_ = false;
    }

    private static function init():void {
        dict_ = new Dictionary();
        initHelper(33686018, DOT_TYPE);
        initHelper(16908802, SHORT_LINE_TYPE);
        initHelper(16843266, L_TYPE);
        initHelper(16908546, LINE_TYPE);
        initHelper(16843265, T_TYPE);
        initHelper(16843009, CROSS_TYPE);
    }

    private static function getConnectedResults(_arg_1:int):ConnectedResults {
        if (dict_ == null) {
            init();
        }
        var _local_2:int = (_arg_1 & 252645135);
        return (dict_[_local_2]);
    }

    private static function initHelper(_arg_1:int, _arg_2:int):void {
        var _local_4:int;
        var _local_3:int;
        while (_local_3 < 4) {
            if (!dict_.hasOwnProperty(String(_arg_1))) {
                dict_[_arg_1] = new ConnectedResults(_arg_2, _local_3);
                _local_4 = (_arg_1 & 0xFF);
                _arg_1 = ((_arg_1 >> 8) | (_local_4 << 24));
            }
            _local_3++;
        }
    }


    override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        var _local_4:ObjectFace3D;
        var _local_5:int;
        var _local_6:int;
        var _local_7:BitmapData;
        var _local_8:Square;
        if (obj3D_ == null) {
            this.rebuild3D();
        }
        Utils3D.projectVectors(_arg_2.wToS_, obj3D_.vW_, obj3D_.vS_, obj3D_.uvts_);
        for each (_local_4 in obj3D_.faces_) {
            _local_5 = (((_local_4.normalW_.x > 0.4)) ? 1 : (((_local_4.normalW_.x < -0.4)) ? -1 : 0));
            _local_6 = (((_local_4.normalW_.y > 0.4)) ? 1 : (((_local_4.normalW_.y < -0.4)) ? -1 : 0));
            _local_7 = _local_4.texture_;
            if (((!((_local_5 == 0))) || (!((_local_6 == 0))))) {
                _local_8 = map_.lookupSquare((x_ + _local_5), (y_ + _local_6));
                if ((((_local_8 == null)) || ((_local_8.texture_ == null)))) {
                    _local_7 = null;
                }
            }
            _local_4.draw(_arg_1, 0, _local_7);
        }
    }

    public function rebuild3D():void {
        obj3D_ = new Object3D();
        var _local_1:ConnectedResults = getConnectedResults(connectType_);
        if (_local_1 == null) {
            obj3D_ = null;
            return;
        }
        this.rotation_ = _local_1.rotation_;
        switch (_local_1.type_) {
            case DOT_TYPE:
                this.buildDot();
                break;
            case SHORT_LINE_TYPE:
                this.buildShortLine();
                break;
            case L_TYPE:
                this.buildL();
                break;
            case LINE_TYPE:
                this.buildLine();
                break;
            case T_TYPE:
                this.buildT();
                break;
            case CROSS_TYPE:
                this.buildCross();
                break;
            default:
                obj3D_ = null;
                return;
        }
        obj3D_.setPosition(x_, y_, 0, (this.rotation_ * 90));
    }

    protected function buildDot():void {
    }

    protected function buildShortLine():void {
    }

    protected function buildL():void {
    }

    protected function buildLine():void {
    }

    protected function buildT():void {
    }

    protected function buildCross():void {
    }


}
}//package com.company.assembleegameclient.objects

class ConnectedResults {

    public var type_:int;
    public var rotation_:int;

    public function ConnectedResults(_arg_1:int, _arg_2:int) {
        this.type_ = _arg_1;
        this.rotation_ = _arg_2;
    }

}
