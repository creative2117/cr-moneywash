local Translations = {
    text3d = {
        ["3dtext"] = "~w~[G] ~q~Tvätta pengar",
        ["3dtext_left"] = "%{timeleft} sekunder kvar",
        ["3dtext_done"] = "~w~[G] ~q~Ta ut pengarna",
    },
    notify = {
        ["no_markedbills"] = "Du har inga svarta pengar!",
        ["Start_washing"] = "Du börjar att tvätta pengar av ett värde av %{value}",
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})