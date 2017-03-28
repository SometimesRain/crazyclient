package kabam.rotmg.minimap.view {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;

import flash.utils.Dictionary;

import kabam.rotmg.core.view.Layers;
import kabam.rotmg.game.focus.control.SetGameFocusSignal;
import kabam.rotmg.game.signals.ExitGameSignal;
import kabam.rotmg.minimap.control.MiniMapZoomSignal;
import kabam.rotmg.minimap.control.UpdateGameObjectTileSignal;
import kabam.rotmg.minimap.control.UpdateGroundTileSignal;
import kabam.rotmg.minimap.model.UpdateGroundTileVO;
import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.ui.model.UpdateGameObjectTileVO;
import kabam.rotmg.ui.signals.UpdateHUDSignal;

import robotlegs.bender.extensions.mediatorMap.api.IMediator;

public class MiniMapMediator implements IMediator {

    [Inject]
    public var view:MiniMap;
    [Inject]
    public var model:HUDModel;
    [Inject]
    public var setFocus:SetGameFocusSignal;
    [Inject]
    public var updateGroundTileSignal:UpdateGroundTileSignal;
    [Inject]
    public var updateGameObjectTileSignal:UpdateGameObjectTileSignal;
    [Inject]
    public var miniMapZoomSignal:MiniMapZoomSignal;
    [Inject]
    public var updateHUD:UpdateHUDSignal;
    [Inject]
    public var exitGameSignal:ExitGameSignal;
    [Inject]
    public var layers:Layers;


    public function initialize():void {
        this.view.setMap(this.model.gameSprite.map);
        this.setFocus.add(this.onSetFocus);
        this.updateHUD.add(this.onUpdateHUD);
        this.updateGameObjectTileSignal.add(this.onUpdateGameObjectTile);
        this.updateGroundTileSignal.add(this.onUpdateGroundTile);
        this.miniMapZoomSignal.add(this.onMiniMapZoom);
        this.exitGameSignal.add(this.onExitGame);
        this.view.menuLayer = this.layers.top;
    }

    private function onExitGame():void {
        this.view.deactivate();
    }

    public function destroy():void {
        this.setFocus.remove(this.onSetFocus);
        this.updateHUD.remove(this.onUpdateHUD);
        this.updateGameObjectTileSignal.remove(this.onUpdateGameObjectTile);
        this.updateGroundTileSignal.remove(this.onUpdateGroundTile);
        this.miniMapZoomSignal.remove(this.onMiniMapZoom);
        this.exitGameSignal.remove(this.onExitGame);
    }

    private function onSetFocus(_arg_1:String):void {
        var _local_2:GameObject = this.getFocusById(_arg_1);
        this.view.setFocus(_local_2);
    }

    private function getFocusById(_arg_1:String):GameObject {
        var _local_3:GameObject;
        if (_arg_1 == "") {
            return (this.view.map.player_);
        }
        var _local_2:Dictionary = this.view.map.goDict_;
        for each (_local_3 in _local_2) {
            if (_local_3.name_ == _arg_1) {
                return (_local_3);
            }
        }
        return (this.view.map.player_);
    }

    private function onUpdateGroundTile(_arg_1:UpdateGroundTileVO):void {
        this.view.setGroundTile(_arg_1.tileX, _arg_1.tileY, _arg_1.tileType);
    }

    private function onUpdateGameObjectTile(_arg_1:UpdateGameObjectTileVO):void {
        this.view.setGameObjectTile(_arg_1.tileX, _arg_1.tileY, _arg_1.gameObject);
    }

    private function onMiniMapZoom(_arg_1:String):void {
        if (_arg_1 == MiniMapZoomSignal.IN) {
            this.view.zoomIn();
        }
        else {
            if (_arg_1 == MiniMapZoomSignal.OUT) {
                this.view.zoomOut();
            }
        }
    }

    private function onUpdateHUD(_arg_1:Player):void {
        this.view.draw();
    }


}
}//package kabam.rotmg.minimap.view
