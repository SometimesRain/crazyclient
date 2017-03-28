package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.sound.SoundEffectLibrary;

import flash.utils.Dictionary;

public class ObjectProperties {

    public var type_:int;
    public var id_:String;
    public var displayId_:String;
    public var shadowSize_:int;
    public var isPlayer_:Boolean = false;
    public var isEnemy_:Boolean = false;
    public var drawOnGround_:Boolean = false;
    public var drawUnder_:Boolean = false;
    public var occupySquare_:Boolean = false;
    public var fullOccupy_:Boolean = false;
    public var enemyOccupySquare_:Boolean = false;
    public var static_:Boolean = false;
    public var noMiniMap_:Boolean = false;
    public var protectFromGroundDamage_:Boolean = false;
    public var protectFromSink_:Boolean = false;
    public var z_:Number = 0;
    public var flying_:Boolean = false;
    public var color_:uint = 0xFFFFFF;
    public var showName_:Boolean = false;
    public var dontFaceAttacks_:Boolean = false;
    public var bloodProb_:Number = 0;
    public var bloodColor_:uint = 0xFF0000;
    public var shadowColor_:uint = 0;
    public var sounds_:Object = null;
    public var portrait_:TextureData = null;
    public var minSize_:int = 100;
    public var maxSize_:int = 100;
    public var sizeStep_:int = 5;
    public var whileMoving_:WhileMovingProperties = null;
    public var belonedDungeon:String = "";
    public var oldSound_:String = null;
    public var projectiles_:Dictionary;
    public var angleCorrection_:Number = 0;
    public var rotation_:Number = 0;

    public function ObjectProperties(_arg_1:XML) {
        var _local_2:XML;
        var _local_3:XML;
        var _local_4:int;
        this.projectiles_ = new Dictionary();
        super();
        if (_arg_1 == null) {
            return;
        }
        this.type_ = int(_arg_1.@type);
        this.id_ = String(_arg_1.@id);
        this.displayId_ = this.id_;
        if (_arg_1.hasOwnProperty("DisplayId")) {
            this.displayId_ = _arg_1.DisplayId;
        }
        this.shadowSize_ = ((_arg_1.hasOwnProperty("ShadowSize")) ? _arg_1.ShadowSize : 100);
        this.isPlayer_ = _arg_1.hasOwnProperty("Player");
        this.isEnemy_ = _arg_1.hasOwnProperty("Enemy");
        this.drawOnGround_ = _arg_1.hasOwnProperty("DrawOnGround");
        if (((this.drawOnGround_) || (_arg_1.hasOwnProperty("DrawUnder")))) {
            this.drawUnder_ = true;
        }
        this.occupySquare_ = _arg_1.hasOwnProperty("OccupySquare");
        this.fullOccupy_ = _arg_1.hasOwnProperty("FullOccupy");
        this.enemyOccupySquare_ = _arg_1.hasOwnProperty("EnemyOccupySquare");
        this.static_ = _arg_1.hasOwnProperty("Static");
        this.noMiniMap_ = _arg_1.hasOwnProperty("NoMiniMap");
        this.protectFromGroundDamage_ = _arg_1.hasOwnProperty("ProtectFromGroundDamage");
        this.protectFromSink_ = _arg_1.hasOwnProperty("ProtectFromSink");
        this.flying_ = _arg_1.hasOwnProperty("Flying");
        this.showName_ = _arg_1.hasOwnProperty("ShowName");
        this.dontFaceAttacks_ = _arg_1.hasOwnProperty("DontFaceAttacks");
        if (_arg_1.hasOwnProperty("Z")) {
            this.z_ = Number(_arg_1.Z);
        }
        if (_arg_1.hasOwnProperty("Color")) {
            this.color_ = uint(_arg_1.Color);
        }
        if (_arg_1.hasOwnProperty("Size")) {
            this.minSize_ = (this.maxSize_ = _arg_1.Size);
        }
        else {
            if (_arg_1.hasOwnProperty("MinSize")) {
                this.minSize_ = _arg_1.MinSize;
            }
            if (_arg_1.hasOwnProperty("MaxSize")) {
                this.maxSize_ = _arg_1.MaxSize;
            }
            if (_arg_1.hasOwnProperty("SizeStep")) {
                this.sizeStep_ = _arg_1.SizeStep;
            }
        }
        this.oldSound_ = ((_arg_1.hasOwnProperty("OldSound")) ? String(_arg_1.OldSound) : null);
        for each (_local_2 in _arg_1.Projectile) {
            _local_4 = int(_local_2.@id);
            this.projectiles_[_local_4] = new ProjectileProperties(_local_2);
        }
        this.angleCorrection_ = ((_arg_1.hasOwnProperty("AngleCorrection")) ? ((Number(_arg_1.AngleCorrection) * Math.PI) / 4) : 0);
        this.rotation_ = ((_arg_1.hasOwnProperty("Rotation")) ? _arg_1.Rotation : 0);
        if (_arg_1.hasOwnProperty("BloodProb")) {
            this.bloodProb_ = Number(_arg_1.BloodProb);
        }
        if (_arg_1.hasOwnProperty("BloodColor")) {
            this.bloodColor_ = uint(_arg_1.BloodColor);
        }
        if (_arg_1.hasOwnProperty("ShadowColor")) {
            this.shadowColor_ = uint(_arg_1.ShadowColor);
        }
        for each (_local_3 in _arg_1.Sound) {
            if (this.sounds_ == null) {
                this.sounds_ = {};
            }
            this.sounds_[int(_local_3.@id)] = _local_3.toString();
        }
        if (_arg_1.hasOwnProperty("Portrait")) {
            this.portrait_ = new TextureDataConcrete(XML(_arg_1.Portrait));
        }
        if (_arg_1.hasOwnProperty("WhileMoving")) {
            this.whileMoving_ = new WhileMovingProperties(XML(_arg_1.WhileMoving));
        }
    }

    public function loadSounds():void {
        var _local_1:String;
        if (this.sounds_ == null) {
            return;
        }
        for each (_local_1 in this.sounds_) {
            SoundEffectLibrary.load(_local_1);
        }
    }

    public function getSize():int {
        if (this.minSize_ == this.maxSize_) {
            return (this.minSize_);
        }
        var _local_1:int = ((this.maxSize_ - this.minSize_) / this.sizeStep_);
        return ((this.minSize_ + (int((Math.random() * _local_1)) * this.sizeStep_)));
    }


}
}//package com.company.assembleegameclient.objects

class WhileMovingProperties {

    public var z_:Number = 0;
    public var flying_:Boolean = false;

    public function WhileMovingProperties(_arg_1:XML) {
        if (_arg_1.hasOwnProperty("Z")) {
            this.z_ = Number(_arg_1.Z);
        }
        this.flying_ = _arg_1.hasOwnProperty("Flying");
    }

}
