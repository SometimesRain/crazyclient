package kabam.rotmg.news.controller {
import kabam.rotmg.news.model.NewsCellVO;

import org.osflash.signals.Signal;

public class NewsDataUpdatedSignal extends Signal {

    public function NewsDataUpdatedSignal() {
        super(Vector.<NewsCellVO>);
    }

}
}//package kabam.rotmg.news.controller
