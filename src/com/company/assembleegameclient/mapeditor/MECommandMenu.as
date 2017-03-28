package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.editor.CommandEvent;
import com.company.assembleegameclient.editor.CommandMenu;
import com.company.assembleegameclient.editor.CommandMenuItem;
import com.company.util.KeyCodes;

import kabam.rotmg.application.DynamicSettings;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;

public class MECommandMenu extends CommandMenu {

    public static const NONE_COMMAND:int = 0;
    public static const DRAW_COMMAND:int = 1;
    public static const ERASE_COMMAND:int = 2;
    public static const SAMPLE_COMMAND:int = 3;
    public static const EDIT_COMMAND:int = 4;
    public static const CUT_COMMAND:int = 5;
    public static const COPY_COMMAND:int = 6;
    public static const PASTE_COMMAND:int = 7;
    public static const PICK_UP_COMMAND:int = 8;
    public static const DROP_COMMAND:int = 9;

    public function MECommandMenu() {
        var _local_1:PlayerModel = StaticInjectorContext.getInjector().getInstance(PlayerModel);
        addCommandMenuItem("(D)raw", KeyCodes.D, this.select, DRAW_COMMAND);
        addCommandMenuItem("(E)rase", KeyCodes.E, this.select, ERASE_COMMAND);
        if(_local_1 != null && _local_1.isAdmin())
        {
            addCommandMenuItem("S(A)mple", KeyCodes.A, this.select, SAMPLE_COMMAND);
        }
        addCommandMenuItem("(P)ick Up", KeyCodes.P, this.select, PICK_UP_COMMAND);
        addCommandMenuItem("Drop", -1, this.select, DROP_COMMAND);
        addCommandMenuItem("(U)ndo", KeyCodes.U, this.onUndo, NONE_COMMAND);
        addCommandMenuItem("(R)edo", KeyCodes.R, this.onRedo, NONE_COMMAND);
        addCommandMenuItem("(C)lear", KeyCodes.C, this.onClear, NONE_COMMAND);
        addCommandMenuItem("Cut", -1, this.select, CUT_COMMAND);
        addCommandMenuItem("Copy", -1, this.select, COPY_COMMAND);
        addCommandMenuItem("Paste", -1, this.select, PASTE_COMMAND);
        addCommandMenuItem("(L)oad", KeyCodes.L, this.onLoad, NONE_COMMAND);
        addCommandMenuItem("(S)ave", KeyCodes.S, this.onSave, NONE_COMMAND);
        addCommandMenuItem("(T)est", KeyCodes.T, this.onTest, NONE_COMMAND);
        if(_local_1.isAdmin() || DynamicSettings.settingExists("UGDOpenSubmission") && DynamicSettings.getSettingValue("UGDOpenSubmission") == 1)
        {
            addCommandMenuItem("Submit", -1, this.onSubmit, NONE_COMMAND);
        }
        else
        {
            addBreak();
        }
    }

    private function select(_arg_1:CommandMenuItem):void {
        setSelected(_arg_1);
        dispatchEvent(new CommandEvent(CommandEvent.SELECT_COMMAND_EVENT));
    }

    private function onUndo(_arg_1:CommandMenuItem):void {
        dispatchEvent(new CommandEvent(CommandEvent.UNDO_COMMAND_EVENT));
    }

    private function onRedo(_arg_1:CommandMenuItem):void {
        dispatchEvent(new CommandEvent(CommandEvent.REDO_COMMAND_EVENT));
    }

    private function onClear(_arg_1:CommandMenuItem):void {
        dispatchEvent(new CommandEvent(CommandEvent.CLEAR_COMMAND_EVENT));
    }

    private function onLoad(_arg_1:CommandMenuItem):void {
        dispatchEvent(new CommandEvent(CommandEvent.LOAD_COMMAND_EVENT));
    }

    private function onSave(_arg_1:CommandMenuItem):void {
        dispatchEvent(new CommandEvent(CommandEvent.SAVE_COMMAND_EVENT));
    }

    private function onSubmit(_arg_1:CommandMenuItem):void
    {
        dispatchEvent(new CommandEvent(CommandEvent.SUBMIT_COMMAND_EVENT));
    }

    private function onTest(_arg_1:CommandMenuItem):void {
        dispatchEvent(new CommandEvent(CommandEvent.TEST_COMMAND_EVENT));
    }


}
}//package com.company.assembleegameclient.mapeditor
