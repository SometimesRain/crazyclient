package kabam.rotmg.ui.view {
import com.company.assembleegameclient.objects.Player;

import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.game.view.components.StatsUndockedSignal;
import kabam.rotmg.game.view.components.StatsView;
import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.ui.signals.UpdateHUDSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class HUDMediator extends Mediator {

    [Inject]
    public var view:HUDView;
    [Inject]
    public var hudModel:HUDModel;
    [Inject]
    public var updateHUD:UpdateHUDSignal;
    [Inject]
    public var statsUndocked:StatsUndockedSignal;
    [Inject]
    public var statsDocked:StatsDockedSignal;
    private var stats:Sprite;


    override public function initialize():void {
        this.updateHUD.addOnce(this.onInitializeHUD);
        this.updateHUD.add(this.onUpdateHUD);
        this.statsUndocked.add(this.onStatsUndocked);
    }

    private function onStatsUndocked(_arg_1:StatsView):void {
        this.stats = _arg_1;
        this.view.addChild(_arg_1);
        _arg_1.x = (this.view.mouseX - (_arg_1.width / 2));
        _arg_1.y = (this.view.mouseY - (_arg_1.height / 2));
        this.startDraggingStatsAsset(_arg_1);
    }

    private function startDraggingStatsAsset(_arg_1:StatsView):void {
        _arg_1.startDrag();
        _arg_1.addEventListener(MouseEvent.MOUSE_UP, this.onStatsMouseUp);
    }

    private function onStatsMouseUp(_arg_1:MouseEvent):void {
        /*var _local_2:Sprite = StatsView(_arg_1.target);
        this.stopDraggingStatsAsset(_local_2);
        if (_local_2.hitTestObject(this.view.tabStrip)) {
            this.dockStats(_local_2);
        }*/
    }

    private function dockStats(_arg_1:Sprite):void {
        this.statsDocked.dispatch();
        this.view.removeChild(_arg_1);
        _arg_1.stopDrag();
    }

    private function stopDraggingStatsAsset(_arg_1:Sprite):void {
        _arg_1.removeEventListener(MouseEvent.MOUSE_UP, this.onStatsMouseUp);
        _arg_1.addEventListener(MouseEvent.MOUSE_DOWN, this.onStatsMouseDown);
        _arg_1.stopDrag();
    }

    private function onStatsMouseDown(_arg_1:MouseEvent):void {
        var _local_2:Sprite = Sprite(_arg_1.target);
        this.stats = _local_2;
        _local_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStatsMouseDown);
        _local_2.addEventListener(MouseEvent.MOUSE_UP, this.onStatsMouseUp);
        _local_2.startDrag();
    }

    override public function destroy():void {
        this.updateHUD.remove(this.onUpdateHUD);
        this.statsUndocked.remove(this.onStatsUndocked);
        if (((this.stats) && (this.stats.hasEventListener(MouseEvent.MOUSE_DOWN)))) {
            this.stats.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStatsMouseDown);
        }
    }

    private function onUpdateHUD(_arg_1:Player):void {
        this.view.draw();
    }

    private function onInitializeHUD(_arg_1:Player):void {
        this.view.setPlayerDependentAssets(this.hudModel.gameSprite);
    }


}
}//package kabam.rotmg.ui.view
