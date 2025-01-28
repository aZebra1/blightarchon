if SERVER then
    util.AddNetworkString("OpenModelPanel")
    util.AddNetworkString("UpdateCurrency")

    hook.Add("PlayerButtonDown", "OpenModelUIPanel", function(ply, button)
        if button == KEY_F2 then
            net.Start("OpenModelPanel")
            net.Send(ply)
        end
    end)

    hook.Add("PlayerInitialSpawn", "SendInitialCurrency", function(ply)
        timer.Simple(1, function()
            net.Start("UpdateCurrency")
            net.WriteInt(ply.Currency or 0, 32) -- Default currency value
            net.Send(ply)
        end)
    end)

    hook.Add("PlayerDeath", "ResetCurrencyOnDeath", function(ply)
        ply.Currency = 0
        net.Start("UpdateCurrency")
        net.WriteInt(0, 32)
        net.Send(ply)
    end)

    -- Example: Updating currency (you can replace this with your own logic)
    concommand.Add("set_currency", function(ply, cmd, args)
        if not ply:IsSuperAdmin() then
            ply:ChatPrint("You do not have permission to use this command.")
            return
        end

        local newCurrency = tonumber(args[1]) or 0
        ply.Currency = newCurrency

        net.Start("UpdateCurrency")
        net.WriteInt(newCurrency, 32)
        net.Send(ply)
    end)
end

if CLIENT then
    local playerCurrency = 0

    net.Receive("UpdateCurrency", function()
        playerCurrency = net.ReadInt(32)
    end)

    local function CreateModelPanel()
        local frame = vgui.Create("DFrame")
        frame:SetSize(500, 500)
        frame:Center()
        frame:SetTitle("")
        frame:ShowCloseButton(false)
        frame:SetDraggable(false)
        frame:MakePopup()
        frame:SetAlpha(0)
        frame:AlphaTo(255, 0.2, 0)
        frame:SetBackgroundBlur(true)
        
        frame.Paint = function(self, w, h)
            surface.SetDrawColor(0, 0, 0, 150)
            surface.DrawRect(0, 0, w, h)
        end

        local modelImage = vgui.Create("DImage", frame)
        modelImage:SetSize(300, 300)
        modelImage:SetPos(100, 100)
        modelImage:SetImage("blight/charplet.png") -- Replace with the path to your PNG texture

        local closeButton = vgui.Create("DButton", frame)
        closeButton:SetSize(100, 30)
        closeButton:SetPos(200, 450)
        closeButton:SetText("Close")

        closeButton.DoClick = function()
            frame:AlphaTo(0, 0.2, 0, function()
                frame:Close()
            end)
        end

        local healthBar = vgui.Create("DPanel", frame)
        healthBar:SetSize(200, 20)
        healthBar:SetPos(10, 10)
        healthBar.Paint = function(self, w, h)
            surface.SetDrawColor(255, 0, 0, 255)
            surface.DrawRect(0, 0, w * (LocalPlayer():Health() / 100), h)
            surface.SetDrawColor(50, 50, 50, 255)
            surface.DrawOutlinedRect(0, 0, w, h)
        end

        local armorBar = vgui.Create("DPanel", frame)
        armorBar:SetSize(200, 20)
        armorBar:SetPos(frame:GetWide() - 210, 10) -- Move to top right
        armorBar.Paint = function(self, w, h)
            surface.SetDrawColor(0, 0, 255, 255)
            surface.DrawRect(0, 0, w * (LocalPlayer():Armor() / 100), h)
            surface.SetDrawColor(50, 50, 50, 255)
            surface.DrawOutlinedRect(0, 0, w, h)
        end

        local currencyDisplay = vgui.Create("DPanel", frame)
        currencyDisplay:SetSize(100, 30)
        currencyDisplay:SetPos(frame:GetWide() - 150, frame:GetTall() - 40) -- Bottom right corner
        currencyDisplay.Paint = function(self, w, h)
            surface.SetDrawColor(126, 0, 0, 150)
            surface.DrawRect(0, 0, w, h)
            draw.SimpleText("Flesh: " .. playerCurrency, "DermaDefault", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    net.Receive("OpenModelPanel", function()
        CreateModelPanel()
    end)
end
