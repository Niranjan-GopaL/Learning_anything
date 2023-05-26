;No dependencies

DarkMode(guiObj) {
    guiObj.BackColor := "171717"
    return guiObj
}
Gui.Prototype.DefineProp("DarkMode", { Call: DarkMode })

MakeFontNicer(guiObj, fontSize := 20) {
    guiObj.SetFont("s" fontSize " cC5C5C5", "Consolas")
    return guiObj
}
Gui.Prototype.DefineProp("MakeFontNicer", { Call: MakeFontNicer })

PressTitleBar(guiObj) {
    PostMessage(0xA1, 2, , , guiObj)
    return guiObj
}
Gui.Prototype.DefineProp("PressTitleBar", { Call: PressTitleBar })

NeverFocusWindow(guiObj) {
    WinSetExStyle("0x08000000L", guiObj)
    return guiObj
}
Gui.Prototype.DefineProp("NeverFocusWindow", { Call: NeverFocusWindow })

MakeClickthrough(guiObj) {
    WinSetTransparent(255, guiObj)
    guiObj.Opt("+E0x20")
    return guiObj
}
Gui.Prototype.DefineProp("MakeClickthrough", { Call: MakeClickthrough })


;---------------------------------------------------------------------------------------------------------------------------------

class CleanInputBox extends Gui {

    Width := Round(A_ScreenWidth / 1920 * 1200)
    TopMargin := Round(A_ScreenHeight / 1080 * 800)

    /**
     * Get a gui to type into.
     * Close it by pressing Escape. (This exits the entire thread)
     * Accept your input by pressing Enter.
     * Call WaitForInput() after creating the class instance.
     */
    __New() {
        super.__New("AlwaysOnTop -Caption")
        this.DarkMode().MakeFontNicer(30)
        this.MarginX := 0

        this.InputField := this.AddEdit(
            "x0 Center -E0x200 Background"
            this.BackColor " w" this.Width
        )

        this.Input := ""
        this.isWaiting := true
        this.RegisterHotkeys()
    }

    Show() => (super.Show("y" this.TopMargin " w" this.Width), this)


    /**
     * Occupy the thread until you type in your input and press
     * Enter, returns this input
     * @returns {String}
     */
    WaitForInput() {
        this.Show()
        while this.isWaiting {
        }
        return this.Input
    }

    SetInput() {
        this.Input := this.InputField.Text
        this.isWaiting := false
        this.Finish()
    }

    SetCancel() {
        this.isWaiting := false
        this.Finish()
    }

    RegisterHotkeys() {
        HotIfWinactive("ahk_id " this.Hwnd)
        Hotkey("Enter", (*) => this.SetInput(), "On")
        this.OnEvent("Escape", (*) => this.SetCancel())
    }

    Finish() {
        HotIfWinactive("ahk_id " this.Hwnd)
        Hotkey("Enter", "Off")
        this.Minimize()
        this.Destroy()
    }
}


;-----------------------------------------------------------------------------------------------------------------------------------

#j:: {
    if !input := CleanInputBox().WaitForInput() {
        return false
    }

    static runner_commands := Map(
        ; "libs?", () => Infos(CountLibraries()),
        ; "drop", () => Shows.DeleteShow(true),
        ; "finish", () => Shows.DeleteShow(false),
        ; "show", () => Shows.Run("episode"),
        ; "down", () => Shows.Run("downloaded"),
        ; "gimp", () => Gimp.winObj.RunAct(),
        ; "davinci", () => Davinci.winObj.RunAct(),
        ; "ext", () => Explorer.WinObjs.VsCodeExtensions.RunAct_Folders(),
        ; "saved", () => Explorer.WinObjs.SavedScreenshots.RunAct_Folders(),
    )

    static runner_regex := Map(
        ; "go", (input) => _GitLinkOpenCopy(input),
        ; "gl", (input) => ClipSend(Git.Link(input), , false),
        ; "p", (input) => _LinkPaste(input),
        ; "o", (input) => _LinkOpen(input),
        ; "cp", (input) => (A_Clipboard := input, Info('"' input '" copied')),
        ; "rap", (input) => Spotify.NewRapper(input),
        ; "fav", (input) => Spotify.FavRapper(input),
        ; "disc", (input) => Spotify.NewDiscovery(input),
        ; "link", (input) => Shows.SetLink(input),
        ; "ep", (input) => Shows.SetEpisode(input),
        ; "finish", (input) => Shows._OperateConsumed(input, false),
        ; "dd", (input) => Shows.SetDownloaded(input),
        ; "drop", (input) => Shows._OperateConsumed(input, true),
        ; "relink", (input) => Shows.UpdateLink(input),
        ; "ev", (input) => Infos(Calculator(input)),
        ; "evp", (input) => ClipSend(Calculator(input)),
    )

    if runner_commands.Has(input) {
        runner_commands[input].Call()
        return
    }

    regex := "^("
    for key, _ in runner_regex {
        regex .= key "|"
    }

    regex .= ") (.+)"
    result := input.RegexMatch(regex)
    if runner_regex.Has(result[1])
        runner_regex[result[1]].Call(result[2])

    static _GitLinkOpenCopy(input) {
        ; link := Git.Link(input)
        ; Browser.RunLink(link)
        ; A_Clipboard := link
    }

    static _LinkPaste(input) {
        ; link := Environment.Links.Choose(input)
        ; if !link
        ;     return
        ; ClipSend(link, , false)
    }

    static _LinkOpen(input) {
        ; link := Environment.Links.Choose(input)
        ; if !link
        ;     return
        ; Browser.RunLink(link)
    }

}