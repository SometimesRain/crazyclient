package kabam.rotmg.arena.view {
import com.company.assembleegameclient.util.Currency;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.editor.view.StaticTextButton;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.util.components.DialogBackground;
import kabam.rotmg.util.components.LegacyBuyButton;

import org.osflash.signals.Signal;

public class ContinueOrQuitDialog extends Sprite {

    public const quit:Signal = new Signal();
    public const buyContinue:Signal = new Signal(int, int);
    private const WIDTH:int = 350;
    private const HEIGHT:int = 150;
    private const background:DialogBackground = makeBackground();
    private const title:StaticTextDisplay = makeTitle();
    private const quitSubtitle:StaticTextDisplay = makeSubtitle();
    private const quitButton:StaticTextButton = makeQuitButton();
    private const continueButton:LegacyBuyButton = makeContinueButton();
    private const restartSubtitle:StaticTextDisplay = makeSubtitle();
    private const processingText:StaticTextDisplay = makeSubtitle();

    private var cost:int;

    public function ContinueOrQuitDialog(_arg_1:int, _arg_2:Boolean) {
        this.cost = _arg_1;
        this.continueButton.setPrice(_arg_1, Currency.GOLD);
        this.setProcessing(_arg_2);
    }

    public function init(_arg_1:int, _arg_2:int):void {
        this.positionThis();
        this.quitButton.addEventListener(MouseEvent.CLICK, this.onQuit);
        this.continueButton.addEventListener(MouseEvent.CLICK, this.onBuyContinue);
        this.quitSubtitle.setStringBuilder(new LineBuilder().setParams(TextKey.CONTINUE_OR_QUIT_QUIT_SUBTITLE));
        this.restartSubtitle.setStringBuilder(new LineBuilder().setParams(TextKey.CONTINUE_OR_QUIT_CONTINUE_SUBTITLE, {"waveNumber": _arg_1.toString()}));
        this.processingText.setStringBuilder(new StaticStringBuilder("Processing"));
        this.processingText.visible = false;
        this.align();
        this.makeHorizontalLine();
        this.makeVerticalLine();
    }

    public function setProcessing(_arg_1:Boolean):void {
        this.processingText.visible = _arg_1;
        this.continueButton.visible = !(_arg_1);
    }

    public function destroy():void {
        this.quitButton.removeEventListener(MouseEvent.CLICK, this.onQuit);
        this.continueButton.removeEventListener(MouseEvent.CLICK, this.onBuyContinue);
    }

    private function onQuit(_arg_1:MouseEvent):void {
        this.quit.dispatch();
    }

    private function onBuyContinue(_arg_1:MouseEvent):void {
        this.buyContinue.dispatch(Currency.GOLD, this.cost);
    }

    private function align():void {
        this.quitSubtitle.x = (70 - (this.quitSubtitle.width / 2));
        this.quitSubtitle.y = 85;
        this.quitButton.x = (70 - (this.quitButton.width / 2));
        this.quitButton.y = 110;
        this.restartSubtitle.x = ((105 - (this.restartSubtitle.width / 2)) + 140);
        this.restartSubtitle.y = 85;
        this.continueButton.x = ((105 - (this.continueButton.width / 2)) + 140);
        this.continueButton.y = 110;
        this.processingText.x = ((105 - (this.processingText.width / 2)) + 140);
        this.processingText.y = 110;
    }

    private function positionThis():void {
        x = ((stage.stageWidth - this.WIDTH) * 0.5);
        y = ((stage.stageHeight - this.HEIGHT) * 0.5);
    }

    private function makeBackground():DialogBackground {
        var _local_1:DialogBackground = new DialogBackground();
        _local_1.draw(this.WIDTH, this.HEIGHT);
        addChild(_local_1);
        return (_local_1);
    }

    private function makeTitle():StaticTextDisplay {
        var _local_1:StaticTextDisplay = new StaticTextDisplay();
        _local_1.setSize(20).setBold(true).setColor(0xB3B3B3);
        _local_1.setStringBuilder(new LineBuilder().setParams(TextKey.CONTINUE_OR_QUIT_TITLE));
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        _local_1.x = ((this.WIDTH - _local_1.width) * 0.5);
        _local_1.y = 25;
        addChild(_local_1);
        return (_local_1);
    }

    private function makeHorizontalLine():void {
        this.background.graphics.lineStyle();
        this.background.graphics.beginFill(0x666666, 1);
        this.background.graphics.drawRect(1, 70, (this.background.width - 2), 2);
        this.background.graphics.endFill();
    }

    private function makeVerticalLine():void {
        this.background.graphics.lineStyle();
        this.background.graphics.beginFill(0x666666, 1);
        this.background.graphics.drawRect(140, 70, 2, (this.HEIGHT - 66));
        this.background.graphics.endFill();
    }

    private function makeQuitButton():StaticTextButton {
        var _local_1:StaticTextButton = new StaticTextButton(15, TextKey.CONTINUE_OR_QUIT_EXIT);
        addChild(_local_1);
        return (_local_1);
    }

    private function makeContinueButton():LegacyBuyButton {
        var _local_1:LegacyBuyButton = new LegacyBuyButton("", 15, this.cost, Currency.GOLD);
        _local_1.readyForPlacement.addOnce(this.align);
        addChild(_local_1);
        return (_local_1);
    }

    private function makeSubtitle():StaticTextDisplay {
        var _local_1:StaticTextDisplay = new StaticTextDisplay();
        _local_1.setSize(15).setColor(0xFFFFFF).setBold(true);
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        addChild(_local_1);
        return (_local_1);
    }


}
}//package kabam.rotmg.arena.view
