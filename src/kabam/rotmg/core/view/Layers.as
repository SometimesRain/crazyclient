package kabam.rotmg.core.view {
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import kabam.rotmg.dialogs.view.DialogsView;
import kabam.rotmg.tooltips.view.TooltipsView;

public class Layers extends Sprite {

    private var menu:ScreensView;
    public var overlay:DisplayObjectContainer;
    private var tooltips:TooltipsView;
    public var top:DisplayObjectContainer;
    public var mouseDisabledTop:DisplayObjectContainer;
    private var dialogs:DialogsView;
    public var api:DisplayObjectContainer;
    public var console:DisplayObjectContainer;

    public function Layers() {
        addChild((this.menu = new ScreensView()));
        addChild((this.overlay = new Sprite()));
        addChild((this.top = new Sprite()));
        addChild((this.mouseDisabledTop = new Sprite()));
        this.mouseDisabledTop.mouseEnabled = false;
        addChild((this.dialogs = new DialogsView()));
        addChild((this.tooltips = new TooltipsView()));
        addChild((this.api = new Sprite()));
        addChild((this.console = new Sprite()));
    }

}
}//package kabam.rotmg.core.view
