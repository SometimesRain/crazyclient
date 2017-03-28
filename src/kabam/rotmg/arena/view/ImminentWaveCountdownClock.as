package kabam.rotmg.arena.view {
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.filters.DropShadowFilter;
import flash.utils.Timer;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;

public class ImminentWaveCountdownClock extends Sprite {

    public const close:Signal = new Signal();
    private const countDownContainer:Sprite = new Sprite();
    private const nextWaveText:StaticTextDisplay = makeNextWaveText();
    private const countdownStringBuilder:StaticStringBuilder = new StaticStringBuilder();
    private const countdownText:StaticTextDisplay = makeCountdownText();
    private const waveTimer:Timer = new Timer(1000);
    private const waveStartContainer:Sprite = new Sprite();
    private const waveAsset:ImminentWaveCountdownClock_WaveAsset = makeWaveAsset();
    private const waveText:StaticTextDisplay = makeWaveText();
    private const waveNumberText:StaticTextDisplay = makeWaveNumberText();
    private const startText:StaticTextDisplay = makeStartText();
    private const waveStartTimer:Timer = new Timer(1500, 1);

    private var WaveAsset:Class;
    private var count:int = 5;
    private var waveNumber:int = -1;

    public function ImminentWaveCountdownClock() {
        this.WaveAsset = ImminentWaveCountdownClock_WaveAsset;
        super();
    }

    public function init():void {
        mouseChildren = false;
        mouseEnabled = false;
        this.waveTimer.addEventListener(TimerEvent.TIMER, this.updateCountdownClock);
        this.waveTimer.start();
    }

    public function destroy():void {
        this.waveTimer.stop();
        this.waveTimer.removeEventListener(TimerEvent.TIMER, this.updateCountdownClock);
        this.waveStartTimer.stop();
        this.waveStartTimer.removeEventListener(TimerEvent.TIMER, this.cleanup);
    }

    public function show():void {
        addChild(this.countDownContainer);
        this.center();
    }

    public function setWaveNumber(_arg_1:int):void {
        this.waveNumber = _arg_1;
        this.waveNumberText.setStringBuilder(new StaticStringBuilder(this.waveNumber.toString()));
        this.waveNumberText.x = ((this.waveAsset.width / 2) - (this.waveNumberText.width / 2));
    }

    private function center():void {
        x = (300 - (width / 2));
        y = ((contains(this.countDownContainer)) ? 138 : 87.5);
    }

    private function updateCountdownClock(_arg_1:TimerEvent):void {
        if (this.count > 1) {
            this.count--;
            this.countdownText.setStringBuilder(this.countdownStringBuilder.setString(this.count.toString()));
            this.countdownText.x = ((this.nextWaveText.width / 2) - (this.countdownText.width / 2));
        }
        else {
            removeChild(this.countDownContainer);
            addChild(this.waveStartContainer);
            this.waveTimer.removeEventListener(TimerEvent.TIMER, this.updateCountdownClock);
            this.waveStartTimer.addEventListener(TimerEvent.TIMER, this.cleanup);
            this.waveStartTimer.start();
            this.center();
        }
    }

    private function cleanup(_arg_1:TimerEvent):void {
        this.waveStartTimer.removeEventListener(TimerEvent.TIMER, this.cleanup);
        this.close.dispatch();
    }

    private function makeNextWaveText():StaticTextDisplay {
        var _local_1:StaticTextDisplay = new StaticTextDisplay();
        _local_1.setSize(20).setBold(true).setColor(0xCCCCCC);
        _local_1.setStringBuilder(new LineBuilder().setParams(TextKey.ARENA_COUNTDOWN_CLOCK_NEXT_WAVE));
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8, 2)];
        this.countDownContainer.addChild(_local_1);
        return (_local_1);
    }

    private function makeCountdownText():StaticTextDisplay {
        var _local_1:StaticTextDisplay;
        _local_1 = new StaticTextDisplay();
        _local_1.setSize(42).setBold(true).setColor(0xCCCCCC);
        _local_1.setStringBuilder(this.countdownStringBuilder.setString(this.count.toString()));
        _local_1.y = this.nextWaveText.height;
        _local_1.x = ((this.nextWaveText.width / 2) - (_local_1.width / 2));
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8, 2)];
        this.countDownContainer.addChild(_local_1);
        return (_local_1);
    }

    private function makeWaveText():StaticTextDisplay {
        var _local_1:StaticTextDisplay = new StaticTextDisplay();
        _local_1.setSize(18).setBold(true).setColor(16567065);
        _local_1.setStringBuilder(new LineBuilder().setParams(TextKey.ARENA_COUNTDOWN_CLOCK_WAVE));
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8, 2)];
        _local_1.x = ((this.waveAsset.width / 2) - (_local_1.width / 2));
        _local_1.y = (((this.waveAsset.height / 2) - (_local_1.height / 2)) - 15);
        this.waveStartContainer.addChild(_local_1);
        return (_local_1);
    }

    private function makeWaveNumberText():StaticTextDisplay {
        var _local_1:StaticTextDisplay = new StaticTextDisplay();
        _local_1.setSize(40).setBold(true).setColor(16567065);
        _local_1.y = ((this.waveText.y + this.waveText.height) - 5);
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8, 2)];
        this.waveStartContainer.addChild(_local_1);
        return (_local_1);
    }

    private function makeWaveAsset():ImminentWaveCountdownClock_WaveAsset {
        var _local_1:* = new this.WaveAsset();
        this.waveStartContainer.addChild(_local_1);
        return (_local_1);
    }

    private function makeStartText():StaticTextDisplay {
        var _local_1:StaticTextDisplay = new StaticTextDisplay();
        _local_1.setSize(32).setBold(true).setColor(0xB3B3B3);
        _local_1.setStringBuilder(new LineBuilder().setParams(TextKey.ARENA_COUNTDOWN_CLOCK_START));
        _local_1.y = ((this.waveAsset.y + this.waveAsset.height) - 5);
        _local_1.x = ((this.waveAsset.width / 2) - (_local_1.width / 2));
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8, 2)];
        this.waveStartContainer.addChild(_local_1);
        return (_local_1);
    }


}
}//package kabam.rotmg.arena.view
