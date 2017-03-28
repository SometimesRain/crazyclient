package kabam.rotmg.maploading.view {
import kabam.rotmg.maploading.commands.CharacterAnimationFactory;
import kabam.rotmg.maploading.signals.HideMapLoadingSignal;
import kabam.rotmg.maploading.signals.HideMapLoadingSignalNoFade;
import kabam.rotmg.maploading.signals.MapLoadedSignal;
import kabam.rotmg.messaging.impl.incoming.MapInfo;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MapLoadingMediator extends Mediator {

    [Inject]
    public var view:MapLoadingView;
    [Inject]
    public var mapLoading:MapLoadedSignal;
    [Inject]
    public var hideMapLoading:HideMapLoadingSignal;
    [Inject]
    public var hideMapLoadingNoFade:HideMapLoadingSignalNoFade;
    [Inject]
    public var characterAnimationFactory:CharacterAnimationFactory;


    override public function initialize():void {
        this.view.showAnimation(this.characterAnimationFactory.make());
        this.mapLoading.addOnce(this.onMapLoaded);
        this.hideMapLoading.add(this.onHide);
        this.hideMapLoadingNoFade.add(this.onHideNoFade);
    }

    private function onMapLoaded(_arg_1:MapInfo):void {
        this.view.showMap(_arg_1.displayName_, _arg_1.difficulty_);
    }

    override public function destroy():void {
        this.hideMapLoading.remove(this.onHide);
    }

    private function onHide():void {
        this.view.disable();
    }

    private function onHideNoFade():void {
        this.view.disableNoFadeOut();
    }


}
}//package kabam.rotmg.maploading.view
