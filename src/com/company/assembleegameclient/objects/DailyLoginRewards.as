package com.company.assembleegameclient.objects
{
	import com.company.assembleegameclient.ui.panels.Panel;
	import com.company.assembleegameclient.game.GameSprite;
	import kabam.rotmg.dailyLogin.view.DailyLoginPanel;
	
	public class DailyLoginRewards extends GameObject implements IInteractiveObject
	{
		 
		
		public function DailyLoginRewards(param1:XML)
		{
			super(param1);
			isInteractive_ = true;
		}
		
		public function getPanel(param1:GameSprite) : Panel
		{
			return new DailyLoginPanel(param1);
		}
	}
}
