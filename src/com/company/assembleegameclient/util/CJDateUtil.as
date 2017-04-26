package com.company.assembleegameclient.util {
public class CJDateUtil { //inheriting date causes corrupt abc data error, nice language flash
	
	private var date:Date;
	
	public function CJDateUtil() {
		date = new Date();
	}
	
	public function getFormattedTime():String {
		return toDoubleDigit(date.getHours())+":"+toDoubleDigit(date.getMinutes());
	}
	
	private function toDoubleDigit(hours:int):String {
		return hours > 9 ? hours.toString() : "0" + hours;
	}
}
}//package com.company.assembleegameclient.util
