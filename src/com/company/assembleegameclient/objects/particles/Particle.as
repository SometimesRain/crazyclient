package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.objects.BasicObject;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.GraphicsUtil;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.geom.Matrix;

public class Particle extends BasicObject {

    public var size_:int;
    public var color_:uint;
    protected var bitmapFill_:GraphicsBitmapFill;
    protected var path_:GraphicsPath;
    protected var vS_:Vector.<Number>;
    protected var fillMatrix_:Matrix;

    public function Particle(_arg_1:uint, _arg_2:Number, _arg_3:int) {
        this.bitmapFill_ = new GraphicsBitmapFill(null, null, false, false);
        this.path_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, null);
        this.vS_ = new Vector.<Number>();
        this.fillMatrix_ = new Matrix();
        super();
        objectId_ = getNextFakeObjectId();
        this.setZ(_arg_2);
        this.setColor(_arg_1);
        this.setSize(_arg_3);
    }

    public function moveTo(_arg_1:Number, _arg_2:Number):Boolean {
        var _local_3:Square;
        _local_3 = map_.getSquare(_arg_1, _arg_2);
        if (_local_3 == null) {
            return (false);
        }
        x_ = _arg_1;
        y_ = _arg_2;
        square_ = _local_3;
        return (true);
    }

    public function moveToInModal(_arg_1:Number, _arg_2:Number):Boolean {
        x_ = _arg_1;
        y_ = _arg_2;
        return (true);
    }

    public function setColor(_arg_1:uint):void {
        this.color_ = _arg_1;
    }

    public function setZ(_arg_1:Number):void {
        z_ = _arg_1;
    }

    public function setSize(_arg_1:int):void {
        this.size_ = ((_arg_1 / 100) * 5);
    }

    override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        var _local_4:BitmapData = TextureRedrawer.redrawSolidSquare(this.color_, this.size_);
        var _local_5:int = _local_4.width;
        var _local_6:int = _local_4.height;
        this.vS_.length = 0;
        this.vS_.push((posS_[3] - (_local_5 / 2)), (posS_[4] - (_local_6 / 2)), (posS_[3] + (_local_5 / 2)), (posS_[4] - (_local_6 / 2)), (posS_[3] + (_local_5 / 2)), (posS_[4] + (_local_6 / 2)), (posS_[3] - (_local_5 / 2)), (posS_[4] + (_local_6 / 2)));
        this.path_.data = this.vS_;
        this.bitmapFill_.bitmapData = _local_4;
        this.fillMatrix_.identity();
        this.fillMatrix_.translate(this.vS_[0], this.vS_[1]);
        this.bitmapFill_.matrix = this.fillMatrix_;
        _arg_1.push(this.bitmapFill_);
        _arg_1.push(this.path_);
        _arg_1.push(GraphicsUtil.END_FILL);
    }


}
}//package com.company.assembleegameclient.objects.particles
