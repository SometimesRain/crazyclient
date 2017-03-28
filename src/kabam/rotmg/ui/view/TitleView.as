package kabam.rotmg.ui.view {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.screens.AccountScreen;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.ui.SoundIcon;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.external.ExternalInterface;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.transfer.view.KabamLoginView;
import kabam.rotmg.application.model.PlatformModel;
import kabam.rotmg.application.model.PlatformType;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.model.EnvironmentData;
import kabam.rotmg.ui.view.components.DarkLayer;
import kabam.rotmg.ui.view.components.MapBackground;
import kabam.rotmg.ui.view.components.MenuOptionsBar;
import com.company.rotmg.graphics.TitleScreenGraphic;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class TitleView extends Sprite {

    public static const MIDDLE_OF_BOTTOM_BAND:Number = 589.45;
    public static var queueEmailConfirmation:Boolean = false;
    public static var queuePasswordPrompt:Boolean = false;
    public static var queuePasswordPromptFull:Boolean = false;
    public static var queueRegistrationPrompt:Boolean = false;
    public static var kabammigrateOpened:Boolean = false;

    private var versionText:TextFieldDisplayConcrete;
    private var copyrightText:TextFieldDisplayConcrete;
    private var menuOptionsBar:MenuOptionsBar;
    private var data:EnvironmentData;
    public var playClicked:Signal;
    public var serversClicked:Signal;
    public var accountClicked:Signal;
    public var legendsClicked:Signal;
    public var languagesClicked:Signal;
    public var supportClicked:Signal;
    public var kabamTransferClicked:Signal;
    public var editorClicked:Signal;
    public var quitClicked:Signal;
    public var optionalButtonsAdded:Signal;
    private var migrateButton:TitleMenuOption;

    public function TitleView() {
        this.menuOptionsBar = this.makeMenuOptionsBar();
        this.optionalButtonsAdded = new Signal();
        super();
        addChild(new MapBackground());
        addChild(new DarkLayer());
        addChild(new TitleScreenGraphic());
        addChild(this.menuOptionsBar);
        addChild(new AccountScreen());
        this.makeChildren();
        addChild(new SoundIcon());
    }

    public function openKabamTransferView():void {
        var _local_1:OpenDialogSignal = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
        _local_1.dispatch(new KabamLoginView());
    }

    private function makeMenuOptionsBar():MenuOptionsBar {
        var _local_1:TitleMenuOption = ButtonFactory.getPlayButton();
        var _local_2:TitleMenuOption = ButtonFactory.getServersButton();
        var _local_3:TitleMenuOption = ButtonFactory.getAccountButton();
        var _local_4:TitleMenuOption = ButtonFactory.getLegendsButton();
        var _local_5:TitleMenuOption = ButtonFactory.getSupportButton();
        this.playClicked = _local_1.clicked;
        this.serversClicked = _local_2.clicked;
        this.accountClicked = _local_3.clicked;
        this.legendsClicked = _local_4.clicked;
        this.supportClicked = _local_5.clicked;
        var _local_6:MenuOptionsBar = new MenuOptionsBar();
        _local_6.addButton(_local_1, MenuOptionsBar.CENTER);
        _local_6.addButton(_local_2, MenuOptionsBar.LEFT);
        _local_6.addButton(_local_5, MenuOptionsBar.LEFT);
        _local_6.addButton(_local_3, MenuOptionsBar.RIGHT);
        _local_6.addButton(_local_4, MenuOptionsBar.RIGHT);
        return (_local_6);
    }

    private function makeChildren():void {
        this.versionText = this.makeText().setHTML(true).setAutoSize(TextFieldAutoSize.LEFT).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.versionText.y = MIDDLE_OF_BOTTOM_BAND;
        addChild(this.versionText);
        this.copyrightText = this.makeText().setAutoSize(TextFieldAutoSize.RIGHT).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.copyrightText.setStringBuilder(new LineBuilder().setParams("MPGH.net"));
        this.copyrightText.filters = [new DropShadowFilter(0, 0, 0)];
        this.copyrightText.x = 800;
        this.copyrightText.y = MIDDLE_OF_BOTTOM_BAND;
        addChild(this.copyrightText);
    }

    public function makeText():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(12).setColor(0x7F7F7F);
        _local_1.filters = [new DropShadowFilter(0, 0, 0)];
        return (_local_1);
    }

    public function initialize(_arg_1:EnvironmentData):void {
        this.data = _arg_1;
        this.updateVersionText();
        this.handleOptionalButtons();
    }

    public function putNoticeTagToOption(_arg_1:TitleMenuOption, _arg_2:String, _arg_3:int = 14, _arg_4:uint = 0x99FF66, _arg_5:Boolean = true):void
    {
        _arg_1.createNoticeTag(_arg_2, _arg_3, _arg_4, _arg_5);
    }

    private function updateVersionText():void {
        this.versionText.setStringBuilder(new StaticStringBuilder("CrazyClient "+Parameters.CRAZY_VERSION+" "+data.buildLabel.substr(6)));
    }

    private function handleOptionalButtons():void {
        this.data.canMapEdit && this.createEditorButton();
        this.data.isDesktop && this.createQuitButton();
        this.optionalButtonsAdded.dispatch();
    }

    private function createQuitButton():void {
        var _local_1:TitleMenuOption = ButtonFactory.getQuitButton();
        this.menuOptionsBar.addButton(_local_1, MenuOptionsBar.RIGHT);
        this.quitClicked = _local_1.clicked;
    }

    private function createEditorButton():void {
        var _local_1:TitleMenuOption = ButtonFactory.getEditorButton();
        this.menuOptionsBar.addButton(_local_1, MenuOptionsBar.RIGHT);
        this.editorClicked = _local_1.clicked;
    }


}
}//package kabam.rotmg.ui.view
