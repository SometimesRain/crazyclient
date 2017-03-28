package kabam.rotmg.text.view {
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.model.TextAndMapProvider;

import org.swiftsuspenders.Injector;

public class StaticTextDisplay extends TextDisplay {

    public function StaticTextDisplay() {
        var _local_1:Injector = StaticInjectorContext.getInjector();
        super(_local_1.getInstance(FontModel), _local_1.getInstance(TextAndMapProvider));
    }

}
}//package kabam.rotmg.text.view
