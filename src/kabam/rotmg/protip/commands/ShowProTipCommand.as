package kabam.rotmg.protip.commands {
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.protip.model.IProTipModel;
import kabam.rotmg.protip.view.ProTipView;

public class ShowProTipCommand {

    [Inject]
    public var layers:Layers;
    [Inject]
    public var view:ProTipView;
    [Inject]
    public var model:IProTipModel;


    public function execute():void {
        this.view.setTip(this.model.getTip());
        this.layers.overlay.addChild(this.view);
    }


}
}//package kabam.rotmg.protip.commands
