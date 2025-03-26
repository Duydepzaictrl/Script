getfenv().death = false -- Không chết sau khi nhận bonds
loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/refs/heads/ok/dead%20rails"))()

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- 🚀 NoClip - Đi xuyên tường
local noclipEnabled = false

local function toggleNoclip()
    noclipEnabled = not noclipEnabled
end

RunService.Stepped:Connect(function()
    if noclipEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide ~= false then
                part.CanCollide = false
            end
        end
    end
end)

-- 📌 UI Bảng điều khiển NoClip + Timer (Draggable)
local screenGui = Instance.new("ScreenGui", player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui"))

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 220, 0, 200)
mainFrame.Position = UDim2.new(0, 20, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 85, 85)
mainFrame.Active = true
mainFrame.Draggable = true -- Cho phép kéo thả bảng UI

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Text = "NoClip & Timer"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.BackgroundTransparency = 1

-- ⏳ Bảng Đếm Thời Gian
local timerLabel = Instance.new("TextLabel", mainFrame)
timerLabel.Size = UDim2.new(1, 0, 0, 40)
timerLabel.Position = UDim2.new(0, 0, 0, 35)
timerLabel.Text = "10:00"
timerLabel.TextColor3 = Color3.fromRGB(255, 85, 85)
timerLabel.Font = Enum.Font.GothamBlack
timerLabel.TextSize = 32
timerLabel.BackgroundTransparency = 1

-- 🔘 Nút Bật/Tắt NoClip
local toggleButton = Instance.new("TextButton", mainFrame)
toggleButton.Size = UDim2.new(1, 0, 0, 40)
toggleButton.Position = UDim2.new(0, 0, 0, 80)
toggleButton.Text = "Toggle NoClip"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 14
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.BorderSizePixel = 1
toggleButton.BorderColor3 = Color3.fromRGB(255, 85, 85)

toggleButton.MouseButton1Click:Connect(function()
    toggleNoclip()
    toggleButton.Text = "NoClip: " .. (noclipEnabled and "ON" or "OFF")
    toggleButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)
end)

-- 🔘 Nút "4 Phút" (Bấm vào sẽ đếm ngược 4 phút)
local fourMinButton = Instance.new("TextButton", mainFrame)
fourMinButton.Size = UDim2.new(1, 0, 0, 40)
fourMinButton.Position = UDim2.new(0, 0, 0, 130)
fourMinButton.Text = "Start 4-Min Timer"
fourMinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
fourMinButton.Font = Enum.Font.GothamBold
fourMinButton.TextSize = 14
fourMinButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
fourMinButton.BorderSizePixel = 1
fourMinButton.BorderColor3 = Color3.fromRGB(255, 85, 85)

-- 🕒 Hàm đếm ngược tối ưu hóa
local function startTimer(duration)
    local endTime = tick() + duration
    while tick() < endTime do
        local remaining = endTime - tick()
        timerLabel.Text = string.format("%02d:%02d", remaining // 60, remaining % 60)
        RunService.Heartbeat:Wait() -- Giảm lag, tối ưu hiệu suất
    end
    timerLabel.Text = "00:00"
end

spawn(function() startTimer(600) end) -- Đếm ngược 10 phút mặc định

fourMinButton.MouseButton1Click:Connect(function()
    spawn(function() startTimer(240) end) -- Đếm ngược 4 phút khi bấm nút
end)
