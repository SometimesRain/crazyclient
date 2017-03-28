package kabam.rotmg.arena.view {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.arena.component.BattleSummaryText;
import kabam.rotmg.editor.view.StaticTextButton;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.components.DialogBackground;

import org.osflash.signals.Signal;

public class BattleSummaryDialog extends Sprite {

    public const close:Signal = new Signal();
    private const WIDTH:int = 264;
    private const HEIGHT:int = 302;
    private const background:DialogBackground = makeBackground();
    private const splashArt:BattleSummaryDialog_BattleSummarySplash = makeSplashArt();

    private var BattleSummarySplash:Class;
    private var leftSummary:BattleSummaryText;
    private var rightSummary:BattleSummaryText;
    private var titleText:StaticTextDisplay;
    private var closeButton:StaticTextButton;

    public function BattleSummaryDialog() {
        this.BattleSummarySplash = BattleSummaryDialog_BattleSummarySplash;
        this.titleText = this.makeTitle();
        this.closeButton = this.makeButton();
        super();
        this.drawHorizontalDivide(25);
        this.drawHorizontalDivide(132);
        this.drawHorizontalDivide(252);
        this.makeVerticalDivide();
    }

    private function makeBackground():DialogBackground {
        var _local_1:DialogBackground = new DialogBackground();
        _local_1.draw(this.WIDTH, this.HEIGHT);
        addChild(_local_1);
        return (_local_1);
    }

    public function positionThis():void {
        x = ((stage.stageWidth - this.WIDTH) * 0.5);
        y = ((stage.stageHeight - this.HEIGHT) * 0.5);
    }

    public function setCurrentRun(_arg_1:int, _arg_2:int):void {
        if (this.leftSummary) {
            removeChild(this.leftSummary);
        }
        this.leftSummary = new BattleSummaryText(TextKey.BATTLE_SUMMARY_CURRENT_SUBTITLE, _arg_1, _arg_2);
        this.leftSummary.y = ((60 - (this.leftSummary.height / 2)) + 132);
        this.leftSummary.x = ((this.WIDTH / 4) - (this.leftSummary.width / 2));
        addChild(this.leftSummary);
    }

    public function setBestRun(_arg_1:int, _arg_2:int):void {
        if (this.rightSummary) {
            removeChild(this.rightSummary);
        }
        this.rightSummary = new BattleSummaryText(TextKey.BATTLE_SUMMARY_BEST_SUBTITLE, _arg_1, _arg_2);
        this.rightSummary.y = ((60 - (this.rightSummary.height / 2)) + 132);
        this.rightSummary.x = (((this.WIDTH / 4) - (this.rightSummary.width / 2)) + (this.WIDTH / 2));
        addChild(this.rightSummary);
    }

    private function closeClicked(_arg_1:MouseEvent):void {
        this.closeButton.removeEventListener(MouseEvent.CLICK, this.closeClicked);
        this.close.dispatch();
    }

    private function makeVerticalDivide():void {
        this.background.graphics.lineStyle();
        this.background.graphics.beginFill(0x666666, 1);
        this.background.graphics.drawRect((this.WIDTH / 2), 132, 2, 120);
        this.background.graphics.endFill();
    }

    private function drawHorizontalDivide(_arg_1:int):void {
        this.background.graphics.lineStyle();
        this.background.graphics.beginFill(0x666666, 1);
        this.background.graphics.drawRect(1, _arg_1, (this.background.width - 2), 2);
        this.background.graphics.endFill();
    }

    private function makeSplashArt():BattleSummaryDialog_BattleSummarySplash {
        var _local_1:* = new this.BattleSummarySplash();
        _local_1.y = 27;
        _local_1.x = 2;
        addChild(_local_1);
        return (_local_1);
    }

    private function makeTitle():StaticTextDisplay {
        var _local_1:StaticTextDisplay;
        _local_1 = new StaticTextDisplay();
        _local_1.setSize(18).setBold(true).setColor(0xB3B3B3);
        _local_1.setStringBuilder(new LineBuilder().setParams(TextKey.BATTLE_SUMMARY_TITLE));
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        _local_1.x = ((this.WIDTH - _local_1.width) * 0.5);
        _local_1.y = 3;
        addChild(_local_1);
        return (_local_1);
    }

    private function makeButton():StaticTextButton {
        var _local_1:StaticTextButton;
        _local_1 = new StaticTextButton(16, TextKey.BATTLE_SUMMARY_CLOSE, 100);
        _local_1.addEventListener(MouseEvent.CLICK, this.closeClicked);
        _local_1.y = ((this.HEIGHT - _local_1.height) - 10);
        _local_1.x = ((this.WIDTH / 2) - (_local_1.width / 2));
        addChild(_local_1);
        return (_local_1);
    }


}
}//package kabam.rotmg.arena.view
