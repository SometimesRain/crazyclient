package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.assembleegameclient.util.FameUtil;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.utils.getTimer;

import kabam.rotmg.text.model.TextKey;

public class ScoringBox extends Sprite {

    private var rect_:Rectangle;
    private var mask_:Shape;
    private var linesSprite_:Sprite;
    private var scoreTextLines_:Vector.<ScoreTextLine>;
    private var scrollbar_:Scrollbar;
    private var startTime_:int;

    public function ScoringBox(_arg_1:Rectangle, _arg_2:XML) {
        var _local_4:XML;
        this.mask_ = new Shape();
        this.linesSprite_ = new Sprite();
        this.scoreTextLines_ = new Vector.<ScoreTextLine>();
        super();
        this.rect_ = _arg_1;
        graphics.lineStyle(1, 0x494949, 2);
        graphics.drawRect((this.rect_.x + 1), (this.rect_.y + 1), (this.rect_.width - 2), (this.rect_.height - 2));
        graphics.lineStyle();
        this.scrollbar_ = new Scrollbar(16, this.rect_.height);
        this.scrollbar_.addEventListener(Event.CHANGE, this.onScroll);
        this.mask_.graphics.beginFill(0xFFFFFF, 1);
        this.mask_.graphics.drawRect(this.rect_.x, this.rect_.y, this.rect_.width, this.rect_.height);
        this.mask_.graphics.endFill();
        addChild(this.mask_);
        mask = this.mask_;
        addChild(this.linesSprite_);
        this.addLine(TextKey.FAMEVIEW_SHOTS, null, 0, _arg_2.Shots, false, 5746018);
        if (int(_arg_2.Shots) != 0) {
            this.addLine(TextKey.FAMEVIEW_ACCURACY, null, 0, ((100 * Number(_arg_2.ShotsThatDamage)) / Number(_arg_2.Shots)), true, 5746018, "", "%");
        }
        this.addLine(TextKey.FAMEVIEW_TILES_SEEN, null, 0, _arg_2.TilesUncovered, false, 5746018);
        this.addLine(TextKey.FAMEVIEW_MONSTERKILLS, null, 0, _arg_2.MonsterKills, false, 5746018);
        this.addLine(TextKey.FAMEVIEW_GODKILLS, null, 0, _arg_2.GodKills, false, 5746018);
        this.addLine(TextKey.FAMEVIEW_ORYXKILLS, null, 0, _arg_2.OryxKills, false, 5746018);
        this.addLine(TextKey.FAMEVIEW_QUESTSCOMPLETED, null, 0, _arg_2.QuestsCompleted, false, 5746018);
		this.addLine(TextKey.FAMEVIEW_DUNGEONSCOMPLETED,null,0,int(_arg_2.PirateCavesCompleted) + int(_arg_2.UndeadLairsCompleted) + int(_arg_2.AbyssOfDemonsCompleted) + int(_arg_2.SnakePitsCompleted) + int(_arg_2.SpiderDensCompleted) + int(_arg_2.SpriteWorldsCompleted) + int(_arg_2.TombsCompleted) + int(_arg_2.ForestMazeCompleted) + int(_arg_2.LairOfDraconisCompleted) + int(_arg_2.CandyLandCompleted) + int(_arg_2.HauntedCemeteryCompleted) + int(_arg_2.CaveOfAThousandTreasuresCompleted) + int(_arg_2.MadLabCompleted) + int(_arg_2.DavyJonesCompleted) + int(_arg_2.TombHeroicCompleted) + int(_arg_2.DreamscapeCompleted) + int(_arg_2.IceCaveCompleted) + int(_arg_2.DeadWaterDocksCompleted) + int(_arg_2.CrawlingDepthCompleted) + int(_arg_2.WoodLandCompleted) + int(_arg_2.BattleNexusCompleted) + int(_arg_2.TheShattersCompleted) + int(_arg_2.BelladonnaCompleted) + int(_arg_2.PuppetMasterCompleted) + int(_arg_2.ToxicSewersCompleted) + int(_arg_2.TheHiveCompleted),false,5746018);
        this.addLine(TextKey.FAMEVIEW_PARTYMEMBERLEVELUPS, null, 0, _arg_2.LevelUpAssists, false, 5746018);
        var _local_3:BitmapData = FameUtil.getFameIcon();
        _local_3 = BitmapUtil.cropToBitmapData(_local_3, 6, 6, (_local_3.width - 12), (_local_3.height - 12));
        this.addLine(TextKey.FAMEVIEW_BASEFAMEEARNED, null, 0, _arg_2.BaseFame, true, 0xFFC800, "", "", new Bitmap(_local_3));
        for each (_local_4 in _arg_2.Bonus) {
            this.addLine(_local_4.@id, _local_4.@desc, _local_4.@level, int(_local_4), true, 0xFFC800, "+", "", new Bitmap(_local_3));
        }
    }

    public function showScore():void {
        var _local_1:ScoreTextLine;
        this.animateScore();
        this.startTime_ = -(int.MAX_VALUE);
        for each (_local_1 in this.scoreTextLines_) {
            _local_1.skip();
        }
    }

    public function animateScore():void {
        this.startTime_ = getTimer();
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onScroll(_arg_1:Event):void {
        var _local_2:Number = this.scrollbar_.pos();
        this.linesSprite_.y = ((_local_2 * ((this.rect_.height - this.linesSprite_.height) - 15)) + 5);
    }

    private function addLine(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:Boolean, _arg_6:uint, _arg_7:String = "", _arg_8:String = "", _arg_9:DisplayObject = null):void {
        if ((((_arg_4 == 0)) && (!(_arg_5)))) {
            return;
        }
        this.scoreTextLines_.push(new ScoreTextLine(20, 0xB3B3B3, _arg_6, _arg_1, _arg_2, _arg_3, _arg_4, _arg_7, _arg_8, _arg_9));
    }

    private function onEnterFrame(_arg_1:Event):void {
        var _local_3:Number;
        var _local_6:ScoreTextLine;
        var _local_2:Number = (this.startTime_ + ((2000 * (this.scoreTextLines_.length - 1)) / 2));
        _local_3 = getTimer();
        var _local_4:int = Math.min(this.scoreTextLines_.length, (((2 * (getTimer() - this.startTime_)) / 2000) + 1));
        var _local_5:int;
        while (_local_5 < _local_4) {
            _local_6 = this.scoreTextLines_[_local_5];
            _local_6.y = (28 * _local_5);
            this.linesSprite_.addChild(_local_6);
            _local_5++;
        }
        this.linesSprite_.y = ((this.rect_.height - this.linesSprite_.height) - 10);
        if (_local_3 > (_local_2 + 1000)) {
            this.addScrollbar();
            dispatchEvent(new Event(Event.COMPLETE));
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }
    }

    private function addScrollbar():void {
        graphics.clear();
        graphics.lineStyle(1, 0x494949, 2);
        graphics.drawRect((this.rect_.x + 1), (this.rect_.y + 1), (this.rect_.width - 26), (this.rect_.height - 2));
        graphics.lineStyle();
        this.scrollbar_.x = (this.rect_.width - 16);
        this.scrollbar_.setIndicatorSize(this.mask_.height, this.linesSprite_.height);
        this.scrollbar_.setPos(1);
        addChild(this.scrollbar_);
    }


}
}//package com.company.assembleegameclient.screens
