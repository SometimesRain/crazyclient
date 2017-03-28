package com.company.assembleegameclient.mapeditor {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Rectangle;

public class BigBitmapData {

    private static const CHUNK_SIZE:int = 0x0100;

    public var width_:int;
    public var height_:int;
    public var fillColor_:uint;
    private var maxChunkX_:int;
    private var maxChunkY_:int;
    private var chunks_:Vector.<BitmapData>;

    public function BigBitmapData(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:uint) {
        var _local_6:int;
        var _local_7:int;
        var _local_8:int;
        super();
        this.width_ = _arg_1;
        this.height_ = _arg_2;
        this.fillColor_ = _arg_4;
        this.maxChunkX_ = Math.ceil((this.width_ / CHUNK_SIZE));
        this.maxChunkY_ = Math.ceil((this.height_ / CHUNK_SIZE));
        this.chunks_ = new Vector.<BitmapData>((this.maxChunkX_ * this.maxChunkY_), true);
        var _local_5:int;
        while (_local_5 < this.maxChunkX_) {
            _local_6 = 0;
            while (_local_6 < this.maxChunkY_) {
                _local_7 = Math.min(CHUNK_SIZE, (this.width_ - (_local_5 * CHUNK_SIZE)));
                _local_8 = Math.min(CHUNK_SIZE, (this.height_ - (_local_6 * CHUNK_SIZE)));
                this.chunks_[(_local_5 + (_local_6 * this.maxChunkX_))] = new BitmapDataSpy(_local_7, _local_8, _arg_3, this.fillColor_);
                _local_6++;
            }
            _local_5++;
        }
    }

    public function copyTo(_arg_1:BitmapData, _arg_2:Rectangle, _arg_3:Rectangle):void {
        var _local_12:int;
        var _local_13:BitmapData;
        var _local_14:Rectangle;
        var _local_4:Number = (_arg_3.width / _arg_2.width);
        var _local_5:Number = (_arg_3.height / _arg_2.height);
        var _local_6:int = int((_arg_3.x / CHUNK_SIZE));
        var _local_7:int = int((_arg_3.y / CHUNK_SIZE));
        var _local_8:int = Math.ceil((_arg_3.right / CHUNK_SIZE));
        var _local_9:int = Math.ceil((_arg_3.bottom / CHUNK_SIZE));
        var _local_10:Matrix = new Matrix();
        var _local_11:int = _local_6;
        while (_local_11 < _local_8) {
            _local_12 = _local_7;
            while (_local_12 < _local_9) {
                _local_13 = this.chunks_[(_local_11 + (_local_12 * this.maxChunkX_))];
                _local_10.identity();
                _local_10.scale(_local_4, _local_5);
                _local_10.translate(((_arg_3.x - (_local_11 * CHUNK_SIZE)) - (_arg_2.x * _local_4)), ((_arg_3.y - (_local_12 * CHUNK_SIZE)) - (_arg_2.x * _local_5)));
                _local_14 = new Rectangle((_arg_3.x - (_local_11 * CHUNK_SIZE)), (_arg_3.y - (_local_12 * CHUNK_SIZE)), _arg_3.width, _arg_3.height);
                _local_13.draw(_arg_1, _local_10, null, null, _local_14, false);
                _local_12++;
            }
            _local_11++;
        }
    }

    public function copyFrom(_arg_1:Rectangle, _arg_2:BitmapData, _arg_3:Rectangle):void {
        var _local_13:int;
        var _local_14:BitmapData;
        var _local_4:Number = (_arg_3.width / _arg_1.width);
        var _local_5:Number = (_arg_3.height / _arg_1.height);
        var _local_6:int = Math.max(0, int((_arg_1.x / CHUNK_SIZE)));
        var _local_7:int = Math.max(0, int((_arg_1.y / CHUNK_SIZE)));
        var _local_8:int = Math.min((this.maxChunkX_ - 1), int((_arg_1.right / CHUNK_SIZE)));
        var _local_9:int = Math.min((this.maxChunkY_ - 1), int((_arg_1.bottom / CHUNK_SIZE)));
        var _local_10:Rectangle = new Rectangle();
        var _local_11:Matrix = new Matrix();
        var _local_12:int = _local_6;
        while (_local_12 <= _local_8) {
            _local_13 = _local_7;
            while (_local_13 <= _local_9) {
                _local_14 = this.chunks_[(_local_12 + (_local_13 * this.maxChunkX_))];
                _local_11.identity();
                _local_11.translate((((_arg_3.x / _local_4) - _arg_1.x) + (_local_12 * CHUNK_SIZE)), (((_arg_3.y / _local_5) - _arg_1.y) + (_local_13 * CHUNK_SIZE)));
                _local_11.scale(_local_4, _local_5);
                _arg_2.draw(_local_14, _local_11, null, null, _arg_3, false);
                _local_13++;
            }
            _local_12++;
        }
    }

    public function erase(_arg_1:Rectangle):void {
        var _local_8:int;
        var _local_9:BitmapData;
        var _local_2:int = int((_arg_1.x / CHUNK_SIZE));
        var _local_3:int = int((_arg_1.y / CHUNK_SIZE));
        var _local_4:int = Math.ceil((_arg_1.right / CHUNK_SIZE));
        var _local_5:int = Math.ceil((_arg_1.bottom / CHUNK_SIZE));
        var _local_6:Rectangle = new Rectangle();
        var _local_7:int = _local_2;
        while (_local_7 < _local_4) {
            _local_8 = _local_3;
            while (_local_8 < _local_5) {
                _local_9 = this.chunks_[(_local_7 + (_local_8 * this.maxChunkX_))];
                _local_6.x = (_arg_1.x - (_local_7 * CHUNK_SIZE));
                _local_6.y = (_arg_1.y - (_local_8 * CHUNK_SIZE));
                _local_6.right = (_arg_1.right - (_local_7 * CHUNK_SIZE));
                _local_6.bottom = (_arg_1.bottom - (_local_8 * CHUNK_SIZE));
                _local_9.fillRect(_local_6, this.fillColor_);
                _local_8++;
            }
            _local_7++;
        }
    }

    public function getDebugSprite():Sprite {
        var _local_3:int;
        var _local_4:BitmapData;
        var _local_5:Bitmap;
        var _local_1:Sprite = new Sprite();
        var _local_2:int;
        while (_local_2 < this.maxChunkX_) {
            _local_3 = 0;
            while (_local_3 < this.maxChunkY_) {
                _local_4 = this.chunks_[(_local_2 + (_local_3 * this.maxChunkX_))];
                _local_5 = new Bitmap(_local_4);
                _local_5.x = (_local_2 * CHUNK_SIZE);
                _local_5.y = (_local_3 * CHUNK_SIZE);
                _local_1.addChild(_local_5);
                _local_3++;
            }
            _local_2++;
        }
        return (_local_1);
    }


}
}//package com.company.assembleegameclient.mapeditor
