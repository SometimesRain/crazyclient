package kabam.rotmg.arena.view {
import flash.display.Sprite;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class ArenaWaveCounter extends Sprite {

    private const waveText:StaticTextDisplay = makeWaveText();
    private const waveStringBuilder:LineBuilder = new LineBuilder();


    private function makeWaveText():StaticTextDisplay {
        var _local_1:StaticTextDisplay = new StaticTextDisplay();
        _local_1.setSize(24).setBold(true).setColor(0xFFFFFF);
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        addChild(_local_1);
        return (_local_1);
    }

    public function setWaveNumber(_arg_1:int):void {
        this.waveText.setStringBuilder(this.waveStringBuilder.setParams(TextKey.ARENA_LEADERBOARD_LIST_ITEM_WAVENUMBER, {"waveNumber": _arg_1}));
    }


}
}//package kabam.rotmg.arena.view
