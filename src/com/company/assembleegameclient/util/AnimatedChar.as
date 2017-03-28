package com.company.assembleegameclient.util {
import com.company.assembleegameclient.map.Camera;
import com.company.util.Trig;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

public class AnimatedChar {

    public static const RIGHT:int = 0;
    public static const LEFT:int = 1;
    public static const DOWN:int = 2;
    public static const UP:int = 3;
    public static const NUM_DIR:int = 4;
    public static const STAND:int = 0;
    public static const WALK:int = 1;
    public static const ATTACK:int = 2;
    public static const NUM_ACTION:int = 3;
    private static const SEC_TO_DIRS:Vector.<Vector.<int>> = new <Vector.<int>>[new <int>[LEFT, UP, DOWN], new <int>[UP, LEFT, DOWN], new <int>[UP, RIGHT, DOWN], new <int>[RIGHT, UP, DOWN], new <int>[RIGHT, DOWN], new <int>[DOWN, RIGHT], new <int>[DOWN, LEFT], new <int>[LEFT, DOWN]];
    private static const PIOVER4:Number = (Math.PI / 4);//0.785398163397448

    public var origImage_:MaskedImage;
    private var width_:int;
    private var height_:int;
    private var firstDir_:int;
    private var dict_:Dictionary;

    public function AnimatedChar(_arg_1:MaskedImage, _arg_2:int, _arg_3:int, _arg_4:int) {
        this.dict_ = new Dictionary();
        super();
        this.origImage_ = _arg_1;
        this.width_ = _arg_2;
        this.height_ = _arg_3;
        this.firstDir_ = _arg_4;
        var _local_5:Dictionary = new Dictionary();
        var _local_6:MaskedImageSet = new MaskedImageSet();
        _local_6.addFromMaskedImage(_arg_1, _arg_2, _arg_3);
        if (_arg_4 == RIGHT) {
            this.dict_[RIGHT] = this.loadDir(0, false, false, _local_6);
            this.dict_[LEFT] = this.loadDir(0, true, false, _local_6);
            if (_local_6.images_.length >= 14) {
                this.dict_[DOWN] = this.loadDir(7, false, true, _local_6);
                if (_local_6.images_.length >= 21) {
                    this.dict_[UP] = this.loadDir(14, false, true, _local_6);
                }
            }
        }
        else {
            if (_arg_4 == DOWN) {
                this.dict_[DOWN] = this.loadDir(0, false, true, _local_6);
                if (_local_6.images_.length >= 14) {
                    this.dict_[RIGHT] = this.loadDir(7, false, false, _local_6);
                    this.dict_[LEFT] = this.loadDir(7, true, false, _local_6);
                    if (_local_6.images_.length >= 21) {
                        this.dict_[UP] = this.loadDir(14, false, true, _local_6);
                    }
                }
            }
        }
    }

    public function getFirstDirImage():BitmapData {
        var _local_1:BitmapData = new BitmapDataSpy((this.width_ * 7), this.height_, true, 0);
        var _local_2:Dictionary = this.dict_[this.firstDir_];
        var _local_3:Vector.<MaskedImage> = _local_2[STAND];
        if (_local_3.length > 0) {
            _local_1.copyPixels(_local_3[0].image_, _local_3[0].image_.rect, new Point(0, 0));
        }
        _local_3 = _local_2[WALK];
        if (_local_3.length > 0) {
            _local_1.copyPixels(_local_3[0].image_, _local_3[0].image_.rect, new Point(this.width_, 0));
        }
        if (_local_3.length > 1) {
            _local_1.copyPixels(_local_3[1].image_, _local_3[1].image_.rect, new Point((this.width_ * 2), 0));
        }
        _local_3 = _local_2[ATTACK];
        if (_local_3.length > 0) {
            _local_1.copyPixels(_local_3[0].image_, _local_3[0].image_.rect, new Point((this.width_ * 4), 0));
        }
        if (_local_3.length > 1) {
            _local_1.copyPixels(_local_3[1].image_, new Rectangle(this.width_, 0, (this.width_ * 2), this.height_), new Point((this.width_ * 5), 0));
        }
        return (_local_1);
    }

    public function imageVec(_arg_1:int, _arg_2:int):Vector.<MaskedImage> {
        return (this.dict_[_arg_1][_arg_2]);
    }

    public function imageFromDir(_arg_1:int, _arg_2:int, _arg_3:Number):MaskedImage {
        var _local_4:Vector.<MaskedImage> = this.dict_[_arg_1][_arg_2];
        _arg_3 = Math.max(0, Math.min(0.99999, _arg_3));
        var _local_5:int = (_arg_3 * _local_4.length);
        return (_local_4[_local_5]);
    }

    public function imageFromAngle(_arg_1:Number, _arg_2:int, _arg_3:Number):MaskedImage {
        var _local_4:int = (int(((_arg_1 / PIOVER4) + 4)) % 8);
        var _local_5:Vector.<int> = SEC_TO_DIRS[_local_4];
        var _local_6:Dictionary = this.dict_[_local_5[0]];
        if (_local_6 == null) {
            _local_6 = this.dict_[_local_5[1]];
            if (_local_6 == null) {
                _local_6 = this.dict_[_local_5[2]];
            }
        }
        var _local_7:Vector.<MaskedImage> = _local_6[_arg_2];
        _arg_3 = Math.max(0, Math.min(0.99999, _arg_3));
        var _local_8:int = (_arg_3 * _local_7.length);
        return (_local_7[_local_8]);
    }

    public function imageFromFacing(_arg_1:Number, _arg_2:Camera, _arg_3:int, _arg_4:Number):MaskedImage {
        var _local_5:Number = Trig.boundToPI((_arg_1 - _arg_2.angleRad_));
        var _local_6:int = (int(((_local_5 / PIOVER4) + 4)) % 8);
        var _local_7:Vector.<int> = SEC_TO_DIRS[_local_6];
        var _local_8:Dictionary = this.dict_[_local_7[0]];
        if (_local_8 == null) {
            _local_8 = this.dict_[_local_7[1]];
            if (_local_8 == null) {
                _local_8 = this.dict_[_local_7[2]];
            }
        }
        var _local_9:Vector.<MaskedImage> = _local_8[_arg_3];
        _arg_4 = Math.max(0, Math.min(0.99999, _arg_4));
        var _local_10:int = (_arg_4 * _local_9.length);
        return (_local_9[_local_10]);
    }

    private function loadDir(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean, _arg_4:MaskedImageSet):Dictionary {
        var _local_14:Vector.<MaskedImage>;
        var _local_15:BitmapData;
        var _local_16:BitmapData;
        var _local_5:Dictionary = new Dictionary();
        var _local_6:MaskedImage = _arg_4.images_[(_arg_1 + 0)];
        var _local_7:MaskedImage = _arg_4.images_[(_arg_1 + 1)];
        var _local_8:MaskedImage = _arg_4.images_[(_arg_1 + 2)];
        if (_local_8.amountTransparent() == 1) {
            _local_8 = null;
        }
        var _local_9:MaskedImage = _arg_4.images_[(_arg_1 + 4)];
        var _local_10:MaskedImage = _arg_4.images_[(_arg_1 + 5)];
        if (_local_9.amountTransparent() == 1) {
            _local_9 = null;
        }
        if (_local_10.amountTransparent() == 1) {
            _local_10 = null;
        }
        var _local_11:MaskedImage = _arg_4.images_[(_arg_1 + 6)];
        if (((!((_local_10 == null))) && (!((_local_11.amountTransparent() == 1))))) {
            _local_15 = new BitmapDataSpy((this.width_ * 3), this.height_, true, 0);
            _local_15.copyPixels(_local_10.image_, new Rectangle(0, 0, this.width_, this.height_), new Point(this.width_, 0));
            _local_15.copyPixels(_local_11.image_, new Rectangle(0, 0, this.width_, this.height_), new Point((this.width_ * 2), 0));
            _local_16 = null;
            if (((!((_local_10.mask_ == null))) || (!((_local_11.mask_ == null))))) {
                _local_16 = new BitmapDataSpy((this.width_ * 3), this.height_, true, 0);
            }
            if (_local_10.mask_ != null) {
                _local_16.copyPixels(_local_10.mask_, new Rectangle(0, 0, this.width_, this.height_), new Point(this.width_, 0));
            }
            if (_local_11.mask_ != null) {
                _local_16.copyPixels(_local_11.mask_, new Rectangle(0, 0, this.width_, this.height_), new Point((this.width_ * 2), 0));
            }
            _local_10 = new MaskedImage(_local_15, _local_16);
        }
        var _local_12:Vector.<MaskedImage> = new Vector.<MaskedImage>();
        _local_12.push(((_arg_2) ? _local_6.mirror() : _local_6));
        _local_5[STAND] = _local_12;
        var _local_13:Vector.<MaskedImage> = new Vector.<MaskedImage>();
        _local_13.push(((_arg_2) ? _local_7.mirror() : _local_7));
        if (_local_8 != null) {
            _local_13.push(((_arg_2) ? _local_8.mirror() : _local_8));
        }
        else {
            if (_arg_3) {
                _local_13.push(((_arg_2) ? _local_7 : _local_7.mirror(7)));
            }
            else {
                _local_13.push(((_arg_2) ? _local_6.mirror() : _local_6));
            }
        }
        _local_5[WALK] = _local_13;
        if ((((_local_9 == null)) && ((_local_10 == null)))) {
            _local_14 = _local_13;
        }
        else {
            _local_14 = new Vector.<MaskedImage>();
            if (_local_9 != null) {
                _local_14.push(((_arg_2) ? _local_9.mirror() : _local_9));
            }
            if (_local_10 != null) {
                _local_14.push(((_arg_2) ? _local_10.mirror() : _local_10));
            }
        }
        _local_5[ATTACK] = _local_14;
        return (_local_5);
    }


}
}//package com.company.assembleegameclient.util
