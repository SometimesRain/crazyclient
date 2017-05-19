package com.company.assembleegameclient.game {
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.objects.Character;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.GuildHallPortal;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.Portal;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.options.Options;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.KeyCodes;
import flash.desktop.Clipboard;
import flash.desktop.ClipboardFormats;
import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import kabam.rotmg.chat.control.ParseChatMessageSignal;
import kabam.rotmg.chat.control.TextHandler;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.ui.view.HUDView;

import flash.display.Stage;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.system.Capabilities;
import flash.utils.getTimer;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.constants.UseType;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.friends.view.FriendListView;
import kabam.rotmg.game.model.PotionInventoryModel;
import kabam.rotmg.game.model.UseBuyPotionVO;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.game.signals.ExitGameSignal;
import kabam.rotmg.game.signals.GiftStatusUpdateSignal;
import kabam.rotmg.game.signals.SetTextBoxVisibilitySignal;
import kabam.rotmg.game.signals.UseBuyPotionSignal;
import kabam.rotmg.game.view.components.StatsTabHotKeyInputSignal;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.minimap.control.MiniMapZoomSignal;
import kabam.rotmg.pets.controller.reskin.ReskinPetFlowStartSignal;
import kabam.rotmg.ui.UIUtils;
import com.company.assembleegameclient.game.events.ReconnectEvent;
import kabam.rotmg.maploading.view.MapLoadingView;

import net.hires.debug.Stats;

import org.swiftsuspenders.Injector;

public class MapUserInput {

    private static var stats_:Stats = new Stats();
    private static const MOUSE_DOWN_WAIT_PERIOD:uint = 175;
    private static var arrowWarning_:Boolean = false;
	
    public static var reconRealm:ReconnectEvent;
    public static var reconDung:ReconnectEvent;
    public static var reconVault:ReconnectEvent;
    public static var reconRandom:ReconnectEvent;
    public static var dungTime:uint = 0;
    public static var skipRender:Boolean = false;
    public var lightSpeed:Boolean = false;
    private var maxprism:Boolean = false;
	private var spaceSpam:int = 0; //makes sure you don't dc when spamming
	public static var optionsOpen:Boolean = false;
	public var ninjaTapped:Boolean = false;
	public static var inputting:Boolean = false;

    public var gs_:GameSprite;
    private var moveLeft_:int = 0;
    private var moveRight_:int = 0;
    private var moveUp_:int = 0;
    private var moveDown_:int = 0;
    private var rotateLeft_:int = 0;
    private var rotateRight_:int = 0;
    public var mouseDown_:Boolean = false;
    public var autofire_:Boolean = false;
    private var currentString:String = "";
    public var specialKeyDown_:Boolean = false;
    private var enablePlayerInput_:Boolean = true;
    private var giftStatusUpdateSignal:GiftStatusUpdateSignal;
    private var addTextLine:AddTextLineSignal;
    private var setTextBoxVisibility:SetTextBoxVisibilitySignal;
    private var statsTabHotKeyInputSignal:StatsTabHotKeyInputSignal;
    private var miniMapZoom:MiniMapZoomSignal;
    private var useBuyPotionSignal:UseBuyPotionSignal;
    private var potionInventoryModel:PotionInventoryModel;
    private var openDialogSignal:OpenDialogSignal;
    private var closeDialogSignal:CloseDialogsSignal;
    private var layers:Layers;
    private var exitGame:ExitGameSignal;
    private var areFKeysAvailable:Boolean;
    private var reskinPetFlowStart:ReskinPetFlowStartSignal;
    private var parseChatMessage:ParseChatMessageSignal;

    public function MapUserInput(_arg_1:GameSprite) {
        this.gs_ = _arg_1;
        this.gs_.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        this.gs_.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        var _local_2:Injector = StaticInjectorContext.getInjector();
        this.giftStatusUpdateSignal = _local_2.getInstance(GiftStatusUpdateSignal);
        this.reskinPetFlowStart = _local_2.getInstance(ReskinPetFlowStartSignal);
        this.addTextLine = _local_2.getInstance(AddTextLineSignal);
        this.setTextBoxVisibility = _local_2.getInstance(SetTextBoxVisibilitySignal);
        this.miniMapZoom = _local_2.getInstance(MiniMapZoomSignal);
        this.useBuyPotionSignal = _local_2.getInstance(UseBuyPotionSignal);
        this.potionInventoryModel = _local_2.getInstance(PotionInventoryModel);
        this.layers = _local_2.getInstance(Layers);
        this.statsTabHotKeyInputSignal = _local_2.getInstance(StatsTabHotKeyInputSignal);
        this.exitGame = _local_2.getInstance(ExitGameSignal);
        this.openDialogSignal = _local_2.getInstance(OpenDialogSignal);
        this.closeDialogSignal = _local_2.getInstance(CloseDialogsSignal);
        this.parseChatMessage = _local_2.getInstance(ParseChatMessageSignal);
        var _local_3:ApplicationSetup = _local_2.getInstance(ApplicationSetup);
        this.areFKeysAvailable = _local_3.areDeveloperHotkeysEnabled();
        this.gs_.map.signalRenderSwitch.add(this.onRenderSwitch);
    }

    public function onRenderSwitch(_arg_1:Boolean):void {
        if (_arg_1) {
            this.gs_.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.gs_.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            this.gs_.map.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.gs_.map.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        else {
            this.gs_.map.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.gs_.map.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            this.gs_.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.gs_.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
    }

    public function clearInput():void {
        this.moveLeft_ = 0;
        this.moveRight_ = 0;
        this.moveUp_ = 0;
        this.moveDown_ = 0;
        this.rotateLeft_ = 0;
        this.rotateRight_ = 0;
        this.mouseDown_ = false;
        this.autofire_ = false;
        this.lightSpeed = false;
        this.maxprism = false;
        this.setPlayerMovement();
    }

    public function setEnablePlayerInput(_arg_1:Boolean):void {
        if (this.enablePlayerInput_ != _arg_1) {
            this.enablePlayerInput_ = _arg_1;
            this.clearInput();
        }
    }

    private function onAddedToStage(_arg_1:Event):void {
        var _local_2:Stage = this.gs_.stage;
        _local_2.addEventListener(Event.ACTIVATE, this.onActivate);
        _local_2.addEventListener(Event.DEACTIVATE, this.onDeactivate);
        _local_2.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        _local_2.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        _local_2.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
		//
        _local_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        _local_2.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        //this.gs_.map.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        //this.gs_.map.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        _local_2.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        _local_2.addEventListener(MouseEvent.RIGHT_CLICK, this.disableRightClick); //right click
    }

    public function disableRightClick(_arg_1:MouseEvent):void {
		gs_.map.player_.mapLightSpeed = !gs_.map.player_.mapLightSpeed;
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        var _local_2:Stage = this.gs_.stage;
        _local_2.removeEventListener(Event.ACTIVATE, this.onActivate);
        _local_2.removeEventListener(Event.DEACTIVATE, this.onDeactivate);
        _local_2.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        _local_2.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        _local_2.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
		//
        _local_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        _local_2.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        //this.gs_.map.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        //this.gs_.map.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        _local_2.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        _local_2.removeEventListener(MouseEvent.RIGHT_CLICK, this.disableRightClick);
    }

    private function onActivate(_arg_1:Event):void {
    }

    private function onDeactivate(_arg_1:Event):void {
        this.clearInput();
    }

    public function onMouseDown(_arg_1:MouseEvent):void {
		//addTextLine.dispatch(ChatMessage.make(Parameters.CLIENT_CHAT_NAME, "mouse down x: "+gs_.mouseX + " y: "+gs_.mouseY));
		if (gs_.mouseX >= gs_.hudView.x) {
			return;
		}
		if (optionsOpen) {
			return;
		}
        this.mouseDown_ = true;
        var _local_3:Number;
        var _local_4:int;
        var _local_5:XML;
        var _local_6:Number;
        var _local_7:Number;
        var _local_2:Player = gs_.map.player_;
        if (_local_2 == null) {
            return;
        }
        if (!this.enablePlayerInput_) {
            return;
        }
        if (_arg_1.shiftKey) {
            _local_4 = _local_2.equipment_[1];
            if (_local_4 == -1) {
                return;
            }
            _local_5 = ObjectLibrary.xmlLibrary_[_local_4];
            if ((((_local_5 == null)) || (_local_5.hasOwnProperty("EndMpCost")))) {
                return;
            }
            if (_local_2.isUnstable()) {
                _local_6 = ((Math.random() * 600) - 300);
                _local_7 = ((Math.random() * 600) - 325);
            }
            else {
                _local_6 = this.gs_.map.mouseX;
                _local_7 = this.gs_.map.mouseY;
            }
            if (Parameters.isGpuRender()) {
                if ((((((_arg_1.currentTarget == _arg_1.target)) || ((_arg_1.target == this.gs_.map)))) || ((_arg_1.target == this.gs_)))) {
                    _local_2.useAltWeapon(_local_6, _local_7, UseType.START_USE);
                }
            }
            else {
                _local_2.useAltWeapon(_local_6, _local_7, UseType.START_USE);
            }
            return;
        }
        if (Parameters.isGpuRender()) {
            if ((((((((_arg_1.currentTarget == _arg_1.target)) || ((_arg_1.target == this.gs_.map)))) || ((_arg_1.target == this.gs_)))) || ((_arg_1.currentTarget == this.gs_.chatBox_.list)))) {
                _local_3 = Math.atan2(this.gs_.map.mouseY, this.gs_.map.mouseX);
            }
            else {
                return;
            }
        }
        else {
            _local_3 = Math.atan2(this.gs_.map.mouseY, this.gs_.map.mouseX);
        }
        if (_local_2.isUnstable()) {
            _local_2.attemptAttackAngle((Math.random() * 360));
        }
        else {
            _local_2.attemptAttackAngle(_local_3);
        }
    }

    public function onMouseUp(_arg_1:MouseEvent):void {
        this.mouseDown_ = false;
        var _local_2:Player = this.gs_.map.player_;
        if (_local_2 == null) {
            return;
        }
        _local_2.isShooting = false;
    }

    private function onMouseWheel(_arg_1:MouseEvent):void {
        if (_arg_1.delta > 0) {
            this.miniMapZoom.dispatch(MiniMapZoomSignal.IN);
        }
        else {
            this.miniMapZoom.dispatch(MiniMapZoomSignal.OUT);
        }
    }

    private function onEnterFrame(_arg_1:Event):void {
        var _local_2:Player;
        var _local_3:Number;
        if (enablePlayerInput_ && (mouseDown_ || autofire_) || Parameters.data_.AAOn) {
            _local_2 = this.gs_.map.player_;
            if (_local_2 != null) {
                if (_local_2.isUnstable()) {
                    _local_2.attemptAttackAngle((Math.random() * 360));
                }
                else {
                    _local_3 = Math.atan2(this.gs_.map.mouseY, this.gs_.map.mouseX);
                    _local_2.attemptAttackAngle(_local_3);
                }
            }
        }
    }
	
	private function handleAutoAbil(player:Player):Boolean {
		if (!(player.objectType_ == 0x0300 || player.objectType_ == 0x031d || player.objectType_ == 0x031f || (player.objectType_ == 0x0310 && Parameters.data_.priestAA))) {
			return false; //not rogue, warrior, paladin, priest
		}
		if (spaceSpam >= getTimer()) {
			if (player.mapAutoAbil) {
				player.mapAutoAbil = false
				player.notifyPlayer("Auto Ability: Disabled", 0x00FF00, 1500);
			}
			return true; //not time yet
		}
		spaceSpam = getTimer() + 500;
		switch(player.equipment_[1]) {
			case 0xb27: //ghostly
			case 0xae1: //twi
			case 0xb29: //ggen
			case 0xa6b: //ghelm
			case 0xc08: //jugg
			case 0xb26: //gcookie
			case 0xa55: //zseal
			case 0x21a2: //drape
			case 0xc1e: //prot
			case 0x16de: //ice prot
				player.mapAutoAbil = !player.mapAutoAbil;
				player.notifyPlayer(player.mapAutoAbil ? "Auto Ability: Enabled" : "Auto Ability: Disabled", 0x00FF00, 1500);
				return true;
		}
		return false;
	}
	
	private function isIgnored(igtype:int):Boolean {
		for each (var type:int in Parameters.data_.AAIgnore) {
			if (igtype == type) {
				return true;
			}
		}
		if (Parameters.data_.tombHack && igtype >= 3366 && igtype <= 3368) { //tomb bosses
			if (igtype != Parameters.data_.curBoss) {
				return true;
			}
		}
		return false;
	}
	
	private function handlePerfectAim(player:Player):void {
		var po:Point = player.sToW(gs_.map.mouseX,gs_.map.mouseY);
		var target:GameObject;
		var obj:GameObject;
		var distSq:int = int.MAX_VALUE;
		var temp:int;
		var projspd:Number = 0.015;
		//find closest target to mouse with at least 1000 health
		for each (obj in gs_.map.goDict_) {
			if (obj.props_.isEnemy_ && obj.maxHP_ >= 1000 && !isIgnored(obj.objectType_)) {
				temp = (obj.x_ - po.x) * (obj.x_ - po.x) + (obj.y_ - po.y) * (obj.y_ - po.y);
				if (temp < distSq) {
					distSq = temp;
					target = obj;
				}
			}
		}
		if (target == null) {
			player.notifyPlayer("No targets nearby!", 0x00FF00, 1500);
		}
		else { //TODO see if enemy is too far
			player.notifyPlayer(ObjectLibrary.typeToDisplayId_[target.objectType_], 0x00FF00, 1500);
			if (!Parameters.data_.perfectLead) {
				aimAt(player, new Vector3D(target.x_, target.y_));
			}
			else {
				if (player.objectType_ == 798 || player.equipment_[1] == 0x1413) {
					projspd = 0.016;
				}
				if (player.equipment_[1] == 0x0d43) {
					projspd = 0.014;
				}
				aimAt(player, player.leadPos(new Vector3D(player.x_,player.y_), new Vector3D(target.x_,target.y_), new Vector3D(target.moveVec_.x,target.moveVec_.y), projspd));
			}
		}
	}
	
	private function aimAt(player:Player, t:Vector3D):void {
		if (Parameters.data_.inaccurate) {
			t.x = int(t.x) + 0.5;
			t.y = int(t.y) + 0.5;
		}
		gs_.gsc_.useItem(getTimer(), player.objectId_, 1, player.equipment_[1], t.x, t.y, UseType.START_USE);
		player.doShoot(getTimer(), player.equipment_[1], ObjectLibrary.xmlLibrary_[player.equipment_[1]], Math.atan2(t.y - player.y_, t.x - player.x_), false);
	}
	
	private function handlePerfectBomb(player:Player):Boolean {
		if ((Parameters.data_.perfectQuiv && player.objectType_ == 775) || (Parameters.data_.perfectStun && player.objectType_ == 798)) {
			handlePerfectAim(player);
			return true;
		}
		if (!(player.objectType_ == 782 || player.objectType_ == 800)) { //wiz assassin
			return false;
		}
		var target:GameObject;
		var obj:GameObject;
		var distSq:int;
		//get target within 15 tiles that has the most health and at least 1000 health
		for each (obj in gs_.map.goDict_) {
			if (obj.props_.isEnemy_ && obj.maxHP_ >= 1000 && !isIgnored(obj.objectType_)) {
				distSq = (obj.x_ - player.x_) * (obj.x_ - player.x_) + (obj.y_ - player.y_) * (obj.y_ - player.y_);
				if (distSq < 225) {
					if (target == null || obj.maxHP_ > target.maxHP_) {
						target = obj;
					}
				}
			}
		}
		if (target == null) {
			player.notifyPlayer("No targets nearby!", 0x00FF00, 1500);
		}
		else if (target.isInvincible() || target.isInvulnerable() || target.isStasis()) {
			player.notifyPlayer(ObjectLibrary.typeToDisplayId_[target.objectType_]+": Invulnerable", 0x00FF00, 1500);
		}
		else {
			player.notifyPlayer(ObjectLibrary.typeToDisplayId_[target.objectType_], 0x00FF00, 1500);
			if (Parameters.data_.inaccurate) {
				gs_.gsc_.useItem(getTimer(), player.objectId_, 1, player.equipment_[1], int(target.x_) + 1/2, int(target.y_) + 1/2, UseType.START_USE);
			}
			else {
				gs_.gsc_.useItem(getTimer(), player.objectId_, 1, player.equipment_[1], target.x_, target.y_, UseType.START_USE);
			}
		}
		return true;
	}
	
	private function handleCooldown(player:Player, abilXML:XML):void {
		var cd:int = 500; //base cooldown
		if (abilXML.hasOwnProperty("Cooldown")) {
			cd = (Number(abilXML.Cooldown) * 1000);
		}
		player.lastAltAttack_ = getTimer();
		player.nextAltAttack_ = getTimer() + cd;
	}
	
	private function ninjaTap(player:Player):Boolean {
		if (player.objectType_ != 0x0326) {
			return false;
		}
		ninjaTapped = !ninjaTapped;
		if (ninjaTapped) {
			player.useAltWeapon(gs_.map.mouseX, gs_.map.mouseY, UseType.START_USE)
		}
		else {
			player.useAltWeapon(gs_.map.mouseX, gs_.map.mouseY, UseType.END_USE)
		}
		return true;
	}
	
	private function abilityUsed(player:Player, abilXML:XML):void {
		specialKeyDown_ = true;
        if (player == null)
			return;
		if (Parameters.data_.autoAbil && handleAutoAbil(player)) {
			return;
		}
		if (player.nextAltAttack_ >= getTimer()) {
			return;
		}
		if (int(abilXML.MpCost) > player.mp_) {
			return;
		}
		if (Parameters.data_.perfectBomb && handlePerfectBomb(player)) {
			handleCooldown(player, abilXML);
			return;
		}
		if (Parameters.data_.ninjaTap && ninjaTap(player)) { //Parameter.data_.ninjaTap
			return;
		}
		if (maxprism && (player.objectType_ == 804 || player.equipment_[1] == 0xa5a)) { //trickster or plane
			var angle:Number = Math.atan2(gs_.map.mouseX, gs_.map.mouseY);
			if (angle < 0) {
				angle += Math.PI * 2;
			}
			var desX:Number = 20 * 50 * Math.sin(angle); //hypotenuse 20 -> how far is the teleport used
			var desY:Number = 20 * 50 * Math.cos(angle);
			player.useAltWeapon(desX, desY, UseType.START_USE);
			return;
		}
        if (player.isUnstable() && Parameters.data_.dbUnstableAbil) {
			player.useAltWeapon(Math.random() * 600 - 300, Math.random() * 600 - 325, UseType.START_USE)
        }
        else {
			player.useAltWeapon(gs_.map.mouseX, gs_.map.mouseY, UseType.START_USE)
        }
	}

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        var player:Player = gs_.map.player_;
		var obj:GameObject;
		var dist:int;
        switch (_arg_1.keyCode) {
            case KeyCodes.F1:
            case KeyCodes.F2:
            case KeyCodes.F3:
            case KeyCodes.F4:
            case KeyCodes.F5:
            case KeyCodes.F6:
            case KeyCodes.F7:
            case KeyCodes.F8:
            case KeyCodes.F9:
            case KeyCodes.F10:
            case KeyCodes.F11:
            case KeyCodes.F12:
            case KeyCodes.INSERT:
            case KeyCodes.ALTERNATE:
                break;
            default:
                if (gs_.stage.focus != null) {
                    return;
                }
        }
        switch (_arg_1.keyCode) {
            case Parameters.data_.moveUp:
                this.moveUp_ = 1;
                break;
            case Parameters.data_.moveDown:
                this.moveDown_ = 1;
                break;
            case Parameters.data_.moveLeft:
                this.moveLeft_ = 1;
                break;
            case Parameters.data_.moveRight:
                this.moveRight_ = 1;
                break;
            case Parameters.data_.useSpecial:
				abilityUsed(player, ObjectLibrary.xmlLibrary_[player.equipment_[1]]);
                break;
            case Parameters.data_.QuestTeleport:
				var quest:GameObject = gs_.map.quest_.getObject(1);
                if(quest != null)
                {
                    dist = int.MAX_VALUE;
					var _targetPlayer:String = "";
					for each(obj in gs_.map.goDict_) {
						if (obj is Player) {
							var _distSquared:int = (obj.x_ - quest.x_) * (obj.x_ - quest.x_) + (obj.y_ - quest.y_) * (obj.y_ - quest.y_);
							if (_distSquared < dist) {
								dist = _distSquared;
								_targetPlayer = obj.name_;
							}
							/*if ((_obj as Player).isInvisible()) { //invis check TODO
								
							}*/
						}
					}
					if (_targetPlayer == player.name_) {
						player.notifyPlayer("You are the closest!",0x00FF00,1500);
						break;
					}
					gs_.gsc_.teleport(_targetPlayer);
					//player.notifyPlayer("Teleporting to " + _targetPlayer,0x00FF00,1500);
                }
                else
                {
                    player.notifyPlayer("You have no quest!",0x00FF00,1500);
                }
                break;
            case Parameters.data_.enterPortal:
                dist = int.MAX_VALUE;
				var _targetPortal:int = -1;
				for each(obj in gs_.map.goDict_)
                {
					if(obj is Portal || obj is GuildHallPortal)
					{
						var _distSquared2:int = (obj.x_ - player.x_) * (obj.x_ - player.x_) + (obj.y_ - player.y_) * (obj.y_ - player.y_);
						if(_distSquared2 < dist)
						{
							dist = _distSquared2;
							_targetPortal = obj.objectId_;
						}
					}
				}
				if(_targetPortal == -1)
				{
					player.notifyPlayer("No portals to enter!",0x00FF00,1500);
					break;
				}
				//addTextLine.dispatch(ChatMessage.make(Parameters.CLIENT_CHAT_NAME, "entering "+_targetPortal));
				gs_.gsc_.usePortal(_targetPortal);
                break;
            case Parameters.data_.incFinder:
				var holders:Array = new Array();
				for each(obj in gs_.map.goDict_)
                {
					if(obj is Player)
					{
						var thisPlayer:Player = obj as Player;
						for each (var item:int in thisPlayer.equipment_) {
							if (item == 1826) {
								holders.push(thisPlayer.name_);
								break;
							}
						}
					}
				}
				if(holders.length == 0)
				{
					player.notifyPlayer("No one has an inc!",0x00FF00,1500);
					break;
				}
				else {
					var k:int = 0;
					var msg:String = "Inc Holders:\n";
					for each (var name:String in holders) {
						msg = msg + name + "\n";
						k++;
					}
					player.notifyPlayer(msg,0x00FF00,1000 + 500 * k);
				}
                break;
            case Parameters.data_.rotateLeft:
                if (!Parameters.data_.allowRotation) break;
                this.rotateLeft_ = 1;
                break;
            case Parameters.data_.rotateRight:
                if (!Parameters.data_.allowRotation) break;
                this.rotateRight_ = 1;
                break;
            case Parameters.data_.resetToDefaultCameraAngle:
                Parameters.data_.cameraAngle = Parameters.data_.defaultCameraAngle;
                Parameters.save();
                break;
            case Parameters.data_.autofireToggle:
                player.isShooting = (this.autofire_ = !(this.autofire_));
                break;
            case Parameters.data_.toggleHPBar:
                Parameters.data_.HPBar = !(Parameters.data_.HPBar);
                break;
            case Parameters.data_.useInvSlot1:
                this.useItem(4);
                break;
            case Parameters.data_.useInvSlot2:
                this.useItem(5);
                break;
            case Parameters.data_.useInvSlot3:
                this.useItem(6);
                break;
            case Parameters.data_.useInvSlot4:
                this.useItem(7);
                break;
            case Parameters.data_.useInvSlot5:
                this.useItem(8);
                break;
            case Parameters.data_.useInvSlot6:
                this.useItem(9);
                break;
            case Parameters.data_.useInvSlot7:
                this.useItem(10);
                break;
            case Parameters.data_.useInvSlot8:
                this.useItem(11);
                break;
            case Parameters.data_.useHealthPotion:
                if (this.potionInventoryModel.getPotionModel(PotionInventoryModel.HEALTH_POTION_ID).available) {
                    this.useBuyPotionSignal.dispatch(new UseBuyPotionVO(PotionInventoryModel.HEALTH_POTION_ID, UseBuyPotionVO.CONTEXTBUY));
                }
                break;
            case Parameters.data_.useMagicPotion:
                if (this.potionInventoryModel.getPotionModel(PotionInventoryModel.MAGIC_POTION_ID).available) {
                    this.useBuyPotionSignal.dispatch(new UseBuyPotionVO(PotionInventoryModel.MAGIC_POTION_ID, UseBuyPotionVO.CONTEXTBUY));
                }
                break;
            case Parameters.data_.miniMapZoomOut:
                this.miniMapZoom.dispatch(MiniMapZoomSignal.OUT);
                break;
            case Parameters.data_.miniMapZoomIn:
                this.miniMapZoom.dispatch(MiniMapZoomSignal.IN);
                break;
            case Parameters.data_.togglePerformanceStats:
                this.togglePerformanceStats();
                break;
            case Parameters.data_.escapeToNexus:
            case Parameters.data_.escapeToNexus2:
                this.exitGame.dispatch();
                this.gs_.gsc_.escape();
                Parameters.data_.needsRandomRealm = false;
                Parameters.save();
                break;
            case Parameters.data_.friendList:
                Parameters.data_.friendListDisplayFlag = !(Parameters.data_.friendListDisplayFlag);
                if (Parameters.data_.friendListDisplayFlag) {
                    this.openDialogSignal.dispatch(new FriendListView());
                }
                else {
                    this.closeDialogSignal.dispatch();
                }
                break;
            case Parameters.data_.options:
				openOptions();
                break;
            case Parameters.data_.toggleCentering:
                Parameters.data_.centerOnPlayer = !(Parameters.data_.centerOnPlayer);
                Parameters.save();
                break;
            case Parameters.data_.switchTabs:
                //this.statsTabHotKeyInputSignal.dispatch();
				gs_.hudView.toggleStats();
                break;
			//ADDITIONS
            case Parameters.data_.ReconRealm:
				if (reconRealm != null) {
					reconRealm.charId_ = gs_.gsc_.charId_;
					gs_.dispatchEvent(reconRealm);
				}
				else {
					var tocon:Server = new Server();
					tocon.setName(Parameters.data_.servName);
					tocon.setAddress(Parameters.data_.servAddr);
					tocon.setPort(2050);
					var paramRecon:ReconnectEvent = new ReconnectEvent(
						tocon,
						Parameters.data_.reconGID,
						false,
						gs_.gsc_.charId_,
						Parameters.data_.reconTime,
						Parameters.data_.reconKey,
						false
					);
					gs_.dispatchEvent(paramRecon);
				}
                break;
			case Parameters.data_.ReconRandom:
				if (reconVault != null) {
					reconRandom = reconVault;
					reconRandom.charId_ = gs_.gsc_.charId_;
					reconRandom.server_.name = "Random";
					reconRandom.gameId_ = -3;
					gs_.dispatchEvent(reconRandom);
				}
            case Parameters.data_.ReconDung:
				if (reconDung != null) {
					if (getTimer() - dungTime < 180000) {
						reconDung.charId_ = gs_.gsc_.charId_;
						gs_.dispatchEvent(reconDung);
					}
				}
				else if (getTimer() - Parameters.data_.dreconTime < 180000) {
					var tocon2:Server = new Server();
					tocon2.setName(Parameters.data_.dservName);
					tocon2.setAddress(Parameters.data_.dservAddr);
					tocon2.setPort(2050);
					var paramRecon2:ReconnectEvent = new ReconnectEvent(
						tocon2,
						Parameters.data_.dreconGID,
						false,
						gs_.gsc_.charId_,
						Parameters.data_.dreconTime,
						Parameters.data_.dreconKey,
						false
					);
					gs_.dispatchEvent(paramRecon2);
				}
                break;
            case Parameters.data_.ReconVault:
				if (reconVault != null) {
					reconVault.charId_ = gs_.gsc_.charId_;
					gs_.dispatchEvent(reconVault);
				}
                break;
			//
            case Parameters.data_.tpto:
				gs_.gsc_.teleport(TextHandler.caller);
                break;
            case Parameters.data_.TextPause:
                gs_.gsc_.playerText("/pause");
                break;
            case Parameters.data_.TextThessal:
                gs_.gsc_.playerText("He lives and reigns and conquers the world");
                break;
			//
            case Parameters.data_.msg1key:
				if (Parameters.data_.msg1 == null)
					break;
					
				parseChatMessage.dispatch(Parameters.data_.msg1);
                break;
            case Parameters.data_.msg2key:
				if (Parameters.data_.msg2 == null)
					break;
					
				parseChatMessage.dispatch(Parameters.data_.msg2);
                break;
            case Parameters.data_.msg3key:
				if (Parameters.data_.msg3 == null)
					break;
					
				parseChatMessage.dispatch(Parameters.data_.msg3);
                break;
			//
            case Parameters.data_.SkipRenderKey:
                MapUserInput.skipRender = !MapUserInput.skipRender;
                break;
            case Parameters.data_.maxPrism:
                maxprism = !maxprism;
				player.notifyPlayer(maxprism ? "Max Prism: Enabled" : "Max Prism: Disabled",0x00FF00,1500);
                break;
            case Parameters.data_.SWLightKey:
                player.mapLightSpeed = (this.lightSpeed = !(this.lightSpeed));
                break;
            case Parameters.data_.Cam45DegInc:
                Parameters.data_.cameraAngle = Parameters.data_.cameraAngle - 0.785398163397448;
                Parameters.save();
                break;
            case Parameters.data_.Cam45DegDec:
                Parameters.data_.cameraAngle = Parameters.data_.cameraAngle + 0.785398163397448;
                Parameters.save();
                break;
            case Parameters.data_.cam2quest:
				var po:Point = gs_.map.quest_.getLoc();
                Parameters.data_.cameraAngle = Math.atan2(player.y_ - po.y, player.x_ - po.x) - 1.57079632679;
                Parameters.save();
                break;
            case Parameters.data_.AAHotkey:
				Parameters.data_.AAOn = !Parameters.data_.AAOn;
				player.levelUpEffect(Parameters.data_.AAOn ? "Auto Aim: On" : "Auto Aim: Off");
                break;
            case Parameters.data_.AAModeHotkey:
				selectAimMode();
                break;
            case Parameters.data_.tombCycle:
				Parameters.data_.curBoss++;
				if (Parameters.data_.curBoss > 3368) {
					Parameters.data_.curBoss = 3366;
				}
				Parameters.save()
				player.notifyPlayer("Active boss: "+ObjectLibrary.typeToDisplayId_[Parameters.data_.curBoss],0x00FF00,1500);
				break;
            case Parameters.data_.kautoSprite:
				Parameters.data_.autoSprite = !Parameters.data_.autoSprite;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.autoSprite ? "Auto Sprite: On" : "Auto Sprite: Off", 0x00ff00, 1500);
                break;
            case Parameters.data_.kdbPetrify:
				Parameters.data_.dbPetrify = !Parameters.data_.dbPetrify;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.dbPetrify ? "Petrify: On" : "Petrify: Off", Parameters.data_.dbPetrify ? 0xff0000 : 0x00ff00, 1500);
                break;
            case Parameters.data_.kdbArmorBroken:
				Parameters.data_.dbArmorBroken = !Parameters.data_.dbArmorBroken;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.dbArmorBroken ? "Armor Broken: On" : "Armor Broken: Off", Parameters.data_.dbArmorBroken ? 0xff0000 : 0x00ff00, 1500);
                break;
            case Parameters.data_.kdbBleeding:
				Parameters.data_.dbBleeding = !Parameters.data_.dbBleeding;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.dbBleeding ? "Bleeding: On" : "Bleeding: Off", Parameters.data_.dbBleeding ? 0xff0000 : 0x00ff00, 1500);
                break;
            case Parameters.data_.kdbDazed:
				Parameters.data_.dbDazed = !Parameters.data_.dbDazed;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.dbDazed ? "Dazed: On" : "Dazed: Off", Parameters.data_.dbDazed ? 0xff0000 : 0x00ff00, 1500);
                break;
            case Parameters.data_.kdbParalyzed:
				Parameters.data_.dbParalyzed = !Parameters.data_.dbParalyzed;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.dbParalyzed ? "Paralyzed: On" : "Paralyzed: Off", Parameters.data_.dbParalyzed ? 0xff0000 : 0x00ff00, 1500);
                break;
            case Parameters.data_.kdbSick:
				Parameters.data_.dbSick = !Parameters.data_.dbSick;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.dbSick ? "Sick: On" : "Sick: Off", Parameters.data_.dbSick ? 0xff0000 : 0x00ff00, 1500);
                break;
            case Parameters.data_.kdbSlowed:
				Parameters.data_.dbSlowed = !Parameters.data_.dbSlowed;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.dbSlowed ? "Slowed: On" : "Slowed: Off", Parameters.data_.dbSlowed ? 0xff0000 : 0x00ff00, 1500);
                break;
            case Parameters.data_.kdbStunned:
				Parameters.data_.dbStunned = !Parameters.data_.dbStunned;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.dbStunned ? "Stunned: On" : "Stunned: Off", Parameters.data_.dbStunned ? 0xff0000 : 0x00ff00, 1500);
                break;
            case Parameters.data_.kdbWeak:
				Parameters.data_.dbWeak = !Parameters.data_.dbWeak;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.dbWeak ? "Weak: On" : "Weak: Off", Parameters.data_.dbWeak ? 0xff0000 : 0x00ff00, 1500);
                break;
            case Parameters.data_.kdbQuiet:
				Parameters.data_.dbQuiet = !Parameters.data_.dbQuiet;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.dbQuiet ? "Quiet: On" : "Quiet: Off", Parameters.data_.dbQuiet ? 0xff0000 : 0x00ff00, 1500);
                break;
            case Parameters.data_.kdbPetStasis:
				Parameters.data_.dbPetStasis = !Parameters.data_.dbPetStasis;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.dbPetStasis ? "Pet Stasis: On" : "Pet Stasis: Off", Parameters.data_.dbPetStasis ? 0xff0000 : 0x00ff00, 1500);
                break;
            case Parameters.data_.kdbAll:
				Parameters.data_.dbAll = !Parameters.data_.dbAll;
				Parameters.data_.dbPetrify = Parameters.data_.dbAll;
				Parameters.data_.dbArmorBroken = Parameters.data_.dbAll;
				Parameters.data_.dbBleeding = Parameters.data_.dbAll;
				Parameters.data_.dbDazed = Parameters.data_.dbAll;
				Parameters.data_.dbParalyzed = Parameters.data_.dbAll;
				Parameters.data_.dbSick = Parameters.data_.dbAll;
				Parameters.data_.dbSlowed = Parameters.data_.dbAll;
				Parameters.data_.dbStunned = Parameters.data_.dbAll;
				Parameters.data_.dbWeak = Parameters.data_.dbAll;
				Parameters.data_.dbQuiet = Parameters.data_.dbAll;
				Parameters.data_.dbPetStasis = Parameters.data_.dbAll;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.dbAll ? "All: On" : "All: Off", Parameters.data_.dbAll ? 0xff0000 : 0x00ff00, 1500);
                break;
            case Parameters.data_.kdbPre1:
				activatePreset(1);
                break;
            case Parameters.data_.kdbPre2:
				activatePreset(2);
                break;
            case Parameters.data_.kdbPre3:
				activatePreset(3);
                break;
            case Parameters.data_.resetCHP:
				player.chp = player.hp_;
				player.cmaxhp = player.maxHP_;
				player.cmaxhpboost = player.maxHPBoost_;
                break;
            case Parameters.data_.pbToggle:
				Parameters.data_.perfectBomb = !Parameters.data_.perfectBomb;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.perfectBomb ? "Spell Bomb Aim: On" : "Spell Bomb Aim: Off", 0x00ff00, 1500);
                break;
            case Parameters.data_.tPassCover:
				Parameters.data_.PassesCover = !Parameters.data_.PassesCover;
				Parameters.save();
				player.notifyPlayer(Parameters.data_.PassesCover ? "Proj No-Clip: On" : "Proj No-Clip: Off", 0x00ff00, 1500);
                break;
        }
        this.setPlayerMovement();
    }
	
	public function openOptions():void {
		closeDialogSignal.dispatch();
        clearInput();
		GameSprite.hidePreloader();
        layers.overlay.addChild(new Options(gs_));
	}
	
	public function activatePreset(preset:int, setstate:int = -1):void { //very nice code indeed
		var effTotal:int;
		var state:Boolean;
		var name:String;
		switch (preset) {
			case 1:
				name = Parameters.data_.dbPre1[0];
				effTotal = Parameters.data_.dbPre1[1];
				break;
			case 2:
				name = Parameters.data_.dbPre2[0];
				effTotal = Parameters.data_.dbPre2[1];
				break;
			case 3:
				name = Parameters.data_.dbPre3[0];
				effTotal = Parameters.data_.dbPre3[1];
				break;
		}
		if (effTotal == 0) {
			return;
		}
		if (setstate == -1) {
			switch (preset) {
				case 1:
					Parameters.data_.dbPre1[2] = !Parameters.data_.dbPre1[2];
					state = Parameters.data_.dbPre1[2];
					break;
				case 2:
					Parameters.data_.dbPre2[2] = !Parameters.data_.dbPre2[2];
					state = Parameters.data_.dbPre2[2];
					break;
				case 3:
					Parameters.data_.dbPre3[2] = !Parameters.data_.dbPre3[2];
					state = Parameters.data_.dbPre3[2];
					break;
			}
		}
		else if (setstate == 0) { //off
			switch (preset) {
				case 1:
					Parameters.data_.dbPre1[2] = false;
					state = Parameters.data_.dbPre1[2];
					break;
				case 2:
					Parameters.data_.dbPre2[2] = false;
					state = Parameters.data_.dbPre2[2];
					break;
				case 3:
					Parameters.data_.dbPre3[2] = false;
					state = Parameters.data_.dbPre3[2];
					break;
			}
		}
		else if (setstate == 1) {
			switch (preset) {
				case 1:
					Parameters.data_.dbPre1[2] = true;
					state = Parameters.data_.dbPre1[2];
					break;
				case 2:
					Parameters.data_.dbPre2[2] = true;
					state = Parameters.data_.dbPre2[2];
					break;
				case 3:
					Parameters.data_.dbPre3[2] = true;
					state = Parameters.data_.dbPre3[2];
					break;
			}
		}
		for (var i:int = 0; i < 11; i++) {
			if ((effTotal & 1 << i) != 0) {
				switch (i) {
					case 0:
						Parameters.data_.dbArmorBroken = state;
						break;
					case 1:
						Parameters.data_.dbBleeding = state;
						break;
					case 2:
						Parameters.data_.dbDazed = state;
						break;
					case 3:
						Parameters.data_.dbParalyzed = state;
						break;
					case 4:
						Parameters.data_.dbSick = state;
						break;
					case 5:
						Parameters.data_.dbSlowed = state;
						break;
					case 6:
						Parameters.data_.dbStunned = state;
						break;
					case 7:
						Parameters.data_.dbWeak = state;
						break;
					case 8:
						Parameters.data_.dbQuiet = state;
						break;
					case 9:
						Parameters.data_.dbPetStasis = state;
						break;
					case 10:
						Parameters.data_.dbPetrify = state;
						break;
				}
			}
		}
		Parameters.save();
		if (setstate != 0) {
			gs_.map.player_.notifyPlayer(state ? name+": On" : name+": Off", state ? 0xff0000 : 0x00ff00, 1500);
		}
	}
    
    private function selectAimMode() : void
    {
        var _loc1_:int = 0;
        var _loc2_:String = "";
        if (Parameters.data_.aimMode == undefined) {
            _loc1_ = 1;
        }
        else {
            _loc1_ = (Parameters.data_.aimMode + 1) % 3;
        }
        switch(_loc1_) {
            case 1:
                _loc2_ = "Aim Assist Mode: Highest HP";
                break;
            case 2:
                _loc2_ = "Aim Assist Mode: Closest";
                break;
            case 0:
                _loc2_ = "Aim Assist Mode: Closest to Cursor";
        }
        gs_.map.player_.levelUpEffect(_loc2_);
        Parameters.data_.aimMode = _loc1_;
    }

    private function onKeyUp(_arg_1:KeyboardEvent):void {
        var _local_2:Number;
        var _local_3:Number;
        switch (_arg_1.keyCode) {
            case Parameters.data_.moveUp:
                this.moveUp_ = 0;
                break;
            case Parameters.data_.moveDown:
                this.moveDown_ = 0;
                break;
            case Parameters.data_.moveLeft:
                this.moveLeft_ = 0;
                break;
            case Parameters.data_.moveRight:
                this.moveRight_ = 0;
                break;
            case Parameters.data_.rotateLeft:
                this.rotateLeft_ = 0;
                break;
            case Parameters.data_.rotateRight:
                this.rotateRight_ = 0;
                break;
            case Parameters.data_.useSpecial:
				this.specialKeyDown_ = false;
				if (!Parameters.data_.ninjaTap && !inputting) {
					gs_.map.player_.useAltWeapon(gs_.map.mouseX, gs_.map.mouseY, UseType.END_USE)
				}
                break;
        }
        this.setPlayerMovement();
    }

    private function setPlayerMovement():void {
        var _local_1:Player = this.gs_.map.player_;
        if (_local_1 != null) {
            if (enablePlayerInput_) {
                _local_1.setRelativeMovement(rotateRight_ - rotateLeft_, moveRight_ - moveLeft_, moveDown_ - moveUp_);
            }
            else {
                _local_1.setRelativeMovement(0, 0, 0);
            }
        }
    }

    private function useItem(_arg_1:int):void {
        /*if (this.tabStripModel.currentSelection == TabStripModel.BACKPACK) {
            _arg_1 = (_arg_1 + GeneralConstants.NUM_INVENTORY_SLOTS);
        }*/
        GameServerConnection.instance.useItem_new(this.gs_.map.player_, _arg_1);
    }

    private function togglePerformanceStats():void {
        if (this.gs_.contains(stats_)) {
            this.gs_.removeChild(stats_);
            this.gs_.removeChild(this.gs_.gsc_.jitterWatcher_);
            this.gs_.gsc_.disableJitterWatcher();
        }
        else {
            this.gs_.addChild(stats_);
            this.gs_.gsc_.enableJitterWatcher();
            this.gs_.gsc_.jitterWatcher_.y = stats_.height;
            this.gs_.addChild(this.gs_.gsc_.jitterWatcher_);
        }
    }

    private function toggleScreenShotMode():void {
        Parameters.screenShotMode_ = !(Parameters.screenShotMode_);
        if (Parameters.screenShotMode_) {
            this.gs_.hudView.visible = false;
            this.setTextBoxVisibility.dispatch(false);
        }
        else {
            this.gs_.hudView.visible = true;
            this.setTextBoxVisibility.dispatch(true);
        }
    }


}
}//package com.company.assembleegameclient.game
