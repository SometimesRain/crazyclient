package kabam.rotmg.news.view {
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.text.TextField;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class NewsModalPage extends Sprite {

    public static const TEXT_MARGIN:int = 22;
    public static const TEXT_MARGIN_HTML:int = 26;

    public function NewsModalPage(_arg_1:String, _arg_2:String) {
        var _local_3:TextField;
        super();
        this.doubleClickEnabled = false;
        this.mouseEnabled = false;
        _local_3 = new TextField();
        var _local_4:FontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
        _local_4.apply(_local_3, 16, 15792127, false, true);
        _local_3.width = (NewsModal.MODAL_WIDTH - (TEXT_MARGIN_HTML * 2));
        _local_3.height = (NewsModal.MODAL_HEIGHT - 101);
        _local_3.multiline = true;
        _local_3.wordWrap = true;
        _local_3.htmlText = _arg_2;
        _local_3.x = TEXT_MARGIN_HTML;
        _local_3.y = 53;
        _local_3.filters = [new DropShadowFilter(0, 0, 0)];
        disableMouseOnText(_local_3);
        addChild(_local_3);
        var _local_5:TextFieldDisplayConcrete = NewsModal.getText(_arg_1, TEXT_MARGIN, 6, true);
        addChild(_local_5);
    }

    private static function disableMouseOnText(_arg_1:TextField):void {
        _arg_1.mouseWheelEnabled = false;
    }


}
}//package kabam.rotmg.news.view
