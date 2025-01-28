local isTabHeld = false

hook.Add("Think", "ScoreboardToggle", function()
    -- Check if the Tab key is pressed or released
    if input.IsKeyDown(KEY_TAB) then
        if not isTabHeld then
            isTabHeld = true
        end
    else
        if isTabHeld then
            isTabHeld = false
        end
    end
end)

hook.Add("HUDPaint", "CustomScoreboard", function()
    if not isTabHeld then return end -- Only show when Tab is held

    local screenWidth, screenHeight = ScrW(), ScrH()
    local scoreboardWidth, scoreboardHeight = screenWidth * 0.5, screenHeight * 0.6
    local scoreboardX, scoreboardY = (screenWidth - scoreboardWidth) / 2, (screenHeight - scoreboardHeight) / 2
    local rowHeight = 60 -- Increased height to accommodate icons and titles

    -- Load icons
    local superadminIcon = Material("icon16/application_osx_terminal.png")
    local adminIcon = Material("icon16/shield.png")
    local userIcon = Material("icon16/user.png")
    local memberIcon = Material("icon16/user_add.png")

    -- Draw the scoreboard background
    draw.RoundedBox(10, scoreboardX, scoreboardY, scoreboardWidth, scoreboardHeight, Color(50, 50, 50, 200))

    -- Draw the title
    draw.SimpleText("NASTY FUCKLETS", "DermaLarge", scoreboardX + scoreboardWidth / 2, scoreboardY + 20, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

    local yOffset = scoreboardY + 60

    for _, ply in ipairs(player.GetAll()) do
        -- Draw a box for each player
        draw.RoundedBox(6, scoreboardX + 10, yOffset, scoreboardWidth - 20, rowHeight, Color(70, 70, 70, 220))

        -- Draw icons for Admin and Super Admin
        local iconX = scoreboardX + 20

        if ply:IsUserGroup("superadmin") then
            surface.SetMaterial(superadminIcon)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRect(iconX, yOffset + 22, 16, 16) -- Draw crown icon
        end
        if ply:IsUserGroup("admin") then
            surface.SetMaterial(adminIcon)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRect(iconX, yOffset + 22, 16, 16) -- Draw shield icon
            iconX = iconX + 20 -- Adjust for next icon
        end
        if ply:IsUserGroup("member") then
            surface.SetMaterial(memberIcon)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRect(iconX, yOffset + 22, 16, 16) -- Draw crown icon
        end
        if ply:IsUserGroup("user") then
            surface.SetMaterial(userIcon)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRect(iconX, yOffset + 22, 16, 16) -- Draw crown icon
        end

        -- Draw the player's name
        draw.SimpleText(ply:Nick(), "Trebuchet18", scoreboardX + 50, yOffset + 20, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        -- Draw the player's title (if any)
        if ply:IsUserGroup("superadmin") then
            draw.SimpleText("blight.archon.elder", "Trebuchet18", scoreboardX + 50, yOffset + 40, Color(163, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        if ply:IsUserGroup("admin") then
            draw.SimpleText("blight.archon.disciple", "Trebuchet18", scoreboardX + 50, yOffset + 40, Color(200, 200, 50), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        if ply:IsUserGroup("member") then
            draw.SimpleText("prime.fucklet", "Trebuchet18", scoreboardX + 50, yOffset + 40, Color(200, 200, 50), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        if ply:IsUserGroup("user") then
            draw.SimpleText("nasty.fucklet", "Trebuchet18", scoreboardX + 50, yOffset + 40, Color(200, 200, 50), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        -- Draw the player's ping
        draw.SimpleText(ply:Ping(), "Trebuchet18", scoreboardX + scoreboardWidth - 30, yOffset + rowHeight / 2, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

        yOffset = yOffset + rowHeight + 5 -- Adjust for the next player

        -- Stop if we're out of room
        if yOffset + rowHeight > scoreboardY + scoreboardHeight then
            break
        end
    end
end)

hook.Add("ScoreboardShow", "DisableDefaultScoreboard", function()
    return false -- Disable the default scoreboard
end)
