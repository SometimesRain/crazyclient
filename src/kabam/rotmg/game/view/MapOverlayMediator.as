package kabam.rotmg.game.view {
import com.company.assembleegameclient.map.mapoverlay.MapOverlay;
import com.company.assembleegameclient.map.mapoverlay.SpeechBalloon;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.game.model.AddSpeechBalloonVO;
import kabam.rotmg.game.model.ChatFilter;
import kabam.rotmg.game.signals.AddSpeechBalloonSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MapOverlayMediator extends Mediator {

    [Inject]
    public var view:MapOverlay;
    [Inject]
    public var addSpeechBalloon:AddSpeechBalloonSignal;
    [Inject]
    public var chatFilter:ChatFilter;
    [Inject]
    public var account:Account;


    override public function initialize():void {
        this.addSpeechBalloon.add(this.onAddSpeechBalloon);
    }

    override public function destroy():void {
        this.addSpeechBalloon.remove(this.onAddSpeechBalloon);
    }

    private function onAddSpeechBalloon(_arg_1:AddSpeechBalloonVO):void {
        var _local_2:String = ((((this.account.isRegistered()) || (this.chatFilter.guestChatFilter(_arg_1.go.name_)))) ? _arg_1.text : ". . .");
        var _local_3:* = new SpeechBalloon(_arg_1.go, _local_2, _arg_1.name, _arg_1.isTrade, _arg_1.isGuild, _arg_1.background, _arg_1.backgroundAlpha, _arg_1.outline, _arg_1.outlineAlpha, _arg_1.textColor, _arg_1.lifetime, _arg_1.bold, _arg_1.hideable);
        this.view.addSpeechBalloon(_local_3);
    }


}
}//package kabam.rotmg.game.view
