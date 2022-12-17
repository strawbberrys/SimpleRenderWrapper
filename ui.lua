local Ui = {}
do
    local Page = {}

    Ui.__index = Ui
    Page.__index = Page

    function Ui.new(title: string, minSize: Vector2?, maxSize: Vector2?)
        local renderWindow = RenderWindow.new(title)

        if minSize then
            renderWindow.MinSize = minSize
        end

        if maxSize then
            renderWindow.MaxSize = maxSize
        end

        renderWindow.VisibilityOverride = true
        
        local tabMenu = renderWindow:TabMenu()

        return setmetatable({
            renderWindow = renderWindow,
            tabMenu = tabMenu
        }, Ui)
    end

    function Ui:addPage(name: string)
        local tabMenu = self.tabMenu
        local page = tabMenu:Add(name)

        return Page.new(page)
    end

    function Page.new(page: RenderDummyWindow)
        return setmetatable({page = page}, Page)
    end

    function Page:addDivider(name: string)
        local page = self.page

        page:Label(name)
        page:Separator()
    end

    function Page:addButton(name: string, callback: () -> ()): RenderButton
        local button = self.page:Button()

        button.Label = name
        button.OnUpdated:Connect(callback)

        return button
    end

    function Page:addToggle(name: string, callback: (enabled: boolean) -> ()): RenderCheckbox
        local checkbox = self.page:CheckBox()

        checkbox.Label = name
        checkbox.OnUpdated:Connect(callback)

        return checkbox
    end

    function Page:addSlider(name: string, min: number, max: number, callback: (value: number) -> ()): RenderIntSlider
        local intSlider = self.page:IntSlider()

        intSlider.Label = name
        intSlider.Min = min
        intSlider.Max = max

        return intSlider
    end

    function Page:addDropdown(name: string, items: {string}, callback: (newSelection: any) -> ()): RenderCombo
        local sameLine = self.page:SameLine()
        local combo = sameLine:Combo()
        local button = sameLine:Button()

        combo.Items = items

        button.Label = name
        button.OnUpdated:Connect(function()
            callback(combo.Items[combo.SelectedItem])
        end)

        return combo, button
    end

    function Page:addTextBox(name: string, callback: (value: string) -> ()): (RenderTextbox, RenderButton)
        local sameLine = self.page:SameLine()
        local textBox = sameLine:TextBox()
        local button = sameLine:Button()

        button.Label = name
        button.OnUpdated:Connect(function()
            callback(textBox.Value)
        end)

        return textBox, button
    end
end

return Ui
