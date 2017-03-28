package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.engine3d.Point3D;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.objects.particles.HitEffect;
import com.company.assembleegameclient.objects.particles.SparkParticle;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.tutorial.Tutorial;
import com.company.assembleegameclient.tutorial.doneAction;
import com.company.assembleegameclient.util.BloodComposition;
import com.company.assembleegameclient.util.FreeList;
import com.company.assembleegameclient.util.RandomUtil;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.GraphicsUtil;
import com.company.util.Trig;
import com.company.assembleegameclient.game.MapUserInput;

import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.GraphicsGradientFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.utils.Dictionary;

public class Projectile extends BasicObject {

    private static var objBullIdToObjId_:Dictionary = new Dictionary();

    public var props_:ObjectProperties;
    public var containerProps_:ObjectProperties;
    public var projProps_:ProjectileProperties;
    public var texture_:BitmapData;
    public var bulletId_:uint;
    public var ownerId_:int;
    public var containerType_:int;
    public var bulletType_:uint;
    public var damagesEnemies_:Boolean;
    public var damagesPlayers_:Boolean;
    public var damage_:int;
    public var sound_:String;
    public var startX_:Number;
    public var startY_:Number;
    public var startTime_:int;
    public var angle_:Number = 0;
    public var multiHitDict_:Dictionary;
    public var p_:Point3D;
    private var staticPoint_:Point;
    private var staticVector3D_:Vector3D;
    protected var shadowGradientFill_:GraphicsGradientFill;
    protected var shadowPath_:GraphicsPath;

    public function Projectile() {
        this.p_ = new Point3D(100);
        this.staticPoint_ = new Point();
        this.staticVector3D_ = new Vector3D();
        this.shadowGradientFill_ = new GraphicsGradientFill(GradientType.RADIAL, [0, 0], [0.5, 0], null, new Matrix());
        this.shadowPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
        super();
    }

    public static function findObjId(_arg_1:int, _arg_2:uint):int {
        return (objBullIdToObjId_[((_arg_2 << 24) | _arg_1)]);
    }

    public static function getNewObjId(_arg_1:int, _arg_2:uint):int {
        var _local_3:int = getNextFakeObjectId();
        objBullIdToObjId_[((_arg_2 << 24) | _arg_1)] = _local_3;
        return (_local_3);
    }

    public static function removeObjId(_arg_1:int, _arg_2:uint):void {
        delete objBullIdToObjId_[((_arg_2 << 24) | _arg_1)];
    }

    public static function dispose():void {
        objBullIdToObjId_ = new Dictionary();
    }


    public function reset(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Number, _arg_6:int, _arg_7:String = "", _arg_8:String = ""):void {
        var _local_11:Number;
        clear();
        this.containerType_ = _arg_1;
        this.bulletType_ = _arg_2;
        this.ownerId_ = _arg_3;
        this.bulletId_ = _arg_4;
        this.angle_ = Trig.boundToPI(_arg_5);
        this.startTime_ = _arg_6;
        objectId_ = getNewObjId(this.ownerId_, this.bulletId_);
        z_ = 0.5;
        this.containerProps_ = ObjectLibrary.propsLibrary_[this.containerType_];
        this.projProps_ = this.containerProps_.projectiles_[_arg_2];
        var _local_9:String = ((((!((_arg_7 == ""))) && ((this.projProps_.objectId_ == _arg_8)))) ? _arg_7 : this.projProps_.objectId_);
        this.props_ = ObjectLibrary.getPropsFromId(_local_9);
        hasShadow_ = (this.props_.shadowSize_ > 0);
        var _local_10:TextureData = ObjectLibrary.typeToTextureData_[this.props_.type_];
        this.texture_ = _local_10.getTexture(objectId_);
        this.damagesPlayers_ = this.containerProps_.isEnemy_;
        this.damagesEnemies_ = !(this.damagesPlayers_);
        this.sound_ = this.containerProps_.oldSound_;
        this.multiHitDict_ = ((this.projProps_.multiHit_) ? new Dictionary() : null);
        if (this.projProps_.size_ >= 0) {
            _local_11 = this.projProps_.size_;
        }
        else {
            _local_11 = ObjectLibrary.getSizeFromType(this.containerType_);
        }
        this.p_.setSize((8 * (_local_11 / 100)));
        this.damage_ = 0;
    }

    public function setDamage(_arg_1:int):void {
        this.damage_ = _arg_1;
    }

    override public function addTo(_arg_1:Map, _arg_2:Number, _arg_3:Number):Boolean {
        var _local_4:Player;
        this.startX_ = _arg_2;
        this.startY_ = _arg_3;
        if (!super.addTo(_arg_1, _arg_2, _arg_3)) {
            return (false);
        }
        if (((!(this.containerProps_.flying_)) && (square_.sink_))) {
            z_ = 0.1;
        }
        else {
            _local_4 = (_arg_1.goDict_[this.ownerId_] as Player);
            if (((!((_local_4 == null))) && ((_local_4.sinkLevel_ > 0)))) {
                z_ = (0.5 - (0.4 * (_local_4.sinkLevel_ / Parameters.MAX_SINK_LEVEL)));
            }
        }
        return (true);
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

    override public function removeFromMap():void {
        super.removeFromMap();
        removeObjId(this.ownerId_, this.bulletId_);
        this.multiHitDict_ = null;
        FreeList.deleteObject(this);
    }

    private function positionAt(_arg_1:int, _arg_2:Point):void {
        var _local_5:Number;
        var _local_6:Number;
        var _local_7:Number;
        var _local_8:Number;
        var _local_9:Number;
        var _local_10:Number;
        var _local_11:Number;
        var _local_12:Number;
        var _local_13:Number;
        var _local_14:Number;
        _arg_2.x = this.startX_;
        _arg_2.y = this.startY_;
        var _local_3:Number = (_arg_1 * (this.projProps_.speed_ / 10000));
        var _local_4:Number = ((((this.bulletId_ % 2)) == 0) ? 0 : Math.PI);
        if (this.projProps_.wavy_) {
            _local_5 = (6 * Math.PI);
            _local_6 = (Math.PI / 64);
            _local_7 = (this.angle_ + (_local_6 * Math.sin((_local_4 + ((_local_5 * _arg_1) / 1000)))));
            _arg_2.x = (_arg_2.x + (_local_3 * Math.cos(_local_7)));
            _arg_2.y = (_arg_2.y + (_local_3 * Math.sin(_local_7)));
        }
        else {
            if (this.projProps_.parametric_) {
                _local_8 = (((_arg_1 / this.projProps_.lifetime_) * 2) * Math.PI);
                _local_9 = (Math.sin(_local_8) * (((this.bulletId_ % 2)) ? 1 : -1));
                _local_10 = (Math.sin((2 * _local_8)) * ((((this.bulletId_ % 4)) < 2) ? 1 : -1));
                _local_11 = Math.sin(this.angle_);
                _local_12 = Math.cos(this.angle_);
                _arg_2.x = (_arg_2.x + (((_local_9 * _local_12) - (_local_10 * _local_11)) * this.projProps_.magnitude_));
                _arg_2.y = (_arg_2.y + (((_local_9 * _local_11) + (_local_10 * _local_12)) * this.projProps_.magnitude_));
            }
            else {
                if (this.projProps_.boomerang_) {
                    _local_13 = ((this.projProps_.lifetime_ * (this.projProps_.speed_ / 10000)) / 2);
                    if (_local_3 > _local_13) {
                        _local_3 = (_local_13 - (_local_3 - _local_13));
                    }
                }
                _arg_2.x = (_arg_2.x + (_local_3 * Math.cos(this.angle_)));
                _arg_2.y = (_arg_2.y + (_local_3 * Math.sin(this.angle_)));
                if (this.projProps_.amplitude_ != 0) {
                    _local_14 = (this.projProps_.amplitude_ * Math.sin((_local_4 + ((((_arg_1 / this.projProps_.lifetime_) * this.projProps_.frequency_) * 2) * Math.PI))));
                    _arg_2.x = (_arg_2.x + (_local_14 * Math.cos((this.angle_ + (Math.PI / 2)))));
                    _arg_2.y = (_arg_2.y + (_local_14 * Math.sin((this.angle_ + (Math.PI / 2)))));
                }
            }
        }
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_5:Vector.<uint>;
        var _local_7:Player;
        var _local_8:Boolean;
        var _local_9:Boolean;
        var _local_10:Boolean;
        var _local_11:int;
        var _local_12:Boolean;
        var _local_3:int = (_arg_1 - this.startTime_);
        if (_local_3 > this.projProps_.lifetime_) {
            return (false);
        }
        var _local_4:Point = this.staticPoint_;
        this.positionAt(_local_3, _local_4);
        if (((!(this.moveTo(_local_4.x, _local_4.y))) || ((square_.tileType_ == 0xFFFF)))) {
            if (this.damagesPlayers_) {
                map_.gs_.gsc_.squareHit(_arg_1, this.bulletId_, this.ownerId_);
            }
            else {
                if (square_.obj_ != null) {
                    _local_5 = BloodComposition.getColors(this.texture_);
                    map_.addObj(new HitEffect(_local_5, 100, 3, this.angle_, this.projProps_.speed_), _local_4.x, _local_4.y);
                }
            }
            return (false);
        }
        if (((((!((square_.obj_ == null))) && (((!(square_.obj_.props_.isEnemy_)) || (!(this.damagesEnemies_)))))) && (((square_.obj_.props_.enemyOccupySquare_) || (((!(this.projProps_.passesCover_)) && (square_.obj_.props_.occupySquare_))))))) {
            if (this.damagesPlayers_) {
                map_.gs_.gsc_.otherHit(_arg_1, this.bulletId_, this.ownerId_, square_.obj_.objectId_);
            }
            else {
                _local_5 = BloodComposition.getColors(this.texture_);
                map_.addObj(new HitEffect(_local_5, 100, 3, this.angle_, this.projProps_.speed_), _local_4.x, _local_4.y);
            }
			if (Parameters.data_["PassesCover"] == true && this.ownerId_ == map_.player_.objectId_) {
				return true;
			}
            return false;
        }
        var _local_6:GameObject = this.getHit(_local_4.x, _local_4.y);
        if (_local_6 != null) {
            _local_7 = map_.player_;
            _local_8 = !((_local_7 == null));
            _local_9 = _local_6.props_.isEnemy_;
            _local_10 = ((((_local_8) && (!(_local_7.isPaused())))) && (((this.damagesPlayers_) || (((_local_9) && ((this.ownerId_ == _local_7.objectId_)))))));
            if (_local_10) {
                _local_11 = GameObject.damageWithDefense(this.damage_, _local_6.defense_, this.projProps_.armorPiercing_, _local_6.condition_);
                _local_12 = false;
                if (_local_6.hp_ <= _local_11) {
                    _local_12 = true;
                    if (_local_6.props_.isEnemy_) {
                        doneAction(map_.gs_, Tutorial.KILL_ACTION);
                    }
                }
                if (_local_6 == _local_7) {
					//player hit with cond effect SS DEBUFFS
					var takeEff:Boolean = true;
					var effName:String = "";
                    for each(_local_3 in projProps_.effects_) //params.statEff = true -> take the effect -> takeEff = true
                    {
						//welcome to the if jungle
						if (_local_3 == 2) {
							if (!Parameters.data_.dbQuiet) {
								effName = "Quiet";
								takeEff = false;
								if (map_.name_ == "Oryx\'s Castle" && Parameters.data_.dbQuietCastle)
								{
									takeEff = true;
								}
								break; //it doesn't matter if we break if we're in castle although we don't take the eff
							}
						}
						else if (_local_3 == 3) {
							if (!Parameters.data_.dbWeak) {
								effName = "Weak";
								takeEff = false;
								break; //we decided to not take this bullet -> break
							}
						}
						else if (_local_3 == 4) {
							if (!Parameters.data_.dbSlowed) {
								effName = "Slowed";
								takeEff = false;
								break;
							}
						}
						else if (_local_3 == 5) {
							if (!Parameters.data_.dbSick) {
								effName = "Sick";
								takeEff = false;
								break;
							}
						}
						else if (_local_3 == 6) {
							if (!Parameters.data_.dbDazed) {
								effName = "Dazed";
								takeEff = false;
								break;
							}
						}
						else if (_local_3 == 7) {
							if (!Parameters.data_.dbStunned) {
								effName = "Stunned";
								takeEff = false;
								break;
							}
						}
						else if (_local_3 == 14) {
							if (!Parameters.data_.dbParalyzed) {
								effName = "Paralyzed";
								takeEff = false;
								break;
							}
						}
						else if (_local_3 == 16) {
							if (!Parameters.data_.dbBleeding) {
								effName = "Bleeding";
								takeEff = false;
								break;
							}
						}
						else if (_local_3 == 27) {
							if (!Parameters.data_.dbArmorBroken) {
								effName = "Armor Broken";
								takeEff = false;
								break;
							}
						}
						else if (_local_3 == 37) {
							if (!Parameters.data_.dbPetStasis) {
								effName = "Pet Stasis";
								takeEff = false;
								break;
							}
						}
					}
					if (takeEff) { //TODO
						_local_6.damage(this.containerType_, _local_11, this.projProps_.effects_, false, this); //if effects was removed could we use this?
						map_.gs_.gsc_.playerHit(this.bulletId_, this.ownerId_); //needs to be ignored
					}
					else {
						if (effName != "") {
							_local_7.notifyPlayer(effName, 0x00ff00, 1500);
						}
						if (_local_11 > 0) {
							_local_7.negateHealth(_local_11);
							GameObject.takeDmgNotif(_local_11, _local_7);
						}
						return false;
					}
                }
                else {
                    if (_local_6.props_.isEnemy_) {
                        if (!damageIgnored(_local_6) || (_local_6.isInvulnerable() && !isStun())) //don't hit invulnerable or ignored enemies
                        {
                            return true;
                        }
						if (Parameters.data_.tombHack && ((_local_6.objectType_ >= 3366 && _local_6.objectType_ <= 3368) || (_local_6.objectType_ >= 32692 && _local_6.objectType_ <= 32694))) { //tomb bosses
							if (_local_6.objectType_ != Parameters.data_.curBoss && _local_6.objectType_ != Parameters.data_.curBoss + 29326) {
								return true;
							}
						}
                        map_.gs_.gsc_.enemyHit(_arg_1, this.bulletId_, _local_6.objectId_, _local_12);
                        _local_6.damage(this.containerType_, _local_11, this.projProps_.effects_, _local_12, this);
                    }
                    else {
                        if (!this.projProps_.multiHit_) {
                            map_.gs_.gsc_.otherHit(_arg_1, this.bulletId_, this.ownerId_, _local_6.objectId_);
                        }
                    }
                }
            }
            if (this.projProps_.multiHit_) {
                this.multiHitDict_[_local_6] = true;
            }
            else {
                return false;
            }
        }
        return true;
    }
	
	private function isStun():Boolean { //shields and quivers
		if (containerType_ > 2567 && containerType_ < 2573) { //some tiered shields
			return true;
		}
		if (containerType_ > 0xa60 && containerType_ < 0xa66) { //some tiered quivers
			return true;
		}
		switch (containerType_) {
			case 2767: //reinforced shield
			case 2850: //colossus shield
			case 2624: //snakeskin shield
			case 9017: //mad god shield
			case 3395: //scutum
			case 0xc0f: //ogmur
			case 0xc07: //qot
			case 0xb28: //elvish
			case 0xade: //elvencraft quiver
			case 0x916: //midnight star
				return true;
		}
		return false;
	}
    
    public function damageIgnored(param1:GameObject) : Boolean //prevents you from damaging enemies
    {
        var _loc2_:int = 0;
        for each(_loc2_ in Parameters.data_.AAIgnore)
        {
			if (_loc2_ == 1619 || _loc2_ == 3441) { //sprite child or oryx suit of armor
				continue;
			}
            if (_loc2_ == param1.props_.type_)
            {
                if (!Parameters.data_.damageIgnored)
                {
                    return false;
                }
                break;
            }
        }
        return true;
    }

    public function getHit(_arg_1:Number, _arg_2:Number):GameObject {
        var _local_5:GameObject;
        var _local_6:Number;
        var _local_7:Number;
        var _local_8:Number;
        var _local_9:Number;
        var _local_3:Number = Number.MAX_VALUE;
        var _local_4:GameObject;
        for each (_local_5 in map_.goDict_) {
            if (!_local_5.isInvincible()) {
                if (!_local_5.isStasis()) {
                    if (((((this.damagesEnemies_) && (_local_5.props_.isEnemy_))) || (((this.damagesPlayers_) && (_local_5.props_.isPlayer_))))) {
                        if (!((_local_5.dead_) || (_local_5.isPaused()))) {
                            _local_6 = (((_local_5.x_ > _arg_1)) ? (_local_5.x_ - _arg_1) : (_arg_1 - _local_5.x_));
                            _local_7 = (((_local_5.y_ > _arg_2)) ? (_local_5.y_ - _arg_2) : (_arg_2 - _local_5.y_));
                            if (!(((_local_6 > _local_5.radius_)) || ((_local_7 > _local_5.radius_)))) {
                                if (!((this.projProps_.multiHit_) && (!((this.multiHitDict_[_local_5] == null))))) {
                                    if (_local_5 == map_.player_) {
                                        return (_local_5);
                                    }
                                    _local_8 = Math.sqrt(((_local_6 * _local_6) + (_local_7 * _local_7)));
                                    _local_9 = ((_local_6 * _local_6) + (_local_7 * _local_7));
                                    if (_local_9 < _local_3) {
                                        _local_3 = _local_9;
                                        _local_4 = _local_5;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return (_local_4);
    }

    override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        if (MapUserInput.skipRender == true)
        {
            return;
        }
        var _local_6:uint;
        var _local_7:uint;
        var _local_8:int;
        var _local_9:int;
        if (!Parameters.drawProj_) {
            return;
        }
        var _local_4:BitmapData = this.texture_;
        if (Parameters.projColorType_ != 0) {
            switch (Parameters.projColorType_) {
                case 1:
                    _local_6 = 16777100;
                    _local_7 = 0xFFFFFF;
                    break;
                case 2:
                    _local_6 = 16777100;
                    _local_7 = 16777100;
                    break;
                case 3:
                    _local_6 = 0xFF0000;
                    _local_7 = 0xFF0000;
                    break;
                case 4:
                    _local_6 = 0xFF;
                    _local_7 = 0xFF;
                    break;
                case 5:
                    _local_6 = 0xFFFFFF;
                    _local_7 = 0xFFFFFF;
                    break;
                case 6:
                    _local_6 = 0;
                    _local_7 = 0;
                    break;
            }
            _local_4 = TextureRedrawer.redraw(_local_4, 120, true, _local_7);
        }
        var _local_5:Number = (((this.props_.rotation_ == 0)) ? 0 : (_arg_3 / this.props_.rotation_));
        this.staticVector3D_.x = x_;
        this.staticVector3D_.y = y_;
        this.staticVector3D_.z = z_;
        this.p_.draw(_arg_1, this.staticVector3D_, (((this.angle_ - _arg_2.angleRad_) + this.props_.angleCorrection_) + _local_5), _arg_2.wToS_, _arg_2, _local_4);
        if (this.projProps_.particleTrail_ && !Parameters.data_.AntiLag) {
            _local_8 = (((this.projProps_.particleTrailLifetimeMS) != -1) ? this.projProps_.particleTrailLifetimeMS : 600);
            _local_9 = 0;
            for (; _local_9 < 3; _local_9++) {
                if (((!((map_ == null))) && (!((map_.player_.objectId_ == this.ownerId_))))) {
                    if ((((this.projProps_.particleTrailIntensity_ == -1)) && (((Math.random() * 100) > this.projProps_.particleTrailIntensity_)))) continue;
                }
                map_.addObj(new SparkParticle(100, this.projProps_.particleTrailColor_, _local_8, 0.5, RandomUtil.plusMinus(3), RandomUtil.plusMinus(3)), x_, y_);
            }
        }
    }

    override public function drawShadow(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        if (!Parameters.drawProj_) {
            return;
        }
        var _local_4:Number = (this.props_.shadowSize_ / 400);
        var _local_5:Number = (30 * _local_4);
        var _local_6:Number = (15 * _local_4);
        this.shadowGradientFill_.matrix.createGradientBox((_local_5 * 2), (_local_6 * 2), 0, (posS_[0] - _local_5), (posS_[1] - _local_6));
        _arg_1.push(this.shadowGradientFill_);
        this.shadowPath_.data.length = 0;
        Vector.<Number>(this.shadowPath_.data).push((posS_[0] - _local_5), (posS_[1] - _local_6), (posS_[0] + _local_5), (posS_[1] - _local_6), (posS_[0] + _local_5), (posS_[1] + _local_6), (posS_[0] - _local_5), (posS_[1] + _local_6));
        _arg_1.push(this.shadowPath_);
        _arg_1.push(GraphicsUtil.END_FILL);
    }


}
}//package com.company.assembleegameclient.objects
