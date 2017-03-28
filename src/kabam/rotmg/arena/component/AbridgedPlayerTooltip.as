package kabam.rotmg.arena.component {
import com.company.assembleegameclient.ui.GuildText;
import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Bitmap;

import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class AbridgedPlayerTooltip extends ToolTip {

    public function AbridgedPlayerTooltip(_arg_1:ArenaLeaderboardEntry) {
        var _local_3:StaticTextDisplay;
        var _local_5:GuildText;
        var _local_2:Bitmap = new Bitmap();
        _local_2.bitmapData = _arg_1.playerBitmap;
        _local_2.scaleX = 0.75;
        _local_2.scaleY = 0.75;
        _local_2.y = 5;
        addChild(_local_2);
        _local_3 = new StaticTextDisplay();
        _local_3.setSize(14).setBold(true).setColor(0xFFFFFF);
        _local_3.setStringBuilder(new StaticStringBuilder(_arg_1.name));
        _local_3.x = 40;
        _local_3.y = 5;
        addChild(_local_3);
        if (_arg_1.guildName) {
            _local_5 = new GuildText(_arg_1.guildName, _arg_1.guildRank);
            _local_5.x = 40;
            _local_5.y = 20;
            addChild(_local_5);
        }
        super(0x363636, 0.5, 0xFFFFFF, 1);
        var _local_4:EquippedGrid = new EquippedGrid(null, _arg_1.slotTypes, null);
        _local_4.x = 5;
        _local_4.y = ((_local_5) ? ((_local_5.y + _local_5.height) - 5) : 55);
        _local_4.setItems(_arg_1.equipment);
        addChild(_local_4);
    }

}
}//package kabam.rotmg.arena.component
