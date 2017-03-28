package kabam.rotmg.game.view {
import kabam.rotmg.game.model.TextPanelData;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TextPanelMediator extends Mediator {

    [Inject]
    public var view:TextPanel;
    [Inject]
    public var data:TextPanelData;


    override public function initialize():void {
        this.view.init(this.data.message);
    }


}
}//package kabam.rotmg.game.view
