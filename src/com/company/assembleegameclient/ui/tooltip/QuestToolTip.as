package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.ui.GameObjectListItem;

import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class QuestToolTip extends ToolTip {

    private var text_:TextFieldDisplayConcrete;
    public var enemyGOLI_:GameObjectListItem;

    public function QuestToolTip(_arg_1:GameObject) {
        super(6036765, 1, 16549442, 1, false);
        this.text_ = new TextFieldDisplayConcrete().setSize(22).setColor(16549442).setBold(true);
        this.text_.setStringBuilder(new LineBuilder().setParams(TextKey.QUEST_TOOLTIP_QUEST));
        this.text_.filters = [new DropShadowFilter(0, 0, 0)];
        this.text_.x = 0;
        this.text_.y = 0;
        waiter.push(this.text_.textChanged);
        addChild(this.text_);
        this.enemyGOLI_ = new GameObjectListItem(0xB3B3B3, true, _arg_1);
        this.enemyGOLI_.x = 0;
        this.enemyGOLI_.y = 32;
        waiter.push(this.enemyGOLI_.textReady);
        addChild(this.enemyGOLI_);
        filters = [];
    }

}
}//package com.company.assembleegameclient.ui.tooltip
