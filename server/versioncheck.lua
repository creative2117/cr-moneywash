Citizen.CreateThread(function()
    local updatePath = "/creative2117/cr-moneywash"
    local resourceName = "creative Development(" .. GetCurrentResourceName() .. ")"

    function checkVersion(err, responseText, headers)
        local curVersion = LoadResourceFile(GetCurrentResourceName(), "version")

        if curVersion > responseText  then
            print("^1You somehow skipped a few versions of " .. resourceName ..
                      " or the git went offline, if it's still online i advise you to update ( or downgrade? )^0")
        elseif curVersion ~= responseText then
            print("\n^1###############################")
                    print("\n^5" .. resourceName .. " is outdated\n\n^2should be:" .. responseText .. "^1is:" .. curVersion ..
                              "\n^5please update it from https://github.com" .. updatePath .. "")
                    print("\n^1###############################^0")
        else
            print("\n^2" .. resourceName .. " is up to date, have fun!^0")
        end
    end

    PerformHttpRequest("https://raw.githubusercontent.com" .. updatePath .. "/main/version", checkVersion, "GET")
end)