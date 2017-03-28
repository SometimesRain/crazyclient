package com.company.util {
public class Extents2D {

    public var minX_:Number;
    public var minY_:Number;
    public var maxX_:Number;
    public var maxY_:Number;

    public function Extents2D() {
        this.clear();
    }

    public function add(_arg_1:Number, _arg_2:Number):void {
        if (_arg_1 < this.minX_) {
            this.minX_ = _arg_1;
        }
        if (_arg_2 < this.minY_) {
            this.minY_ = _arg_2;
        }
        if (_arg_1 > this.maxX_) {
            this.maxX_ = _arg_1;
        }
        if (_arg_2 > this.maxY_) {
            this.maxY_ = _arg_2;
        }
    }

    public function clear():void {
        this.minX_ = Number.MAX_VALUE;
        this.minY_ = Number.MAX_VALUE;
        this.maxX_ = Number.MIN_VALUE;
        this.maxY_ = Number.MIN_VALUE;
    }

    public function toString():String {
        return ((((((((("min:(" + this.minX_) + ", ") + this.minY_) + ") max:(") + this.maxX_) + ", ") + this.maxY_) + ")"));
    }


}
}//package com.company.util
