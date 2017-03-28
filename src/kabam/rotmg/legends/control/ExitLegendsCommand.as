package kabam.rotmg.legends.control {
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;

import kabam.rotmg.core.signals.InvalidateDataSignal;
import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
import kabam.rotmg.death.model.DeathModel;
import kabam.rotmg.ui.view.TitleView;

public class ExitLegendsCommand {

    [Inject]
    public var model:DeathModel;
    [Inject]
    public var invalidate:InvalidateDataSignal;
    [Inject]
    public var setScreen:SetScreenWithValidDataSignal;


    public function execute():void {
        if (this.model.getIsDeathViewPending()) {
            this.clearRecentlyDeceasedAndGotoCharacterView();
        }
        else {
            this.gotoTitleView();
        }
    }

    private function clearRecentlyDeceasedAndGotoCharacterView():void {
        this.model.clearPendingDeathView();
        this.invalidate.dispatch();
        this.setScreen.dispatch(new CharacterSelectionAndNewsScreen());
    }

    private function gotoTitleView():void {
        this.setScreen.dispatch(new TitleView());
    }


}
}//package kabam.rotmg.legends.control
