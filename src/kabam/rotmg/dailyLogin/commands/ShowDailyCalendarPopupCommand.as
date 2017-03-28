package kabam.rotmg.dailyLogin.commands
{
	import kabam.rotmg.dialogs.control.OpenDialogSignal;
	import kabam.rotmg.dailyLogin.model.DailyLoginModel;
	import kabam.rotmg.dailyLogin.view.DailyLoginModal;
	
	public class ShowDailyCalendarPopupCommand
	{
		
		[Inject]
		public var openDialog:OpenDialogSignal;
		
		[Inject]
		public var dailyLoginModel:DailyLoginModel;
		
		public function ShowDailyCalendarPopupCommand()
		{
			super();
		}
		
		public function execute() : void
		{
			if(this.dailyLoginModel.shouldDisplayCalendarAtStartup && this.dailyLoginModel.initialized)
			{
				this.openDialog.dispatch(new DailyLoginModal());
			}
		}
	}
}
