local Translations = {
    text3d = {
        ["3dtext"] = "~w~[G] ~q~Wash money",
        ["3dtext_left"] = "%{timeleft} secunds left",
        ["3dtext_done"] = "~w~[G] ~q~Take the money",
    },
    notify = {
        ["no_markedbills"] = "You don'y have any marked bills!",
        ["Start_washing"] = "You started to wash money with the value of %{value}",
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})