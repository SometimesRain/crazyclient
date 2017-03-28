package com.company.assembleegameclient.util {
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.map.GroundProperties;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.AssetLibrary;
import com.company.util.BitmapUtil;
import com.company.util.ImageSet;
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;

public class TileRedrawer {

    private static const rect0:Rectangle = new Rectangle(0, 0, 4, 4);
    private static const p0:Point = new Point(0, 0);
    private static const rect1:Rectangle = new Rectangle(4, 0, 4, 4);
    private static const p1:Point = new Point(4, 0);
    private static const rect2:Rectangle = new Rectangle(0, 4, 4, 4);
    private static const p2:Point = new Point(0, 4);
    private static const rect3:Rectangle = new Rectangle(4, 4, 4, 4);
    private static const p3:Point = new Point(4, 4);
    private static const INNER:int = 0;
    private static const SIDE0:int = 1;
    private static const SIDE1:int = 2;
    private static const OUTER:int = 3;
    private static const INNERP1:int = 4;
    private static const INNERP2:int = 5;
    private static const mlist_:Vector.<Vector.<ImageSet>> = getMasks();
    private static var cache_:Vector.<Object> = new <Object>[null, {}];
    private static const RECT01:Rectangle = new Rectangle(0, 0, 8, 4);
    private static const RECT13:Rectangle = new Rectangle(4, 0, 4, 8);
    private static const RECT23:Rectangle = new Rectangle(0, 4, 8, 4);
    private static const RECT02:Rectangle = new Rectangle(0, 0, 4, 8);
    private static const RECT0:Rectangle = new Rectangle(0, 0, 4, 4);
    private static const RECT1:Rectangle = new Rectangle(4, 0, 4, 4);
    private static const RECT2:Rectangle = new Rectangle(0, 4, 4, 4);
    private static const RECT3:Rectangle = new Rectangle(4, 4, 4, 4);
    private static const POINT0:Point = new Point(0, 0);
    private static const POINT1:Point = new Point(4, 0);
    private static const POINT2:Point = new Point(0, 4);
    private static const POINT3:Point = new Point(4, 4);


    public static function redraw(_arg_1:Square, _arg_2:Boolean):BitmapData {
        var _local_3:Array;
        var _local_5:BitmapData;
        if (Parameters.blendType_ == 0) {
            return (null);
        }
        if (_arg_1.tileType_ == 253) {
            _local_3 = getCompositeSig(_arg_1);
        }
        else {
            if (_arg_1.props_.hasEdge_) {
                _local_3 = getEdgeSig(_arg_1);
            }
            else {
                _local_3 = getSig(_arg_1);
            }
        }
        if (_local_3 == null) {
            return (null);
        }
        var _local_4:Object = cache_[Parameters.blendType_];
        if (_local_4.hasOwnProperty(_local_3)) {
            return (_local_4[_local_3]);
        }
        if (_arg_1.tileType_ == 253) {
            _local_5 = buildComposite(_local_3);
            _local_4[_local_3] = _local_5;
            return (_local_5);
        }
        if (_arg_1.props_.hasEdge_) {
            _local_5 = drawEdges(_local_3);
            _local_4[_local_3] = _local_5;
            return (_local_5);
        }
        var _local_6:Boolean;
        var _local_7:Boolean;
        var _local_8:Boolean;
        var _local_9:Boolean;
        if (_local_3[1] != _local_3[4]) {
            _local_6 = true;
            _local_7 = true;
        }
        if (_local_3[3] != _local_3[4]) {
            _local_6 = true;
            _local_8 = true;
        }
        if (_local_3[5] != _local_3[4]) {
            _local_7 = true;
            _local_9 = true;
        }
        if (_local_3[7] != _local_3[4]) {
            _local_8 = true;
            _local_9 = true;
        }
        if (((!(_local_6)) && (!((_local_3[0] == _local_3[4]))))) {
            _local_6 = true;
        }
        if (((!(_local_7)) && (!((_local_3[2] == _local_3[4]))))) {
            _local_7 = true;
        }
        if (((!(_local_8)) && (!((_local_3[6] == _local_3[4]))))) {
            _local_8 = true;
        }
        if (((!(_local_9)) && (!((_local_3[8] == _local_3[4]))))) {
            _local_9 = true;
        }
        if (((((((!(_local_6)) && (!(_local_7)))) && (!(_local_8)))) && (!(_local_9)))) {
            _local_4[_local_3] = null;
            return (null);
        }
        var _local_10:BitmapData = GroundLibrary.getBitmapData(_arg_1.tileType_);
        if (_arg_2) {
            _local_5 = _local_10.clone();
        }
        else {
            _local_5 = new BitmapDataSpy(_local_10.width, _local_10.height, true, 0);
        }
        if (_local_6) {
            redrawRect(_local_5, rect0, p0, mlist_[0], _local_3[4], _local_3[3], _local_3[0], _local_3[1]);
        }
        if (_local_7) {
            redrawRect(_local_5, rect1, p1, mlist_[1], _local_3[4], _local_3[1], _local_3[2], _local_3[5]);
        }
        if (_local_8) {
            redrawRect(_local_5, rect2, p2, mlist_[2], _local_3[4], _local_3[7], _local_3[6], _local_3[3]);
        }
        if (_local_9) {
            redrawRect(_local_5, rect3, p3, mlist_[3], _local_3[4], _local_3[5], _local_3[8], _local_3[7]);
        }
        _local_4[_local_3] = _local_5;
        return (_local_5);
    }

    private static function redrawRect(_arg_1:BitmapData, _arg_2:Rectangle, _arg_3:Point, _arg_4:Vector.<ImageSet>, _arg_5:uint, _arg_6:uint, _arg_7:uint, _arg_8:uint):void {
        var _local_9:BitmapData;
        var _local_10:BitmapData;
        if ((((_arg_5 == _arg_6)) && ((_arg_5 == _arg_8)))) {
            _local_10 = _arg_4[OUTER].random();
            _local_9 = GroundLibrary.getBitmapData(_arg_7);
        }
        else {
            if (((!((_arg_5 == _arg_6))) && (!((_arg_5 == _arg_8))))) {
                if (_arg_6 != _arg_8) {
                    _arg_1.copyPixels(GroundLibrary.getBitmapData(_arg_6), _arg_2, _arg_3, _arg_4[INNERP1].random(), p0, true);
                    _arg_1.copyPixels(GroundLibrary.getBitmapData(_arg_8), _arg_2, _arg_3, _arg_4[INNERP2].random(), p0, true);
                    return;
                }
                _local_10 = _arg_4[INNER].random();
                _local_9 = GroundLibrary.getBitmapData(_arg_6);
            }
            else {
                if (_arg_5 != _arg_6) {
                    _local_10 = _arg_4[SIDE0].random();
                    _local_9 = GroundLibrary.getBitmapData(_arg_6);
                }
                else {
                    _local_10 = _arg_4[SIDE1].random();
                    _local_9 = GroundLibrary.getBitmapData(_arg_8);
                }
            }
        }
        _arg_1.copyPixels(_local_9, _arg_2, _arg_3, _local_10, p0, true);
    }

    private static function getSig(_arg_1:Square):Array {
        var _local_6:int;
        var _local_7:Square;
        var _local_2:Array = new Array();
        var _local_3:Map = _arg_1.map_;
        var _local_4:uint = _arg_1.tileType_;
        var _local_5:int = (_arg_1.y_ - 1);
        while (_local_5 <= (_arg_1.y_ + 1)) {
            _local_6 = (_arg_1.x_ - 1);
            while (_local_6 <= (_arg_1.x_ + 1)) {
                if ((((((((((_local_6 < 0)) || ((_local_6 >= _local_3.width_)))) || ((_local_5 < 0)))) || ((_local_5 >= _local_3.height_)))) || ((((_local_6 == _arg_1.x_)) && ((_local_5 == _arg_1.y_)))))) {
                    _local_2.push(_local_4);
                }
                else {
                    _local_7 = _local_3.squares_[(_local_6 + (_local_5 * _local_3.width_))];
                    if ((((_local_7 == null)) || ((_local_7.props_.blendPriority_ <= _arg_1.props_.blendPriority_)))) {
                        _local_2.push(_local_4);
                    }
                    else {
                        _local_2.push(_local_7.tileType_);
                    }
                }
                _local_6++;
            }
            _local_5++;
        }
        return (_local_2);
    }

    private static function getMasks():Vector.<Vector.<ImageSet>> {
        var _local_1:Vector.<Vector.<ImageSet>> = new Vector.<Vector.<ImageSet>>();
        addMasks(_local_1, AssetLibrary.getImageSet("inner_mask"), AssetLibrary.getImageSet("sides_mask"), AssetLibrary.getImageSet("outer_mask"), AssetLibrary.getImageSet("innerP1_mask"), AssetLibrary.getImageSet("innerP2_mask"));
        return (_local_1);
    }

    private static function addMasks(_arg_1:Vector.<Vector.<ImageSet>>, _arg_2:ImageSet, _arg_3:ImageSet, _arg_4:ImageSet, _arg_5:ImageSet, _arg_6:ImageSet):void {
        var _local_7:int;
        for each (_local_7 in [-1, 0, 2, 1]) {
            _arg_1.push(new <ImageSet>[rotateImageSet(_arg_2, _local_7), rotateImageSet(_arg_3, (_local_7 - 1)), rotateImageSet(_arg_3, _local_7), rotateImageSet(_arg_4, _local_7), rotateImageSet(_arg_5, _local_7), rotateImageSet(_arg_6, _local_7)]);
        }
    }

    private static function rotateImageSet(_arg_1:ImageSet, _arg_2:int):ImageSet {
        var _local_4:BitmapData;
        var _local_3:ImageSet = new ImageSet();
        for each (_local_4 in _arg_1.images_) {
            _local_3.add(BitmapUtil.rotateBitmapData(_local_4, _arg_2));
        }
        return (_local_3);
    }

    private static function getCompositeSig(_arg_1:Square):Array {
        var _local_14:Square;
        var _local_15:Square;
        var _local_16:Square;
        var _local_17:Square;
        var _local_2:Array = new Array();
        _local_2.length = 4;
        var _local_3:Map = _arg_1.map_;
        var _local_4:int = _arg_1.x_;
        var _local_5:int = _arg_1.y_;
        var _local_6:Square = _local_3.lookupSquare(_local_4, (_local_5 - 1));
        var _local_7:Square = _local_3.lookupSquare((_local_4 - 1), _local_5);
        var _local_8:Square = _local_3.lookupSquare((_local_4 + 1), _local_5);
        var _local_9:Square = _local_3.lookupSquare(_local_4, (_local_5 + 1));
        var _local_10:int = (((_local_6) != null) ? _local_6.props_.compositePriority_ : -1);
        var _local_11:int = (((_local_7) != null) ? _local_7.props_.compositePriority_ : -1);
        var _local_12:int = (((_local_8) != null) ? _local_8.props_.compositePriority_ : -1);
        var _local_13:int = (((_local_9) != null) ? _local_9.props_.compositePriority_ : -1);
        if ((((_local_10 < 0)) && ((_local_11 < 0)))) {
            _local_14 = _local_3.lookupSquare((_local_4 - 1), (_local_5 - 1));
            _local_2[0] = (((((_local_14 == null)) || ((_local_14.props_.compositePriority_ < 0)))) ? 0xFF : _local_14.tileType_);
        }
        else {
            if (_local_10 < _local_11) {
                _local_2[0] = _local_7.tileType_;
            }
            else {
                _local_2[0] = _local_6.tileType_;
            }
        }
        if ((((_local_10 < 0)) && ((_local_12 < 0)))) {
            _local_15 = _local_3.lookupSquare((_local_4 + 1), (_local_5 - 1));
            _local_2[1] = (((((_local_15 == null)) || ((_local_15.props_.compositePriority_ < 0)))) ? 0xFF : _local_15.tileType_);
        }
        else {
            if (_local_10 < _local_12) {
                _local_2[1] = _local_8.tileType_;
            }
            else {
                _local_2[1] = _local_6.tileType_;
            }
        }
        if ((((_local_11 < 0)) && ((_local_13 < 0)))) {
            _local_16 = _local_3.lookupSquare((_local_4 - 1), (_local_5 + 1));
            _local_2[2] = (((((_local_16 == null)) || ((_local_16.props_.compositePriority_ < 0)))) ? 0xFF : _local_16.tileType_);
        }
        else {
            if (_local_11 < _local_13) {
                _local_2[2] = _local_9.tileType_;
            }
            else {
                _local_2[2] = _local_7.tileType_;
            }
        }
        if ((((_local_12 < 0)) && ((_local_13 < 0)))) {
            _local_17 = _local_3.lookupSquare((_local_4 + 1), (_local_5 + 1));
            _local_2[3] = (((((_local_17 == null)) || ((_local_17.props_.compositePriority_ < 0)))) ? 0xFF : _local_17.tileType_);
        }
        else {
            if (_local_12 < _local_13) {
                _local_2[3] = _local_9.tileType_;
            }
            else {
                _local_2[3] = _local_8.tileType_;
            }
        }
        return (_local_2);
    }

    private static function buildComposite(_arg_1:Array):BitmapData {
        var _local_3:BitmapData;
        var _local_2:BitmapData = new BitmapDataSpy(8, 8, false, 0);
        if (_arg_1[0] != 0xFF) {
            _local_3 = GroundLibrary.getBitmapData(_arg_1[0]);
            _local_2.copyPixels(_local_3, RECT0, POINT0);
        }
        if (_arg_1[1] != 0xFF) {
            _local_3 = GroundLibrary.getBitmapData(_arg_1[1]);
            _local_2.copyPixels(_local_3, RECT1, POINT1);
        }
        if (_arg_1[2] != 0xFF) {
            _local_3 = GroundLibrary.getBitmapData(_arg_1[2]);
            _local_2.copyPixels(_local_3, RECT2, POINT2);
        }
        if (_arg_1[3] != 0xFF) {
            _local_3 = GroundLibrary.getBitmapData(_arg_1[3]);
            _local_2.copyPixels(_local_3, RECT3, POINT3);
        }
        return (_local_2);
    }

    private static function getEdgeSig(_arg_1:Square):Array {
        var _local_7:int;
        var _local_8:Square;
        var _local_9:Boolean;
        var _local_2:Array = new Array();
        var _local_3:Map = _arg_1.map_;
        var _local_4:Boolean;
        var _local_5:Boolean = _arg_1.props_.sameTypeEdgeMode_;
        var _local_6:int = (_arg_1.y_ - 1);
        while (_local_6 <= (_arg_1.y_ + 1)) {
            _local_7 = (_arg_1.x_ - 1);
            while (_local_7 <= (_arg_1.x_ + 1)) {
                _local_8 = _local_3.lookupSquare(_local_7, _local_6);
                if ((((_local_7 == _arg_1.x_)) && ((_local_6 == _arg_1.y_)))) {
                    _local_2.push(_local_8.tileType_);
                }
                else {
                    if (_local_5) {
                        _local_9 = (((_local_8 == null)) || ((_local_8.tileType_ == _arg_1.tileType_)));
                    }
                    else {
                        _local_9 = (((_local_8 == null)) || (!((_local_8.tileType_ == 0xFF))));
                    }
                    _local_2.push(_local_9);
                    _local_4 = ((_local_4) || (!(_local_9)));
                }
                _local_7++;
            }
            _local_6++;
        }
        return (((_local_4) ? _local_2 : null));
    }

    private static function drawEdges(_arg_1:Array):BitmapData {
        var _local_2:BitmapData = GroundLibrary.getBitmapData(_arg_1[4]);
        var _local_3:BitmapData = _local_2.clone();
        var _local_4:GroundProperties = GroundLibrary.propsLibrary_[_arg_1[4]];
        var _local_5:Vector.<BitmapData> = _local_4.getEdges();
        var _local_6:Vector.<BitmapData> = _local_4.getInnerCorners();
        var _local_7:int = 1;
        while (_local_7 < 8) {
            if (!_arg_1[_local_7]) {
                _local_3.copyPixels(_local_5[_local_7], _local_5[_local_7].rect, PointUtil.ORIGIN, null, null, true);
            }
            _local_7 = (_local_7 + 2);
        }
        if (_local_5[0] != null) {
            if (((((_arg_1[3]) && (_arg_1[1]))) && (!(_arg_1[0])))) {
                _local_3.copyPixels(_local_5[0], _local_5[0].rect, PointUtil.ORIGIN, null, null, true);
            }
            if (((((_arg_1[1]) && (_arg_1[5]))) && (!(_arg_1[2])))) {
                _local_3.copyPixels(_local_5[2], _local_5[2].rect, PointUtil.ORIGIN, null, null, true);
            }
            if (((((_arg_1[5]) && (_arg_1[7]))) && (!(_arg_1[8])))) {
                _local_3.copyPixels(_local_5[8], _local_5[8].rect, PointUtil.ORIGIN, null, null, true);
            }
            if (((((_arg_1[3]) && (_arg_1[7]))) && (!(_arg_1[6])))) {
                _local_3.copyPixels(_local_5[6], _local_5[6].rect, PointUtil.ORIGIN, null, null, true);
            }
        }
        if (_local_6 != null) {
            if (((!(_arg_1[3])) && (!(_arg_1[1])))) {
                _local_3.copyPixels(_local_6[0], _local_6[0].rect, PointUtil.ORIGIN, null, null, true);
            }
            if (((!(_arg_1[1])) && (!(_arg_1[5])))) {
                _local_3.copyPixels(_local_6[2], _local_6[2].rect, PointUtil.ORIGIN, null, null, true);
            }
            if (((!(_arg_1[5])) && (!(_arg_1[7])))) {
                _local_3.copyPixels(_local_6[8], _local_6[8].rect, PointUtil.ORIGIN, null, null, true);
            }
            if (((!(_arg_1[3])) && (!(_arg_1[7])))) {
                _local_3.copyPixels(_local_6[6], _local_6[6].rect, PointUtil.ORIGIN, null, null, true);
            }
        }
        return (_local_3);
    }


}
}//package com.company.assembleegameclient.util
