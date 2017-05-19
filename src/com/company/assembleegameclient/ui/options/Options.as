package com.company.assembleegameclient.ui.options {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.game.MapUserInput;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.sound.Music;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.sound.SFX;
import com.company.assembleegameclient.ui.StatusBar;
import com.company.rotmg.graphics.ScreenGraphic;
import com.company.util.AssetLibrary;
import com.company.util.KeyCodes;
import kabam.rotmg.servers.api.Server;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.display.StageQuality;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.navigateToURL;
import flash.system.Capabilities;
import flash.text.TextFieldAutoSize;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import flash.ui.MouseCursorData;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.ui.UIUtils;
import kabam.rotmg.servers.model.LiveServerModel;

public class Options extends Sprite {

    private static const TABS:Vector.<String> = new < String > [TextKey.OPTIONS_CONTROLS, OPT_HOT, TextKey.OPTIONS_CHAT, TextKey.OPTIONS_GRAPHICS, TextKey.OPTIONS_SOUND, AUTOAIM_, ABILMENU,HPDISP_,DEBUFF_, AUTOABIL_,LOOT_,RECON_,SPRITE_,OTHER_,MISC_,DBKEYS_];
	private static const OPT_HOT:String = "Hotkeys ";
	private static const AUTOAIM_:String = "Auto Aim";
	private static const AUTOABIL_:String = "Tomb";
	private static const DEBUFF_:String = "Debuffs";
	private static const DBKEYS_:String = "Hotkeys";
	private static const HPDISP_:String = "Visual";
	private static const ABILMENU:String = "Ability";
	private static const LOOT_:String = "Loot";
	private static const RECON_:String = "Reconnect";
	private static const SPRITE_:String = "Sprite";
	private static const OTHER_:String = "Other";
	private static const MISC_:String = "Messages";
    public static const Y_POSITION:int = 550;
    public static const CHAT_COMMAND:String = "chatCommand";
    public static const CHAT:String = "chat";
    public static const TELL:String = "tell";
    public static const GUILD_CHAT:String = "guildChat";
    public static const SCROLL_CHAT_UP:String = "scrollChatUp";
    public static const SCROLL_CHAT_DOWN:String = "scrollChatDown";
    private static var registeredCursors:Vector.<String> = new Vector.<String>(0);

    private var gs_:GameSprite;
    private var continueButton_:TitleMenuOption;
    private var resetToDefaultsButton_:TitleMenuOption;
    private var homeButton_:TitleMenuOption;
    private var tabs_:Vector.<OptionsTabTitle>;
    private var selected_:OptionsTabTitle = null;
    private var options_:Vector.<Sprite>;

    public function Options(_arg_1:GameSprite) {
        var _local_2:TextFieldDisplayConcrete;
        var kier:int = 0;
        var _local_6:OptionsTabTitle;
        this.tabs_ = new Vector.<OptionsTabTitle>();
        this.options_ = new Vector.<Sprite>();
        super();
        this.gs_ = _arg_1;
        graphics.clear();
        graphics.beginFill(0x2B2B2B, 0.8);
        graphics.drawRect(0, 0, 800, 600);
        graphics.endFill();
        graphics.lineStyle(1, 0x5E5E5E);
        graphics.moveTo(0, 100);
        graphics.lineTo(800, 100);
        graphics.lineStyle();
        _local_2 = new TextFieldDisplayConcrete().setSize(32).setColor(0xFFFFFF);
        _local_2.setBold(true);
        _local_2.setStringBuilder(new LineBuilder().setParams(TextKey.OPTIONS_TITLE));
        _local_2.setAutoSize(TextFieldAutoSize.CENTER);
        _local_2.filters = [new DropShadowFilter(0, 0, 0)];
        _local_2.x = (400 - (_local_2.width / 2));
        _local_2.y = 8;
        addChild(_local_2);
        addChild(new ScreenGraphic());
        this.continueButton_ = new TitleMenuOption(TextKey.OPTIONS_CONTINUE_BUTTON, 36, false);
        this.continueButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.continueButton_.setAutoSize(TextFieldAutoSize.CENTER);
        this.continueButton_.addEventListener(MouseEvent.CLICK, this.onContinueClick);
        addChild(this.continueButton_);
        this.resetToDefaultsButton_ = new TitleMenuOption(TextKey.OPTIONS_RESET_TO_DEFAULTS_BUTTON, 22, false);
        this.resetToDefaultsButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.resetToDefaultsButton_.setAutoSize(TextFieldAutoSize.LEFT);
        this.resetToDefaultsButton_.addEventListener(MouseEvent.CLICK, this.onResetToDefaultsClick);
        addChild(this.resetToDefaultsButton_);
        this.homeButton_ = new TitleMenuOption(TextKey.OPTIONS_HOME_BUTTON, 22, false);
        this.homeButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.homeButton_.setAutoSize(TextFieldAutoSize.RIGHT);
        this.homeButton_.addEventListener(MouseEvent.CLICK, this.onHomeClick);
        addChild(this.homeButton_);
        var pad:int = 8;
		const perrow:int = 8;
        while (kier < TABS.length) {
            var _local_3:OptionsTabTitle = new OptionsTabTitle(TABS[kier]);
            _local_3.x = pad;
            _local_3.y = 50 + 25 * int(kier / perrow);
            if (kier % perrow == 0) {
               pad = 8;
               _local_3.x = pad;
            }
			if (kier == 8) { //debuffs tab
				_local_3.x = 8;
				_local_3.y = 70;
			}
			else if (kier == 15) { //debuffs
				_local_3.x = 8;
				_local_3.y = 85;
			}
            addChild(_local_3);
            _local_3.addEventListener(MouseEvent.CLICK, this.onTabClick);
            this.tabs_.push(_local_3);
            pad = pad + 800 / perrow;
            kier++;
        }
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private static function makePotionBuy():ChoiceOption {
        return (new ChoiceOption("contextualPotionBuy", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CONTEXTUAL_POTION_BUY, TextKey.OPTIONS_CONTEXTUAL_POTION_BUY_DESC, null));
    }

    private static function makeOnOffLabels():Vector.<StringBuilder> {
        return (new <StringBuilder>[makeLineBuilder(TextKey.OPTIONS_ON), makeLineBuilder(TextKey.OPTIONS_OFF)]);
    }

    private static function makeHighLowLabels():Vector.<StringBuilder> {
        return (new <StringBuilder>[new StaticStringBuilder("High"), new StaticStringBuilder("Low")]);
    }

    private static function makeCursorSelectLabels():Vector.<StringBuilder> {
        return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("ProX"), new StaticStringBuilder("X2"), new StaticStringBuilder("X3"), new StaticStringBuilder("X4"), new StaticStringBuilder("Corner1"), new StaticStringBuilder("Corner2"), new StaticStringBuilder("Symb"), new StaticStringBuilder("Alien"), new StaticStringBuilder("Xhair"), new StaticStringBuilder("Dystopia+")]);
    }

    private static function makeLineBuilder(_arg_1:String):LineBuilder {
        return (new LineBuilder().setParams(_arg_1));
    }

    private static function makeClickForGold():ChoiceOption {
        return (new ChoiceOption("clickForGold", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CLICK_FOR_GOLD, TextKey.OPTIONS_CLICK_FOR_GOLD_DESC, null));
    }

    private static function onUIQualityToggle():void {
        UIUtils.toggleQuality(Parameters.data_.uiQuality);
    }

    private static function onBarTextToggle():void {
        StatusBar.barTextSignal.dispatch(Parameters.data_.toggleBarText);
    }

    public static function refreshCursor():void {
        var _local_1:MouseCursorData;
        var _local_2:Vector.<BitmapData>;
        if (((!((Parameters.data_.cursorSelect == MouseCursor.AUTO))) && ((registeredCursors.indexOf(Parameters.data_.cursorSelect) == -1)))) {
            _local_1 = new MouseCursorData();
            _local_1.hotSpot = new Point(15, 15);
            _local_2 = new Vector.<BitmapData>(1, true);
            _local_2[0] = AssetLibrary.getImageFromSet("cursorsEmbed", int(Parameters.data_.cursorSelect));
            _local_1.data = _local_2;
            Mouse.registerCursor(Parameters.data_.cursorSelect, _local_1);
            registeredCursors.push(Parameters.data_.cursorSelect);
        }
        Mouse.cursor = Parameters.data_.cursorSelect;
    }

    private static function makeDegreeOptions():Vector.<StringBuilder> {
        return (new <StringBuilder>[new StaticStringBuilder("45°"), new StaticStringBuilder("0°")]);
    }
    
    private function BoundingDistValues() : Vector.<StringBuilder>
    {
        return new <StringBuilder>[new StaticStringBuilder("1"),new StaticStringBuilder("2"),new StaticStringBuilder("3"),new StaticStringBuilder("4"),new StaticStringBuilder("5"),new StaticStringBuilder("6"),new StaticStringBuilder("7"),new StaticStringBuilder("8"),new StaticStringBuilder("9"),new StaticStringBuilder("10"),new StaticStringBuilder("15"),new StaticStringBuilder("20")];
    }
    
    private function ZeroSix() : Vector.<StringBuilder>
    {
        return new <StringBuilder>[new StaticStringBuilder("0"),new StaticStringBuilder("1"),new StaticStringBuilder("2"),new StaticStringBuilder("3"),new StaticStringBuilder("4"),new StaticStringBuilder("5"),new StaticStringBuilder("6")];
    }
    
    private function ZeroThirteen() : Vector.<StringBuilder>
    {
        return new <StringBuilder>[new StaticStringBuilder("0"),new StaticStringBuilder("1"),new StaticStringBuilder("2"),new StaticStringBuilder("3"),new StaticStringBuilder("4"),new StaticStringBuilder("5"),new StaticStringBuilder("6"),new StaticStringBuilder("7"),new StaticStringBuilder("8"),new StaticStringBuilder("9"),new StaticStringBuilder("10"),new StaticStringBuilder("11"),new StaticStringBuilder("12"),new StaticStringBuilder("13")];
    }
    
    private function ZeroTwelve() : Vector.<StringBuilder>
    {
        return new <StringBuilder>[new StaticStringBuilder("0"),new StaticStringBuilder("1"),new StaticStringBuilder("2"),new StaticStringBuilder("3"),new StaticStringBuilder("4"),new StaticStringBuilder("5"),new StaticStringBuilder("6"),new StaticStringBuilder("7"),new StaticStringBuilder("8"),new StaticStringBuilder("9"),new StaticStringBuilder("10"),new StaticStringBuilder("11"),new StaticStringBuilder("12")];
    }

    private static function onDefaultCameraAngleChange():void {
        Parameters.data_.cameraAngle = Parameters.data_.defaultCameraAngle;
        Parameters.save();
    }


    private function onContinueClick(_arg_1:MouseEvent):void {
        this.close();
    }

    private function onResetToDefaultsClick(_arg_1:MouseEvent):void {
        var _local_3:BaseOption;
        var _local_2:int;
        while (_local_2 < this.options_.length) {
            _local_3 = (this.options_[_local_2] as BaseOption);
            if (_local_3 != null) {
                delete Parameters.data_[_local_3.paramName_];
            }
            _local_2++;
        }
        Parameters.setDefaults();
        Parameters.save();
        this.refresh();
    }

    private function onHomeClick(_arg_1:MouseEvent):void {
        this.close();
        this.gs_.closed.dispatch();
    }

    private function onTabClick(_arg_1:MouseEvent):void {
        var _local_2:OptionsTabTitle = (_arg_1.currentTarget as OptionsTabTitle);
        this.setSelected(_local_2);
    }

    private function setSelected(_arg_1:OptionsTabTitle):void {
        if (_arg_1 == this.selected_) {
            return;
        }
        if (this.selected_ != null) {
            this.selected_.setSelected(false);
        }
        this.selected_ = _arg_1;
        this.selected_.setSelected(true);
        this.removeOptions();
        switch (this.selected_.text_) { //aaopt
            case TextKey.OPTIONS_CONTROLS:
                this.addControlsOptions();
                return;
            case OPT_HOT:
                this.addHotKeysOptions();
                return;
            case TextKey.OPTIONS_CHAT:
                this.addChatOptions();
                return;
            case TextKey.OPTIONS_GRAPHICS:
                this.addGraphicsOptions();
                return;
            case TextKey.OPTIONS_SOUND:
                this.addSoundOptions();
                return;
            /*case TextKey.OPTIONS_MISC:
                this.addMiscOptions();
                return;
            case TextKey.OPTIONS_FRIEND:
                this.addFriendOptions();
                return;
            case "Experimental":
                this.addExperimentalOptions();
                return;*/
			case DEBUFF_:
				nillyDebuffs();
				return;
			case OTHER_:
				nillyOther();
				return;
			case SPRITE_:
				spriteWorld();
				return;
			case AUTOAIM_:
				aimAssist();
				return;
			case ABILMENU:
				abilOptions();
				return;
			case HPDISP_:
				hpBars();
				return;
			case LOOT_:
				lootNotif();
				return;
			case RECON_:
				recon();
				return;
			case MISC_:
				miscMenu();
				return;
			case AUTOABIL_:
				autoAbility();
				return;
			case DBKEYS_:
				dbKeys();
				return;
        }
    }

    private function onAddedToStage(_arg_1:Event):void {
		MapUserInput.optionsOpen = true;
        this.continueButton_.x = 400;
        this.continueButton_.y = Y_POSITION;
        this.resetToDefaultsButton_.x = 20;
        this.resetToDefaultsButton_.y = Y_POSITION;
        this.homeButton_.x = 780;
        this.homeButton_.y = Y_POSITION;
        this.setSelected(this.tabs_[8]); //which tab we start on
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false, 1);
        stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false, 1);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
		MapUserInput.optionsOpen = false;
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false);
        stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false);
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        if (_arg_1.keyCode == Parameters.data_.options) {
            this.close();
        }
        _arg_1.stopImmediatePropagation();
    }

    private function close():void {
        stage.focus = null;
        parent.removeChild(this);
    }

    private function onKeyUp(_arg_1:KeyboardEvent):void {
        _arg_1.stopImmediatePropagation();
    }

    private function removeOptions():void {
        var _local_1:Sprite;
        for each (_local_1 in this.options_) {
            removeChild(_local_1);
        }
        this.options_.length = 0;
    }

    private function addControlsOptions():void {
        this.addOptionAndPosition(new KeyMapper("moveUp", TextKey.OPTIONS_MOVE_UP, TextKey.OPTIONS_MOVE_UP_DESC));
        this.addOptionAndPosition(new KeyMapper("moveLeft", TextKey.OPTIONS_MOVE_LEFT, TextKey.OPTIONS_MOVE_LEFT_DESC));
        this.addOptionAndPosition(new KeyMapper("moveDown", TextKey.OPTIONS_MOVE_DOWN, TextKey.OPTIONS_MOVE_DOWN_DESC));
        this.addOptionAndPosition(new KeyMapper("moveRight", TextKey.OPTIONS_MOVE_RIGHT, TextKey.OPTIONS_MOVE_RIGHT_DESC));
        this.addOptionAndPosition(this.makeAllowCameraRotation());
        this.addOptionAndPosition(this.makeAllowMiniMapRotation());
        this.addOptionAndPosition(new KeyMapper("rotateLeft", TextKey.OPTIONS_ROTATE_LEFT, TextKey.OPTIONS_ROTATE_LEFT_DESC, !(Parameters.data_.allowRotation)));
        this.addOptionAndPosition(new KeyMapper("rotateRight", TextKey.OPTIONS_ROTATE_RIGHT, TextKey.OPTIONS_ROTATE_RIGHT_DESC, !(Parameters.data_.allowRotation)));
        this.addOptionAndPosition(new KeyMapper("useSpecial", TextKey.OPTIONS_USE_SPECIAL_ABILITY, TextKey.OPTIONS_USE_SPECIAL_ABILITY_DESC));
        this.addOptionAndPosition(new KeyMapper("autofireToggle", TextKey.OPTIONS_AUTOFIRE_TOGGLE, TextKey.OPTIONS_AUTOFIRE_TOGGLE_DESC));
        this.addOptionAndPosition(new KeyMapper("toggleHPBar", TextKey.OPTIONS_TOGGLE_HPBAR, TextKey.OPTIONS_TOGGLE_HPBAR_DESC));
        this.addOptionAndPosition(new KeyMapper("resetToDefaultCameraAngle", "Reset to Default Camera Angle", TextKey.OPTIONS_RESET_CAMERA_DESC));
        this.addOptionAndPosition(new KeyMapper("togglePerformanceStats", TextKey.OPTIONS_TOGGLE_PERFORMANCE_STATS, TextKey.OPTIONS_TOGGLE_PERFORMANCE_STATS_DESC));
        this.addOptionAndPosition(new KeyMapper("toggleCentering", TextKey.OPTIONS_TOGGLE_CENTERING, TextKey.OPTIONS_TOGGLE_CENTERING_DESC));
        this.addOptionAndPosition(new KeyMapper("interact", TextKey.OPTIONS_INTERACT_OR_BUY, TextKey.OPTIONS_INTERACT_OR_BUY_DESC));
        this.addOptionAndPosition(makeClickForGold());
        //this.addOptionAndPosition(makePotionBuy());
    }
    
    private function showMobInfo_() : void
    {
        if(!Parameters.data_.showMobInfo && gs_.map.mapOverlay_ != null)
        {
            gs_.map.mapOverlay_.removeChildren(0);
        }
    }
    
	//fullscreen
    private function scaleui() : void
    {
        Parameters.root.dispatchEvent(new Event(Event.RESIZE));
    }
        
	private function fsv3() : void
	{
		stage.scaleMode = Parameters.data_.stageScale;
		Parameters.root.dispatchEvent(new Event(Event.RESIZE));
		fsv3_options();
	}
        
	private function fsv3_options() : void
	{
		var _loc1_:ChoiceOption;
		var _loc2_:int = 0;
		for each(_loc1_ in options_) {
			if (_loc1_.paramName_ == "uiscale") {
				_loc1_.enable(Parameters.data_.stageScale == StageScaleMode.EXACT_FIT);
			}
		}
	}
	
    private function updateEffId() : void
    {
        var _loc1_:ChoiceOption;
        var _loc2_:int;
        while(_loc2_ < options_.length) {
            _loc1_ = options_[_loc2_] as ChoiceOption;
            if (_loc1_ != null) {
                if (_loc1_.paramName_ == "noOption") {
                    _loc1_.setDescription(new StaticStringBuilder("Current Effect ID: "+calcEffId()));
                }
            }
            _loc2_++;
        }
	}
      
    private function nillyDebuffs() : void
    {
        addOptionAndPosition(new ChoiceOption("dbArmorBroken",makeOnOffLabels(),[true,false],"Armor Broken","Red means you will take this status effect. Increases risk of getting disconnected when turned off.",updateEffId,Parameters.data_.dbArmorBroken ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbBlind",makeOnOffLabels(),[true,false],"Blind","Red means you will take this status effect.",null,Parameters.data_.dbBlind ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbBleeding",makeOnOffLabels(),[true,false],"Bleeding","Red means you will take this status effect. Increases risk of getting disconnected when turned off.",updateEffId,Parameters.data_.dbBleeding ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbConfused",makeOnOffLabels(),[true,false],"Confused","Red means you will take this status effect.",null,Parameters.data_.dbConfused ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbDazed",makeOnOffLabels(),[true,false],"Dazed","Red means you will take this status effect. Increases risk of getting disconnected when turned off.",updateEffId,Parameters.data_.dbDazed ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbDarkness",makeOnOffLabels(),[true,false],"Darkness","Red means you will take this status effect.",null,Parameters.data_.dbDarkness ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbParalyzed",makeOnOffLabels(),[true,false],"Paralyzed","Red means you will take this status effect. Increases risk of getting disconnected when turned off.",updateEffId,Parameters.data_.dbParalyzed ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbDrunk",makeOnOffLabels(),[true,false],"Drunk","Red means you will take this status effect.",null,Parameters.data_.dbDrunk ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbSick",makeOnOffLabels(),[true,false],"Sick","Red means you will take this status effect. Increases risk of getting disconnected when turned off.",updateEffId,Parameters.data_.dbSick ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbHallucinating",makeOnOffLabels(),[true,false],"Hallucinating","Red means you will take this status effect.",null,Parameters.data_.dbHallucinating ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbSlowed",makeOnOffLabels(),[true,false],"Slowed","Red means you will take this status effect. Increases risk of getting disconnected when turned off.",updateEffId,Parameters.data_.dbSlowed ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbUnstable",makeOnOffLabels(),[true,false],"Unstable","Red means you will take this status effect.",unstableAbil_options,Parameters.data_.dbUnstable ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbStunned",makeOnOffLabels(),[true,false],"Stunned","Red means you will take this status effect. Increases risk of getting disconnected when turned off.",updateEffId,Parameters.data_.dbStunned ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbUnstableAbil",makeOnOffLabels(),[true,false],"Unstable Ability","Red means your ability will be affected by unstable. Unstable must be turned off for this to have an effect",null,Parameters.data_.dbUnstableAbil ? 0xFF0000 : 0xFFFFFF, true));
        unstableAbil_options();
		addOptionAndPosition(new ChoiceOption("dbWeak",makeOnOffLabels(),[true,false],"Weak","Red means you will take this status effect. Increases risk of getting disconnected when turned off.",updateEffId,Parameters.data_.dbWeak ? 0xFF0000 : 0xFFFFFF, true));
		addOptionAndPosition(new ChoiceOption("noOption",new <StringBuilder>[new StaticStringBuilder("")],[],"Current Effect ID: "+calcEffId(),"Turn on the effects that you want to toggle and use the value displayed here to set a hotkey for it.",null));
        addOptionAndPosition(new ChoiceOption("dbQuiet",makeOnOffLabels(),[true,false],"Quiet","Red means you will take this status effect. Increases risk of getting disconnected when turned off.",quietCastle_options,Parameters.data_.dbQuiet ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbQuietCastle",makeOnOffLabels(),[true,false],"Quiet in Castle","This should be turned on. If you choose not to take quiet in castle you're almost guaranteed to get disconnected.",null,Parameters.data_.dbQuietCastle ? 0xFFFFFF : 0xFF0000, true));
        addOptionAndPosition(new ChoiceOption("dbPetStasis",makeOnOffLabels(),[true,false],"Pet Stasis","Red means you will take this status effect. Increases risk of getting disconnected when turned off.",updateEffId,Parameters.data_.dbPetStasis ? 0xFF0000 : 0xFFFFFF, true));
        addOptionAndPosition(new ChoiceOption("dbPetrify",makeOnOffLabels(),[true,false],"Petrify","Red means you will take this status effect. Increases risk of getting disconnected when turned off.",updateEffId,Parameters.data_.dbPetrify ? 0xFF0000 : 0xFFFFFF, true));
        quietCastle_options();
    }
      
    private function dbKeys() : void
    {
        addOptionAndPosition(new KeyMapper("kdbArmorBroken", "Armor Broken", "Toggles the effect."));
        addOptionAndPosition(new KeyMapper("kdbPre1", Parameters.data_.dbPre1[0], "EffectId: "+Parameters.data_.dbPre1[1]+"\\nUse /eff 1 <effect id> <name> to change this preset."));
        addOptionAndPosition(new KeyMapper("kdbBleeding", "Bleeding", "Toggles the effect."));
        addOptionAndPosition(new KeyMapper("kdbPre2", Parameters.data_.dbPre2[0], "EffectId: "+Parameters.data_.dbPre2[1]+"\\nUse /eff 2 <effect id> <name> to change this preset."));
        addOptionAndPosition(new KeyMapper("kdbDazed", "Dazed", "Toggles the effect"));
        addOptionAndPosition(new KeyMapper("kdbPre3", Parameters.data_.dbPre3[0], "EffectId: "+Parameters.data_.dbPre3[1]+"\\nUse /eff 3 <effect id> <name> to change this preset."));
        addOptionAndPosition(new KeyMapper("kdbParalyzed", "Paralyzed", "Toggles the effect."));
		addOptionAndPosition(new ChoiceOption("deactPre",makeOnOffLabels(),[true,false],"Auto Deactivate Presets","Deactivates presets when leaving a dungeon.",null));
        addOptionAndPosition(new KeyMapper("kdbSick", "Sick", "Toggles the effect."));
		addOptionAndPosition(new NullOption());
        addOptionAndPosition(new KeyMapper("kdbSlowed", "Slowed", "Toggles the effect."));
		addOptionAndPosition(new NullOption());
        addOptionAndPosition(new KeyMapper("kdbStunned", "Stunned", "Toggles the effect."));
		addOptionAndPosition(new NullOption());
        addOptionAndPosition(new KeyMapper("kdbWeak", "Weak", "Toggles the effect."));
		addOptionAndPosition(new NullOption());
        addOptionAndPosition(new KeyMapper("kdbQuiet", "Quiet", "Toggles the effect."));
        addOptionAndPosition(new KeyMapper("kdbAll", "All", "Toggles all effects that can disconnect you."));
        addOptionAndPosition(new KeyMapper("kdbPetStasis", "Pet Stasis", "Toggles the effect."));
        addOptionAndPosition(new KeyMapper("kdbPetrify", "Petrify", "Toggles the effect."));
    }
	
	private function calcEffId():int {
		var i:int = 0;
		if (Parameters.data_.dbArmorBroken) {
			i += 1;
		}
		if (Parameters.data_.dbBleeding) {
			i += 2;
		}
		if (Parameters.data_.dbDazed) {
			i += 4;
		}
		if (Parameters.data_.dbParalyzed) {
			i += 8;
		}
		if (Parameters.data_.dbSick) {
			i += 16;
		}
		if (Parameters.data_.dbSlowed) {
			i += 32;
		}
		if (Parameters.data_.dbStunned) {
			i += 64;
		}
		if (Parameters.data_.dbWeak) {
			i += 128;
		}
		if (Parameters.data_.dbQuiet) {
			i += 256;
		}
		if (Parameters.data_.dbPetStasis) {
			i += 512;
		}
		if (Parameters.data_.dbPetrify) {
			i += 1024;
		}
		return i;
	}
      
    private function quietCastle_options() : void
    {
		updateEffId();
        var _loc1_:ChoiceOption;
        var _loc2_:int;
        while(_loc2_ < options_.length)
        {
            _loc1_ = options_[_loc2_] as ChoiceOption;
            if(_loc1_ != null)
            {
                if(_loc1_.paramName_ == "dbQuietCastle") //BaseOption
                {
                    _loc1_.enable(Parameters.data_.dbQuiet);
                }
            }
            _loc2_++;
        }
	}
      
    private function unstableAbil_options() : void
    {
        var _loc1_:ChoiceOption;
        var _loc2_:int;
        while(_loc2_ < options_.length)
        {
            _loc1_ = options_[_loc2_] as ChoiceOption;
            if(_loc1_ != null)
            {
                if(_loc1_.paramName_ == "dbUnstableAbil") //BaseOption
                {
                    _loc1_.enable(!Parameters.data_.dbUnstable);
                }
            }
            _loc2_++;
        }
	}
        
	private function spriteWorld() : void {
		addOptionAndPosition(new ChoiceOption("SWNoSlow",makeOnOffLabels(),[true,false],"No Slow","Disable slow debuff while in Sprite World.",null));
		addOptionAndPosition(new ChoiceOption("NoClip",makeOnOffLabels(),[true,false],"No-Clip","Enable no-clip while in Sprite World.",null));
		addOptionAndPosition(new ChoiceOption("SWNoTileMove",makeOnOffLabels(),[true,false],"No Tile Movement","Disable tile movement in Sprite World.",null));
		addOptionAndPosition(new ChoiceOption("SWTrees",makeOnOffLabels(),[true,false],"Disable Trees","Removes trees in Sprite World.",null));
		addOptionAndPosition(new ChoiceOption("SWSpeed", makeOnOffLabels(), [true, false], "Speed Hack", "Move 60% faster.", null));
		addOptionAndPosition(new ChoiceOption("leaveSprite", makeOnOffLabels(), [true, false], "Panic Mode", "Automatically turns off all sprite hacks if someone else is in the same sprite world with you.", null));
		addOptionAndPosition(new ChoiceOption("SWLight", makeOnOffLabels(), [true, false], "Lightspeed", "Move 400% faster. Lightspeed is automatically enabled when you enter a Sprite World.", null));
		addOptionAndPosition(new KeyMapper("SWLightKey","Toggle Lightspeed","Toggles between lightspeed and boosted speed in Sprite World."));
		addOptionAndPosition(new ChoiceOption("autoSprite", makeOnOffLabels(), [true, false], "Auto Sprite", "Start at boss room and autofollow the boss. Not recommended to be used with lightspeed.", null));
		addOptionAndPosition(new KeyMapper("kautoSprite","Toggle Auto Sprite","Toggles auto sprite."));
	}
    
    private function aimAssist():void {
        addOptionAndPosition(new ChoiceOption("AAAddOne",makeOnOffLabels(),[true,false],"+0.5 Search Radius","Increase the range at which auto aim will lock on and shoot at mobs by half a tile.",null));
        addOptionAndPosition(new KeyMapper("AAHotkey","Auto Aim","A key that toggles auto aim on and off."));
        addOptionAndPosition(new ChoiceOption("AABoundingDist",BoundingDistValues(),[1,2,3,4,5,6,7,8,9,10,15,20],"Bounding Distance","Restrict auto aim to see only as far as the bounding distance from the mouse cursor in closest to cursor aim mode.",null));
        addOptionAndPosition(new KeyMapper("AAModeHotkey","Cycle Mode","Key that will cycle through the various auto aim modes."));
        addOptionAndPosition(new ChoiceOption("damageIgnored",makeOnOffLabels(),[true,false],"Damage Ignore Mobs","Damage mobs on auto aim ignore list.",null));
		addOptionAndPosition(new ChoiceOption("PassesCover",makeOnOffLabels(),[true,false],"Projectile No-Clip","Toggle allowing projectiles to pass through solid objects as well as invulnerable enemies. Only you can see the effect.",null));
        addOptionAndPosition(new ChoiceOption("AATargetLead",makeOnOffLabels(),[true,false],"Target Lead","Enables leading of targets.",null));
        addOptionAndPosition(new KeyMapper("tPassCover","Toggle Projectile No-Clip","Toggles the hack on and off."));
    }
    
    private function abilOptions():void {
        addOptionAndPosition(new ChoiceOption("perfectBomb",makeOnOffLabels(),[true,false],"Spell Bomb and Poison Aim","Targets the mob with highest max health in 15 tile radius from the player.",pbOptions));
		addOptionAndPosition(new KeyMapper("pbToggle", "Toggle Ability Aim", "Toggles ability aim."));
        addOptionAndPosition(new ChoiceOption("perfectQuiv", makeOnOffLabels(), [true, false], "Quiver Aim", "Targets the mob closest to cursor.", null));
        addOptionAndPosition(new ChoiceOption("perfectLead", makeOnOffLabels(), [true, false], "Ability Aim Target Lead", "Enables leading of ability aim targets.", null));
        addOptionAndPosition(new ChoiceOption("perfectStun", makeOnOffLabels(), [true, false], "Shield Aim", "Targets the mob closest to cursor.", null));
        addOptionAndPosition(new ChoiceOption("inaccurate", makeOnOffLabels(), [true, false], "Inaccurate Ability Aim", "Look more legit by aiming inaccurately.", null));
		addOptionAndPosition(new ChoiceOption("autoAbil", makeOnOffLabels(), [true, false], "Auto Ability", "Automatically uses your ability on warrior, paladin and rogue. Activated by pressing space.", null));
		addOptionAndPosition(new ChoiceOption("palaSpam", makeOnOffLabels(), [true, false], "Spam Paladin Ability", "Uses paladin ability every 0.5 seconds if auto ability is enabled", null));
		addOptionAndPosition(new ChoiceOption("spellVoid", makeOnOffLabels(), [true, false], "Unsafe Prism Use", "Allows using prism through walls. If you land on void you will get disconnected.", null));
        addOptionAndPosition(new KeyMapper("maxPrism","Teleport Max Distance","Always teleports the maximum distance on Trickster. You will have to stand still for this to work."));
		addOptionAndPosition(new ChoiceOption("ninjaTap",makeOnOffLabels(),[true,false],"One-Tap Ninja Ability","Makes space toggle the state of the ability. Tap to turn on, tap to turn off.",null));
		addOptionAndPosition(new ChoiceOption("speedy",makeOnOffLabels(),[true,false],"Disable Speedy","Makes your character unaffected by speedy. Helps with warrior helms.",null));
		addOptionAndPosition(new ChoiceOption("priestAA",makeOnOffLabels(),[true,false],"Prot Auto Ability","Keeps you armored on a priest when using Tome of Holy Protection. For infinite boost, a level 79 magic heal pet is required.",null));
		addOptionAndPosition(new ChoiceOption("abilTimer",makeOnOffLabels(),[true,false],"Ability Timer","Shows time remaining on abilities that give buffs.",null));
		pbOptions();
    }
      
    private function pbOptions():void {
        var _loc1_:ChoiceOption;
        var _loc2_:int;
        while(_loc2_ < options_.length) {
            _loc1_ = options_[_loc2_] as ChoiceOption;
            if (_loc1_ != null) {
                if (_loc1_.paramName_ == "perfectQuiv") {
                    _loc1_.enable(!Parameters.data_.perfectBomb);
                }
				else if (_loc1_.paramName_ == "perfectStun") {
                    _loc1_.enable(!Parameters.data_.perfectBomb);
                }
				else if (_loc1_.paramName_ == "perfectLead") {
                    _loc1_.enable(!Parameters.data_.perfectBomb);
                }
				else if (_loc1_.paramName_ == "pbToggle") {
                    _loc1_.enable(!Parameters.data_.perfectBomb);
                }
            }
            _loc2_++;
        }
	}
    
    private function lootNotif() : void
    {
        addOptionAndPosition(new ChoiceOption("LNAbility",ZeroSix(),[0,1,2,3,4,5,6],"Min Ability Tier","Minimum tier at which notifications and auto loot will function for ability items.",updateWanted));
        addOptionAndPosition(new ChoiceOption("AutoLootOn",makeOnOffLabels(),[true,false],"Auto Loot","Items looted depend on min ability, ring, weapon, and armor tier settings.",loot_options));
        addOptionAndPosition(new ChoiceOption("LNRing",ZeroSix(),[0,1,2,3,4,5,6],"Min Ring Tier","Minimum tier at which notifications and auto loot will function for rings.",updateWanted));
        addOptionAndPosition(new ChoiceOption("showLootNotifs",makeOnOffLabels(),[true,false],"Show Loot Notifications","Show text notifications that tells the user what's in loot bags.",loot_options));
        addOptionAndPosition(new ChoiceOption("LNWeap",ZeroTwelve(),[0,1,2,3,4,5,6,7,8,9,10,11,12],"Min Weapon Tier","Minimum tier at which notifications and auto loot will function for weapons.",updateWanted));
        addOptionAndPosition(new NullOption());
        addOptionAndPosition(new ChoiceOption("LNArmor",ZeroThirteen(),[0,1,2,3,4,5,6,7,8,9,10,11,12,13],"Min Armor Tier","Minimum tier at which notifications and auto loot will function for armor.",updateWanted));
        addOptionAndPosition(new NullOption());
        addOptionAndPosition(new ChoiceOption("potsMajor",makeOnOffLabels(),[true,false],"Loot LIFE/MANA/ATT/DEF","High value potions.",updateWanted));
        addOptionAndPosition(new ChoiceOption("lootHP",makeOnOffLabels(),[true,false],"Loot HP Potions to Inventory","Loots health potions from ground to inventory.",null));
        addOptionAndPosition(new ChoiceOption("potsMinor",makeOnOffLabels(),[true,false],"Loot SPD/DEX/VIT/WIS","Low value potions.",updateWanted));
        addOptionAndPosition(new ChoiceOption("lootMP",makeOnOffLabels(),[true,false],"Loot MP Potions to Inventory","Loots magic potions from ground to inventory.",null));
        addOptionAndPosition(new ChoiceOption("drinkPot",makeOnOffLabels(),[true,false],"Drink Excess Potions","Drinks potions when an item is about to be looted on its slot.",null));
        addOptionAndPosition(new ChoiceOption("grandmaMode",makeOnOffLabels(),[true,false],"Large Loot Bags and Chests","For those of you who are legally blind.",null));
        loot_options();
    }
    
    private function updateWanted() : void
    {
        Player.wantedList = null;
        gs_.map.player_.genWantedList();
    }
    
    private function loot_options() : void
    {
        var _loc1_:ChoiceOption = null;
        var _loc2_:int = 0;
        while(_loc2_ < options_.length)
        {
            _loc1_ = options_[_loc2_] as ChoiceOption;
            if(_loc1_ != null)
            {
                if(_loc1_.paramName_ == "LNAbility" || _loc1_.paramName_ == "LNRing" || _loc1_.paramName_ == "LNWeap" || _loc1_.paramName_ == "LNArmor" || _loc1_.paramName_ == "potsMajor" || _loc1_.paramName_ == "potsMinor")
                {
                    _loc1_.enable(Parameters.data_.AutoLootOn == false && Parameters.data_.showLootNotifs == false);
                }
            }
            _loc2_++;
        }
    }
    
    private function recon() : void
    {
        addOptionAndPosition(new KeyMapper("ReconRealm","Recon Realm","Key that connects the user to the last realm in."));
        addOptionAndPosition(new NullOption());
        addOptionAndPosition(new KeyMapper("ReconDung","Recon Dungeon","Key that connects the user to the last dungeon in. Only works when used within three minutes of connecting to the dungeon."));
        addOptionAndPosition(new NullOption());
        addOptionAndPosition(new KeyMapper("ReconVault", "Recon Vault", "Key that connects the user to their vault."));
		addOptionAndPosition(new NullOption());
        addOptionAndPosition(new KeyMapper("ReconRandom","Connect to Random Realm","Key that connects the user to a random realm on the server."));
    }
    
    private function hpBars() : void
    {
		addOptionAndPosition(new ChoiceOption("stageScale",makeOnOffLabels(),[StageScaleMode.NO_SCALE,StageScaleMode.EXACT_FIT],"Fullscreen v3","Extends viewing area at a cost of lower fps.",this.fsv3));
        addOptionAndPosition(new ChoiceOption("uiscale", makeOnOffLabels(), [true, false], "Scale UI", "Scales the UI to fit the screen.", this.scaleui));
		fsv3_options();
        addOptionAndPosition(new ChoiceOption("STDamage", makeOnOffLabels(), [true, false], "Show Damage", "Show damage done to players and enemies.", null));
		addOptionAndPosition(new ChoiceOption("showSkins", makeOnOffLabels(), [true, false], "Show Skins", "Forces default skin to everyone when turned off.", null));
        addOptionAndPosition(new ChoiceOption("STHealth",makeOnOffLabels(),[true,false],"Show Health","Show total health points of players and enemies as they take damage.",null));
		addOptionAndPosition(new ChoiceOption("showPests", makeOnOffLabels(), [true, false], "Show Pets", "Animal abuse.", null));
        addOptionAndPosition(new ChoiceOption("STColor", makeOnOffLabels(), [true, false], "Dynamic Color", "Changes the status text color based on the percentage of health the player or enemy has.", null));
        addOptionAndPosition(new ChoiceOption("showDyes", makeOnOffLabels(), [true, false], "Show Dyes", "Makes every player use the default dye.", null));
		addOptionAndPosition(new ChoiceOption("InvViewer",makeOnOffLabels(),[true,false],"Inventory Viewer","See the inventory items of other players.",null));
		addOptionAndPosition(new ChoiceOption("StatsViewer",makeOnOffLabels(),[true,false],"Stat Viewer","See the stats of other players.",null));
		addOptionAndPosition(new ChoiceOption("lockHighlight",makeOnOffLabels(),[true,false],"Highlight Locked Players","Highlights locked players name and minimap dot. Requires reloading of area for changes to take effect.",null));
		addOptionAndPosition(new ChoiceOption("HidePlayerFilter",makeOnOffLabels(),[true,false],"Star Requirement (Hide)","Hide players in nexus that are filtered by the star requirement option.",null));
        addOptionAndPosition(new ChoiceOption("AntiLag",makeOnOffLabels(),[true,false],"Anti Lag","Aggressively disables particles.",null));
		addOptionAndPosition(new ChoiceOption("showMobInfo",makeOnOffLabels(),[true,false],"Display Mob Info","Display mob name and id. Useful for finding ids for use with auto aim exception and ignore list.",showMobInfo_));
		addOptionAndPosition(new ChoiceOption("questClosest",makeOnOffLabels(),[true,false],"Show Closest Player to Quest","Extends the quest bar to show closest player to quest and the distance from it.",null));
        addOptionAndPosition(new ChoiceOption("clientSwap",makeOnOffLabels(),[true,false],"Disable Client Swap","Prevents items from teleporting out of your inventory or moving back after switching positions.",null));
		addOptionAndPosition(new ChoiceOption("sizer", makeOnOffLabels(), [true, false], "Shrink Large Objects", "The default setting on other version of CrazyClient, now toggleable.", null));
    }
        
    private function nillyOther() : void
    {
		addOptionAndPosition(new ChoiceOption("AutoNexus",AutoNexusValues(),[0,15,20,25,30],"Auto Nexus","Will attempt to Nexus the player when health drops below the given percentage. You can still die with this on.",null));
		addOptionAndPosition(new ChoiceOption("autoHealP",AutoHealValues(),[0,50,55,60,65,70,75,80],"Auto Heal","Heals you once your HP drops low enough on priest or paladin.",null));
		addOptionAndPosition(new ChoiceOption("autoPot",AutoPotValues(),[0,50,55,60,65,70,75,80],"Auto Pot","Automatically drink a potion if your hp falls below a certain percentage.",null));
		addOptionAndPosition(new ChoiceOption("bestServ", ServerPrefValues(), ["Default", "USWest", "USMidWest", "EUWest", "USEast", "AsiaSouthEast", "USSouth", "USSouthWest", "EUEast", "EUNorth", "EUSouthWest", "USEast3", "USWest2", "USMidWest2", "USEast2", "USNorthWest", "AsiaEast", "USSouth3", "EUNorth2", "EUWest2", "EUSouth", "USSouth2", "USWest3"], "Best Server", "Select your best server.", null));
		
		addOptionAndPosition(new ChoiceOption("TradeDelay",makeOnOffLabels(),[true,false],"Disable Trade Delay","Removes trade delay. Indicator still shows.",null));
		addOptionAndPosition(new ChoiceOption("SafeWalk",makeOnOffLabels(),[true,false],"Safe Walk","Block movement onto tiles that cause damage. Click and hold left mouse to walk over these tiles.",null));
        addOptionAndPosition(new ChoiceOption("slideOnIce", makeOnOffLabels(), [true, false], "Slide on Ice", "Toggles sliding on ice.", null));
        addOptionAndPosition(new KeyMapper("incFinder", "Inc Finder", "Goes through everyone's inventory and backpack then reports if they have an incantation."));
		addOptionAndPosition(new ChoiceOption("rclickTp",makeOnOffLabels(),[true,false],"Right-click Chat Teleport","Right click a chat name to teleport. No menu will be shown.",null));
		addOptionAndPosition(new ChoiceOption("autoTp",makeOnOffLabels(),[true,false],"Teleport Queue","Automatically teleports after teleport cooldown if you have tried to teleport to someone during the cooldown.",null));
        addOptionAndPosition(new KeyMapper("QuestTeleport","Closest Player to Quest Teleport","Teleports to the player that is closest to your quest."));
        addOptionAndPosition(new KeyMapper("tpto","Teleport to Caller","Teleport to a person calling a dungeon. Current keywords: "+Parameters.data_.tptoList));
		addOptionAndPosition(new KeyMapper("resetCHP", "Reset Client HP", "Use this hotkey if your CL bar doesn't match your HP bar."));
        addOptionAndPosition(new ChoiceOption("autoCorrCHP",makeOnOffLabels(),[true,false],"Auto Correct Client HP","Automatically corrects your health. Increases your chance of dying when turned on.",null,Parameters.data_.autoCorrCHP ? 0xFF0000 : 0xFFFFFF, true));
		addOptionAndPosition(new KeyMapper("Cam45DegInc", "Rotate Left (45°)", "Turns your camera by 45 degrees to the left."));
		addOptionAndPosition(new KeyMapper("Cam45DegDec", "Rotate Right (45°)", "Turns your camera by 45 degrees to the right."));
		addOptionAndPosition(new KeyMapper("cam2quest", "Point Camera to Quest", "Turns your camera so that the quest is to your north."));
		addOptionAndPosition(new KeyMapper("enterPortal", "Portal Enter", "Enters nearest portal."));
		addOptionAndPosition(new ChoiceOption("instaSelect",makeOnOffLabels(),[true,false],"Instantly Select All Items","When turned on, a right click on the trade window will select all your items instantly. When turned off, selects only items of the same type, smoothly, like an actual player.",null));
	}
    
    private function miscMenu() : void
    {
        addOptionAndPosition(new KeyMapper("msg1key","Custom Message 1","Currently set to \""+Parameters.data_.msg1+"\". Use /setmsg 1 <message> to replace this message."));
        addOptionAndPosition(new KeyMapper("TextPause","Pause","Pauses the game if there are no nearby enemies. Does not work in dungeons."));
        addOptionAndPosition(new KeyMapper("msg2key","Custom Message 2","Currently set to \""+Parameters.data_.msg2+"\". Use /setmsg 2 <message> to replace this message."));
        addOptionAndPosition(new KeyMapper("TextThessal","Dying Thessal Response","Says \"He lives and reigns and conquers the world.\""));
        addOptionAndPosition(new KeyMapper("msg3key", "Custom Message 3", "Currently set to \"" + Parameters.data_.msg3 + "\". Use /setmsg 3 <message> to replace this message."));
		addOptionAndPosition(new ChoiceOption("wMenu",makeOnOffLabels(),[true,false],"Show Whisper Menu Option","Makes whisper appear under trade on player menu.",null));
        addOptionAndPosition(new NullOption());
		addOptionAndPosition(new ChoiceOption("conCom",makeOnOffLabels(),["/conn","/con"],"Replace /con with /conn","Helps proxy users who want to use said proxy's built-in connect command.",null));
    }
    
    private function AutoNexusValues() : Vector.<StringBuilder>
    {
        return new <StringBuilder>[new StaticStringBuilder(Parameters.data_.AutoNexus == 0 ? "Off" : Parameters.data_.AutoNexus+"%"),new StaticStringBuilder("15%"),new StaticStringBuilder("20%"),new StaticStringBuilder("25%"),new StaticStringBuilder("30%")];
    }
    
    private function AutoHealValues() : Vector.<StringBuilder>
    {
        return new <StringBuilder>[new StaticStringBuilder(Parameters.data_.autoHealP == 0 ? "Off" : Parameters.data_.autoHealP+"%"),new StaticStringBuilder("50%"),new StaticStringBuilder("55%"),new StaticStringBuilder("60%"),new StaticStringBuilder("65%"),new StaticStringBuilder("70%"),new StaticStringBuilder("75%"),new StaticStringBuilder("80%")];
    }
    
    private function AutoPotValues() : Vector.<StringBuilder>
    {
        return new <StringBuilder>[new StaticStringBuilder(Parameters.data_.autoPot == 0 ? "Off" : Parameters.data_.autoPot+"%"),new StaticStringBuilder("50%"),new StaticStringBuilder("55%"),new StaticStringBuilder("60%"),new StaticStringBuilder("65%"),new StaticStringBuilder("70%"),new StaticStringBuilder("75%"),new StaticStringBuilder("80%")];
    }
    
    private function ServerPrefValues() : Vector.<StringBuilder>
    {
        return new <StringBuilder>[new StaticStringBuilder("Default"), new StaticStringBuilder("USW"), new StaticStringBuilder("USMW"), new StaticStringBuilder("EUW"), new StaticStringBuilder("USE"), new StaticStringBuilder("ASE"), new StaticStringBuilder("USS"), new StaticStringBuilder("USSW"), new StaticStringBuilder("EUE"), new StaticStringBuilder("EUN"), new StaticStringBuilder("EUSW"), new StaticStringBuilder("USE3"), new StaticStringBuilder("USW2"), new StaticStringBuilder("USMW2"), new StaticStringBuilder("USE2"), new StaticStringBuilder("USNW"), new StaticStringBuilder("AE"), new StaticStringBuilder("USS3"), new StaticStringBuilder("EUN2"), new StaticStringBuilder("EUW2"), new StaticStringBuilder("EUS"), new StaticStringBuilder("USS2"), new StaticStringBuilder("USW3")];
	}
    
    private function autoAbility() : void
    {
        addOptionAndPosition(new ChoiceOption("curBoss",bossNames(),[3368,3366,3367],"Current Boss","You will only be able to hit the current boss.",null));
        addOptionAndPosition(new ChoiceOption("tombHack",makeOnOffLabels(),[true,false],"Tomb Hack","Tomb hack allows you to only damage the selected boss, leaving others unharmed even if you shoot them.",tombDeactivate));
		addOptionAndPosition(new KeyMapper("tombCycle", "Next Boss", "Selects the next boss.", !Parameters.data_.tombHack));
		tombDeactivate();
        //addOptionAndPosition(new ChoiceOption("AutoHealPercentage",AutoHealValues(),[0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100],"Auto Heal Threshold","NillyOptions.AutoAbility.Heal.desc",null));
        //addOptionAndPosition(new KeyMapper("AutoAbilityHotkey","Toggle Auto Ability","NillyOptions.AutoAbility.Hotkey.desc"));
        //addOptionAndPosition(new ChoiceOption("AutoAbilityManual",makeOnOffLabels(),[true,false],"Auto Ability on Manual Aim","NillyOptions.AutoAbility.Manual.desc",null));
        //addOptionAndPosition(new ChoiceOption("AutoAbilityExceptOnly",makeOnOffLabels(),[true,false],"Target Exception List Only","NillyOptions.AutoAbility.ExceptOnly.desc",null));
        //addOptionAndPosition(new NullOption());
        //addOptionAndPosition(new ChoiceOption("AutoAbilityTargetBuffed",makeOnOffLabels(),[true,false],"Target Invulnerable Mobs","NillyOptions.AutoAbility.TargetBuffed.desc",null));
    }
    
    private function tombDeactivate() : void
    {
        var _loc2_:int = 0;
        while(_loc2_ < options_.length)
        {
            var choice:ChoiceOption = options_[_loc2_] as ChoiceOption;
            if(choice != null)
            {
                if(choice.paramName_ == "curBoss") {
                    choice.enable(!Parameters.data_.tombHack);
                }
            }
            var keymap:KeyMapper = options_[_loc2_] as KeyMapper;
            if (keymap != null) {
                if (keymap.paramName_ == "tombCycle") {
                    keymap.setDisabled(!Parameters.data_.tombHack);
                }
            }
            _loc2_++;
        }
    }
    
    private function bossNames() : Vector.<StringBuilder>
    {
        return new <StringBuilder>[new StaticStringBuilder("Bes"),new StaticStringBuilder("Nut"),new StaticStringBuilder("Geb")];
    }

    private function makeAllowCameraRotation():ChoiceOption {
        return (new ChoiceOption("allowRotation", makeOnOffLabels(), [true, false], TextKey.OPTIONS_ALLOW_ROTATION, TextKey.OPTIONS_ALLOW_ROTATION_DESC, this.onAllowRotationChange));
    }

    private function makeAllowMiniMapRotation():ChoiceOption {
        return (new ChoiceOption("allowMiniMapRotation", makeOnOffLabels(), [true, false], "Allow Minimap Rotation", TextKey.OPTIONS_ALLOW_MINIMAP_ROTATION_DESC, null));
    }

    private function onAllowRotationChange():void {
        var _local_2:KeyMapper;
        var _local_1:int;
        while (_local_1 < this.options_.length) {
            _local_2 = (this.options_[_local_1] as KeyMapper);
            if (_local_2 != null) {
                if ((((_local_2.paramName_ == "rotateLeft")) || ((_local_2.paramName_ == "rotateRight")))) {
                    _local_2.setDisabled(!(Parameters.data_.allowRotation));
                }
            }
            _local_1++;
        }
    }

    private function addHotKeysOptions():void {
        this.addOptionAndPosition(new KeyMapper("useHealthPotion", TextKey.OPTIONS_USE_BUY_HEALTH, TextKey.OPTIONS_USE_BUY_HEALTH_DESC));
        this.addOptionAndPosition(new KeyMapper("useMagicPotion", TextKey.OPTIONS_USE_BUY_MAGIC, TextKey.OPTIONS_USE_BUY_MAGIC_DESC));
        this.addInventoryOptions();
        this.addOptionAndPosition(new KeyMapper("miniMapZoomIn", TextKey.OPTIONS_MINI_MAP_ZOOM_IN, TextKey.OPTIONS_MINI_MAP_ZOOM_IN_DESC));
        this.addOptionAndPosition(new KeyMapper("miniMapZoomOut", TextKey.OPTIONS_MINI_MAP_ZOOM_OUT, TextKey.OPTIONS_MINI_MAP_ZOOM_OUT_DESC));
        this.addOptionAndPosition(new KeyMapper("escapeToNexus", TextKey.OPTIONS_ESCAPE_TO_NEXUS, TextKey.OPTIONS_ESCAPE_TO_NEXUS_DESC));
        this.addOptionAndPosition(new KeyMapper("options", TextKey.OPTIONS_SHOW_OPTIONS, TextKey.OPTIONS_SHOW_OPTIONS_DESC));
        this.addOptionAndPosition(new KeyMapper("switchTabs", TextKey.OPTIONS_SWITCH_TABS, TextKey.OPTIONS_SWITCH_TABS_DESC));
        this.addOptionAndPosition(new KeyMapper("GPURenderToggle", TextKey.OPTIONS_HARDWARE_ACC_HOTKEY_TITLE, TextKey.OPTIONS_HARDWARE_ACC_HOTKEY_DESC));
        this.addOptionsChoiceOption();
        addOptionAndPosition(new KeyMapper("SkipRenderKey","Toggle Rendering","Stops rendering the playfield. Minimap and the rest of the HUD is still updated."));
        /*if (this.isAirApplication()) {
            this.addOptionAndPosition(new KeyMapper("toggleFullscreen", TextKey.OPTIONS_TOGGLE_FULLSCREEN, TextKey.OPTIONS_TOGGLE_FULLSCREEN_DESC));
        }*/
    }

    public function isAirApplication():Boolean {
        return ((Capabilities.playerType == "Desktop"));
    }

    public function addOptionsChoiceOption():void {
        var _local_1:String = (((Capabilities.os.split(" ")[0] == "Mac")) ? "Command" : "Ctrl");
        var _local_2:ChoiceOption = new ChoiceOption("inventorySwap", makeOnOffLabels(), [true, false], "Switch Items from/to Backpack", "", null);
        _local_2.setTooltipText(new LineBuilder().setParams(TextKey.OPTIONS_SWITCH_ITEM_IN_BACKPACK_DESC, {"key": _local_1}));
        this.addOptionAndPosition(_local_2);
    }

    public function addInventoryOptions():void {
        var _local_2:KeyMapper;
        var _local_1:int = 1;
        while (_local_1 <= 8) {
            _local_2 = new KeyMapper(("useInvSlot" + _local_1), "", "");
            _local_2.setDescription(new LineBuilder().setParams(TextKey.OPTIONS_INVENTORY_SLOT_N, {"n": _local_1}));
            _local_2.setTooltipText(new LineBuilder().setParams(TextKey.OPTIONS_INVENTORY_SLOT_N_DESC, {"n": _local_1}));
            this.addOptionAndPosition(_local_2);
            _local_1++;
        }
    }

    private function addChatOptions():void {
        this.addOptionAndPosition(new KeyMapper(CHAT, TextKey.OPTIONS_ACTIVATE_CHAT, TextKey.OPTIONS_ACTIVATE_CHAT_DESC));
        this.addOptionAndPosition(new KeyMapper(CHAT_COMMAND, TextKey.OPTIONS_START_CHAT, TextKey.OPTIONS_START_CHAT_DESC));
        this.addOptionAndPosition(new KeyMapper(TELL, TextKey.OPTIONS_BEGIN_TELL, TextKey.OPTIONS_BEGIN_TELL_DESC));
        this.addOptionAndPosition(new KeyMapper(GUILD_CHAT, TextKey.OPTIONS_BEGIN_GUILD_CHAT, TextKey.OPTIONS_BEGIN_GUILD_CHAT_DESC));
        this.addOptionAndPosition(new KeyMapper(SCROLL_CHAT_UP, TextKey.OPTIONS_SCROLL_CHAT_UP, TextKey.OPTIONS_SCROLL_CHAT_UP_DESC));
        this.addOptionAndPosition(new KeyMapper(SCROLL_CHAT_DOWN, TextKey.OPTIONS_SCROLL_CHAT_DOWN, TextKey.OPTIONS_SCROLL_CHAT_DOWN_DESC));
        this.addOptionAndPosition(new ChoiceOption("forceChatQuality", makeOnOffLabels(), [true, false], TextKey.OPTIONS_FORCE_CHAT_QUALITY, TextKey.OPTIONS_FORCE_CHAT_QUALITY_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("hidePlayerChat", makeOnOffLabels(), [true, false], TextKey.OPTIONS_HIDE_PLAYER_CHAT, TextKey.OPTIONS_HIDE_PLAYER_CHAT_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("chatAll", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_ALL, TextKey.OPTIONS_CHAT_ALL_DESC, this.onAllChatEnabled));
        this.addOptionAndPosition(new ChoiceOption("chatWhisper", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_WHISPER, TextKey.OPTIONS_CHAT_WHISPER_DESC, this.onAllChatDisabled));
        this.addOptionAndPosition(new ChoiceOption("chatGuild", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_GUILD, TextKey.OPTIONS_CHAT_GUILD_DESC, this.onAllChatDisabled));
        this.addOptionAndPosition(new ChoiceOption("chatTrade", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_TRADE, TextKey.OPTIONS_CHAT_TRADE_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("chatStarRequirement", makeStarSelectLabels(), [0, 13, 27, 41, 55, 69, 70], TextKey.OPTIONS_STAR_REQ, "Blocks messages from players of this rank and below.", null));
    }

    private static function makeStarSelectLabels():Vector.<StringBuilder> {
        return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("Light Blue"), new StaticStringBuilder("Blue"), new StaticStringBuilder("Red"), new StaticStringBuilder("Orange"), new StaticStringBuilder("Yellow"), new StaticStringBuilder("Alone")]);
    }

    private function onAllChatDisabled():void {
        var _local_2:ChoiceOption;
        Parameters.data_.chatAll = false;
        var _local_1:int;
        while (_local_1 < this.options_.length) {
            _local_2 = (this.options_[_local_1] as ChoiceOption);
            if (_local_2 != null) {
                switch (_local_2.paramName_) {
                    case "chatAll":
                        _local_2.refreshNoCallback();
                        break;
                }
            }
            _local_1++;
        }
    }

    private function onAllChatEnabled():void {
        var _local_2:ChoiceOption;
        Parameters.data_.hidePlayerChat = false;
        Parameters.data_.chatWhisper = true;
        Parameters.data_.chatGuild = true;
        Parameters.data_.chatFriend = false;
        var _local_1:int;
        while (_local_1 < this.options_.length) {
            _local_2 = (this.options_[_local_1] as ChoiceOption);
            if (_local_2 != null) {
                switch (_local_2.paramName_) {
                    case "hidePlayerChat":
                    case "chatWhisper":
                    case "chatGuild":
                    case "chatFriend":
                        _local_2.refreshNoCallback();
                        break;
                }
            }
            _local_1++;
        }
    }

    /*private function addExperimentalOptions():void {
        this.addOptionAndPosition(new ChoiceOption("disableEnemyParticles", makeOnOffLabels(), [true, false], "Disable enemy particles", "Disable particles when hit enemy and when enemy is dying.", null));
        this.addOptionAndPosition(new ChoiceOption("disableAllyParticles", makeOnOffLabels(), [true, false], "Disable ally particles", "Disable particles produces by shooting ally.", null));
        this.addOptionAndPosition(new ChoiceOption("disablePlayersHitParticles", makeOnOffLabels(), [true, false], "Disable players hit particles", "Disable particles when player or ally is hit.", null));
    }*/

    private function addGraphicsOptions():void {
        var _local_1:String;
        var _local_2:Number;
        this.addOptionAndPosition(new ChoiceOption("defaultCameraAngle", makeDegreeOptions(), [((7 * Math.PI) / 4), 0], TextKey.OPTIONS_DEFAULT_CAMERA_ANGLE, TextKey.OPTIONS_DEFAULT_CAMERA_ANGLE_DESC, onDefaultCameraAngleChange));
        this.addOptionAndPosition(new ChoiceOption("centerOnPlayer", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CENTER_ON_PLAYER, TextKey.OPTIONS_CENTER_ON_PLAYER_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("showQuestPortraits", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_QUEST_PORTRAITS, TextKey.OPTIONS_SHOW_QUEST_PORTRAITS_DESC, this.onShowQuestPortraitsChange));
        this.addOptionAndPosition(new ChoiceOption("showProtips", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_TIPS, TextKey.OPTIONS_SHOW_TIPS_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("drawShadows", makeOnOffLabels(), [true, false], TextKey.OPTIONS_DRAW_SHADOWS, TextKey.OPTIONS_DRAW_SHADOWS_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("textBubbles", makeOnOffLabels(), [true, false], TextKey.OPTIONS_DRAW_TEXT_BUBBLES, TextKey.OPTIONS_DRAW_TEXT_BUBBLES_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("showTradePopup", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_TRADE_REQUEST_PANEL, TextKey.OPTIONS_SHOW_TRADE_REQUEST_PANEL_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("showGuildInvitePopup", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_GUILD_INVITE_PANEL, TextKey.OPTIONS_SHOW_GUILD_INVITE_PANEL_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("cursorSelect", makeCursorSelectLabels(), [MouseCursor.AUTO, "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"], "Custom Cursor", "Click here to change the mouse cursor. May help with aiming.", refreshCursor));
        if (!Parameters.GPURenderError) {
            _local_1 = TextKey.OPTIONS_HARDWARE_ACC_DESC;
            _local_2 = 0xFFFFFF;
        }
        else {
            _local_1 = TextKey.OPTIONS_HARDWARE_ACC_DESC_ERROR;
            _local_2 = 16724787;
        }
        this.addOptionAndPosition(new ChoiceOption("GPURender", makeOnOffLabels(), [true, false], TextKey.OPTIONS_HARDWARE_ACC_TITLE, _local_1, null, _local_2));
        this.addOptionAndPosition(new ChoiceOption("toggleBarText", makeOnOffLabels(), [true, false], TextKey.OPTIONS_TOGGLE_BARTEXT, TextKey.OPTIONS_TOGGLE_BARTEXT_DESC, onBarTextToggle));
        this.addOptionAndPosition(new ChoiceOption("particleEffect", makeHighLowLabels(), [true, false], TextKey.OPTIONS_TOGGLE_PARTICLE_EFFECT, TextKey.OPTIONS_TOGGLE_PARTICLE_EFFECT_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("uiQuality", makeHighLowLabels(), [true, false], TextKey.OPTIONS_TOGGLE_UI_QUALITY, TextKey.OPTIONS_TOGGLE_UI_QUALITY_DESC, onUIQualityToggle));
        this.addOptionAndPosition(new ChoiceOption("HPBar", makeOnOffLabels(), [true, false], TextKey.OPTIONS_HPBAR, TextKey.OPTIONS_HPBAR_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("disableEnemyParticles", makeOnOffLabels(), [true, false], "Disable Enemy Particles", "Disable particles when hit enemy and when enemy is dying.", null));
        this.addOptionAndPosition(new ChoiceOption("disableAllyParticles", makeOnOffLabels(), [true, false], "Disable Ally Particles", "Disable particles produces by shooting ally.", null));
        this.addOptionAndPosition(new ChoiceOption("disablePlayersHitParticles", makeOnOffLabels(), [true, false], "Disable Players Hit Particles", "Disable particles when player or ally is hit.", null));
    }

    private function onShowQuestPortraitsChange():void {
        if (((((((!((this.gs_ == null))) && (!((this.gs_.map == null))))) && (!((this.gs_.map.partyOverlay_ == null))))) && (!((this.gs_.map.partyOverlay_.questArrow_ == null))))) {
            this.gs_.map.partyOverlay_.questArrow_.refreshToolTip();
        }
    }

    private function onFullscreenChange():void {
        stage.displayState = ((Parameters.data_.fullscreenMode) ? "fullScreenInteractive" : StageDisplayState.NORMAL);
    }

    private function addSoundOptions():void {
        this.addOptionAndPosition(new ChoiceOption("playMusic", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_MUSIC, TextKey.OPTIONS_PLAY_MUSIC_DESC, this.onPlayMusicChange));
        this.addOptionAndPosition(new SliderOption("musicVolume", this.onMusicVolumeChange), -120, 15);
        this.addOptionAndPosition(new ChoiceOption("playSFX", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_SOUND_EFFECTS, TextKey.OPTIONS_PLAY_SOUND_EFFECTS_DESC, this.onPlaySoundEffectsChange));
        this.addOptionAndPosition(new SliderOption("SFXVolume", this.onSoundEffectsVolumeChange), -120, 34);
        this.addOptionAndPosition(new ChoiceOption("playPewPew", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_WEAPON_SOUNDS, TextKey.OPTIONS_PLAY_WEAPON_SOUNDS_DESC, null));
    }

    /*private function addMiscOptions():void {
        this.addOptionAndPosition(new ChoiceOption("showProtips", new <StringBuilder>[makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW), makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW)], [Parameters.data_.showProtips, Parameters.data_.showProtips], TextKey.OPTIONS_LEGAL_PRIVACY, TextKey.OPTIONS_LEGAL_PRIVACY_DESC, this.onLegalPrivacyClick));
        this.addOptionAndPosition(new NullOption());
        this.addOptionAndPosition(new ChoiceOption("showProtips", new <StringBuilder>[makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW), makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW)], [Parameters.data_.showProtips, Parameters.data_.showProtips], TextKey.OPTIONS_LEGAL_TOS, TextKey.OPTIONS_LEGAL_TOS_DESC, this.onLegalTOSClick));
        this.addOptionAndPosition(new NullOption());
    }*/

    private function addFriendOptions():void {
        this.addOptionAndPosition(new ChoiceOption("tradeWithFriends", makeOnOffLabels(), [true, false], TextKey.OPTIONS_TRADE_FRIEND, TextKey.OPTIONS_TRADE_FRIEND_DESC, this.onPlaySoundEffectsChange));
        this.addOptionAndPosition(new KeyMapper("friendList", TextKey.OPTIONS_SHOW_FRIEND_LIST, TextKey.OPTIONS_SHOW_FRIEND_LIST_DESC));
        this.addOptionAndPosition(new ChoiceOption("chatFriend", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_FRIEND, TextKey.OPTIONS_CHAT_FRIEND_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("friendStarRequirement", makeStarSelectLabels(), [0, 13, 27, 41, 55, 69, 70], TextKey.OPTIONS_STAR_REQ, TextKey.OPTIONS_FRIEND_STAR_REQ_DESC, null));
    }

    private function onPlayMusicChange():void {
        Music.setPlayMusic(Parameters.data_.playMusic);
        if (Parameters.data_.playMusic) {
            Music.setMusicVolume(1);
        }
        else {
            Music.setMusicVolume(0);
        }
        this.refresh();
    }

    private function onPlaySoundEffectsChange():void {
        SFX.setPlaySFX(Parameters.data_.playSFX);
        if (((Parameters.data_.playSFX) || (Parameters.data_.playPewPew))) {
            SFX.setSFXVolume(1);
        }
        else {
            SFX.setSFXVolume(0);
        }
        this.refresh();
    }

    private function onMusicVolumeChange(_arg_1:Number):void {
        Music.setMusicVolume(_arg_1);
    }

    private function onSoundEffectsVolumeChange(_arg_1:Number):void {
        SFX.setSFXVolume(_arg_1);
    }

    private function addOptionAndPosition(option:Option, offsetX:Number = 0, offsetY:Number = 0):void {
        var positionOption:Function;
        positionOption = function ():void {
            option.x = (options_.length % 2 == 0 ? 20 : 415) + offsetX;
            //option.y = int(options_.length / 2) * 44 + 122 + offsetY;
            option.y = int(options_.length / 2) * 41 + 110 + offsetY;
        };
        option.textChanged.addOnce(positionOption);
        this.addOption(option);
    }

    private function addOption(_arg_1:Option):void {
        addChild(_arg_1);
        _arg_1.addEventListener(Event.CHANGE, this.onChange);
        this.options_.push(_arg_1);
    }

    private function onChange(_arg_1:Event):void {
        this.refresh();
    }

    private function refresh():void {
        var _local_2:BaseOption;
        var _local_1:int;
        while (_local_1 < this.options_.length) {
            _local_2 = (this.options_[_local_1] as BaseOption);
            if (_local_2 != null) {
                _local_2.refresh();
            }
            _local_1++;
        }
    }


}
}//package com.company.assembleegameclient.ui.options
