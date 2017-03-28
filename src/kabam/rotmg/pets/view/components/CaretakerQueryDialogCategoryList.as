package kabam.rotmg.pets.view.components {
import flash.display.DisplayObject;
import flash.events.MouseEvent;

import kabam.lib.ui.impl.LayoutList;
import kabam.lib.ui.impl.VerticalLayout;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;

public class CaretakerQueryDialogCategoryList extends LayoutList {

    private const waiter:SignalWaiter = new SignalWaiter();
    public const ready:Signal = waiter.complete;
    public const selected:Signal = new Signal(String);

    public function CaretakerQueryDialogCategoryList(_arg_1:Array) {
        setLayout(this.makeLayout());
        setItems(this.makeItems(_arg_1));
        this.ready.addOnce(updateLayout);
    }

    private function makeLayout():VerticalLayout {
        var _local_1:VerticalLayout = new VerticalLayout();
        _local_1.setPadding(2);
        return (_local_1);
    }

    private function makeItems(_arg_1:Array):Vector.<DisplayObject> {
        var _local_2:Vector.<DisplayObject> = new Vector.<DisplayObject>();
        var _local_3:int;
        while (_local_3 < _arg_1.length) {
            _local_2.push(this.makeItem(_arg_1[_local_3]));
            _local_3++;
        }
        return (_local_2);
    }

    private function makeItem(_arg_1:Object):CaretakerQueryDialogCategoryItem {
        var _local_2:CaretakerQueryDialogCategoryItem = new CaretakerQueryDialogCategoryItem(_arg_1.category, _arg_1.info);
        _local_2.addEventListener(MouseEvent.CLICK, this.onClick);
        this.waiter.push(_local_2.textChanged);
        return (_local_2);
    }

    private function onClick(_arg_1:MouseEvent):void {
        var _local_2:CaretakerQueryDialogCategoryItem = (_arg_1.currentTarget as CaretakerQueryDialogCategoryItem);
        this.selected.dispatch(_local_2.info);
    }


}
}//package kabam.rotmg.pets.view.components
