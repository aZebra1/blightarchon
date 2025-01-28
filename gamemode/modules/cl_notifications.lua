-- File: cl_notifications.lua
-- Purpose: Notification system for Garry's Mod with a command terminal theme

if CLIENT then
    local notifications = {}
    local notificationDuration = 5 -- seconds

    -- Add a notification to the queue
    function AddNotification(text, color)
        table.insert(notifications, {
            text = text,
            color = color or Color(0, 255, 0), -- Default to green terminal text
            time = CurTime()
        })
    end

    -- Draw notifications on the screen
    hook.Add("HUDPaint", "DrawCommandTerminalNotifications", function()
        local scrW, scrH = ScrW(), ScrH()
        local baseX, baseY = scrW - 300, scrH - 100
        local spacing = 24

        for i, notification in ipairs(notifications) do
            local timeSince = CurTime() - notification.time
            if timeSince > notificationDuration then
                table.remove(notifications, i)
            else
                local alpha = 255
                if timeSince > notificationDuration - 1 then
                    alpha = math.Clamp(255 * (1 - (timeSince - (notificationDuration - 1))), 0, 255)
                end

                --draw.RoundedBox(4, baseX - 10, baseY - (#notifications - i + 1) * spacing - 2, 300, 22, Color(10, 10, 10, 200))
                draw.SimpleText(notification.text, "DermaDefault", baseX + 140, baseY - (#notifications - i + 1) * spacing + 11, Color(notification.color.r, notification.color.g, notification.color.b, alpha), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            end
        end
    end)

    -- Example API call for testing
    concommand.Add("add_test_notification", function()
        AddNotification("> Test Notification!", Color(0, 255, 0))
    end)

    net.Receive("SendNotification", function()
        local text = net.ReadString()
        local color = net.ReadColor()
        AddNotification(text, color)
    end)
end
