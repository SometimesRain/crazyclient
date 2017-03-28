package kabam.rotmg.game.view.components {
import com.company.assembleegameclient.objects.Player;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;

import kabam.rotmg.game.model.StatModel;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.natives.NativeSignal;

public class StatsView extends Sprite {

    private static const statsModel:Array = [new StatModel(TextKey.STAT_MODEL_ATTACK_SHORT, TextKey.STAT_MODEL_ATTACK_LONG, TextKey.STAT_MODEL_ATTACK_DESCRIPTION, true), new StatModel(TextKey.STAT_MODEL_DEFENSE_SHORT, TextKey.STAT_MODEL_DEFENSE_LONG, TextKey.STAT_MODEL_DEFENSE_DESCRIPTION, false), new StatModel(TextKey.STAT_MODEL_SPEED_SHORT, TextKey.STAT_MODEL_SPEED_LONG, TextKey.STAT_MODEL_SPEED_DESCRIPTION, true), new StatModel(TextKey.STAT_MODEL_DEXTERITY_SHORT, TextKey.STAT_MODEL_DEXTERITY_LONG, TextKey.STAT_MODEL_DEXTERITY_DESCRIPTION, true), new StatModel(TextKey.STAT_MODEL_VITALITY_SHORT, TextKey.STAT_MODEL_VITALITY_LONG, TextKey.STAT_MODEL_VITALITY_DESCRIPTION, true), new StatModel(TextKey.STAT_MODEL_WISDOM_SHORT, TextKey.STAT_MODEL_WISDOM_LONG, TextKey.STAT_MODEL_WISDOM_DESCRIPTION, true)];
    public static const ATTACK:int = 0;
    public static const DEFENSE:int = 1;
    public static const SPEED:int = 2;
    public static const DEXTERITY:int = 3;
    public static const VITALITY:int = 4;
    public static const WISDOM:int = 5;
    public static const STATE_UNDOCKED:String = "state_undocked";
    public static const STATE_DOCKED:String = "state_docked";
    public static const STATE_DEFAULT:String = STATE_DOCKED;
	//public static var l2m:Boolean = false;

    private const WIDTH:int = 191; //191 173
    private const HEIGHT:int = 45;

    //private var background:Sprite;
    public var stats_:Vector.<StatView>;
    public var containerSprite:Sprite;
    public var mouseDown:NativeSignal;
    public var currentState:String = "state_docked";
    public var myPlayer:Boolean = true;

    public function StatsView() {
        //this.background = this.createBackground();
        this.stats_ = new Vector.<StatView>();
        this.containerSprite = new Sprite();
        super();
        //addChild(this.background);
        addChild(this.containerSprite);
        this.createStats();
        mouseChildren = false;
        this.mouseDown = new NativeSignal(this, MouseEvent.MOUSE_DOWN, MouseEvent);
    }

    private function createStats():void {
        var _local_3:StatView;
        var _local_1:int;
        var _local_2:int;
        while (_local_2 < statsModel.length) {
            _local_3 = this.createStat(_local_2, _local_1);
            this.stats_.push(_local_3);
            this.containerSprite.addChild(_local_3);
            _local_1 = (_local_1 + (_local_2 % 2));
            _local_2++;
        }
    }

    private function createStat(_arg_1:int, _arg_2:int):StatView {
        var _local_4:StatView;
        var _local_3:StatModel = statsModel[_arg_1];
        _local_4 = new StatView(_local_3.name, _local_3.abbreviation, _local_3.description, _local_3.redOnZero);
        _local_4.x = (((_arg_1 % 2) * this.WIDTH) / 2);
        _local_4.y = (_arg_2 * (this.HEIGHT / 3));
        return (_local_4);
    }

    public function draw(_arg_1:Player):void {
        if (_arg_1) {
            //this.setBackgroundVisibility();
            this.drawStats(_arg_1);
        }
        this.containerSprite.x = ((this.WIDTH - this.containerSprite.width) / 2);
    }

    private function drawStats(_arg_1:Player):void {
		/*if (l2m) {
			this.stats_[ATTACK].draw(_arg_1.attackMax_ - _arg_1.attack_ + _arg_1.attackBoost_, 0, 0);
			this.stats_[DEFENSE].draw(_arg_1.defenseMax_ - _arg_1.defense_ + _arg_1.defenseBoost_, 0, 0);
			this.stats_[SPEED].draw(_arg_1.speedMax_ - _arg_1.speed_ + _arg_1.speedBoost_, 0, 0);
			this.stats_[DEXTERITY].draw(_arg_1.dexterityMax_ - _arg_1.dexterity_ + _arg_1.dexterityBoost_, 0, 0);
			this.stats_[VITALITY].draw(_arg_1.vitalityMax_ - _arg_1.vitality_ + _arg_1.vitalityBoost_, 0, 0);
			this.stats_[WISDOM].draw(_arg_1.wisdomMax_ - _arg_1.wisdom_ + _arg_1.wisdomBoost_, 0, 0);
		}
		else {*/
			this.stats_[ATTACK].draw(_arg_1.attack_, _arg_1.attackBoost_, _arg_1.attackMax_);
			this.stats_[DEFENSE].draw(_arg_1.defense_, _arg_1.defenseBoost_, _arg_1.defenseMax_);
			this.stats_[SPEED].draw(_arg_1.speed_, _arg_1.speedBoost_, _arg_1.speedMax_);
			this.stats_[DEXTERITY].draw(_arg_1.dexterity_, _arg_1.dexterityBoost_, _arg_1.dexterityMax_);
			this.stats_[VITALITY].draw(_arg_1.vitality_, _arg_1.vitalityBoost_, _arg_1.vitalityMax_);
			this.stats_[WISDOM].draw(_arg_1.wisdom_, _arg_1.wisdomBoost_, _arg_1.wisdomMax_);
		//}
    }

    /*public function dock():void {
        this.currentState = STATE_DOCKED;
    }

    public function undock():void {
        this.currentState = STATE_UNDOCKED;
    }

    private function createBackground():Sprite {
        this.background = new Sprite();
        this.background.graphics.clear();
        this.background.graphics.beginFill(0x363636);
        this.background.graphics.lineStyle(2, 0xFFFFFF);
        this.background.graphics.drawRoundRect(-5, -5, (this.WIDTH + 10), (this.HEIGHT + 13), 10);
        this.background.filters = [new GlowFilter(0, 1, 10, 10, 1, 3)];
        return (this.background);
    }

    private function setBackgroundVisibility():void {
        if (this.currentState == STATE_UNDOCKED) {
            this.background.alpha = 1;
        }
        else {
            if (this.currentState == STATE_DOCKED) {
                this.background.alpha = 0;
            }
        }
    }*/


}
}//package kabam.rotmg.game.view.components
