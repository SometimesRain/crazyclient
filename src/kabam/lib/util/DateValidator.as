package kabam.lib.util {
public class DateValidator {

    private static const DAYS_IN_MONTH:Vector.<int> = Vector.<int>([31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]);
    private static const FEBRUARY:int = 2;

    private var thisYear:int;

    public function DateValidator() {
        this.thisYear = new Date().getFullYear();
    }

    public function isValidMonth(_arg_1:int):Boolean {
        return ((((_arg_1 > 0)) && ((_arg_1 <= 12))));
    }

    public function isValidDay(_arg_1:int, _arg_2:int = -1, _arg_3:int = -1):Boolean {
        return ((((_arg_1 > 0)) && ((_arg_1 <= this.getDaysInMonth(_arg_2, _arg_3)))));
    }

    public function getDaysInMonth(_arg_1:int = -1, _arg_2:int = -1):int {
        if (_arg_1 == -1) {
            return (31);
        }
        return ((((_arg_1 == FEBRUARY)) ? this.getDaysInFebruary(_arg_2) : DAYS_IN_MONTH[(_arg_1 - 1)]));
    }

    private function getDaysInFebruary(_arg_1:int):int {
        if ((((_arg_1 == -1)) || (this.isLeapYear(_arg_1)))) {
            return (29);
        }
        return (28);
    }

    public function isLeapYear(_arg_1:int):Boolean {
        var _local_2:Boolean = ((_arg_1 % 4) == 0);
        var _local_3:Boolean = ((_arg_1 % 100) == 0);
        var _local_4:Boolean = ((_arg_1 % 400) == 0);
        return (((_local_2) && (((!(_local_3)) || (_local_4)))));
    }

    public function isValidDate(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Boolean {
        return (((((this.isValidYear(_arg_3, _arg_4)) && (this.isValidMonth(_arg_1)))) && (this.isValidDay(_arg_2, _arg_1, _arg_3))));
    }

    public function isValidYear(_arg_1:int, _arg_2:int):Boolean {
        return ((((_arg_1 <= this.thisYear)) && ((_arg_1 > (this.thisYear - _arg_2)))));
    }


}
}//package kabam.lib.util
