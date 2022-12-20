--- An example using all the components and methods.

local SimpleRenderWrapper = loadstring(game:HttpGet("https://raw.githubusercontent.com/strawbberrys/SimpleRenderWrapper/main/ui.lua"))()

-- create ui
local ui = SimpleRenderWrapper.new("Sample UI", Vector2.new(300, 300))

-- main page
do
    local mainPage = ui:addPage("Main")

    mainPage:addButton("Sample Button", function()
        print("Hello, world!")
    end)

    local playerCollapsable = mainPage:addCollapsable("Player", true)

    playerCollapsable:addDropdown("Goto", {"Home", "City", "Mars"}, function(location)
        print("Going to " .. location)
    end)
    
    playerCollapsable:addTextBox("Set Money", function(value)
        print("Set money to " .. value)
    end)

    local settingsCollapsable = mainPage:addCollapsable("Settings")

    settingsCollapsable:addToggle("Rainbow UI", function(value)
        print("Rainbow UI is now: " .. tostring(value))
    end)
end

-- visuals page
do
    local visualsPage = ui:addPage("Visuals")

    local visualsSameLine = visualsPage:addSameLine()

    visualsSameLine:addToggle("ESP", function(value)
        if value then
            print("ESP enabled")
        else
            print("ESP disabled")
        end
    end)

    visualsSameLine:addToggle("Skeleton", function(value)
        if value then
            print("Skeleton enabled")
        else
            print("Skeleton disabled")
        end
    end)

    visualsPage:addDivider("Visuals Settings")

    visualsPage:addSlider("ESP Rounding", 0, 100, function(value)
        print("ESP Rounding set to: " .. tostring(value))
    end)
end
