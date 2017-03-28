package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.objects.BasicObject;
import com.company.assembleegameclient.objects.animation.Animations;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.GraphicsUtil;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.geom.Matrix;
import flash.geom.Vector3D;

public class XMLParticle extends BasicObject {

    public var texture_:BitmapData = null;
    public var animations_:Animations = null;
    public var size_:int;
    public var durationLeft_:Number;
    public var moveVec_:Vector3D;
    protected var bitmapFill_:GraphicsBitmapFill;
    protected var path_:GraphicsPath;
    protected var vS_:Vector.<Number>;
    protected var uvt_:Vector.<Number>;
    protected var fillMatrix_:Matrix;

    public function XMLParticle(_arg_1:ParticleProperties) {
        this.bitmapFill_ = new GraphicsBitmapFill(null, null, false, false);
        this.path_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, null);
        this.vS_ = new Vector.<Number>();
        this.uvt_ = new Vector.<Number>();
        this.fillMatrix_ = new Matrix();
        super();
        objectId_ = getNextFakeObjectId();
        this.size_ = _arg_1.size_;
        z_ = _arg_1.z_;
        this.durationLeft_ = _arg_1.duration_;
        this.texture_ = _arg_1.textureData_.getTexture(objectId_);
        if (_arg_1.animationsData_ != null) {
            this.animations_ = new Animations(_arg_1.animationsData_);
        }
        this.moveVec_ = new Vector3D();
        var _local_2:Number = ((Math.PI * 2) * Math.random());
        this.moveVec_.x = ((Math.cos(_local_2) * 0.1) * 5);
        this.moveVec_.y = ((Math.sin(_local_2) * 0.1) * 5);
    }

    public function moveTo(_arg_1:Number, _arg_2:Number):Boolean {
        var _local_3:Square = map_.getSquare(_arg_1, _arg_2);
        if (_local_3 == null) {
            return (false);
        }
        x_ = _arg_1;
        y_ = _arg_2;
        square_ = _local_3;
        return (true);
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_3:Number;
        _local_3 = (_arg_2 / 1000);
        this.durationLeft_ = (this.durationLeft_ - _local_3);
        if (this.durationLeft_ <= 0) {
            return (false);
        }
        x_ = (x_ + (this.moveVec_.x * _local_3));
        y_ = (y_ + (this.moveVec_.y * _local_3));
        return (true);
    }

    override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        var _local_7:BitmapData;
        var _local_4:BitmapData = this.texture_;
        if (this.animations_ != null) {
            _local_7 = this.animations_.getTexture(_arg_3);
            if (_local_7 != null) {
                _local_4 = _local_7;
            }
        }
        _local_4 = TextureRedrawer.redraw(_local_4, this.size_, true, 0);
        var _local_5:int = _local_4.width;
        var _local_6:int = _local_4.height;
        this.vS_.length = 0;
        this.vS_.push((posS_[3] - (_local_5 / 2)), (posS_[4] - _local_6), (posS_[3] + (_local_5 / 2)), (posS_[4] - _local_6), (posS_[3] + (_local_5 / 2)), posS_[4], (posS_[3] - (_local_5 / 2)), posS_[4]);
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
