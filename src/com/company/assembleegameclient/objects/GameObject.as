package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.engine3d.Model3D;
import com.company.assembleegameclient.engine3d.Object3D;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.map.mapoverlay.CharacterStatusText;
import com.company.assembleegameclient.objects.animation.Animations;
import com.company.assembleegameclient.objects.animation.AnimationsData;
import com.company.assembleegameclient.objects.particles.ExplosionEffect;
import com.company.assembleegameclient.objects.particles.HitEffect;
import com.company.assembleegameclient.objects.particles.ParticleEffect;
import com.company.assembleegameclient.objects.particles.ShockerEffect;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.BloodComposition;
import com.company.assembleegameclient.util.ConditionEffect;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.BitmapUtil;
import com.company.util.CachingColorTransformer;
import com.company.util.ConversionUtil;
import com.company.util.GraphicsUtil;
import com.company.util.MoreColorUtil;
import com.company.assembleegameclient.game.MapUserInput;

import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsGradientFill;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.filters.ColorMatrixFilter;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;
import flash.utils.getTimer;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.messaging.impl.data.WorldPosData;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.stage3D.GraphicsFillExtra;
import kabam.rotmg.stage3D.Object3D.Object3DStage3D;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class GameObject extends BasicObject {

    protected static const PAUSED_FILTER:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
    protected static const CURSED_FILTER:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.redFilterMatrix);
    protected static const IDENTITY_MATRIX:Matrix = new Matrix();
    private static const ZERO_LIMIT:Number = 1E-5;
    private static const NEGATIVE_ZERO_LIMIT:Number = -(ZERO_LIMIT);
    public static const ATTACK_PERIOD:int = 300;

    private var mobInfoShown:Boolean = false;
    public var nameBitmapData_:BitmapData = null;
    private var nameFill_:GraphicsBitmapFill = null;
    private var namePath_:GraphicsPath = null;
    public var shockEffect:ShockerEffect;
    private var isShocked:Boolean;
    private var isShockedTransformSet:Boolean = false;
    private var isCharging:Boolean;
    private var isChargingTransformSet:Boolean = false;
    public var props_:ObjectProperties;
    public var name_:String;
    public var radius_:Number = 0.5;
    public var facing_:Number = 0;
    public var flying_:Boolean = false;
    public var attackAngle_:Number = 0;
    public var attackStart_:int = 0;
    public var animatedChar_:AnimatedChar = null;
    public var texture_:BitmapData = null;
    public var mask_:BitmapData = null;
    public var randomTextureData_:Vector.<TextureData> = null;
    public var obj3D_:Object3D = null;
    public var object3d_:Object3DStage3D = null;
    public var effect_:ParticleEffect = null;
    public var animations_:Animations = null;
    public var dead_:Boolean = false;
    protected var portrait_:BitmapData = null;
    protected var texturingCache_:Dictionary = null;
    public var maxHP_:int = 200;
    public var hp_:int = 200;
    public var size_:int = 100;
    public var level_:int = -1;
    public var defense_:int = 0;
    public var slotTypes_:Vector.<int> = null;
    public var equipment_:Vector.<int> = null;
    public var condition_:Vector.<uint>;
    protected var tex1Id_:int = 0;
    protected var tex2Id_:int = 0;
    public var isInteractive_:Boolean = false;
    public var objectType_:int;
    private var nextBulletId_:uint = 1;
    private var sizeMult_:Number = 1;
    public var sinkLevel_:int = 0;
    public var hallucinatingTexture_:BitmapData = null;
    public var flash_:FlashDescription = null;
    public var connectType_:int = -1;
    private var isStunImmune_:Boolean = false;
    private var isParalyzeImmune_:Boolean = false;
    private var isDazedImmune_:Boolean = false;
    private var ishpScaleSet:Boolean = false;
    protected var lastTickUpdateTime_:int = 0;
    protected var myLastTickId_:int = -1;
    protected var posAtTick_:Point;
    protected var tickPosition_:Point;
    public var moveVec_:Vector3D; //was protected
    protected var bitmapFill_:GraphicsBitmapFill;
    protected var path_:GraphicsPath;
    protected var vS_:Vector.<Number>;
    protected var uvt_:Vector.<Number>;
    protected var fillMatrix_:Matrix;
    private var hpbarBackFill_:GraphicsSolidFill = null;
    private var hpbarBackPath_:GraphicsPath = null;
    private var hpbarFill_:GraphicsSolidFill = null;
    private var hpbarPath_:GraphicsPath = null;
    private var icons_:Vector.<BitmapData> = null;
    private var iconFills_:Vector.<GraphicsBitmapFill> = null;
    private var iconPaths_:Vector.<GraphicsPath> = null;
    protected var shadowGradientFill_:GraphicsGradientFill = null;
    protected var shadowPath_:GraphicsPath = null;
	
	public var jittery:Boolean = false;
    public var aimAssistPoint:Vector3D = null;
    public var aimAssistTarget:com.company.assembleegameclient.objects.GameObject = null;

    public function GameObject(_arg_1:XML) {
        var _local_4:int;
        this.props_ = ObjectLibrary.defaultProps_;
        this.condition_ = new <uint>[0, 0];
        this.posAtTick_ = new Point();
        this.tickPosition_ = new Point();
        this.moveVec_ = new Vector3D();
        this.bitmapFill_ = new GraphicsBitmapFill(null, null, false, false);
        this.path_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, null);
        this.vS_ = new Vector.<Number>();
        this.uvt_ = new Vector.<Number>();
        this.fillMatrix_ = new Matrix();
        super();
        if (_arg_1 == null) {
            return;
        }
        this.objectType_ = int(_arg_1.@type);
        this.props_ = ObjectLibrary.propsLibrary_[this.objectType_];
        hasShadow_ = (this.props_.shadowSize_ > 0);
        var _local_2:TextureData = ObjectLibrary.typeToTextureData_[this.objectType_];
        this.texture_ = _local_2.texture_;
        this.mask_ = _local_2.mask_;
        this.animatedChar_ = _local_2.animatedChar_;
        this.randomTextureData_ = _local_2.randomTextureData_;
        if (_local_2.effectProps_ != null) {
            this.effect_ = ParticleEffect.fromProps(_local_2.effectProps_, this);
        }
        if (this.texture_ != null) {
            this.sizeMult_ = (this.texture_.height / 8);
        }
        if (_arg_1.hasOwnProperty("Model")) {
            this.obj3D_ = Model3D.getObject3D(String(_arg_1.Model));
            this.object3d_ = Model3D.getStage3dObject3D(String(_arg_1.Model));
            if (this.texture_ != null) {
                this.object3d_.setBitMapData(this.texture_);
            }
        }
        var _local_3:AnimationsData = ObjectLibrary.typeToAnimationsData_[this.objectType_];
        if (_local_3 != null) {
            this.animations_ = new Animations(_local_3);
        }
        z_ = this.props_.z_;
        this.flying_ = this.props_.flying_;
        if (_arg_1.hasOwnProperty("MaxHitPoints")) {
            this.hp_ = (this.maxHP_ = int(_arg_1.MaxHitPoints));
        }
        if (_arg_1.hasOwnProperty("Defense")) {
            this.defense_ = int(_arg_1.Defense);
        }
        if (_arg_1.hasOwnProperty("SlotTypes")) {
            this.slotTypes_ = ConversionUtil.toIntVector(_arg_1.SlotTypes);
            this.equipment_ = new Vector.<int>(this.slotTypes_.length);
            _local_4 = 0;
            while (_local_4 < this.equipment_.length) {
                this.equipment_[_local_4] = -1;
                _local_4++;
            }
        }
        if (_arg_1.hasOwnProperty("Tex1")) {
            this.tex1Id_ = int(_arg_1.Tex1);
        }
        if (_arg_1.hasOwnProperty("Tex2")) {
            this.tex2Id_ = int(_arg_1.Tex2);
        }
        if (_arg_1.hasOwnProperty("StunImmune")) {
            this.isStunImmune_ = true;
        }
        if (_arg_1.hasOwnProperty("ParalyzeImmune")) {
            this.isParalyzeImmune_ = true;
        }
        if (_arg_1.hasOwnProperty("DazedImmune")) {
            this.isDazedImmune_ = true;
        }
        this.props_.loadSounds();
    }

    public static function damageWithDefense(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Vector.<uint>):int {
        var _local_5:int = _arg_2;
        if (((_arg_3) || (!(((_arg_4[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORBROKEN_BIT) == 0))))) {
            _local_5 = 0;
        }
        else {
            if ((_arg_4[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORED_BIT) != 0) {
                _local_5 = (_local_5 * 2);
            }
        }
        var _local_6:int = ((_arg_1 * 3) / 20);
        var _local_7:int = Math.max(_local_6, (_arg_1 - _local_5));
        if ((_arg_4[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.INVULNERABLE_BIT) != 0) {
            _local_7 = 0;
        }
        if ((_arg_4[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PETRIFIED_BIT) != 0) {
            _local_7 = (_local_7 * 0.9);
        }
        if ((_arg_4[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.CURSE_BIT) != 0) {
            _local_7 = (_local_7 * 1.2);
        }
        return (_local_7);
    }


    public function setObjectId(_arg_1:int):void {
        var _local_2:TextureData;
        objectId_ = _arg_1;
        if (this.randomTextureData_ != null) {
            _local_2 = this.randomTextureData_[(objectId_ % this.randomTextureData_.length)];
            this.texture_ = _local_2.texture_;
            this.mask_ = _local_2.mask_;
            this.animatedChar_ = _local_2.animatedChar_;
            if (this.object3d_ != null) {
                this.object3d_.setBitMapData(this.texture_);
            }
        }
    }

    public function setAltTexture(_arg_1:int):void {
        var _local_3:TextureData;
        var _local_2:TextureData = ObjectLibrary.typeToTextureData_[this.objectType_];
        if (_arg_1 == 0) {
            _local_3 = _local_2;
        }
        else {
            _local_3 = _local_2.getAltTextureData(_arg_1);
            if (_local_3 == null) {
                return;
            }
        }
        this.texture_ = _local_3.texture_;
        this.mask_ = _local_3.mask_;
        this.animatedChar_ = _local_3.animatedChar_;
        if (this.effect_ != null) {
            map_.removeObj(this.effect_.objectId_);
            this.effect_ = null;
        }
        if (_local_3.effectProps_ != null) {
            this.effect_ = ParticleEffect.fromProps(_local_3.effectProps_, this);
            if (map_ != null) {
                map_.addObj(this.effect_, x_, y_);
            }
        }
    }

    public function setTex1(_arg_1:int):void {
        if (_arg_1 == this.tex1Id_) {
            return;
        }
        this.tex1Id_ = _arg_1;
        this.texturingCache_ = new Dictionary();
        this.portrait_ = null;
    }

    public function setTex2(_arg_1:int):void {
        if (_arg_1 == this.tex2Id_) {
            return;
        }
        this.tex2Id_ = _arg_1;
        this.texturingCache_ = new Dictionary();
        this.portrait_ = null;
    }

    public function playSound(_arg_1:int):void {
        SoundEffectLibrary.play(this.props_.sounds_[_arg_1]);
    }

    override public function dispose():void {
        var _local_1:Object;
        var _local_2:BitmapData;
        var _local_3:Dictionary;
        var _local_4:Object;
        var _local_5:BitmapData;
        super.dispose();
        this.texture_ = null;
        if (this.portrait_ != null) {
            this.portrait_.dispose();
            this.portrait_ = null;
        }
        if (this.texturingCache_ != null) {
            for each (_local_1 in this.texturingCache_) {
                _local_2 = (_local_1 as BitmapData);
                if (_local_2 != null) {
                    _local_2.dispose();
                }
                else {
                    _local_3 = (_local_1 as Dictionary);
                    for each (_local_4 in _local_3) {
                        _local_5 = (_local_4 as BitmapData);
                        if (_local_5 != null) {
                            _local_5.dispose();
                        }
                    }
                }
            }
            this.texturingCache_ = null;
        }
        if (this.obj3D_ != null) {
            this.obj3D_.dispose();
            this.obj3D_ = null;
        }
        if (this.object3d_ != null) {
            this.object3d_.dispose();
            this.object3d_ = null;
        }
        this.slotTypes_ = null;
        this.equipment_ = null;
        if (this.nameBitmapData_ != null) {
            this.nameBitmapData_.dispose();
            this.nameBitmapData_ = null;
        }
        this.nameFill_ = null;
        this.namePath_ = null;
        this.bitmapFill_ = null;
        this.path_.commands = null;
        this.path_.data = null;
        this.vS_ = null;
        this.uvt_ = null;
        this.fillMatrix_ = null;
        this.icons_ = null;
        this.iconFills_ = null;
        this.iconPaths_ = null;
        this.shadowGradientFill_ = null;
        if (this.shadowPath_ != null) {
            this.shadowPath_.commands = null;
            this.shadowPath_.data = null;
            this.shadowPath_ = null;
        }
    }

    public function isQuiet():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.QUIET_BIT) == 0)));
    }

    public function isWeak():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.WEAK_BIT) == 0)));
    }

    public function isSlowed():Boolean {
        if(Parameters.data_["SWNoSlow"] == true)
        {
            if(map_.name_ == "Sprite World")
            {
                return false;
            }
        }
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.SLOWED_BIT) == 0)));
    }

    public function isSick():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.SICK_BIT) == 0)));
    }

    public function isDazed():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.DAZED_BIT) == 0)));
    }

    public function isStunned():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.STUNNED_BIT) == 0)));
    }

    public function isBlind():Boolean {
        if(Parameters.data_["dbBlind"] != true)
        {
            return false;
        }
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.BLIND_BIT) == 0)));
    }

    public function isDrunk():Boolean {
        if(Parameters.data_["dbDrunk"] != true)
        {
            return false;
        }
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.DRUNK_BIT) == 0)));
    }

    public function isConfused():Boolean {
        if(Parameters.data_["dbConfused"] != true)
        {
            return false;
        }
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.CONFUSED_BIT) == 0)));
    }

    public function isStunImmune():Boolean {
        return (((!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.STUN_IMMUNE_BIT) == 0))) || (this.isStunImmune_)));
    }

    public function isInvisible():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.INVISIBLE_BIT) == 0)));
    }

    public function isParalyzed():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.PARALYZED_BIT) == 0)));
    }

    public function isSpeedy():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.SPEEDY_BIT) == 0)));
    }

    public function isNinjaSpeedy():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.NINJA_SPEEDY_BIT) == 0)));
    }

    public function isHallucinating():Boolean {
        if(Parameters.data_["dbHallucinating"] != true)
        {
            return false;
        }
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.HALLUCINATING_BIT) == 0)));
    }

    public function isHealing():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.HEALING_BIT) == 0)));
    }

    public function isBleeding():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.BLEEDING_BIT) == 0)));
    }

    public function isDamaging():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.DAMAGING_BIT) == 0)));
    }

    public function isBerserk():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.BERSERK_BIT) == 0)));
    }

    public function isPaused():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.PAUSED_BIT) == 0)));
    }

    public function isStasis():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.STASIS_BIT) == 0)));
    }

    public function isInvincible():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.INVINCIBLE_BIT) == 0)));
    }

    public function isInvulnerable():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.INVULNERABLE_BIT) == 0)));
    }

    public function isArmored():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORED_BIT) == 0)));
    }

    public function isArmorBroken():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORBROKEN_BIT) == 0)));
    }

    public function isArmorBrokenImmune():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORBROKEN_IMMUNE_BIT) == 0)));
    }

    public function isSlowedImmune():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.SLOWED_IMMUNE_BIT) == 0)));
    }

    public function isUnstable():Boolean {
        if(Parameters.data_["dbUnstable"] != true)
        {
            return false;
        }
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.UNSTABLE_BIT) == 0)));
    }

    public function isShowPetEffectIcon():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PET_EFFECT_ICON) == 0)));
    }

    public function isDarkness():Boolean {
        if(Parameters.data_["dbDarkness"] != true)
        {
            return false;
        }
        return (!(((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.DARKNESS_BIT) == 0)));
    }

    public function isParalyzeImmune():Boolean {
        return (((this.isParalyzeImmune_) || (!(((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PARALYZED_IMMUNE_BIT) == 0)))));
    }

    public function isDazedImmune():Boolean {
        return (((this.isDazedImmune_) || (!(((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.DAZED_IMMUNE_BIT) == 0)))));
    }

    public function isPetrified():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PETRIFIED_BIT) == 0)));
    }

    public function isPetrifiedImmune():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PETRIFIED_IMMUNE_BIT) == 0)));
    }

    public function isCursed():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.CURSE_BIT) == 0)));
    }

    public function isHpBoosted():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.HP_BOOST_BIT) == 0)));
    }

    public function isCursedImmune():Boolean {
        return (!(((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.CURSE_IMMUNE_BIT) == 0)));
    }

    public function isSafe(_arg_1:int = 20):Boolean {
        var _local_2:GameObject;
        var _local_3:int;
        var _local_4:int;
        for each (_local_2 in map_.goDict_) {
            if ((((_local_2 is Character)) && (_local_2.props_.isEnemy_))) {
                _local_3 = (((x_ > _local_2.x_)) ? (x_ - _local_2.x_) : (_local_2.x_ - x_));
                _local_4 = (((y_ > _local_2.y_)) ? (y_ - _local_2.y_) : (_local_2.y_ - y_));
                if ((((_local_3 < _arg_1)) && ((_local_4 < _arg_1)))) {
                    return (false);
                }
            }
        }
        return (true);
    }

    public function getName():String {
        return ((((((this.name_ == null)) || ((this.name_ == "")))) ? ObjectLibrary.typeToDisplayId_[this.objectType_] : this.name_));
    }

    public function getColor():uint {
        return (BitmapUtil.mostCommonColor(this.texture_));
    }

    public function getBulletId():uint {
        var _local_1:uint = this.nextBulletId_;
        this.nextBulletId_ = ((this.nextBulletId_ + 1) % 128);
        return (_local_1);
    }

    public function distTo(_arg_1:WorldPosData):Number {
        var _local_2:Number = (_arg_1.x_ - x_);
        var _local_3:Number = (_arg_1.y_ - y_);
        return (Math.sqrt(((_local_2 * _local_2) + (_local_3 * _local_3))));
    }

    public function toggleShockEffect(_arg_1:Boolean):void {
        if (_arg_1) {
            this.isShocked = true;
        }
        else {
            this.isShocked = false;
            this.isShockedTransformSet = false;
        }
    }

    public function toggleChargingEffect(_arg_1:Boolean):void {
        if (_arg_1) {
            this.isCharging = true;
        }
        else {
            this.isCharging = false;
            this.isChargingTransformSet = false;
        }
    }

    override public function addTo(_arg_1:Map, _arg_2:Number, _arg_3:Number):Boolean {
        map_ = _arg_1;
        this.posAtTick_.x = (this.tickPosition_.x = _arg_2);
        this.posAtTick_.y = (this.tickPosition_.y = _arg_3);
        if (!this.moveTo(_arg_2, _arg_3)) {
            map_ = null;
            return (false);
        }
        if (this.effect_ != null) {
            map_.addObj(this.effect_, _arg_2, _arg_3);
        }
        return (true);
    }

    override public function removeFromMap():void {
        if (((this.props_.static_) && (!((square_ == null))))) {
            if (square_.obj_ == this) {
                square_.obj_ = null;
            }
            square_ = null;
        }
        if (this.effect_ != null) {
            map_.removeObj(this.effect_.objectId_);
        }
        super.removeFromMap();
        this.dispose();
    }

    public function moveTo(_arg_1:Number, _arg_2:Number):Boolean {
        var _local_3:Square = map_.getSquare(_arg_1, _arg_2);
        if (_local_3 == null) {
            return (false);
        }
        x_ = _arg_1;
        y_ = _arg_2;
        if (this.props_.static_) {
            if (square_ != null) {
                square_.obj_ = null;
            }
            _local_3.obj_ = this;
        }
        square_ = _local_3;
        if (this.obj3D_ != null) {
            this.obj3D_.setPosition(x_, y_, 0, this.props_.rotation_);
        }
        if (this.object3d_ != null) {
            this.object3d_.setPosition(x_, y_, 0, this.props_.rotation_);
        }
        return (true);
    }
    
    private function mobInfo(param1:String) : void
    {
        var _loc2_:CharacterStatusText = new CharacterStatusText(this,65280,int.MAX_VALUE);
        _loc2_.setStringBuilder(new StaticStringBuilder(param1));
        map_.mapOverlay_.addStatusText(_loc2_);
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        if(Parameters.data_.showMobInfo)
        {
            if(!mobInfoShown)
            {
                if(props_.isEnemy_)
                {
                    mobInfo(props_.id_ + " - " + props_.type_);
                    mobInfoShown = true;
                }
            }
        }
        else
        {
            mobInfoShown = false;
        }
        var _local_4:int;
        var _local_5:Number;
        var _local_6:Number;
        var _local_3:Boolean;
        if (!(((this.moveVec_.x == 0)) && ((this.moveVec_.y == 0)))) {
            if (this.myLastTickId_ < map_.gs_.gsc_.lastTickId_) {
                this.moveVec_.x = 0;
                this.moveVec_.y = 0;
                this.moveTo(this.tickPosition_.x, this.tickPosition_.y);
            }
            else {
                _local_4 = (_arg_1 - this.lastTickUpdateTime_);
                _local_5 = (this.posAtTick_.x + (_local_4 * this.moveVec_.x));
                _local_6 = (this.posAtTick_.y + (_local_4 * this.moveVec_.y));
                this.moveTo(_local_5, _local_6);
                _local_3 = true;
            }
        }
        if (this.props_.whileMoving_ != null) {
            if (!_local_3) {
                z_ = this.props_.z_;
                this.flying_ = this.props_.flying_;
            }
            else {
                z_ = this.props_.whileMoving_.z_;
                this.flying_ = this.props_.whileMoving_.flying_;
            }
        }
        return (true);
    }

    public function onGoto(_arg_1:Number, _arg_2:Number, _arg_3:int):void {
        this.moveTo(_arg_1, _arg_2);
        this.lastTickUpdateTime_ = _arg_3;
        this.tickPosition_.x = _arg_1;
        this.tickPosition_.y = _arg_2;
        this.posAtTick_.x = _arg_1;
        this.posAtTick_.y = _arg_2;
        this.moveVec_.x = 0;
        this.moveVec_.y = 0;
    }

    public function onTickPos(_arg_1:Number, _arg_2:Number, _arg_3:int, _arg_4:int):void {
        if (this.myLastTickId_ < map_.gs_.gsc_.lastTickId_) {
            this.moveTo(this.tickPosition_.x, this.tickPosition_.y);
        }
        this.lastTickUpdateTime_ = map_.gs_.lastUpdate_;
        this.tickPosition_.x = _arg_1;
        this.tickPosition_.y = _arg_2;
        this.posAtTick_.x = x_;
        this.posAtTick_.y = y_;
        this.moveVec_.x = ((this.tickPosition_.x - this.posAtTick_.x) / _arg_3);
        this.moveVec_.y = ((this.tickPosition_.y - this.posAtTick_.y) / _arg_3);
        this.myLastTickId_ = _arg_4;
    }

    public function damage(_arg_1:int, _arg_2:int, _arg_3:Vector.<uint>, _arg_4:Boolean, _arg_5:Projectile):void {
        var _local_7:int;
        var _local_8:uint;
        var _local_9:ConditionEffect;
        var _local_10:CharacterStatusText;
        var _local_11:PetsModel;
        var _local_12:PetVO;
        var _local_13:String;
        var _local_14:Vector.<uint>;
        var _local_15:Boolean;
        var _local_6:Boolean;
        if (_arg_4) {
            this.dead_ = true;
        }
        else {
            if (_arg_3 != null) {
                _local_7 = 0;
                for each (_local_8 in _arg_3) {
                    _local_9 = null;
                    if (((((!((_arg_5 == null))) && (_arg_5.projProps_.isPetEffect_))) && (_arg_5.projProps_.isPetEffect_[_local_8]))) {
                        _local_11 = StaticInjectorContext.getInjector().getInstance(PetsModel);
                        _local_12 = _local_11.getActivePet();
                        if (_local_12 != null) {
                            _local_9 = ConditionEffect.effects_[_local_8];
                            this.showConditionEffectPet(_local_7, _local_9.name_);
                            _local_7 = (_local_7 + 500);
                        }
                    }
                    else {
                        switch (_local_8) {
                            case ConditionEffect.NOTHING:
                                break;
                            case ConditionEffect.QUIET:
                            case ConditionEffect.WEAK:
                            case ConditionEffect.SICK:
                            case ConditionEffect.BLIND:
                            case ConditionEffect.HALLUCINATING:
                            case ConditionEffect.DRUNK:
                            case ConditionEffect.CONFUSED:
                            case ConditionEffect.STUN_IMMUNE:
                            case ConditionEffect.INVISIBLE:
                            case ConditionEffect.SPEEDY:
                            case ConditionEffect.BLEEDING:
                            case ConditionEffect.STASIS:
                            case ConditionEffect.STASIS_IMMUNE:
                            case ConditionEffect.NINJA_SPEEDY:
                            case ConditionEffect.UNSTABLE:
                            case ConditionEffect.DARKNESS:
                            case ConditionEffect.PETRIFIED_IMMUNE:
                                _local_9 = ConditionEffect.effects_[_local_8];
                                break;
                            case ConditionEffect.SLOWED:
                                if (this.isSlowedImmune()) {
                                    _local_10 = new CharacterStatusText(this, 0xFF0000, 3000);
                                    _local_10.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                                    map_.mapOverlay_.addStatusText(_local_10);
                                }
                                else {
                                    _local_9 = ConditionEffect.effects_[_local_8];
                                }
                                break;
                            case ConditionEffect.ARMORBROKEN:
                                if (this.isArmorBrokenImmune()) {
                                    _local_10 = new CharacterStatusText(this, 0xFF0000, 3000);
                                    _local_10.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                                    map_.mapOverlay_.addStatusText(_local_10);
                                }
                                else {
                                    _local_9 = ConditionEffect.effects_[_local_8];
                                }
                                break;
                            case ConditionEffect.STUNNED:
                                if (this.isStunImmune()) {
                                    _local_10 = new CharacterStatusText(this, 0xFF0000, 3000);
                                    _local_10.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                                    map_.mapOverlay_.addStatusText(_local_10);
                                }
                                else {
                                    _local_9 = ConditionEffect.effects_[_local_8];
                                }
                                break;
                            case ConditionEffect.DAZED:
                                if (this.isDazedImmune()) {
                                    _local_10 = new CharacterStatusText(this, 0xFF0000, 3000);
                                    _local_10.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                                    map_.mapOverlay_.addStatusText(_local_10);
                                }
                                else {
                                    _local_9 = ConditionEffect.effects_[_local_8];
                                }
                                break;
                            case ConditionEffect.PARALYZED:
                                if (this.isParalyzeImmune()) {
                                    _local_10 = new CharacterStatusText(this, 0xFF0000, 3000);
                                    _local_10.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                                    map_.mapOverlay_.addStatusText(_local_10);
                                }
                                else {
                                    _local_9 = ConditionEffect.effects_[_local_8];
                                }
                                break;
                            case ConditionEffect.PETRIFIED:
                                if (this.isPetrifiedImmune()) {
                                    _local_10 = new CharacterStatusText(this, 0xFF0000, 3000);
                                    _local_10.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                                    map_.mapOverlay_.addStatusText(_local_10);
                                }
                                else {
                                    _local_9 = ConditionEffect.effects_[_local_8];
                                }
                                break;
                            case ConditionEffect.CURSE:
                                if (this.isCursedImmune()) {
                                    _local_10 = new CharacterStatusText(this, 0xFF0000, 3000);
                                    _local_10.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                                    map_.mapOverlay_.addStatusText(_local_10);
                                }
                                else {
                                    _local_9 = ConditionEffect.effects_[_local_8];
                                }
                                break;
                            case ConditionEffect.GROUND_DAMAGE:
                                _local_6 = true;
                                break;
                        }
                        if (_local_9 != null) {
                            if (_local_8 < ConditionEffect.NEW_CON_THREASHOLD) {
                                if ((this.condition_[ConditionEffect.CE_FIRST_BATCH] | _local_9.bit_) == this.condition_[ConditionEffect.CE_FIRST_BATCH]) continue;
                                this.condition_[ConditionEffect.CE_FIRST_BATCH] = (this.condition_[ConditionEffect.CE_FIRST_BATCH] | _local_9.bit_);
                            }
                            else {
                                if ((this.condition_[ConditionEffect.CE_SECOND_BATCH] | _local_9.bit_) == this.condition_[ConditionEffect.CE_SECOND_BATCH]) continue;
                                this.condition_[ConditionEffect.CE_SECOND_BATCH] = (this.condition_[ConditionEffect.CE_SECOND_BATCH] | _local_9.bit_);
                            }
                            _local_13 = _local_9.localizationKey_;
                            this.showConditionEffect(_local_7, _local_13);
                            _local_7 = (_local_7 + 500);
                        }
                    }
                }
            }
        }
        if (!((this.props_.isEnemy_) && (Parameters.data_.disableEnemyParticles))) {
            _local_14 = BloodComposition.getBloodComposition(this.objectType_, this.texture_, this.props_.bloodProb_, this.props_.bloodColor_);
            if (this.dead_) {
                map_.addObj(new ExplosionEffect(_local_14, this.size_, 30), x_, y_);
            }
            else {
                if (_arg_5 != null) {
                    map_.addObj(new HitEffect(_local_14, this.size_, 10, _arg_5.angle_, _arg_5.projProps_.speed_), x_, y_);
                }
                else {
                    map_.addObj(new ExplosionEffect(_local_14, this.size_, 10), x_, y_);
                }
            }
        }
        if (_arg_2 > 0) {
            _local_15 = ((((this.isArmorBroken()) || (((!((_arg_5 == null))) && (_arg_5.projProps_.armorPiercing_))))) || (_local_6));
            this.showDamageText(_arg_2, _local_15);
        }
    }

    public function showConditionEffect(_arg_1:int, _arg_2:String):void {
        var _local_3:CharacterStatusText = new CharacterStatusText(this, 0xFF0000, 3000, _arg_1);
        _local_3.setStringBuilder(new LineBuilder().setParams(_arg_2));
        map_.mapOverlay_.addStatusText(_local_3);
    }

    public function showConditionEffectPet(_arg_1:int, _arg_2:String):void {
        var _local_3:CharacterStatusText = new CharacterStatusText(this, 0xFF0000, 3000, _arg_1);
        _local_3.setStringBuilder(new StaticStringBuilder(("Pet " + _arg_2)));
        map_.mapOverlay_.addStatusText(_local_3);
    }

    public function showDamageText(_arg_1:int, _arg_2:Boolean):void {
		takeDmgNotif(_arg_1, this, _arg_2);
    }
	
    public static function takeDmgNotif(param1:int, param2:GameObject, param3:Boolean = false) : void {
        var _loc3_:Boolean = Parameters.data_.STDamage;
        var _loc4_:Boolean = Parameters.data_.STHealth;
        var _loc5_:int = param2.hp_ - param1;
        _loc5_ = _loc5_ < 0 ? 0  : _loc5_;
        var _loc6_:int;
		if (param3) {
			_loc6_ = 9437439;
		}
		else if (Parameters.data_.STColor) {
			_loc6_ = green2red(param2.hp_ / param2.maxHP_ * 100);
		}
		else {
			_loc6_ = 16711680;
		}
        var _loc7_:String = (_loc3_ ? "-" + param1 + (_loc4_ ? " [" : "" ) : "") + (_loc4_ ? _loc5_ + (_loc3_ ? "]" : "") :"");
        var _loc8_:CharacterStatusText = new CharacterStatusText(param2,_loc6_,1000);
        _loc8_.setStringBuilder(new StaticStringBuilder(_loc7_));
        param2.map_.mapOverlay_.addStatusText(_loc8_);
	}
	
    public static function green2red(zeroToHundred:int) : int
    {
        if(zeroToHundred > 50)
        {
            return 65280 + 327680 * int(100 - zeroToHundred);
        }
        return 16776960 - 1280 * int(50 - zeroToHundred);
    }

    protected function makeNameBitmapData():BitmapData {
        var _local_1:StringBuilder = new StaticStringBuilder(this.name_);
        var _local_2:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
        return (_local_2.make(_local_1, 16, 0xFFFFFF, true, IDENTITY_MATRIX, true));
    }

    public function drawName(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera):void {
        if (this.nameBitmapData_ == null) {
            this.nameBitmapData_ = this.makeNameBitmapData();
            this.nameFill_ = new GraphicsBitmapFill(null, new Matrix(), false, false);
            this.namePath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
        }
        var _local_3:int = ((this.nameBitmapData_.width / 2) + 1);
        var _local_4:int = 30;
        var _local_5:Vector.<Number> = this.namePath_.data;
        _local_5.length = 0;
        _local_5.push((posS_[0] - _local_3), posS_[1], (posS_[0] + _local_3), posS_[1], (posS_[0] + _local_3), (posS_[1] + _local_4), (posS_[0] - _local_3), (posS_[1] + _local_4));
        this.nameFill_.bitmapData = this.nameBitmapData_;
        var _local_6:Matrix = this.nameFill_.matrix;
        _local_6.identity();
        _local_6.translate(_local_5[0], _local_5[1]);
        _arg_1.push(this.nameFill_);
        _arg_1.push(this.namePath_);
        _arg_1.push(GraphicsUtil.END_FILL);
    }

    protected function getHallucinatingTexture():BitmapData {
        if (this.hallucinatingTexture_ == null) {
            this.hallucinatingTexture_ = AssetLibrary.getImageFromSet("lofiChar8x8", int((Math.random() * 239)));
        }
        return (this.hallucinatingTexture_);
    }

    protected function getTexture(_arg_1:Camera, _arg_2:int):BitmapData {
        var _local_6:Pet;
        var _local_7:Number;
        var _local_8:int;
        var _local_9:MaskedImage;
        var _local_10:int;
        var _local_11:BitmapData;
        var _local_12:int;
        var _local_13:BitmapData;
        if ((this is Pet)) {
            _local_6 = Pet(this);
            if (((!((this.condition_[ConditionEffect.CE_FIRST_BATCH] == 0))) && (!(this.isPaused())))) {
                if (_local_6.skinId != 32912) {
                    _local_6.setSkin(32912);
                }
            }
            else {
                if (!_local_6.isDefaultAnimatedChar) {
                    _local_6.setDefaultSkin();
                }
            }
        }
        var _local_3:BitmapData = this.texture_;
        var _local_4:int = this.size_;
        var _local_5:BitmapData;
        if (this.animatedChar_ != null) {
            _local_7 = 0;
            _local_8 = AnimatedChar.STAND;
            if (_arg_2 < (this.attackStart_ + ATTACK_PERIOD)) {
                if (!this.props_.dontFaceAttacks_) {
                    this.facing_ = this.attackAngle_;
                }
                _local_7 = (((_arg_2 - this.attackStart_) % ATTACK_PERIOD) / ATTACK_PERIOD);
                _local_8 = AnimatedChar.ATTACK;
            }
            else {
                if (((!((this.moveVec_.x == 0))) || (!((this.moveVec_.y == 0))))) {
                    _local_10 = (0.5 / this.moveVec_.length);
                    _local_10 = (_local_10 + (400 - (_local_10 % 400)));
                    if ((((((((this.moveVec_.x > ZERO_LIMIT)) || ((this.moveVec_.x < NEGATIVE_ZERO_LIMIT)))) || ((this.moveVec_.y > ZERO_LIMIT)))) || ((this.moveVec_.y < NEGATIVE_ZERO_LIMIT)))) {
                        this.facing_ = Math.atan2(this.moveVec_.y, this.moveVec_.x);
                        _local_8 = AnimatedChar.WALK;
                    }
                    else {
                        _local_8 = AnimatedChar.STAND;
                    }
                    _local_7 = ((_arg_2 % _local_10) / _local_10);
                }
            }
            _local_9 = this.animatedChar_.imageFromFacing(this.facing_, _arg_1, _local_8, _local_7);
            _local_3 = _local_9.image_;
            _local_5 = _local_9.mask_;
        }
        else {
            if (this.animations_ != null) {
                _local_11 = this.animations_.getTexture(_arg_2);
                if (_local_11 != null) {
                    _local_3 = _local_11;
                }
            }
        }
        if (((this.props_.drawOnGround_) || (!((this.obj3D_ == null))))) {
            return (_local_3);
        }
        if (_arg_1.isHallucinating_) {
            _local_12 = (((_local_3 == null)) ? 8 : _local_3.width);
            _local_3 = this.getHallucinatingTexture();
            _local_5 = null;
            _local_4 = (this.size_ * Math.min(1.5, (_local_12 / _local_3.width)));
        }
        if (((this.isCursed()) && (!((this is Pet))))) {
            _local_3 = CachingColorTransformer.filterBitmapData(_local_3, CURSED_FILTER);
        }
        if (((((this.isStasis()) || (this.isPetrified()))) && (!((this is Pet))))) {
            _local_3 = CachingColorTransformer.filterBitmapData(_local_3, PAUSED_FILTER);
        }
        if ((((this.tex1Id_ == 0)) && ((this.tex2Id_ == 0)))) {
            _local_3 = TextureRedrawer.redraw(_local_3, _local_4, false, 0);
        }
        else {
            _local_13 = null;
            if (this.texturingCache_ == null) {
                this.texturingCache_ = new Dictionary();
            }
            else {
                _local_13 = this.texturingCache_[_local_3];
            }
            if (_local_13 == null) {
                _local_13 = TextureRedrawer.resize(_local_3, _local_5, _local_4, false, this.tex1Id_, this.tex2Id_);
                _local_13 = GlowRedrawer.outlineGlow(_local_13, 0);
                this.texturingCache_[_local_3] = _local_13;
            }
            _local_3 = _local_13;
        }
        return (_local_3);
    }

    public function useAltTexture(_arg_1:String, _arg_2:int):void {
        this.texture_ = AssetLibrary.getImageFromSet(_arg_1, _arg_2);
        this.sizeMult_ = (this.texture_.height / 8);
    }

    public function getPortrait():BitmapData {
        var _local_1:BitmapData;
        var _local_2:int;
        if (this.portrait_ == null) {
            _local_1 = (((this.props_.portrait_) != null) ? this.props_.portrait_.getTexture() : this.texture_);
            _local_2 = ((4 / _local_1.width) * 100);
            this.portrait_ = TextureRedrawer.resize(_local_1, this.mask_, _local_2, true, this.tex1Id_, this.tex2Id_);
            this.portrait_ = GlowRedrawer.outlineGlow(this.portrait_, 0);
        }
        return (this.portrait_);
    }

    public function setAttack(_arg_1:int, _arg_2:Number):void {
        this.attackAngle_ = _arg_2;
        this.attackStart_ = getTimer();
    }

    override public function draw3d(_arg_1:Vector.<Object3DStage3D>):void {
        if (this.object3d_ != null) {
            _arg_1.push(this.object3d_);
        }
    }

    protected function drawHpBar(_arg_1:Vector.<IGraphicsData>, _arg_2:int, _arg_3:int):void {
        var _local_7:Number;
        var _local_8:Number;
        if (this.hpbarPath_ == null) {
            this.hpbarBackFill_ = new GraphicsSolidFill();
            this.hpbarBackPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
            this.hpbarFill_ = new GraphicsSolidFill(0x10FF00);
            this.hpbarPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
        }
        var _local_3:Number = this.maxHP_;
        if (this.hp_ <= _local_3) {
            _local_7 = ((_local_3 - this.hp_) / _local_3);
            this.hpbarBackFill_.color = MoreColorUtil.lerpColor(0x545454, 0xFF0000, (Math.abs(Math.sin((_arg_2 / 300))) * _local_7));
        }
        else {
            this.hpbarBackFill_.color = 0x545454;
        }
        var _local_4:int = _arg_3 < 20 ? 20 : _arg_3; //width
        var _local_5:int = 2; //margin
        var _local_6:int = 4; //height
        this.hpbarBackPath_.data.length = 0;
        this.hpbarBackPath_.data.push((posS_[0] - _local_4), (posS_[1] + _local_5), (posS_[0] + _local_4), (posS_[1] + _local_5), (posS_[0] + _local_4), ((posS_[1] + _local_5) + _local_6), (posS_[0] - _local_4), ((posS_[1] + _local_5) + _local_6));
        _arg_1.push(this.hpbarBackFill_);
        _arg_1.push(this.hpbarBackPath_);
        _arg_1.push(GraphicsUtil.END_FILL);
        if (this.hp_ > 0) {
            _local_8 = (((this.hp_ / this.maxHP_) * 2) * _local_4);
            this.hpbarPath_.data.length = 0;
            this.hpbarPath_.data.push((posS_[0] - _local_4), (posS_[1] + _local_5), ((posS_[0] - _local_4) + _local_8), (posS_[1] + _local_5), ((posS_[0] - _local_4) + _local_8), ((posS_[1] + _local_5) + _local_6), (posS_[0] - _local_4), ((posS_[1] + _local_5) + _local_6));
            _arg_1.push(this.hpbarFill_);
            _arg_1.push(this.hpbarPath_);
            _arg_1.push(GraphicsUtil.END_FILL);
        }
        GraphicsFillExtra.setSoftwareDrawSolid(this.hpbarFill_, true);
        GraphicsFillExtra.setSoftwareDrawSolid(this.hpbarBackFill_, true);
    }

    override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        if (MapUserInput.skipRender) {
			return;
		}
        var _local_8:BitmapData;
        var _local_9:uint;
        var _local_10:uint;
        var _local_4:BitmapData = this.getTexture(_arg_2, _arg_3);
        if (this.props_.drawOnGround_) {
            if (square_.faces_.length == 0) {
                return;
            }
            this.path_.data = square_.faces_[0].face_.vout_;
            this.bitmapFill_.bitmapData = _local_4;
            square_.baseTexMatrix_.calculateTextureMatrix(this.path_.data);
            this.bitmapFill_.matrix = square_.baseTexMatrix_.tToS_;
            _arg_1.push(this.bitmapFill_);
            _arg_1.push(this.path_);
            _arg_1.push(GraphicsUtil.END_FILL);
            return;
        }
        if (((!((this.obj3D_ == null))) && (!(Parameters.isGpuRender())))) {
            this.obj3D_.draw(_arg_1, _arg_2, this.props_.color_, _local_4);
            return;
        }
        if (((!((this.obj3D_ == null))) && (Parameters.isGpuRender()))) {
            _arg_1.push(null);
            return;
        }
        var _local_5:int = _local_4.width;
        var _local_6:int = _local_4.height;
        var _local_7:int = (square_.sink_ + this.sinkLevel_);
        if ((((_local_7 > 0)) && (((this.flying_) || (((!((square_.obj_ == null))) && (square_.obj_.props_.protectFromSink_))))))) {
            _local_7 = 0;
        }
        if (Parameters.isGpuRender()) {
            if (_local_7 != 0) {
                GraphicsFillExtra.setSinkLevel(this.bitmapFill_, Math.max((((_local_7 / _local_6) * 1.65) - 0.02), 0));
                _local_7 = (-(_local_7) + 0.02);
            }
            else {
                if ((((_local_7 == 0)) && (!((GraphicsFillExtra.getSinkLevel(this.bitmapFill_) == 0))))) {
                    GraphicsFillExtra.clearSink(this.bitmapFill_);
                }
            }
        }
        this.vS_.length = 0;
        this.vS_.push((posS_[3] - (_local_5 / 2)), ((posS_[4] - _local_6) + _local_7), (posS_[3] + (_local_5 / 2)), ((posS_[4] - _local_6) + _local_7), (posS_[3] + (_local_5 / 2)), posS_[4], (posS_[3] - (_local_5 / 2)), posS_[4]);
        this.path_.data = this.vS_;
        if (this.flash_ != null) {
            if (!this.flash_.doneAt(_arg_3)) {
                if (Parameters.isGpuRender()) {
                    this.flash_.applyGPUTextureColorTransform(_local_4, _arg_3);
                }
                else {
                    _local_4 = this.flash_.apply(_local_4, _arg_3);
                }
            }
            else {
                this.flash_ = null;
            }
        }
        if (((this.isShocked) && (!(this.isShockedTransformSet)))) {
            if (Parameters.isGpuRender()) {
                GraphicsFillExtra.setColorTransform(_local_4, new ColorTransform(-1, -1, -1, 1, 0xFF, 0xFF, 0xFF, 0));
            }
            else {
                _local_8 = _local_4.clone();
                _local_8.colorTransform(_local_8.rect, new ColorTransform(-1, -1, -1, 1, 0xFF, 0xFF, 0xFF, 0));
                _local_8 = CachingColorTransformer.filterBitmapData(_local_8, new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix));
                _local_4 = _local_8;
            }
            this.isShockedTransformSet = true;
        }
        if (((this.isCharging) && (!(this.isChargingTransformSet)))) {
            if (Parameters.isGpuRender()) {
                GraphicsFillExtra.setColorTransform(_local_4, new ColorTransform(1, 1, 1, 1, 0xFF, 0xFF, 0xFF, 0));
            }
            else {
                _local_8 = _local_4.clone();
                _local_8.colorTransform(_local_8.rect, new ColorTransform(1, 1, 1, 1, 0xFF, 0xFF, 0xFF, 0));
                _local_4 = _local_8;
            }
            this.isChargingTransformSet = true;
        }
        this.bitmapFill_.bitmapData = _local_4;
        this.fillMatrix_.identity();
        this.fillMatrix_.translate(this.vS_[0], this.vS_[1]);
        this.bitmapFill_.matrix = this.fillMatrix_;
        _arg_1.push(this.bitmapFill_);
        _arg_1.push(this.path_);
        _arg_1.push(GraphicsUtil.END_FILL);
        if (((((((!(this.isPaused())) && (((this.condition_[ConditionEffect.CE_FIRST_BATCH]) || (this.condition_[ConditionEffect.CE_SECOND_BATCH]))))) && (!(Parameters.screenShotMode_)))) && (!((this is Pet))))) {
            this.drawConditionIcons(_arg_1, _arg_2, _arg_3);
        }
        if (this.props_.showName_ && this.name_ != null && this.name_.length != 0) {
            this.drawName(_arg_1, _arg_2);
        }
		if ((this.props_ && (this.props_.isEnemy_ || this.props_.isPlayer_)) && !(this.props_.noMiniMap_)) {
            _local_9 = ((_local_4.getPixel32((_local_4.width / 4), (_local_4.height / 4)) | _local_4.getPixel32((_local_4.width / 2), (_local_4.height / 2))) | _local_4.getPixel32(((_local_4.width * 3) / 4), ((_local_4.height * 3) / 4)));
            _local_10 = (_local_9 >> 24);
            if (_local_10 != 0) {
                hasShadow_ = true;
                if (Parameters.data_.HPBar) {
                    this.drawHpBar(_arg_1, _arg_3, _local_4.height / 3.2);
                }
            }
            else {
                hasShadow_ = false;
            }
        }
    }

    public function drawConditionIcons(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        var _local_9:BitmapData;
        var _local_10:GraphicsBitmapFill;
        var _local_11:GraphicsPath;
        var _local_12:Number;
        var _local_13:Number;
        var _local_14:Matrix;
        if (this.icons_ == null) {
            this.icons_ = new Vector.<BitmapData>();
            this.iconFills_ = new Vector.<GraphicsBitmapFill>();
            this.iconPaths_ = new Vector.<GraphicsPath>();
        }
        this.icons_.length = 0;
        var _local_4:int = (_arg_3 / 500);
        ConditionEffect.getConditionEffectIcons(this.condition_[ConditionEffect.CE_FIRST_BATCH], this.icons_, _local_4);
        ConditionEffect.getConditionEffectIcons2(this.condition_[ConditionEffect.CE_SECOND_BATCH], this.icons_, _local_4);
        var _local_5:Number = posS_[3];
        var _local_6:Number = this.vS_[1];
        var _local_7:int = this.icons_.length;
        var _local_8:int;
        while (_local_8 < _local_7) {
            _local_9 = this.icons_[_local_8];
            if (_local_8 >= this.iconFills_.length) {
                this.iconFills_.push(new GraphicsBitmapFill(null, new Matrix(), false, false));
                this.iconPaths_.push(new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>()));
            }
            _local_10 = this.iconFills_[_local_8];
            _local_11 = this.iconPaths_[_local_8];
            _local_10.bitmapData = _local_9;
            _local_12 = ((_local_5 - ((_local_9.width * _local_7) / 2)) + (_local_8 * _local_9.width));
            _local_13 = (_local_6 - (_local_9.height / 2));
            _local_11.data.length = 0;
            _local_11.data.push(_local_12, _local_13, (_local_12 + _local_9.width), _local_13, (_local_12 + _local_9.width), (_local_13 + _local_9.height), _local_12, (_local_13 + _local_9.height));
            _local_14 = _local_10.matrix;
            _local_14.identity();
            _local_14.translate(_local_12, _local_13);
            _arg_1.push(_local_10);
            _arg_1.push(_local_11);
            _arg_1.push(GraphicsUtil.END_FILL);
            _local_8++;
        }
    }

    override public function drawShadow(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
		if (Parameters.data_.HidePlayerFilter != false && this is Player && this != map_.player_ && map_.name_ == "Nexus") {
			if ((this as Player).numStars_ <= Parameters.data_.chatStarRequirement) {
				return;
			}
        }
        if (this.shadowGradientFill_ == null) {
            this.shadowGradientFill_ = new GraphicsGradientFill(GradientType.RADIAL, [this.props_.shadowColor_, this.props_.shadowColor_], [0.5, 0], null, new Matrix());
            this.shadowPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
        }
        var _local_4:Number = (((this.size_ / 100) * (this.props_.shadowSize_ / 100)) * this.sizeMult_);
        var _local_5:Number = (30 * _local_4);
        var _local_6:Number = (15 * _local_4);
        this.shadowGradientFill_.matrix.createGradientBox((_local_5 * 2), (_local_6 * 2), 0, (posS_[0] - _local_5), (posS_[1] - _local_6));
        _arg_1.push(this.shadowGradientFill_);
        this.shadowPath_.data.length = 0;
        this.shadowPath_.data.push((posS_[0] - _local_5), (posS_[1] - _local_6), (posS_[0] + _local_5), (posS_[1] - _local_6), (posS_[0] + _local_5), (posS_[1] + _local_6), (posS_[0] - _local_5), (posS_[1] + _local_6));
        _arg_1.push(this.shadowPath_);
        _arg_1.push(GraphicsUtil.END_FILL);
    }

    public function clearTextureCache():void {
        this.texturingCache_ = new Dictionary();
    }

    public function toString():String {
        return "[" + getQualifiedClassName(this) + " id: " + objectId_ + " type: " + ObjectLibrary.typeToDisplayId_[this.objectType_] + " pos: " + x_ + ", " + y_ + "]";
    }

}
}//package com.company.assembleegameclient.objects
