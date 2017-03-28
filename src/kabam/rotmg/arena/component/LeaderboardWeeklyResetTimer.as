package kabam.rotmg.arena.component {
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.filters.DropShadowFilter;
import flash.utils.Timer;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class LeaderboardWeeklyResetTimer extends Sprite {

    private const MONDAY:Number = 1;
    private const UTC_COUNTOFF_HOUR:Number = 7;

    private var differenceMilliseconds:Number;
    private var updateTimer:Timer;
    private var resetClock:StaticTextDisplay;
    private var resetClockStringBuilder:LineBuilder;

    public function LeaderboardWeeklyResetTimer() {
        this.differenceMilliseconds = this.makeDifferenceMilliseconds();
        this.resetClock = this.makeResetClockDisplay();
        this.resetClockStringBuilder = new LineBuilder();
        super();
        addChild(this.resetClock);
        this.resetClock.setStringBuilder(this.resetClockStringBuilder.setParams(TextKey.ARENA_WEEKLY_RESET_LABEL, {"time": this.getDateString()}));
        this.updateTimer = new Timer(1000);
        this.updateTimer.addEventListener(TimerEvent.TIMER, this.onUpdateTime);
        this.updateTimer.start();
    }

    private function onUpdateTime(_arg_1:TimerEvent):void {
        this.differenceMilliseconds = (this.differenceMilliseconds - 1000);
        this.resetClock.setStringBuilder(this.resetClockStringBuilder.setParams(TextKey.ARENA_WEEKLY_RESET_LABEL, {"time": this.getDateString()}));
    }

    private function getDateString():String {
        var _local_1:int = this.differenceMilliseconds;
        var _local_2:int = Math.floor((_local_1 / 86400000));
        _local_1 = (_local_1 % 86400000);
        var _local_3:int = Math.floor((_local_1 / 3600000));
        _local_1 = (_local_1 % 3600000);
        var _local_4:int = Math.floor((_local_1 / 60000));
        _local_1 = (_local_1 % 60000);
        var _local_5:int = Math.floor((_local_1 / 1000));
        var _local_6:String = "";
        if (_local_2 > 0) {
            _local_6 = (((((_local_2 + " days, ") + _local_3) + " hours, ") + _local_4) + " minutes");
        }
        else {
            _local_6 = (((((_local_3 + " hours, ") + _local_4) + " minutes, ") + _local_5) + " seconds");
        }
        return (_local_6);
    }

    private function makeDifferenceMilliseconds():Number {
        var _local_1:Date = new Date();
        var _local_2:Date = this.makeResetDate();
        return ((_local_2.getTime() - _local_1.getTime()));
    }

    private function makeResetDate():Date {
        var _local_1:Date = new Date();
        if ((((_local_1.dayUTC == this.MONDAY)) && ((_local_1.hoursUTC < this.UTC_COUNTOFF_HOUR)))) {
            _local_1.setUTCHours((this.UTC_COUNTOFF_HOUR - _local_1.hoursUTC));
            return (_local_1);
        }
        _local_1.setUTCHours(7);
        _local_1.setUTCMinutes(0);
        _local_1.setUTCSeconds(0);
        _local_1.setUTCMilliseconds(0);
        _local_1.setUTCDate((_local_1.dateUTC + 1));
        while (_local_1.dayUTC != this.MONDAY) {
            _local_1.setUTCDate((_local_1.dateUTC + 1));
        }
        return (_local_1);
    }

    private function makeResetClockDisplay():StaticTextDisplay {
        var _local_1:StaticTextDisplay = new StaticTextDisplay();
        _local_1.setSize(14).setColor(16567065).setBold(true);
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        return (_local_1);
    }


}
}//package kabam.rotmg.arena.component
