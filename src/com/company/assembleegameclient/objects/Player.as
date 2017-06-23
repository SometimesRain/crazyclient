package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.map.mapoverlay.CharacterStatusText;
import com.company.assembleegameclient.objects.particles.HealingEffect;
import com.company.assembleegameclient.objects.particles.LevelUpEffect;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.tutorial.Tutorial;
import com.company.assembleegameclient.tutorial.doneAction;
import com.company.assembleegameclient.ui.TradeInventory;
import com.company.assembleegameclient.ui.TradeSlot;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.ConditionEffect;
import com.company.assembleegameclient.util.FameUtil;
import com.company.assembleegameclient.util.FreeList;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.CachingColorTransformer;
import com.company.util.ConversionUtil;
import com.company.util.GraphicsUtil;
import com.company.util.IntPoint;
import com.company.util.MoreColorUtil;
import com.company.util.PointUtil;
import com.company.util.Trig;
import kabam.rotmg.game.model.UseBuyPotionVO;
import kabam.rotmg.game.signals.UseBuyPotionSignal;
import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;

import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.game.MapUserInput;
import kabam.rotmg.chat.control.ParseChatMessageCommand;

import flash.display.BitmapData;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import flash.utils.getTimer;

import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.constants.ActivationType;
import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.constants.UseType;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.model.PotionInventoryModel;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.game.view.components.QueuedStatusText;
import kabam.rotmg.stage3D.GraphicsFillExtra;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

import org.swiftsuspenders.Injector;

public class Player extends Character {

    public static const MS_BETWEEN_TELEPORT:int = 10000;
    private static const MOVE_THRESHOLD:Number = 0.4;
    public static var isAdmin:Boolean = false;
    public static var isMod:Boolean = false;
    private static const NEARBY:Vector.<Point> = new <Point>[new Point(0, 0), new Point(1, 0), new Point(0, 1), new Point(1, 1)];
    private static var newP:Point = new Point();
    private static const RANK_OFFSET_MATRIX:Matrix = new Matrix(1, 0, 0, 1, 2, 2);
    private static const NAME_OFFSET_MATRIX:Matrix = new Matrix(1, 0, 0, 1, 20, 0); //changing last to 1 causes the y bug
    private static const MIN_MOVE_SPEED:Number = 0.004;
    private static const MAX_MOVE_SPEED:Number = 0.0096;
    private static const MIN_ATTACK_FREQ:Number = 0.0015;
    private static const MAX_ATTACK_FREQ:Number = 0.008;
    private static const MIN_ATTACK_MULT:Number = 0.5;
    private static const MAX_ATTACK_MULT:Number = 2;
    
    public static const SEARCH_LOOT_FREQ:int = 20;
    public static const MAX_LOOT_DIST:Number = 1;
    public static const VAULT_CHEST:int = 1284;
    public static const HEALTH_POT:int = 2594;
    public static const MAGIC_POT:int = 2595;
    public static const MAX_STACK_POTS:int = 6;
    public static const LOOT_EVERY_MS:int = 550;
    public static const WEAP_ARMOR_MIN_TIER:int = 10;
    public static const HEALTH_SLOT:int = 254;
    public static const MAGIC_SLOT:int = 255;
    public static var wantedList:Vector.<int> = null;
    public static var lastSearchTime:int = 0;
    public static var lastLootTime:int = 0;
    public static var nextLootSlot:int = -1;
	private var nextSwap:int = 0;
	private var bools:Array = new Array(false,false,false,false,false,false,false,false);
    public var followTarget:GameObject;
	
    public var questMob:GameObject;
    public var questMob1:GameObject;
    public var questMob2:GameObject;
    public var questMob3:GameObject;
    public var mapLightSpeed:Boolean = false;
	public var afkMsg:String = "";
	public var sendStr:int = int.MAX_VALUE;
	
	private var timerStep:int = 500;
	private var timerCount:int = 1;
	private var startTime:int = 0;
	private var endCount:int = 0;
	public var select_:int = -1;
	private var nextSelect:int = 0;
	private var loopStart:int = 4;
	
	private var nextAutoAbil:int = 0;
    public var mapAutoAbil:Boolean = false;
    private var opFailed:Boolean = false;
	
    private var potionInventoryModel:PotionInventoryModel;
    private var useBuyPotionSignal:UseBuyPotionSignal;
	private var lastPotionUse:int = 0;
	
	public var chp:Number = -1;
	public var cmaxhp:int = -1;
	public var cmaxhpboost:int = -1;
	private var vitTime:int = -1;
	public var remBuff:Vector.<int> = new <int>[];

    public var xpTimer:int;
    public var skinId:int;
    public var skin:AnimatedChar;
    public var isShooting:Boolean;
    public var accountId_:String = "";
    public var credits_:int = 0;
    public var tokens_:int = 0;
    public var numStars_:int = 0;
    public var fame_:int = 0;
    public var nameChosen_:Boolean = false;
    public var currFame_:int = 0;
    public var nextClassQuestFame_:int = -1;
    public var legendaryRank_:int = -1;
    public var guildName_:String = null;
    public var guildRank_:int = -1;
    public var isFellowGuild_:Boolean = false;
    public var breath_:int = -1;
    public var maxMP_:int = 200;
    public var mp_:Number = 0;
    public var nextLevelExp_:int = 1000;
    public var exp_:int = 0;
    public var attack_:int = 0;
    public var speed_:int = 0;
    public var dexterity_:int = 0;
    public var vitality_:int = 0;
    public var wisdom_:int = 0;
    public var maxHPBoost_:int = 0;
    public var maxMPBoost_:int = 0;
    public var attackBoost_:int = 0;
    public var defenseBoost_:int = 0;
    public var speedBoost_:int = 0;
    public var vitalityBoost_:int = 0;
    public var wisdomBoost_:int = 0;
    public var dexterityBoost_:int = 0;
    public var xpBoost_:int = 0;
    public var healthPotionCount_:int = 0;
    public var magicPotionCount_:int = 0;
    public var attackMax_:int = 0;
    public var defenseMax_:int = 0;
    public var speedMax_:int = 0;
    public var dexterityMax_:int = 0;
    public var vitalityMax_:int = 0;
    public var wisdomMax_:int = 0;
    public var maxHPMax_:int = 0;
    public var maxMPMax_:int = 0;
    public var hasBackpack_:Boolean = false;
    public var starred_:Boolean = false;
    public var ignored_:Boolean = false;
    public var distSqFromThisPlayer_:Number = 0;
    protected var rotate_:Number = 0;
    protected var relMoveVec_:Point = null;
    protected var moveMultiplier_:Number = 1;
    public var attackPeriod_:int = 0;
    public var lastAltAttack_:int = 0; //custom
    public var nextAltAttack_:int = 0;
    public var nextTeleportAt_:int = 0;
    public var dropBoost:int = 0;
    public var tierBoost:int = 0;
    protected var healingEffect_:HealingEffect = null;
    protected var nearestMerchant_:Merchant = null;
    public var isDefaultAnimatedChar:Boolean = true;
    public var projectileIdSetOverrideNew:String = "";
    public var projectileIdSetOverrideOld:String = "";
    private var addTextLine:AddTextLineSignal;
    private var factory:CharacterFactory;
    private var ip_:IntPoint;
    private var breathBackFill_:GraphicsSolidFill = null;
    private var breathBackPath_:GraphicsPath = null;
    private var breathFill_:GraphicsSolidFill = null;
    private var breathPath_:GraphicsPath = null;
	
    public var collect:int = 0;
	
	public var thunderTime:int = 0;

    public function Player(_arg_1:XML) {
        this.ip_ = new IntPoint();
        var _local_2:Injector = StaticInjectorContext.getInjector();
        this.addTextLine = _local_2.getInstance(AddTextLineSignal);
        this.factory = _local_2.getInstance(CharacterFactory);
        this.potionInventoryModel = _local_2.getInstance(PotionInventoryModel); //autodrink potion
        this.useBuyPotionSignal = _local_2.getInstance(UseBuyPotionSignal); //autodrink potion
        super(_arg_1);
        this.attackMax_ = int(_arg_1.Attack.@max);
        this.defenseMax_ = int(_arg_1.Defense.@max);
        this.speedMax_ = int(_arg_1.Speed.@max);
        this.dexterityMax_ = int(_arg_1.Dexterity.@max);
        this.vitalityMax_ = int(_arg_1.HpRegen.@max);
        this.wisdomMax_ = int(_arg_1.MpRegen.@max);
        this.maxHPMax_ = int(_arg_1.MaxHitPoints.@max);
        this.maxMPMax_ = int(_arg_1.MaxMagicPoints.@max);
        texturingCache_ = new Dictionary();
    }

    public static function fromPlayerXML(_arg_1:String, _arg_2:XML):Player {
        var _local_3:int = int(_arg_2.ObjectType);
        var _local_4:XML = ObjectLibrary.xmlLibrary_[_local_3];
        var _local_5:Player = new Player(_local_4);
        _local_5.name_ = _arg_1;
        _local_5.level_ = int(_arg_2.Level);
        _local_5.exp_ = int(_arg_2.Exp);
        _local_5.equipment_ = ConversionUtil.toIntVector(_arg_2.Equipment);
        _local_5.maxHP_ = int(_arg_2.MaxHitPoints);
        _local_5.hp_ = int(_arg_2.HitPoints);
        _local_5.maxMP_ = int(_arg_2.MaxMagicPoints);
        _local_5.mp_ = int(_arg_2.MagicPoints);
        _local_5.attack_ = int(_arg_2.Attack);
        _local_5.defense_ = int(_arg_2.Defense);
        _local_5.speed_ = int(_arg_2.Speed);
        _local_5.dexterity_ = int(_arg_2.Dexterity);
        _local_5.vitality_ = int(_arg_2.HpRegen);
        _local_5.wisdom_ = int(_arg_2.MpRegen);
        _local_5.tex1Id_ = int(_arg_2.Tex1);
        _local_5.tex2Id_ = int(_arg_2.Tex2);
        return (_local_5);
    }


    public function setRelativeMovement(_arg_1:Number, _arg_2:Number, _arg_3:Number):void {
        var _local_4:Number;
        if (this.relMoveVec_ == null) {
            this.relMoveVec_ = new Point();
        }
        this.rotate_ = _arg_1;
        this.relMoveVec_.x = _arg_2;
        this.relMoveVec_.y = _arg_3;
        if (isConfused()) {
            _local_4 = this.relMoveVec_.x;
            this.relMoveVec_.x = -(this.relMoveVec_.y);
            this.relMoveVec_.y = -(_local_4);
            this.rotate_ = -(this.rotate_);
        }
    }

    public function setCredits(_arg_1:int):void {
        this.credits_ = _arg_1;
    }

    public function setTokens(_arg_1:int):void {
        this.tokens_ = _arg_1;
    }

    public function setGuildName(_arg_1:String):void {
        var _local_3:GameObject;
        var _local_4:Player;
        var _local_5:Boolean;
        this.guildName_ = _arg_1;
        var _local_2:Player = map_.player_;
        if (_local_2 == this) {
            for each (_local_3 in map_.goDict_) {
                _local_4 = (_local_3 as Player);
                if (((!((_local_4 == null))) && (!((_local_4 == this))))) {
                    _local_4.setGuildName(_local_4.guildName_);
                }
            }
        }
        else {
            _local_5 = ((((((!((_local_2 == null))) && (!((_local_2.guildName_ == null))))) && (!((_local_2.guildName_ == ""))))) && ((_local_2.guildName_ == this.guildName_)));
            if (_local_5 != this.isFellowGuild_) {
                this.isFellowGuild_ = _local_5;
                nameBitmapData_ = null;
            }
        }
    }

    public function isTeleportEligible(_arg_1:Player):Boolean {
        return (!(((_arg_1.isPaused()) || (_arg_1.isInvisible()))));
    }

    public function teleportTo(_arg_1:Player):Boolean {
        if (isPaused()) {
            this.addTextLine.dispatch(this.makeErrorMessage(TextKey.PLAYER_NOTELEPORTWHILEPAUSED));
            return (false);
        }
        if (!this.isTeleportEligible(_arg_1)) {
            if (_arg_1.isInvisible()) {
                this.addTextLine.dispatch(this.makeErrorMessage(TextKey.TELEPORT_INVISIBLE_PLAYER, {"player": _arg_1.name_}));
            }
            else {
                this.addTextLine.dispatch(this.makeErrorMessage(TextKey.PLAYER_TELEPORT_TO_PLAYER, {"player": _arg_1.name_}));
            }
            return (false);
        }
        map_.gs_.gsc_.teleport(_arg_1.name_);
        return (true);
    }

    private function makeErrorMessage(_arg_1:String, _arg_2:Object = null):ChatMessage {
        return (ChatMessage.make(Parameters.ERROR_CHAT_NAME, _arg_1, -1, -1, "", false, _arg_2));
    }

    public function levelUpEffect(_arg_1:String, _arg_2:Boolean = true):void {
        if (_arg_2) {
            this.levelUpParticleEffect();
        }
        var _local_3:QueuedStatusText = new QueuedStatusText(this, new LineBuilder().setParams(_arg_1), 0xFF00, 2000);
        map_.mapOverlay_.addQueuedText(_local_3);
    }

    public function handleLevelUp(_arg_1:Boolean):void {
        SoundEffectLibrary.play("level_up");
        if (_arg_1) {
            this.levelUpEffect(TextKey.PLAYER_NEWCLASSUNLOCKED, false);
            this.levelUpEffect(TextKey.PLAYER_LEVELUP);
        }
        else {
            this.levelUpEffect(TextKey.PLAYER_LEVELUP);
        }
		if (objectId_ == map_.player_.objectId_) {
			chp = maxHP_;
			var objxml:XML = ObjectLibrary.xmlLibrary_[objectType_];
			var avggains:Array = new Array();
			var msgout:String = "You rolled ";
			var statabbr:Array = new Array("HP", "MP", "ATT", "DEF", "SPD", "DEX", "VIT", "WIS");
			var base:Array = new Array(
					maxHP_ - maxHPBoost_ - objxml.MaxHitPoints,
					maxMP_ - maxMPBoost_ - objxml.MaxMagicPoints,
					attack_ - attackBoost_ - objxml.Attack,
					defense_ - defenseBoost_ - objxml.Defense,
					speed_ - speedBoost_ - objxml.Speed,
					dexterity_ - dexterityBoost_ - objxml.Dexterity,
					vitality_ - vitalityBoost_ - objxml.HpRegen,
					wisdom_ - wisdomBoost_ - objxml.MpRegen
			);
			var r:int = 0;
			for each(var xmlrow:XML in objxml.LevelIncrease) {
				var avg:Number = (int(xmlrow.@min) + int(xmlrow.@max)) / 2;
				var diff:Number = base[r] - (level_ - 1) * avg;
				avggains.push(diff);
				r++;
			}
			for (var j:int = 0; j < 8; j++) {
				if (avggains[j] > 0)  {
					msgout += "+"+avggains[j] + " " + statabbr[j]+ ", ";
				}
				else {
					msgout += avggains[j] + " " + statabbr[j]+ ", ";
				}
			}
			addTextLine.dispatch(ChatMessage.make("*Help*", msgout.substr(0, msgout.length - 2)));
		}
    }

    public function levelUpParticleEffect(_arg_1:uint = 0xFF00FF00):void {
        map_.addObj(new LevelUpEffect(this, _arg_1, 20), x_, y_);
    }

    public function handleExpUp(_arg_1:int):void {
        if (level_ == 20) {
            return;
        }
		if (Parameters.data_.AntiLag && this.objectId_ != map_.player_.objectId_) {
			return;
		}
        var _local_2:CharacterStatusText = new CharacterStatusText(this, 0xFF00, 1000);
        _local_2.setStringBuilder(new LineBuilder().setParams(TextKey.PLAYER_EXP, {"exp": _arg_1}));
        map_.mapOverlay_.addStatusText(_local_2);
    }

    private function getNearbyMerchant():Merchant {
        var _local_3:Point;
        var _local_4:Merchant;
        var _local_1:int = ((((x_ - int(x_))) > 0.5) ? 1 : -1);
        var _local_2:int = ((((y_ - int(y_))) > 0.5) ? 1 : -1);
        for each (_local_3 in NEARBY) {
            this.ip_.x_ = (x_ + (_local_1 * _local_3.x));
            this.ip_.y_ = (y_ + (_local_2 * _local_3.y));
            _local_4 = map_.merchLookup_[this.ip_];
            if (_local_4 != null) {
                return ((((PointUtil.distanceSquaredXY(_local_4.x_, _local_4.y_, x_, y_) < 1)) ? _local_4 : null));
            }
        }
        return (null);
    }

    public function walkTo(_arg_1:Number, _arg_2:Number):Boolean {
        this.modifyMove(_arg_1, _arg_2, newP);
        return (this.moveTo(newP.x, newP.y));
    }

    override public function moveTo(_arg_1:Number, _arg_2:Number):Boolean {
        var _local_3:Boolean = super.moveTo(_arg_1, _arg_2);
        if (map_.gs_.evalIsNotInCombatMapArea()) {
            this.nearestMerchant_ = this.getNearbyMerchant();
        }
        return (_local_3);
    }

    public function modifyMove(_arg_1:Number, _arg_2:Number, _arg_3:Point):void {
        if (((isParalyzed()) || (isPetrified()))) {
            _arg_3.x = x_;
            _arg_3.y = y_;
            return;
        }
        var _local_4:Number = (_arg_1 - x_);
        var _local_5:Number = (_arg_2 - y_);
        if ((((((((_local_4 < MOVE_THRESHOLD)) && ((_local_4 > -(MOVE_THRESHOLD))))) && ((_local_5 < MOVE_THRESHOLD)))) && ((_local_5 > -(MOVE_THRESHOLD))))) {
            this.modifyStep(_arg_1, _arg_2, _arg_3);
            return;
        }
        var _local_6:Number = (MOVE_THRESHOLD / Math.max(Math.abs(_local_4), Math.abs(_local_5)));
        var _local_7:Number = 0;
        _arg_3.x = x_;
        _arg_3.y = y_;
        var _local_8:Boolean;
        while (!(_local_8)) {
            if ((_local_7 + _local_6) >= 1) {
                _local_6 = (1 - _local_7);
                _local_8 = true;
            }
            this.modifyStep((_arg_3.x + (_local_4 * _local_6)), (_arg_3.y + (_local_5 * _local_6)), _arg_3);
            _local_7 = (_local_7 + _local_6);
        }
    }

    public function modifyStep(_arg_1:Number, _arg_2:Number, _arg_3:Point):void {
        var _local_6:Number;
        var _local_7:Number;
        var _local_4:Boolean = ((((((x_ % 0.5) == 0)) && (!((_arg_1 == x_))))) || (!((int((x_ / 0.5)) == int((_arg_1 / 0.5))))));
        var _local_5:Boolean = ((((((y_ % 0.5) == 0)) && (!((_arg_2 == y_))))) || (!((int((y_ / 0.5)) == int((_arg_2 / 0.5))))));
        if (((((!(_local_4)) && (!(_local_5)))) || (this.isValidPosition(_arg_1, _arg_2)))) {
            _arg_3.x = _arg_1;
            _arg_3.y = _arg_2;
            return;
        }
        if (_local_4) {
            _local_6 = (((_arg_1) > x_) ? (int((_arg_1 * 2)) / 2) : (int((x_ * 2)) / 2));
            if (int(_local_6) > int(x_)) {
                _local_6 = (_local_6 - 0.01);
            }
        }
        if (_local_5) {
            _local_7 = (((_arg_2) > y_) ? (int((_arg_2 * 2)) / 2) : (int((y_ * 2)) / 2));
            if (int(_local_7) > int(y_)) {
                _local_7 = (_local_7 - 0.01);
            }
        }
        if (!_local_4) {
            _arg_3.x = _arg_1;
            _arg_3.y = _local_7;
            if (square_ != null && square_.props_.slideAmount_ != 0) {
                this.resetMoveVector(false);
            }
            return;
        }
        if (!_local_5) {
            _arg_3.x = _local_6;
            _arg_3.y = _arg_2;
            if (square_ != null && square_.props_.slideAmount_ != 0) {
                this.resetMoveVector(true);
            }
            return;
        }
        var _local_8:Number = (((_arg_1) > x_) ? (_arg_1 - _local_6) : (_local_6 - _arg_1));
        var _local_9:Number = (((_arg_2) > y_) ? (_arg_2 - _local_7) : (_local_7 - _arg_2));
        if (_local_8 > _local_9) {
            if (this.isValidPosition(_arg_1, _local_7)) {
                _arg_3.x = _arg_1;
                _arg_3.y = _local_7;
                return;
            }
            if (this.isValidPosition(_local_6, _arg_2)) {
                _arg_3.x = _local_6;
                _arg_3.y = _arg_2;
                return;
            }
        }
        else {
            if (this.isValidPosition(_local_6, _arg_2)) {
                _arg_3.x = _local_6;
                _arg_3.y = _arg_2;
                return;
            }
            if (this.isValidPosition(_arg_1, _local_7)) {
                _arg_3.x = _arg_1;
                _arg_3.y = _local_7;
                return;
            }
        }
        _arg_3.x = _local_6;
        _arg_3.y = _local_7;
    }

    private function resetMoveVector(_arg_1:Boolean):void {
        moveVec_.scaleBy(-0.5);
        if (_arg_1) {
            moveVec_.y = (moveVec_.y * -1);
        }
        else {
            moveVec_.x = (moveVec_.x * -1);
        }
    }

    public function isValidPosition(_arg_1:Number, _arg_2:Number):Boolean {
        var _local_3:Square = map_.getSquare(_arg_1, _arg_2);
        if (Parameters.data_.SafeWalk != false)
        {
            if(map_.gs_.mui_.mouseDown_ != true && _local_3.props_.maxDamage_ != 0 && _local_3.obj_ == null)
            {
                return false;
            }
        }
        if (Parameters.data_.NoClip && _local_3 != null)
		{
            if(map_.name_ == "Sprite World")
            {
                return true;
            }
		}
        if (((!((square_ == _local_3))) && ((((_local_3 == null)) || (!(_local_3.isWalkable())))))) {
            return (false);
        }
        var _local_4:Number = (_arg_1 - int(_arg_1));
        var _local_5:Number = (_arg_2 - int(_arg_2));
        if (_local_4 < 0.5) {
            if (this.isFullOccupy((_arg_1 - 1), _arg_2)) {
                return (false);
            }
            if (_local_5 < 0.5) {
                if (((this.isFullOccupy(_arg_1, (_arg_2 - 1))) || (this.isFullOccupy((_arg_1 - 1), (_arg_2 - 1))))) {
                    return (false);
                }
            }
            else {
                if (_local_5 > 0.5) {
                    if (((this.isFullOccupy(_arg_1, (_arg_2 + 1))) || (this.isFullOccupy((_arg_1 - 1), (_arg_2 + 1))))) {
                        return (false);
                    }
                }
            }
        }
        else {
            if (_local_4 > 0.5) {
                if (this.isFullOccupy((_arg_1 + 1), _arg_2)) {
                    return (false);
                }
                if (_local_5 < 0.5) {
                    if (((this.isFullOccupy(_arg_1, (_arg_2 - 1))) || (this.isFullOccupy((_arg_1 + 1), (_arg_2 - 1))))) {
                        return (false);
                    }
                }
                else {
                    if (_local_5 > 0.5) {
                        if (((this.isFullOccupy(_arg_1, (_arg_2 + 1))) || (this.isFullOccupy((_arg_1 + 1), (_arg_2 + 1))))) {
                            return (false);
                        }
                    }
                }
            }
            else {
                if (_local_5 < 0.5) {
                    if (this.isFullOccupy(_arg_1, (_arg_2 - 1))) {
                        return (false);
                    }
                }
                else {
                    if (_local_5 > 0.5) {
                        if (this.isFullOccupy(_arg_1, (_arg_2 + 1))) {
                            return (false);
                        }
                    }
                }
            }
        }
        return (true);
    }

    public function isFullOccupy(_arg_1:Number, _arg_2:Number):Boolean {
        var _local_3:Square = map_.lookupSquare(_arg_1, _arg_2);
        return ((_local_3 == null || _local_3.tileType_ == 0xFF) || (_local_3.obj_ != null && _local_3.obj_.props_.fullOccupy_));
    }
	
    public function notifyPlayer(text:String, color:int = 0x00FF00, lifetime:int = 1500) : void
    {
        var _loc3_:CharacterStatusText = new CharacterStatusText(this,color,lifetime);
        _loc3_.setStringBuilder(new StaticStringBuilder(text));
        map_.mapOverlay_.addStatusText(_loc3_);
    }
	
	//LOOT
    public function lootNotif(param1:String, param2:GameObject) : void
    {
        var _loc3_:CharacterStatusText = new CharacterStatusText(param2,0x00FFFF,4000);
        _loc3_.setStringBuilder(new StaticStringBuilder(param1));
        map_.mapOverlay_.addStatusText(_loc3_);
    }
    
    public function notWanted(param1:XML) : Boolean
    {
        var _loc2_:Boolean = false;
        var _loc3_:String = null;
        var _loc4_:String = null;
        for each(_loc4_ in Parameters.data_.NoLoot)
        {
            if(String(param1.@id).toLowerCase().search(_loc4_) != -1)
            {
                return true;
            }
        }
        return false;
    }
    
    public function genWantedList() : Vector.<int>
    {
        var _loc1_:XML;
        var _loc2_:Vector.<int> = new Vector.<int>();
		_loc2_.push(HEALTH_POT);
		_loc2_.push(MAGIC_POT);
        for each(_loc1_ in ObjectLibrary.xmlLibrary_) {
            if (_loc1_.hasOwnProperty("Item")) { //is item
                if (!notWanted(_loc1_)) { //we want this item
					if (_loc1_.hasOwnProperty("Activate")) { //is potion
						for each(var _loc3_:String in _loc1_.Activate) {
							if (_loc3_ == "IncrementStat") {
								var attr:int = _loc1_.Activate.@stat;
								switch (attr) {
									case 21:
									case 20:
									case 0:
									case 3:
										if (Parameters.data_.potsMajor) {
											_loc2_.push(ObjectLibrary.idToType_[String(_loc1_.@id)]);
										}
										break;
									case 22:
									case 26:
									case 27:
									case 28:
										if (Parameters.data_.potsMinor) {
											_loc2_.push(ObjectLibrary.idToType_[String(_loc1_.@id)]);
										}
										break;
								}
							}
						}
					}
					if (!_loc1_.hasOwnProperty("Tier")) { //untiered
                        _loc2_.push(ObjectLibrary.idToType_[String(_loc1_.@id)]);
					}
					else if (_loc1_.hasOwnProperty("Usable") && _loc1_.Tier >= Parameters.data_.LNAbility) { //abilities
                        _loc2_.push(ObjectLibrary.idToType_[String(_loc1_.@id)]);
					}
					else if (_loc1_.hasOwnProperty("SlotType") && _loc1_.SlotType == 9 && _loc1_.Tier >= Parameters.data_.LNRing) { //rings
                        _loc2_.push(ObjectLibrary.idToType_[String(_loc1_.@id)]);
					}
					else if (!_loc1_.hasOwnProperty("Usable") && _loc1_.Tier >= Parameters.data_.LNWeap && _loc1_.hasOwnProperty("Projectile")) { //weapons
                        _loc2_.push(ObjectLibrary.idToType_[String(_loc1_.@id)]);
					}
					else if (!_loc1_.hasOwnProperty("Usable") && _loc1_.Tier >= Parameters.data_.LNArmor) { //armors
                        _loc2_.push(ObjectLibrary.idToType_[String(_loc1_.@id)]);
					}
                }
            }
        }
        return _loc2_;
    }
    
    public function bagDist(param1:GameObject, param2:Container) : Number
    {
        var _loc3_:Number = param1.x_ - param2.x_;
        var _loc4_:Number = param1.y_ - param2.y_;
        return Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
    }
    
    public function getLootableBags(param1:Vector.<Container>, param2:Number) : Vector.<Container>
    {
        var _loc3_:Container = null;
        var _loc4_:Vector.<Container> = new Vector.<Container>();
        for each(_loc3_ in param1)
        {
            if(bagDist(map_.player_,_loc3_) <= param2)
            {
                _loc4_.push(_loc3_);
            }
        }
        return _loc4_;
    }
    
    public function getLootBags() : Vector.<Container>
    {
        var _loc1_:GameObject = null;
        var _loc2_:Vector.<Container> = new Vector.<Container>();
        for each(_loc1_ in map_.goDict_)
        {
			if(_loc1_ is Container && _loc1_.objectType_ != VAULT_CHEST && _loc1_.objectType_ != 1860) //gift chest
            {
                _loc2_.push(_loc1_);
            }
        }
        return _loc2_;
    }
    
    public function lookForLoot() : Boolean
    {
        var _loc1_:int = getTimer();
        var _loc2_:int = 1000 / SEARCH_LOOT_FREQ;
        if (this == map_.player_ && _loc1_ - lastSearchTime > _loc2_) {
            lastSearchTime = _loc1_;
            return true;
        }
        return false;
    }
    
    public function isWantedItem(param1:int) : Boolean
    {
        var _loc2_:int;
		for each(_loc2_ in Parameters.data_.lootIgnore) { //ignored items
            if (param1 == _loc2_) {
				return false;
			}
		}
        for each(_loc2_ in wantedList) { //wanted items
            if (param1 == _loc2_) {
                return true;
            }
        }
        return false;
    }
	
    public function lootItem(putToSlot:int, bag:Container, slot1:int, lootedItemtype:int) : void
    {
        var dontPutToPotSlot:Boolean = (putToSlot != HEALTH_SLOT && putToSlot != MAGIC_SLOT);
        var weLootedPotion:Boolean = (lootedItemtype == HEALTH_POT || lootedItemtype == MAGIC_POT);
        if ((healthPotionCount_ < MAX_STACK_POTS && lootedItemtype == HEALTH_POT) || (magicPotionCount_ < MAX_STACK_POTS && lootedItemtype == MAGIC_POT))
        { //loot potion to potion slot
            map_.gs_.gsc_.invSwapPotion(this,bag,slot1,lootedItemtype,this,lootedItemtype-2340,-1);
        }
        else if (dontPutToPotSlot && weLootedPotion && !(nextLootSlot == HEALTH_POT || nextLootSlot == MAGIC_POT))
        { //loot potion to inv
			if ((lootedItemtype == 2594 && !Parameters.data_.lootHP) || (lootedItemtype == 2595 && !Parameters.data_.lootMP)) {
				return;
			}
            map_.gs_.gsc_.invSwap(this,this,putToSlot,nextLootSlot,bag,slot1,lootedItemtype);
        }
        else if (dontPutToPotSlot && !weLootedPotion)
        { //loot item
			if (nextLootSlot == -1) { //loot item on empty slot
				map_.gs_.gsc_.invSwap(this,bag,slot1,lootedItemtype,this,putToSlot,-1);
			}
			else { //loot item on potion
				if (Parameters.data_.drinkPot) {
					map_.gs_.gsc_.useItem(getTimer(), this.objectId_, putToSlot, nextLootSlot, this.x_, this.y_, 0); //use the unneeded potion
					map_.gs_.gsc_.invSwap(this,bag,slot1,lootedItemtype,this,putToSlot,-1);
				}
				else {
					map_.gs_.gsc_.invSwap(this,bag,slot1,lootedItemtype,this,putToSlot,equipment_[putToSlot]);
				}
			}
        }
        lastLootTime = getTimer();
    }
	
    public function nextAvailableInventorySlotMod():int { //-1 = no slots; 0-11 = this slot
        var _local_1:int = this.hasBackpack_ ? equipment_.length : (equipment_.length - GeneralConstants.NUM_INVENTORY_SLOTS);
        var _local_2:uint = 4;
        while (_local_2 < _local_1) { //see if slot is open
            if (equipment_[_local_2] == -1) {
				nextLootSlot = equipment_[_local_2];
                return (_local_2);
            }
            _local_2++;
        }
        _local_2 = 4;
        while (_local_2 < _local_1) { //see if slot has a potion
            if (equipment_[_local_2] == HEALTH_POT || equipment_[_local_2] == MAGIC_POT) {
				nextLootSlot = equipment_[_local_2];
                return (_local_2);
            }
            _local_2++;
        }
        return (-1);
    }
    
    public function okToLoot(item:int) : Boolean
    {
        var _loc2_:int = getTimer();
        var _loc3_:int = _loc2_ - lastLootTime;
        if (_loc3_ < LOOT_EVERY_MS) {
            return false; //too early to loot
        }
        if (nextAvailableInventorySlotMod() != -1 || (item == HEALTH_POT && healthPotionCount_ < 6) || (item == MAGIC_POT && magicPotionCount_ < 6)) {
            return true; //we have slots
        }
        return false; //we have no slots
    }
    
    public function autoloot_() : void
    {
        var _loc1_:Container = null;
        var _loc2_:int = 0;
        var _loc3_:Player = null;
        var _loc4_:int = 0;
        var _loc5_:Vector.<Container> = getLootBags();
        _loc5_ = getLootableBags(_loc5_,MAX_LOOT_DIST);
        for each(_loc1_ in _loc5_) {
            _loc4_ = 0;
            for each(_loc2_ in _loc1_.equipment_) {
                if (isWantedItem(_loc2_) && okToLoot(_loc2_)) { //is item wanted?
					if (_loc1_.objectId_ != GameServerConnectionConcrete.ignoredBag) {
						//addTextLine.dispatch(ChatMessage.make("", "Looting bag id "+_loc1_.objectId_));
						lootItem(nextAvailableInventorySlotMod(),_loc1_,_loc4_,_loc2_);
					}
                    return;
                }
                _loc4_ = _loc4_ + 1;
            }
        }
    }
	//LOOT END
	
    public function vault_():void { //monster function
		var i:int;
		var goCont:GameObject;
		var dist:int;
		var locDist:int;
		var cont:Container;
		var suitSlot:int = 0;
		for (i = 4; i < equipment_.length; i++) { //find first suitable slot
			if (!hasBackpack_ && i > 11) { //backpack check
				break;
			}
			else if (collect > 0 && equipment_[i] == -1) { //take, free slot
				suitSlot = i;
				break;
			}
			else if (collect < 0 && equipment_[i] == (0-collect)) { //put, slot with item
				suitSlot = i;
				break;
			}
			else if (collect == int.MIN_VALUE) { //potions
				switch (equipment_[i]) {
					case 0xa20:
					case 0xa1f:
					case 0xa21:
					case 0xa4c:
					case 0xa34:
					case 0xa35:
					case 0xae9:
					case 0xaea:
						suitSlot = i;
						break;
				}
			}
		}
		if (suitSlot == 0) { //no suitable slot
			collect = 0;
			notifyPlayer("Stopping", 0xff0000, 1500);
			return;
		}
		for each(goCont in map_.goDict_) { //find nearest chest
			if (goCont.objectType_ == VAULT_CHEST) {
				if (cont == null) {
					cont = (goCont as Container);
					dist = int((x_ -cont.x_) * (x_ -cont.x_) + (y_ -cont.y_) * (y_ -cont.y_));
				}
				else {
					locDist = int((x_ -goCont.x_) * (x_ -goCont.x_) + (y_ -goCont.y_) * (y_ -goCont.y_));
					if (locDist < dist) {
						dist = locDist;
						cont = (goCont as Container);
					}
				}
			}
		}
		if (cont == null) {
			return;
		}
		if (dist > MAX_LOOT_DIST) { //no chests near enough
			return;
		}
		for (i = 0; i < cont.equipment_.length; i++) {
			if (cont.equipment_[i] == collect) { //take
				map_.gs_.gsc_.invSwap(this, cont, i, cont.equipment_[i], this, suitSlot, equipment_[suitSlot]);
				lastLootTime = getTimer();
				return;
			}
			else if (cont.equipment_[i] == -1 && collect < 0) { //put
				map_.gs_.gsc_.invSwap(this, this, suitSlot, equipment_[suitSlot], cont, i, cont.equipment_[i]);
				lastLootTime = getTimer();
				return;
			}
			else if (collect == int.MAX_VALUE) { //potions
				switch (cont.equipment_[i]) {
					case 0xa20:
					case 0xa1f:
					case 0xa21:
					case 0xa4c:
					case 0xa34:
					case 0xa35:
					case 0xae9:
					case 0xaea:
						map_.gs_.gsc_.invSwap(this, cont, i, cont.equipment_[i], this, suitSlot, equipment_[suitSlot]);
						lastLootTime = getTimer();
						return;
				}
			}
		}
		collect = 0;
		notifyPlayer("Stopping", 0xff0000, 1500);
    }
	
	private function swapInvBp(slot:int):void {
		if (getTimer() >= nextSwap) {
			map_.gs_.gsc_.invSwap(this, this, slot + 4, equipment_[slot + 4], this, slot + 12, equipment_[slot + 12]);
			bools[slot] = false;
			nextSwap = getTimer() + 550;
		}
	}
	
	private function selectSlot(slot:TradeSlot):void {
		var i:int;
		var tradebools:Vector.<Boolean> = new <Boolean>[false,false,false,false];
		nextSelect = getTimer() + 175;
		slot.setIncluded(!slot.included_);
		for (i = 4; i < 12; i++) {
			tradebools[i] = map_.gs_.hudView.tradePanel.myInv_.slots_[i].included_;
		}
		map_.gs_.gsc_.changeTrade(tradebools);
		map_.gs_.hudView.tradePanel.tradeButton_.setState(0);
	}
	
	private function naturalize(i:int):TradeSlot {
		var vect:Vector.<int> = new <int>[4,8,5,9,6,10,7,11];
		return map_.gs_.hudView.tradePanel.myInv_.slots_[vect[i]];
	}
	
	private function findSlots():void {
		for (var j:int = 0; j < 8; j++) {
			var locPlayer2:Player = map_.player_;
			if (locPlayer2.equipment_[j+4] != locPlayer2.equipment_[j+12]) {
				bools[j] = true;
			}
		}
	}
	
	public function startTimer(count:int, step:int = 500):void { //uses milliseconds
		timerCount = 0;
		endCount = count;
		timerStep = step;
		startTime = getTimer();
	}

    override public function damage(_arg_1:int, _arg_2:int, _arg_3:Vector.<uint>, _arg_4:Boolean, _arg_5:Projectile):void {
		negateHealth(_arg_2);
        super.damage(_arg_1, _arg_2, _arg_3, false, _arg_5);
    }

    public function damageWithoutAck(amount:int):void {
		negateHealth(amount);
		showDamageText(amount, false);
		//if armor piercing bullets inflict an effect the color will not be correct
		//can be fixed by including projprops in parameters
    }
	
	public function negateHealth(amount:int):void {
		if (this == map_.player_) {
			chp -= amount;
			checkOPAuto();
		}
	}
	
	private function checkOPAuto():void {
        if (chp / maxHP_ * 100 <= 15) {
			addTextLine.dispatch(ChatMessage.make("", "You were saved at "+chp.toFixed(0)+" health"));
			map_.gs_.gsc_.escape(); //this uses a reconnect event, SENDING A REAL ESCAPE PACKET KILLS YOU
			if (opFailed) {
				addTextLine.dispatch(ChatMessage.make("*Error*", "Unable to find Nexus, disconnecting"));
				map_.gs_.closed.dispatch(); //disconnect
			}
			opFailed = true;
        }
	}
	
	public function getItemHp():int {
		var total:int = 0;
		var item:XML;
		var act:XML;
		for (var i:int = 0; i < 4; i++) {
			if (equipment_[i] == -1) {
				continue;
			}
			item = ObjectLibrary.xmlLibrary_[equipment_[i]];
			if (item.hasOwnProperty("ActivateOnEquip")) {
				for each (act in item.ActivateOnEquip) {
					if (act.@stat == 0) {
						total += act.@amount;
					}
				}
			}
		}
		return total;
	}
	
	public function checkAutonexus():void {
		if (this == map_.player_ && !map_.gs_.isSafeMap) {
			if (hp_ / maxHP_ * 100 <= Parameters.data_.AutoNexus)
			{
				map_.gs_.gsc_.escape();
			}
			if ((objectType_ == 784 || (objectType_ == 799 && !isHealing())) && hp_ / maxHP_ * 100 <= Parameters.data_.autoHealP && (!isSick() || equipment_[1] == 3081))
			{
				useAltWeapon(x_, y_, UseType.START_USE)
			}
			else if (hp_ / maxHP_ * 100 <= Parameters.data_.autoPot && !isSick()) {
				if (this.potionInventoryModel.getPotionModel(PotionInventoryModel.HEALTH_POTION_ID).available && lastPotionUse + 500 <= getTimer()) {
					this.useBuyPotionSignal.dispatch(new UseBuyPotionVO(PotionInventoryModel.HEALTH_POTION_ID, UseBuyPotionVO.CONTEXTBUY));
					lastPotionUse = getTimer();
				}
			}
		}
	}

    override public function update(_arg_1:int, _arg_2:int):Boolean {
		var i:int;
		if (this == map_.player_) {
			if (Parameters.data_.thunderMove && Parameters.data_.preferredServer == "Proxy" && getTimer() > thunderTime + 50) {
				thunderTime = getTimer();
				map_.gs_.gsc_.thunderMove(this);
			}
			if (vitTime != -1 && !isPaused()) {
				if (isBleeding()) { //no vit and -20 hp/s
					chp -= (getTimer() - vitTime) * 0.02;
				}
				else if (isSick()) {
					//do nothing
				}
				else if (isHealing()) { //vit + 20 hp/s
					chp += (getTimer() - vitTime) * Number((21 + 0.12 * vitality_) / 1000);
				}
				else { //vit
					chp += (getTimer() - vitTime) * Number((1 + 0.12 * vitality_) / 1000);
				}
				//drowning
				if (breath_ == 0) { //other effects and -94 hp/s
					chp -= (getTimer() - vitTime) * 0.094;
				}
				//save from DoT
				checkOPAuto();
				//stop overflow
				if (chp > maxHP_) {
					chp = maxHP_;
				}
			}
			vitTime = getTimer();
			var qid:int = -1; 
			if (map_.quest_.getObject(1) != null) { //questbar id prerequisite
				var qob:GameObject = map_.quest_.getObject(1);
				qid = qob.objectType_;
				if (qid == 3334 && Parameters.data_.autoSprite) { //limon
					onGoto(qob.x_, qob.y_ + 2, map_.gs_.lastUpdate_);
				}
			}
			if (qid != 3366 && qid != 3367 && qid != 3368) { //questbar mod set
				questMob = qob;
			}
			else {
				questMob = null;
			}
			if (map_.gs_.gsc_.oncd && getTimer() >= nextTeleportAt_) { //teleport timer
				map_.gs_.gsc_.retryTeleport();
			}
			if (remBuff.length > 0 && getTimer() >= remBuff[remBuff.length - 1]) { //remove paladin buff
				//var mhpboost:int = maxHPBoost_;
				var itemhp:int = getItemHp();
				if (itemhp != cmaxhpboost && !isHpBoosted()) {
					cmaxhp -= cmaxhpboost - itemhp;
					cmaxhpboost = itemhp;
				}
				/*if (itemhp != mhpboost && !isHpBoosted()) {
					maxHP_ -= mhpboost - itemhp;
					maxHPBoost_ = itemhp;
				}*/
				remBuff.pop();
			}
			if (vitTime >= sendStr) { //vittime is used as getTimer()
				map_.gs_.gsc_.playerText(afkMsg);
				sendStr = int.MAX_VALUE;
			}
			if (wantedList == null) //autoloot wanted list
			{
				wantedList = genWantedList();
			}
			if (Parameters.data_.AutoLootOn && lookForLoot()) //autoloot
			{
				autoloot_();
			}
			if (collect != 0 && map_.name_ == "Vault" && lastLootTime + 750 < getTimer()) //fast vaulting, higher delay
			{
				vault_();
			}
			if (ParseChatMessageCommand.switch_) //selects all the slots that need to be swapped
			{
				findSlots();
				ParseChatMessageCommand.switch_ = false;
			}
			if (select_ != -1 && getTimer() >= nextSelect) {
				for (i = loopStart; i < 12; i++) { //trade slot selector
					var slot:TradeSlot = naturalize(i-4);
					if (slot.item_ == select_) {
						selectSlot(slot);
						loopStart = i + 1;
						if (i != 11) {
							break;
						}
					}
					if (i == 11) {
						select_ = -1;
						loopStart = 4;
					}
				}
			}
			for (i = 0; i < 8; i++) { //swap command slot swapper
				if (bools[i]) {
					swapInvBp(i);
					break;
				}
			}
			var p:Player = map_.player_;
			if (lastLootTime + 550 < getTimer()) {
				if (p.healthPotionCount_ < 6) {
					var hasPotinInv:int = p.getSlotwithItem(2594);
					if (hasPotinInv != -1) {
						map_.gs_.gsc_.invSwapPotion(p,p,hasPotinInv,2594,p,254,-1);
						lastLootTime = getTimer();
					}
				}
				/*else if (p.magicPotionCount_ < 6) {
					var hasPotinInv:int = p.getSlotwithItem(2595);
					if (hasPotinInv != -1) {
						gsc.invSwapPotion(p,p,hasPotinInv,2595,p,255,-1);
						lastLootTime = getTimer();
					}
				}*/
			}
			//for 5.5 second timer ticking every 0.5s use step=500 count=5500/500=11
			if (timerCount <= endCount && startTime + timerStep * timerCount <= getTimer()) { //timer
				//notifyPlayer((getTimer() - (startTime + timerStep * timerCount)).toString(), 0x00ff00); //tests latency
				var end:int = endCount * timerStep;
				var cur:int = timerCount * timerStep;
				var time:Number = (end - cur) / 1000;
				if (int(end / 60000) > 0) {
					var secs:Number = (time % 60);
					var secstr:String = secs.toFixed(timerStep < 1000 ? 1 : 0);
					notifyPlayer(int(time / 60).toString()+":"+(secs < 10 ? "0"+secstr : secstr), GameObject.green2red(100 - (cur / end) * 100));
				}
				else {
					notifyPlayer(time.toFixed(timerStep < 1000 ? 1 : 0), GameObject.green2red(100 - (cur / end) * 100));
				}
				timerCount++;
			}
			if (mapAutoAbil && nextAutoAbil <= getTimer()) {
				var abilFreq:int = 0;
				var wismod:Number = 1 + wisdom_ / 150;
				switch(equipment_[1]) {
					case 0xb27: //ghostly
					case 0xae1: //twi
					case 0x21a2: //drape
					//case 0xa5a: //plane
						abilFreq = 6500;
						break;
					case 0xb29: //ggen
					case 0xa6b: //ghelm
						abilFreq = 7000;
						break;
					case 0xc08: //jugg
						abilFreq = 6000;
						break;
					case 0xb26: //gcookie
					case 0xa55: //zseal
						if (Parameters.data_.palaSpam) {
							abilFreq = 500;
						}
						else {
							abilFreq = 4000 * wismod - 200;
						}
						break;
					case 0xc1e: //prot
					case 0x16de: //ice prot
						abilFreq = 4000 * wismod - 200;
						break;
				}
				if (abilFreq > 0) {
					useAltWeapon(x_, y_, UseType.START_USE, abilFreq)
				}
			}
		}
        var _local_3:Number;
        var _local_4:Number;
        var _local_5:Number;
        var _local_6:Vector3D;
        var _local_7:Number;
        var _local_8:int;
        var _local_9:Vector.<uint>;
        if (((this.tierBoost) && (!(isPaused())))) {
            this.tierBoost = (this.tierBoost - _arg_2);
            if (this.tierBoost < 0) {
                this.tierBoost = 0;
            }
        }
        if (((this.dropBoost) && (!(isPaused())))) {
            this.dropBoost = (this.dropBoost - _arg_2);
            if (this.dropBoost < 0) {
                this.dropBoost = 0;
            }
        }
        if (((this.xpTimer) && (!(isPaused())))) {
            this.xpTimer = (this.xpTimer - _arg_2);
            if (this.xpTimer < 0) {
                this.xpTimer = 0;
            }
        }
        if (((isHealing()) && (!(isPaused())))) { //healing
            if (!Parameters.data_.AntiLag && this.healingEffect_ == null) {
                this.healingEffect_ = new HealingEffect(this);
                map_.addObj(this.healingEffect_, x_, y_);
            }
        }
        else {
            if (this.healingEffect_ != null) {
                map_.removeObj(this.healingEffect_.objectId_);
                this.healingEffect_ = null;
            }
        }
        if ((((map_.player_ == this)) && (isPaused()))) {
            return (true);
        }
		//movement
        if (this.relMoveVec_ != null) {
            _local_3 = Parameters.data_.cameraAngle;
            if (this.rotate_ != 0) {
                _local_3 = (_local_3 + ((_arg_2 * Parameters.PLAYER_ROTATE_SPEED) * this.rotate_));
                Parameters.data_.cameraAngle = _local_3;
            }
			_local_4 = this.getMoveSpeed();
			/*
            float angle = (float)Math.Atan2(target.Y - start.Y, target.X - start.X);
            if (angle < 0)
                angle += (float)Math.PI * 2;*/
			if (followTarget != null) {
				_local_5 = (followTarget.y_ - y_) * (followTarget.y_ - y_) + (followTarget.x_ - x_) * (followTarget.x_ - x_);
				if (_local_5 < 0.1) { //make smaller?
                    moveVec_.x = 0;
                    moveVec_.y = 0;
				}
				else {
					_local_5 = Math.atan2(followTarget.y_ - y_, followTarget.x_ - x_); //angle
					moveVec_.x = _local_4 * Math.cos(_local_5);
					moveVec_.y = _local_4 * Math.sin(_local_5);
				}
			}
            else if (this.relMoveVec_.x != 0 || this.relMoveVec_.y != 0) {
                _local_5 = Math.atan2(this.relMoveVec_.y, this.relMoveVec_.x);
                if (square_.props_.slideAmount_ > 0 && Parameters.data_.slideOnIce) { //ice sliding, makes it harder to gain speed
                    _local_6 = new Vector3D();
                    _local_6.x = (_local_4 * Math.cos((_local_3 + _local_5)));
                    _local_6.y = (_local_4 * Math.sin((_local_3 + _local_5)));
                    _local_6.z = 0;
                    _local_7 = _local_6.length;
                    _local_6.scaleBy((-1 * (square_.props_.slideAmount_ - 1)));
                    moveVec_.scaleBy(square_.props_.slideAmount_);
                    if (moveVec_.length < _local_7) {
                        moveVec_ = moveVec_.add(_local_6);
                    }
                }
                else {
					//default move vec
                    moveVec_.x = _local_4 * Math.cos(_local_3 + _local_5);
                    moveVec_.y = _local_4 * Math.sin(_local_3 + _local_5);
                }
            }
            else {
                if (moveVec_.length > 0.00012 && square_.props_.slideAmount_ > 0 && Parameters.data_.slideOnIce) { //ice sliding, makes it harder to stop
                    moveVec_.scaleBy(square_.props_.slideAmount_);
                }
                else {
					//default move vec
                    moveVec_.x = 0;
                    moveVec_.y = 0;
                }
            }
            if (square_ != null && square_.props_.push_) {
                if (Parameters.data_.SWNoTileMove == false) {
					moveVec_.x = (moveVec_.x - (square_.props_.animate_.dx_ / 1000));
					moveVec_.y = (moveVec_.y - (square_.props_.animate_.dy_ / 1000));
                }
            }
            this.walkTo((x_ + (_arg_2 * moveVec_.x)), (y_ + (_arg_2 * moveVec_.y)));
        }
        else {
            if (!super.update(_arg_1, _arg_2)) {
                return (false);
            }
        }
		if (map_.player_ == this && square_.props_.maxDamage_ > 0 && square_.lastDamage_ + 500 < _arg_1 && !isInvincible() && (square_.obj_ == null || !square_.obj_.props_.protectFromGroundDamage_)) {
            _local_8 = map_.gs_.gsc_.getNextDamage(square_.props_.minDamage_, square_.props_.maxDamage_);
            _local_9 = new Vector.<uint>();
            _local_9.push(ConditionEffect.GROUND_DAMAGE);
            damage(-1, _local_8, _local_9, hp_ < _local_8, null);
            map_.gs_.gsc_.groundDamage(_arg_1, x_, y_);
            square_.lastDamage_ = _arg_1;
        }
		//checkAutonexus(); //unnecessary?
        return true;
    }

    public function onMove():void {
        if (map_ == null) {
            return;
        }
        var _local_1:Square = map_.getSquare(x_, y_);
        if (_local_1.props_.sinking_) {
			sinkLevel_ = Math.min((sinkLevel_ + 1), Parameters.MAX_SINK_LEVEL);
			this.moveMultiplier_ = (0.1 + ((1 - (sinkLevel_ / Parameters.MAX_SINK_LEVEL)) * (_local_1.props_.speed_ - 0.1)));
        }
        else {
            sinkLevel_ = 0;
            this.moveMultiplier_ = _local_1.props_.speed_;
        }
        if (Parameters.data_.SWSpeed && map_.name_ == "Sprite World") {
			if (!mapLightSpeed && Parameters.data_.SWLight) {
				moveMultiplier_ = 5;
			}
			else {
				moveMultiplier_ = 1.4;
			}
        }
		//if (mapLightSpeed) moveMultiplier_ = 1.5; //speedhack, disabled for now
    }

    override protected function makeNameBitmapData():BitmapData {
        var _local_1:StringBuilder = new StaticStringBuilder(name_);
        var _local_2:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
        var _local_3:BitmapData = _local_2.make(_local_1, 16, this.getNameColor(), true, NAME_OFFSET_MATRIX, true);
		
        //var _local_2:StringBuilder = new PortalNameParser().makeBuilder("testytestjtestgtest");
        //var _local_3:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
        //return (_local_3.make(_local_2, 16, 0xFFFFFF, true, IDENTITY_MATRIX, true));
		
        _local_3.draw(FameUtil.numStarsToIcon(this.numStars_), RANK_OFFSET_MATRIX);
        return (_local_3);
    }

    private function getNameColor():uint { //name under the player
        if (this.isFellowGuild_) {
            return (Parameters.FELLOW_GUILD_COLOR);
        }
        if (Parameters.data_.lockHighlight && starred_) {
			return 4240365;
        }
        if (this.nameChosen_) {
            return (Parameters.NAME_CHOSEN_COLOR);
        }
        return 0xFFFFFF;
    }

    protected function drawBreathBar(_arg_1:Vector.<IGraphicsData>, _arg_2:int):void {
        var _local_7:Number;
        var _local_8:Number;
        if (this.breathPath_ == null) {
            this.breathBackFill_ = new GraphicsSolidFill();
            this.breathBackPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
            this.breathFill_ = new GraphicsSolidFill(2542335);
            this.breathPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
        }
        if (this.breath_ <= Parameters.BREATH_THRESH) {
            _local_7 = ((Parameters.BREATH_THRESH - this.breath_) / Parameters.BREATH_THRESH);
            this.breathBackFill_.color = MoreColorUtil.lerpColor(0x545454, 0xFF0000, (Math.abs(Math.sin((_arg_2 / 300))) * _local_7));
        }
        else {
            this.breathBackFill_.color = 0x545454;
        }
        var _local_3:int = 20;
        var _local_4:int = 8;
        var _local_5:int = 6;
        var _local_6:Vector.<Number> = (this.breathBackPath_.data as Vector.<Number>);
        _local_6.length = 0;
        _local_6.push((posS_[0] - _local_3), (posS_[1] + _local_4), (posS_[0] + _local_3), (posS_[1] + _local_4), (posS_[0] + _local_3), ((posS_[1] + _local_4) + _local_5), (posS_[0] - _local_3), ((posS_[1] + _local_4) + _local_5));
        _arg_1.push(this.breathBackFill_);
        _arg_1.push(this.breathBackPath_);
        _arg_1.push(GraphicsUtil.END_FILL);
        if (this.breath_ > 0) {
            _local_8 = (((this.breath_ / 100) * 2) * _local_3);
            this.breathPath_.data.length = 0;
            _local_6 = (this.breathPath_.data as Vector.<Number>);
            _local_6.length = 0;
            _local_6.push((posS_[0] - _local_3), (posS_[1] + _local_4), ((posS_[0] - _local_3) + _local_8), (posS_[1] + _local_4), ((posS_[0] - _local_3) + _local_8), ((posS_[1] + _local_4) + _local_5), (posS_[0] - _local_3), ((posS_[1] + _local_4) + _local_5));
            _arg_1.push(this.breathFill_);
            _arg_1.push(this.breathPath_);
            _arg_1.push(GraphicsUtil.END_FILL);
        }
        GraphicsFillExtra.setSoftwareDrawSolid(this.breathFill_, true);
        GraphicsFillExtra.setSoftwareDrawSolid(this.breathBackFill_, true);
    }

    override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
		if (Parameters.data_.HidePlayerFilter && map_.name_ == "Nexus" && this != map_.player_) {
			if (numStars_ <= Parameters.data_.chatStarRequirement) {
				return;
			}
        }
        super.draw(_arg_1, _arg_2, _arg_3);
        if (this != map_.player_) {
            if (!Parameters.screenShotMode_) {
                drawName(_arg_1, _arg_2);
            }
        }
        else {
            if (this.breath_ >= 0) {
                this.drawBreathBar(_arg_1, _arg_3);
            }
        }
    }

    private function getMoveSpeed():Number {
        if (isSlowed()) {
            return ((MIN_MOVE_SPEED * this.moveMultiplier_));
        }
        var _local_1:Number = (MIN_MOVE_SPEED + ((this.speed_ / 75) * (MAX_MOVE_SPEED - MIN_MOVE_SPEED)));
        if (!Parameters.data_.speedy && (isSpeedy() || isNinjaSpeedy())) {
            _local_1 = (_local_1 * 1.5);
        }
        return (_local_1 * this.moveMultiplier_);
    }

    public function attackFrequency():Number {
        if (isDazed()) {
            return (MIN_ATTACK_FREQ);
        }
        var _local_1:Number = (MIN_ATTACK_FREQ + ((this.dexterity_ / 75) * (MAX_ATTACK_FREQ - MIN_ATTACK_FREQ)));
        if (isBerserk()) {
            _local_1 = (_local_1 * 1.5);
        }
        return (_local_1);
    }

    private function attackMultiplier():Number {
        if (isWeak()) {
            return (MIN_ATTACK_MULT);
        }
        var _local_1:Number = (MIN_ATTACK_MULT + ((this.attack_ / 75) * (MAX_ATTACK_MULT - MIN_ATTACK_MULT)));
        if (isDamaging()) {
            _local_1 = (_local_1 * 1.5);
        }
        return (_local_1);
    }

    private function makeSkinTexture():void {
        var _local_1:MaskedImage = this.skin.imageFromAngle(0, AnimatedChar.STAND, 0);
        animatedChar_ = this.skin;
        texture_ = _local_1.image_;
        mask_ = _local_1.mask_;
        this.isDefaultAnimatedChar = true;
    }

    private function setToRandomAnimatedCharacter():void {
        var _local_1:Vector.<XML> = ObjectLibrary.hexTransforms_;
        var _local_2:uint = Math.floor((Math.random() * _local_1.length));
        var _local_3:int = int(_local_1[_local_2].@type);
        var _local_4:TextureData = ObjectLibrary.typeToTextureData_[_local_3];
        texture_ = _local_4.texture_;
        mask_ = _local_4.mask_;
        animatedChar_ = _local_4.animatedChar_;
        this.isDefaultAnimatedChar = false;
    }

    override protected function getTexture(_arg_1:Camera, _arg_2:int):BitmapData {
        var _local_5:MaskedImage;
        var _local_10:int;
        var _local_11:Dictionary;
        var _local_12:Number;
        var _local_13:int;
        var _local_14:ColorTransform;
        var _local_3:Number = 0;
        var _local_4:int = AnimatedChar.STAND;
        if (((this.isShooting) || ((_arg_2 < (attackStart_ + this.attackPeriod_))))) {
            facing_ = attackAngle_;
            _local_3 = (((_arg_2 - attackStart_) % this.attackPeriod_) / this.attackPeriod_);
            _local_4 = AnimatedChar.ATTACK;
        }
        else {
            if (((!((moveVec_.x == 0))) || (!((moveVec_.y == 0))))) {
                _local_10 = (3.5 / this.getMoveSpeed());
                if (((!((moveVec_.y == 0))) || (!((moveVec_.x == 0))))) {
                    facing_ = Math.atan2(moveVec_.y, moveVec_.x);
                }
                _local_3 = ((_arg_2 % _local_10) / _local_10);
                _local_4 = AnimatedChar.WALK;
            }
        }
        if (this.isHexed()) {
            ((this.isDefaultAnimatedChar) && (this.setToRandomAnimatedCharacter()));
        }
        else {
            if (!this.isDefaultAnimatedChar) {
                this.makeSkinTexture();
            }
        }
        if (_arg_1.isHallucinating_) {
            _local_5 = new MaskedImage(getHallucinatingTexture(), null);
        }
        else {
            _local_5 = animatedChar_.imageFromFacing(facing_, _arg_1, _local_4, _local_3);
        }
        var _local_6:int = tex1Id_;
        var _local_7:int = tex2Id_;
        var _local_8:BitmapData;
        if (this.nearestMerchant_) {
            _local_11 = texturingCache_[this.nearestMerchant_];
            if (_local_11 == null) {
                texturingCache_[this.nearestMerchant_] = new Dictionary();
            }
            else {
                _local_8 = _local_11[_local_5];
            }
            _local_6 = this.nearestMerchant_.getTex1Id(tex1Id_);
            _local_7 = this.nearestMerchant_.getTex2Id(tex2Id_);
        }
        else {
            _local_8 = texturingCache_[_local_5];
        }
        if (_local_8 == null) {
            _local_8 = TextureRedrawer.resize(_local_5.image_, _local_5.mask_, size_, false, _local_6, _local_7);
            if (this.nearestMerchant_ != null) {
                texturingCache_[this.nearestMerchant_][_local_5] = _local_8;
            }
            else {
                texturingCache_[_local_5] = _local_8;
            }
        }
        if (hp_ < (maxHP_ * 0.2)) {
            _local_12 = (int((Math.abs(Math.sin((_arg_2 / 200))) * 10)) / 10);
            _local_13 = 128;
            _local_14 = new ColorTransform(1, 1, 1, 1, (_local_12 * _local_13), (-(_local_12) * _local_13), (-(_local_12) * _local_13));
            _local_8 = CachingColorTransformer.transformBitmapData(_local_8, _local_14);
        }
        var _local_9:BitmapData = texturingCache_[_local_8];
        if (_local_9 == null) {
            _local_9 = GlowRedrawer.outlineGlow(_local_8, (((this.legendaryRank_ == -1)) ? 0 : 0xFF0000));
            texturingCache_[_local_8] = _local_9;
        }
        if (((((isPaused()) || (isStasis()))) || (isPetrified()))) {
            _local_9 = CachingColorTransformer.filterBitmapData(_local_9, PAUSED_FILTER);
        }
        else {
            if (isInvisible()) {
                _local_9 = CachingColorTransformer.alphaBitmapData(_local_9, 0.4);
            }
        }
        return (_local_9);
    }

    override public function getPortrait():BitmapData {
        var _local_1:MaskedImage;
        var _local_2:int;
        if (portrait_ == null) {
            _local_1 = animatedChar_.imageFromDir(AnimatedChar.RIGHT, AnimatedChar.STAND, 0);
            _local_2 = ((4 / _local_1.image_.width) * 100);
            portrait_ = TextureRedrawer.resize(_local_1.image_, _local_1.mask_, _local_2, true, tex1Id_, tex2Id_);
            portrait_ = GlowRedrawer.outlineGlow(portrait_, 0);
        }
        return (portrait_);
    }

    public function useAltWeapon(_arg_1:Number, _arg_2:Number, _arg_3:int, abFreq:int = 0):Boolean {
        var _local_7:XML;
        var abilUseTime:int;
        var shootAngle:Number;
        var _local_10:int;
        var _local_11:int;
		var _local_6:Point;
        if (map_ == null || isPaused()) {
            return false;
        }
        var useItemId:int = equipment_[1];
        if (useItemId == -1) {
            return false;
        }
        var thisAbilXML:XML = ObjectLibrary.xmlLibrary_[useItemId];
		if (int(thisAbilXML.MpCost) > mp_) { //this is here for auto ability
			return false;
		}
		if (Parameters.data_.inaccurate) {
			_local_6 = pSTopW(_arg_1, _arg_2);
		}
		else {
			_local_6 = sToW(_arg_1, _arg_2); //allows using ability outside of the map
		}
        if (_local_6 == null) {
            SoundEffectLibrary.play("error");
            return (false);
        }
        for each (_local_7 in thisAbilXML.Activate) {
            if (_local_7.toString() == ActivationType.TELEPORT && !Parameters.data_.spellVoid) {
                if (!this.isValidPosition(_local_6.x, _local_6.y)) { //trickster tp through wall
                    SoundEffectLibrary.play("error");
                    return (false);
                }
            }
        }
        abilUseTime = getTimer();
        if (_arg_3 == UseType.START_USE) {
            if (abilUseTime < this.nextAltAttack_) { //on cooldown
                SoundEffectLibrary.play("error");
                return (false);
            }
			if (abFreq > 0) {
				nextAutoAbil = getTimer() + abFreq;
			}
            _local_11 = 500; //base cooldown
            if (thisAbilXML.hasOwnProperty("Cooldown")) {
                _local_11 = (Number(thisAbilXML.Cooldown) * 1000);
            }
            //addTextLine.dispatch(ChatMessage.make("", "Cooldown for item "+thisAbilXML.@id+" is "+_local_11+" milliseconds"));
            nextAltAttack_ = abilUseTime + _local_11;
			lastAltAttack_ = abilUseTime;
			//usetime, playerid, slotid, objecttype, useposx, useposy, usetype
            map_.gs_.gsc_.useItem(abilUseTime, objectId_, 1, useItemId, _local_6.x, _local_6.y, _arg_3);
            if (thisAbilXML.Activate == ActivationType.SHOOT) {
                shootAngle = Math.atan2(_arg_2, _arg_1);
				/*var coordtest:Number = Math.atan2(_local_6.y - y_, _local_6.x - x_);
				trace("1 deg "+(180/Math.PI*shootAngle)+" rad "+shootAngle);
				trace("2 deg " + (180 / Math.PI * coordtest) + " rad " + coordtest);
				trace(_local_6.x+" "+_local_6.y);*/
				//arrows and shields
                this.doShoot(abilUseTime, useItemId, thisAbilXML, (Parameters.data_.cameraAngle + shootAngle), false);
            }
			//cloak timer, now ability timer
			if (Parameters.data_.abilTimer) {
				var wismod:Number = 1 + wisdom_ / 150;
				switch (equipment_[1]) {
					case 0xa5a: //plane
					case 0x21a2: //drape
					case 0xae1: //twi
					case 0xb27: //ghostly
						startTimer(11); //5.5
						break;
					case 0xc08: //jugg
						startTimer(9); //4.5
						break;
					case 0xb29: //ggen
					case 0xa6b: //ghelm
						startTimer(12); //6.0
						break;
					case 0xc06: //oreo
						startTimer(int(10*wismod));
						break;
					case 0xb26: //gcookie
					case 0xa55: //zseal
					case 0xc1e: //prot
					case 0x16de: //ice prot
						startTimer(int(8*wismod));
						break;
			}
			}
        }
        else {
            if (thisAbilXML.hasOwnProperty("MultiPhase")) { //ninja speed
                map_.gs_.gsc_.useItem(abilUseTime, objectId_, 1, useItemId, _local_6.x, _local_6.y, _arg_3);
                _local_10 = int(thisAbilXML.MpEndCost);
                if (_local_10 <= this.mp_) {
                    shootAngle = Math.atan2(_arg_2, _arg_1);
                    this.doShoot(abilUseTime, useItemId, thisAbilXML, (Parameters.data_.cameraAngle + shootAngle), false);
                }
            }
        }
        return (true);
    }

    public function attemptAttackAngle(_arg_1:Number):void { //this is used to shoot
        //this.shoot((Parameters.data_.cameraAngle + _arg_1));
		aim_(_arg_1);
    }
    
	//AIM BEGIN
    public function autoAim_(param1:Vector3D, param2:Vector3D, param3:ProjectileProperties) : Vector3D {
        var _loc4_:Vector3D;
        var _loc5_:GameObject;
        var _loc6_:Boolean = false;
        var _loc7_:int = 0;
        var _loc8_:Boolean = false;
        var _loc9_:Vector3D;
        var _loc10_:* = undefined;
        var _loc11_:Number;
        var _loc12_:Number;
        var _loc13_:int = Parameters.data_.aimMode;
        var _loc14_:Number = param3.speed_ / 10000;
        var _loc15_:Number = _loc14_ * param3.lifetime_ + (Parameters.data_.AAAddOne ? 0.5 : 0);
        var _loc16_:Number = 0;
        var _loc17_:Number = int.MAX_VALUE;
        var _loc18_:Number = int.MAX_VALUE;
        var i:int;
        aimAssistTarget = null;
        for each(_loc5_ in map_.goDict_) {
            if (_loc5_.props_.isEnemy_) {
                _loc6_ = false;
				for each(_loc7_ in Parameters.data_.AAException) { //get exceptions
					if (_loc7_ == _loc5_.props_.type_) {
						_loc6_ = true;
						break;
					}
				}
				if (!Parameters.data_.tombHack && _loc5_.props_.type_ >= 3366 && _loc5_.props_.type_ <= 3368) { //tomb hack off -> don't shoot shielded bosses
					_loc6_ = false;
				}
                if (_loc6_ || _loc5_ is Character) {
                    if (!(!_loc6_ && (_loc5_.isStasis() || _loc5_.isInvulnerable() || _loc5_.isInvincible()))) {
                        _loc8_ = false;
                        for each(_loc7_ in Parameters.data_.AAIgnore) {
                            if (_loc7_ == _loc5_.props_.type_) {
                                _loc8_ = true;
                                break;
                            }
                        }
                        if (!_loc8_) {
                            if (_loc5_.jittery || !Parameters.data_.AATargetLead || _loc5_.objectType_ == 3334) {
                                _loc9_ = new Vector3D(_loc5_.x_,_loc5_.y_);
                            }
                            else {
                                _loc9_ = leadPos(param1,new Vector3D(_loc5_.x_,_loc5_.y_),new Vector3D(_loc5_.moveVec_.x,_loc5_.moveVec_.y),_loc14_);
                            }
                            if (_loc9_ != null) {
                                _loc10_ = getDist(param1.x,param1.y,_loc9_.x,_loc9_.y);
                                if (_loc10_ <= _loc15_) {
                                    if(_loc13_ == 1) { //aimmode: highest hp
                                        _loc12_ = _loc5_.maxHP_;
										switch (_loc5_.objectType_) {
											case 1625: //ghost god
												_loc12_ = 3000;
											case 3369: //sarc
												_loc12_ = 7500;
											case 3371: //fem priest
												_loc12_ = 8000;
										}
										for each(i in Parameters.data_.AAPriority) { //prioritize list
											if (i == _loc5_.objectType_) {
												_loc12_ = int.MAX_VALUE;
											}
										}
										if (Parameters.data_.tombHack && ((_loc5_.objectType_ >= 3366 && _loc5_.objectType_ <= 3368) || (_loc5_.objectType_ >= 32692 && _loc5_.objectType_ <= 32694))) { //tomb bosses
											if (_loc5_.objectType_ != Parameters.data_.curBoss && _loc5_.objectType_ != Parameters.data_.curBoss + 29326) {
												//_loc12_ = 10000;
												continue;
											}
										}
                                        if (_loc12_ >= _loc16_) {
                                            if (_loc12_ == _loc16_) {
                                                if (_loc5_.hp_ > _loc17_) {
                                                    continue;
                                                }
                                                if (_loc5_.hp_ == _loc17_ && _loc10_ > _loc18_) {
                                                    continue;
                                                }
                                                _loc17_ = _loc5_.hp_;
                                                _loc4_ = _loc9_;
                                                _loc18_ = _loc10_;
                                                aimAssistTarget = _loc5_;
                                            }
                                            else {
                                                _loc4_ = _loc9_;
                                                _loc17_ = _loc5_.hp_;
                                                _loc16_ = _loc12_;
                                                _loc18_ = _loc10_;
                                                aimAssistTarget = _loc5_;
                                            }
                                        }
                                    }
                                    else if (_loc13_ == 2) { //aimmode: closest
                                        if (_loc10_ < _loc18_) {
                                            _loc4_ = _loc9_;
                                            _loc17_ = _loc5_.hp_;
                                            _loc16_ = _loc5_.maxHP_;
                                            _loc18_ = _loc10_;
                                            aimAssistTarget = _loc5_;
                                        }
                                    }
                                    else { //aimmode: closest to cursor
                                        _loc11_ = Parameters.data_.AABoundingDist;
                                        _loc10_ = getDist(param2.x,param2.y,_loc5_.x_,_loc5_.y_);
                                        if (Math.abs(param2.x - _loc9_.x) <= _loc11_ && Math.abs(param2.y - _loc9_.y) <= _loc11_) {
                                            if (_loc10_ <= _loc18_) {
                                                _loc4_ = _loc9_;
                                                _loc17_ = _loc5_.hp_;
                                                _loc16_ = _loc5_.maxHP_;
                                                _loc18_ = _loc10_;
                                                aimAssistTarget = _loc5_;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return _loc4_;
    }
    
    public function getDist(param1:Number, param2:Number, param3:Number, param4:Number):Number {
        var _loc5_:* = param1 - param3;
        var _loc6_:* = param2 - param4;
        return Math.sqrt(_loc6_ * _loc6_ + _loc5_ * _loc5_);
    }
    
    public function leadPos(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Number):Vector3D {
        var _loc5_:Vector3D = param2.subtract(param1);
        var _loc6_:* = param3.dotProduct(param3) - param4 * param4;
        var _loc7_:* = 2 * _loc5_.dotProduct(param3);
        var _loc8_:* = _loc5_.dotProduct(_loc5_);
        var _loc9_:* = (-_loc7_ + Math.sqrt(_loc7_ * _loc7_ - 4 * _loc6_ * _loc8_)) / (2 * _loc6_);
        var _loc10_:* = (-_loc7_ - Math.sqrt(_loc7_ * _loc7_ - 4 * _loc6_ * _loc8_)) / (2 * _loc6_);
        if (_loc9_ < _loc10_ && _loc9_ >= 0) {
            param3.scaleBy(_loc9_);
        }
        else if (_loc10_ >= 0) {
            param3.scaleBy(_loc10_);
        }
        else {
            return null;
        }
        return param2.add(param3);
    }
    
    public function getAimAngle():Number {
        var _loc1_:Vector3D = null;
        var _loc2_:Vector3D = null;
        var _loc3_:Point = null;
        var _loc4_:ProjectileProperties = null;
        var _loc5_:Vector3D = null;
        _loc3_ = sToW(map_.mouseX,map_.mouseY);
        if(_loc3_ == null)
        {
            _loc3_ = new Point(x_,y_);
        }
        _loc2_ = new Vector3D(_loc3_.x,_loc3_.y);
        _loc1_ = new Vector3D(x_,y_);
        _loc4_ = ObjectLibrary.propsLibrary_[equipment_[0]].projectiles_[0];
        aimAssistPoint = autoAim_(_loc1_,_loc2_,_loc4_);
        if(aimAssistPoint != null)
        {
            return Math.atan2(aimAssistPoint.y - y_,aimAssistPoint.x - x_);
        }
        return Number.MAX_VALUE;
    }
    
	public function pSTopW(param1:Number, param2:Number):Point { //inaccurate
		var po:Point = sToW(param1, param2);
		po.x = int(po.x) + 1 / 2;
		po.y = int(po.y) + 1 / 2;
		return po;
	}
	
    public function sToW(param1:Number, param2:Number):Point { //accurate
        var _loc3_:* = Parameters.data_.cameraAngle;
        var _loc4_:* = Math.cos(_loc3_);
        var _loc5_:* = Math.sin(_loc3_);
        param1 = param1 / 50.5;
        param2 = param2 / 50.5;
        var _loc6_:* = param1 * _loc4_ - param2 * _loc5_;
        var _loc7_:* = param1 * _loc5_ + param2 * _loc4_;
        return new Point(map_.player_.x_ + _loc6_,map_.player_.y_ + _loc7_);
    }
    
    public function aim_(param1:Number) : void
    {
        var _loc5_:Number = NaN;
        var _loc2_:Boolean = map_.gs_.mui_.mouseDown_;
        var _loc3_:Boolean = map_.gs_.mui_.autofire_;
        var _loc4_:Boolean = Parameters.data_.AAOn;
        if(_loc4_ && !_loc2_)
        {
            _loc5_ = getAimAngle();
            if(_loc5_ != Number.MAX_VALUE && !isUnstable())
            {
                shoot(_loc5_);
                isShooting = false;
                return;
            }
            if(!_loc3_)
            {
                return;
            }
        }
        shoot(Parameters.data_.cameraAngle + param1);
    }
    
    public function hasWeapon() : Boolean
    {
        var _loc1_:int = equipment_[0];
        if(_loc1_ == -1)
        {
            return false;
        }
        return true;
    }
	//AIM END

    override public function setAttack(_arg_1:int, _arg_2:Number):void {
        var _local_3:XML = ObjectLibrary.xmlLibrary_[_arg_1];
        if ((((_local_3 == null)) || (!(_local_3.hasOwnProperty("RateOfFire"))))) {
            return;
        }
        var _local_4:Number = Number(_local_3.RateOfFire);
        this.attackPeriod_ = ((1 / this.attackFrequency()) * (1 / _local_4));
        super.setAttack(_arg_1, _arg_2);
    }

    private function shoot(_arg_1:Number):void {
        if ((((((((map_ == null)) || (isStunned()))) || (isPaused()))) || (isPetrified()))) {
            return;
        }
        var _local_2:int = equipment_[0];
        if (_local_2 == -1) {
            this.addTextLine.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME, TextKey.PLAYER_NO_WEAPON_EQUIPPED));
            return;
        }
        var _local_3:XML = ObjectLibrary.xmlLibrary_[_local_2];
        var _local_4:int = getTimer();
        var _local_5:Number = Number(_local_3.RateOfFire);
        this.attackPeriod_ = ((1 / this.attackFrequency()) * (1 / _local_5));
        if (_local_4 < (attackStart_ + this.attackPeriod_)) {
            return;
        }
        doneAction(map_.gs_, Tutorial.ATTACK_ACTION);
        attackAngle_ = _arg_1;
        attackStart_ = _local_4;
        this.doShoot(attackStart_, _local_2, _local_3, attackAngle_, true);
    }

    public function doShoot(_arg_1:int, _arg_2:int, _arg_3:XML, _arg_4:Number, _arg_5:Boolean):void {
        var _local_11:uint;
        var _local_12:Projectile;
        var _local_13:int;
        var _local_14:int;
        var _local_15:Number;
        var _local_16:int;
        var _local_6:int = ((_arg_3.hasOwnProperty("NumProjectiles")) ? int(_arg_3.NumProjectiles) : 1);
        var _local_7:Number = (((_arg_3.hasOwnProperty("ArcGap")) ? Number(_arg_3.ArcGap) : 11.25) * Trig.toRadians);
        var _local_8:Number = (_local_7 * (_local_6 - 1));
        var _local_9:Number = (_arg_4 - (_local_8 / 2));
        this.isShooting = _arg_5;
        var _local_10:int;
        while (_local_10 < _local_6) {
            _local_11 = getBulletId();
            _local_12 = (FreeList.newObject(Projectile) as Projectile);
            if (((_arg_5) && (!((this.projectileIdSetOverrideNew == ""))))) {
                _local_12.reset(_arg_2, 0, objectId_, _local_11, _local_9, _arg_1, this.projectileIdSetOverrideNew, this.projectileIdSetOverrideOld);
            }
            else {
                _local_12.reset(_arg_2, 0, objectId_, _local_11, _local_9, _arg_1);
            }
            _local_13 = int(_local_12.projProps_.minDamage_);
            _local_14 = int(_local_12.projProps_.maxDamage_);
            _local_15 = ((_arg_5) ? this.attackMultiplier() : 1);
            _local_16 = (map_.gs_.gsc_.getNextDamage(_local_13, _local_14) * _local_15);
            if (_arg_1 > (map_.gs_.moveRecords_.lastClearTime_ + 600)) {
                _local_16 = 0;
            }
            _local_12.setDamage(_local_16);
            if ((((_local_10 == 0)) && (!((_local_12.sound_ == null))))) {
                SoundEffectLibrary.play(_local_12.sound_, 0.75, false);
            }
            map_.addObj(_local_12, (x_ + (Math.cos(_arg_4) * 0.3)), (y_ + (Math.sin(_arg_4) * 0.3)));
            map_.gs_.gsc_.playerShoot(_arg_1, _local_12);
            _local_9 = (_local_9 + _local_7);
            _local_10++;
        }
    }

    public function isHexed():Boolean {
        return (!(((condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.HEXED_BIT) == 0)));
    }

    public function isInventoryFull():Boolean {
        if(equipment_ == null)
        {
            return false;
        }
        var _local_1:int = equipment_.length;
        var _local_2:uint = 4;
        while (_local_2 < _local_1) {
            if (equipment_[_local_2] <= 0) {
                return (false);
            }
            _local_2++;
        }
        return (true);
    }

    public function nextAvailableInventorySlot():int {
        var _local_1:int = ((this.hasBackpack_) ? equipment_.length : (equipment_.length - GeneralConstants.NUM_INVENTORY_SLOTS));
        var _local_2:uint = 4;
        while (_local_2 < _local_1) {
            if (equipment_[_local_2] <= 0) {
                return (_local_2);
            }
            _local_2++;
        }
        return (-1);
    }
	
    public function getSlotwithItem(item:int):int { //-1 = no slots; 0-11 = this slot USED IN UseBuyPotionCommand FOR AUTOMOVE
        var _local_1:int = this.hasBackpack_ ? equipment_.length : (equipment_.length - GeneralConstants.NUM_INVENTORY_SLOTS);
        var _local_2:uint = 4;
        while (_local_2 < _local_1) {
            if (equipment_[_local_2] == item) {
                return (_local_2);
            }
            _local_2++;
        }
        return (-1);
    }
	
    public function getItemwithSlot(item:int):int { //return item in said slot
        var _local_1:int = this.hasBackpack_ ? equipment_.length : (equipment_.length - GeneralConstants.NUM_INVENTORY_SLOTS);
        var _local_2:uint = 4;
        while (_local_2 < _local_1) {
            if (equipment_[_local_2] == item) {
                return (_local_2);
            }
            _local_2++;
        }
        return (-1);
    }

    public function numberOfAvailableSlots():int {
        var _local_1:int = ((this.hasBackpack_) ? equipment_.length : (equipment_.length - GeneralConstants.NUM_INVENTORY_SLOTS));
        var _local_2:int;
        var _local_3:uint = 4;
        while (_local_3 < _local_1) {
            if (equipment_[_local_3] <= 0) {
                _local_2++;
            }
            _local_3++;
        }
        return (_local_2);
    }

    public function swapInventoryIndex(_arg_1:int):int {
        var _local_2:int;
        var _local_3:int;
        if (!this.hasBackpack_) {
            return (-1);
        }
		trace(_arg_1);
        if (_arg_1 > 11) { //move to inventory
            _local_2 = GeneralConstants.NUM_EQUIPMENT_SLOTS;
            _local_3 = (GeneralConstants.NUM_EQUIPMENT_SLOTS + GeneralConstants.NUM_INVENTORY_SLOTS);
        }
        else { //move to backpack
            _local_2 = (GeneralConstants.NUM_EQUIPMENT_SLOTS + GeneralConstants.NUM_INVENTORY_SLOTS);
            _local_3 = equipment_.length;
        }
        var _local_4:uint = _local_2;
        while (_local_4 < _local_3) {
            if (equipment_[_local_4] <= 0) {
                return (_local_4);
            }
            _local_4++;
        }
        return (-1);
    }

    public function getPotionCount(_arg_1:int):int {
        switch (_arg_1) {
            case PotionInventoryModel.HEALTH_POTION_ID:
                return (this.healthPotionCount_);
            case PotionInventoryModel.MAGIC_POTION_ID:
                return (this.magicPotionCount_);
        }
        return (0);
    }

    public function getTex1():int {
        return (tex1Id_);
    }

    public function getTex2():int {
        return (tex2Id_);
    }


}
}//package com.company.assembleegameclient.objects
