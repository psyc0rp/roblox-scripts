repeat wait() until game:IsLoaded()
wait(2)

local player = game.Players.LocalPlayer
local guiService = game:GetService("StarterGui")

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "AutoRerollUI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 220, 0, 120)
frame.Position = UDim2.new(0, 20, 0, 200)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0

local startButton = Instance.new("TextButton", frame)
startButton.Text = "▶️ Start"
startButton.Size = UDim2.new(1, -10, 0, 30)
startButton.Position = UDim2.new(0, 5, 0, 5)
startButton.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
startButton.TextColor3 = Color3.new(1,1,1)

local stopButton = Instance.new("TextButton", frame)
stopButton.Text = "⏹️ Stop"
stopButton.Size = UDim2.new(1, -10, 0, 30)
stopButton.Position = UDim2.new(0, 5, 0, 40)
stopButton.BackgroundColor3 = Color3.fromRGB(178, 34, 34)
stopButton.TextColor3 = Color3.new(1,1,1)

local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Text = "Status: Aguardando..."
statusLabel.Size = UDim2.new(1, -10, 0, 30)
statusLabel.Position = UDim2.new(0, 5, 0, 75)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.new(1,1,1)
statusLabel.TextScaled = true

local running = false
local traitBom = "Sovereign"

local function clickButton(texto)
    for _, v in pairs(player.PlayerGui:GetDescendants()) do
        if v:IsA("TextButton") and string.lower(v.Text) == string.lower(texto) then
            v:Activate()
            return true
        end
    end
    return false
end

local function getTrait()
    for _, v in pairs(player.PlayerGui:GetDescendants()) do
        if v:IsA("TextLabel") and v.Text == traitBom then
            return v.Text
        end
    end
    return nil
end

local function autoReroll()
    while running do
        wait(2)
        clickButton("Reroll")
        wait(2)

        local trait = getTrait()
        statusLabel.Text = "Trait: " .. (trait or "Indefinido")

        if trait == traitBom then
            statusLabel.Text = "🎉 Encontrado: " .. trait
            running = false
            break
        else
            clickButton("Rollback")
        end
    end
end

startButton.MouseButton1Click:Connect(function()
    if not running then
        running = true
        statusLabel.Text = "Auto reroll iniciado"
        spawn(autoReroll)
    end
end)

stopButton.MouseButton1Click:Connect(function()
    running = false
    statusLabel.Text = "Auto reroll parado"
end)
