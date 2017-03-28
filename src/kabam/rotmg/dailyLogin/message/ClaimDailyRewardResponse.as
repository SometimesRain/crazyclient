package kabam.rotmg.dailyLogin.message
{
	import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
	import flash.utils.IDataInput;
	
	public class ClaimDailyRewardResponse extends IncomingMessage
	{
		
		public var itemId:int;
		
		public var quantity:int;
		
		public var gold:int;
		
		public function ClaimDailyRewardResponse(param1:uint, param2:Function)
		{
			super(param1,param2);
		}
		
		override public function parseFromInput(param1:IDataInput) : void
		{
			this.itemId = param1.readInt();
			this.quantity = param1.readInt();
			this.gold = param1.readInt();
		}
		
		override public function toString() : String
		{
			return formatToString("CLAIMDAILYREWARDRESPONSE","itemId","quantity","gold");
		}
	}
}
