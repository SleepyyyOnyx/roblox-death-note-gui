--[[
    Death Note Tutorial GUI - Compact Horizontal Banner Version
    Click the button to open the tutorial, click close or ESC to hide it
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local tutorialOpen = false

-- Tutorial data
local tutorialPages = {
    {
        title = "WELCOME",
        subtitle = "Welcome to Kira's Judgment",
        description = "Every player receives a hidden role.\nYour goal depends on who you are.\nUse deduction, deception, and strategy\nto survive until the end.\n\nTrust nobody.",
        color = Color3.fromRGB(100, 200, 255),
        icon = "📜"
    },
    {
        title = "PLAYING AS KIRA",
        subtitle = "The God of the New World",
        description = "You have the Death Note. Write names\nto eliminate your enemies. Stay hidden\nand control the game.",
        color = Color3.fromRGB(255, 0, 0),
        icon = "📕"
    },
    {
        title = "PLAYING AS L",
        subtitle = "The Detective",
        description = "Find Kira before they eliminate you.\nUse logic and deduction to expose\nthe vigilante.",
        color = Color3.fromRGB(100, 200, 255),
        icon = "⚖️"
    },
    {
        title = "PLAYING AS SHINIGAMI",
        subtitle = "Death God",
        description = "Watch the chaos unfold. You're neutral\nbut guide the story. Hidden observer.",
        color = Color3.fromRGB(255, 150, 0),
        icon = "👹"
    },
    {
        title = "PLAYING AS MISA",
        subtitle = "The Devoted",
        description = "Support Kira in their mission. But\nbeware - trust can be betrayed.",
        color = Color3.fromRGB(255, 200, 0),
        icon = "💕"
    },
    {
        title = "PLAYING AS INNOCENT",
        subtitle = "The Citizen",
        description = "Survive in a world of danger.\nFigure out who's who before it's too late.",
        color = Color3.fromRGB(100, 255, 100),
        icon = "👤"
    },
    {
        title = "PLAYING AS TASK FORCE",
        subtitle = "Law Enforcement",
        description = "Work with L to stop Kira.\nGather evidence. Hunt the criminal.",
        color = Color3.fromRGB(100, 150, 255),
        icon = "⚔️"
    },
    {
        title = "PLAYING AS CRIMINAL",
        subtitle = "The Hunted",
        description = "You're targeted by Kira.\nHide or find allies to survive.",
        color = Color3.fromRGB(150, 0, 0),
        icon = "💀"
    },
    {
        title = "PLAYING AS NEAR",
        subtitle = "The Successor",
        description = "L is gone. Now YOU hunt Kira.\nUse all your cunning intelligence.",
        color = Color3.fromRGB(200, 200, 200),
        icon = "🎯"
    },
    {
        title = "DEATH NOTES",
        subtitle = "The Power",
        description = "Death Notes can be written in, traded,\nand discovered. Control these and\ncontrol the game.",
        color = Color3.fromRGB(50, 50, 50),
        icon = "📖"
    },
    {
        title = "TIPS & STRATEGIES",
        subtitle = "How to Win",
        description = "Bluff well. Question wisely.\nListen carefully. Never reveal\nyour role too early.",
        color = Color3.fromRGB(200, 200, 255),
        icon = "💡"
    },
    {
        title = "GOOD LUCK",
        subtitle = "May Justice Prevail",
        description = "The game is about to begin.\nYour role will be assigned.\nWill you survive?\n\nTrust nobody.",
        color = Color3.fromRGB(0, 200, 255),
        icon = "✨"
    },
}

local currentPage = 1

-- Create main ScreenGui for button
local buttonGui = Instance.new("ScreenGui")
buttonGui.Name = "DeathNoteTutorialButton"
buttonGui.ResetOnSpawn = false
buttonGui.DisplayOrder = 5
buttonGui.Parent = playerGui

-- Create compact floating banner button
local floatingBanner = Instance.new("Frame")
floatingBanner.Name = "TutorialBanner"
floatingBanner.Size = UDim2.new(0.25, 0, 0.06, 0)
floatingBanner.Position = UDim2.new(0.375, 0, 0.01, 0)
floatingBanner.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
floatingBanner.BorderSizePixel = 2
floatingBanner.BorderColor3 = Color3.fromRGB(0, 200, 255)
floatingBanner.ZIndex = 10
floatingBanner.Parent = buttonGui

local bannerCorner = Instance.new("UICorner")
bannerCorner.CornerRadius = UDim.new(0, 8)
bannerCorner.Parent = floatingBanner

-- Banner glow
local bannerGlow = Instance.new("Frame")
bannerGlow.Size = UDim2.new(1, 10, 1, 10)
bannerGlow.Position = UDim2.new(0, -5, 0, -5)
bannerGlow.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
bannerGlow.BorderSizePixel = 0
bannerGlow.BackgroundTransparency = 0.7
bannerGlow.ZIndex = 8
bannerGlow.Parent = floatingBanner

local bannerGlowCorner = Instance.new("UICorner")
bannerGlowCorner.CornerRadius = UDim.new(0, 10)
bannerGlowCorner.Parent = bannerGlow

-- Banner text
local bannerText = Instance.new("TextLabel")
bannerText.Size = UDim2.new(1, 0, 1, 0)
bannerText.BackgroundTransparency = 1
bannerText.Text = "📖 TUTORIAL"
bannerText.TextColor3 = Color3.fromRGB(100, 200, 255)
bannerText.TextSize = 18
bannerText.Font = Enum.Font.GothamBold
bannerText.ZIndex = 11
bannerText.Parent = floatingBanner

-- Make banner clickable
local floatingBtn = Instance.new("TextButton")
floatingBtn.Size = UDim2.new(1, 0, 1, 0)
floatingBtn.BackgroundTransparency = 1
floatingBtn.BorderSizePixel = 0
floatingBtn.Text = ""
floatingBtn.ZIndex = 12
floatingBtn.Parent = floatingBanner
floatingBtn.AutoButtonColor = false

-- Banner hover effects
floatingBtn.MouseEnter:Connect(function()
    TweenService:Create(floatingBanner, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(0, 150, 255),
    }):Play()
    TweenService:Create(bannerText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextColor3 = Color3.fromRGB(200, 220, 255)
    }):Play()
    TweenService:Create(bannerGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.3
    }):Play()
end)

floatingBtn.MouseLeave:Connect(function()
    TweenService:Create(floatingBanner, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(0, 100, 150),
    }):Play()
    TweenService:Create(bannerText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextColor3 = Color3.fromRGB(100, 200, 255)
    }):Play()
    TweenService:Create(bannerGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.7
    }):Play()
end)

-- Create tutorial ScreenGui (starts hidden)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeathNoteTutorial"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 15
screenGui.Parent = playerGui

-- Main container
local mainContainer = Instance.new("Frame")
mainContainer.Name = "MainContainer"
mainContainer.Size = UDim2.new(1, 0, 1, 0)
mainContainer.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
mainContainer.BorderSizePixel = 0
mainContainer.ZIndex = 1
mainContainer.Parent = screenGui

-- Ultra glow background effect
local glowBg1 = Instance.new("Frame")
glowBg1.Size = UDim2.new(1.2, 0, 1.2, 0)
glowBg1.Position = UDim2.new(-0.1, 0, -0.1, 0)
glowBg1.BackgroundColor3 = Color3.fromRGB(0, 50, 100)
glowBg1.BorderSizePixel = 0
glowBg1.BackgroundTransparency = 0.95
glowBg1.ZIndex = 1
glowBg1.Parent = screenGui

-- COMPACT Main content frame with glow border (smaller, centered)
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(0.7, 0, 0.5, 0)
contentFrame.Position = UDim2.new(0.15, 0, 0.25, 0)
contentFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
contentFrame.BorderSizePixel = 3
contentFrame.BorderColor3 = Color3.fromRGB(0, 150, 255)
contentFrame.ZIndex = 5
contentFrame.Parent = mainContainer

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 20)
contentCorner.Parent = contentFrame

-- Glow effect around main frame
local glowFrame = Instance.new("Frame")
glowFrame.Size = UDim2.new(0.7, 6, 0.5, 6)
glowFrame.Position = UDim2.new(0.15, -3, 0.25, -3)
glowFrame.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
glowFrame.BorderSizePixel = 0
glowFrame.BackgroundTransparency = 0.7
glowFrame.ZIndex = 3
glowFrame.Parent = mainContainer

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 22)
glowCorner.Parent = glowFrame

-- COMPACT HEADER SECTION
local headerFrame = Instance.new("Frame")
headerFrame.Size = UDim2.new(1, 0, 0.12, 0)
headerFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 25)
headerFrame.BorderSizePixel = 0
headerFrame.ZIndex = 6
headerFrame.Parent = contentFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 16)
headerCorner.Parent = headerFrame

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0.08, 0, 0.7, 0)
closeBtn.Position = UDim2.new(0.9, 0, 0.15, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
closeBtn.BorderSizePixel = 2
closeBtn.BorderColor3 = Color3.fromRGB(0, 200, 255)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.ZIndex = 8
closeBtn.Parent = headerFrame
closeBtn.AutoButtonColor = false

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    hideTutorial()
end)

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(255, 0, 0),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
end)

closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(0, 150, 255),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
end)

-- Main title - BIGGER FONT
local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(0.85, 0, 1, 0)
mainTitle.Position = UDim2.new(0.05, 0, 0, 0)
mainTitle.BackgroundTransparency = 1
mainTitle.Text = "TUTORIAL"
mainTitle.TextColor3 = Color3.fromRGB(100, 200, 255)
mainTitle.TextSize = 36
mainTitle.Font = Enum.Font.GothamBlack
mainTitle.ZIndex = 8
mainTitle.Parent = headerFrame

-- COMPACT SIDEBAR (Hidden for space, use dots instead)
-- CONTENT AREA - BIGGER
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(0.95, 0, 0.8, 0)
contentArea.Position = UDim2.new(0.025, 0, 0.12, 0)
contentArea.BackgroundTransparency = 1
contentArea.ZIndex = 6
contentArea.Parent = contentFrame

-- Page title - BIGGER FONT
local pageTitle = Instance.new("TextLabel")
pageTitle.Size = UDim2.new(1, 0, 0.15, 0)
pageTitle.Position = UDim2.new(0, 0, 0, 0)
pageTitle.BackgroundTransparency = 1
pageTitle.Text = tutorialPages[1].title
pageTitle.TextColor3 = tutorialPages[1].color
pageTitle.TextSize = 38
pageTitle.Font = Enum.Font.GothamBlack
pageTitle.ZIndex = 7
pageTitle.Parent = contentArea

-- Page subtitle - BIGGER
local pageSubtitle = Instance.new("TextLabel")
pageSubtitle.Size = UDim2.new(1, 0, 0.1, 0)
pageSubtitle.Position = UDim2.new(0, 0, 0.16, 0)
pageSubtitle.BackgroundTransparency = 1
pageSubtitle.Text = tutorialPages[1].subtitle
pageSubtitle.TextColor3 = Color3.fromRGB(100, 200, 255)
pageSubtitle.TextSize = 16
pageSubtitle.Font = Enum.Font.GothamBold
pageSubtitle.ZIndex = 7
pageSubtitle.Parent = contentArea

-- Decorative line
local decorLine = Instance.new("Frame")
decorLine.Size = UDim2.new(0.6, 0, 0.005, 0)
decorLine.Position = UDim2.new(0.2, 0, 0.28, 0)
decorLine.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
decorLine.BorderSizePixel = 0
decorLine.ZIndex = 7
decorLine.Parent = contentArea

-- Page description - BIGGER FONT
local pageDesc = Instance.new("TextLabel")
pageDesc.Size = UDim2.new(0.95, 0, 0.45, 0)
pageDesc.Position = UDim2.new(0.025, 0, 0.32, 0)
pageDesc.BackgroundTransparency = 1
pageDesc.Text = tutorialPages[1].description
pageDesc.TextColor3 = Color3.fromRGB(180, 180, 200)
pageDesc.TextSize = 18
pageDesc.Font = Enum.Font.Gotham
pageDesc.TextWrapped = true
pageDesc.TextYAlignment = Enum.TextYAlignment.Top
pageDesc.ZIndex = 7
pageDesc.Parent = contentArea

-- Progress dots
local dotsFrame = Instance.new("Frame")
dotsFrame.Size = UDim2.new(1, 0, 0.08, 0)
dotsFrame.Position = UDim2.new(0, 0, 0.8, 0)
dotsFrame.BackgroundTransparency = 1
dotsFrame.ZIndex = 7
dotsFrame.Parent = contentArea

local dotsLayout = Instance.new("UIListLayout")
dotsLayout.FillDirection = Enum.FillDirection.Horizontal
dotsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
dotsLayout.Padding = UDim.new(0, 8)
dotsLayout.Parent = dotsFrame

local dotButtons = {}
for i = 1, #tutorialPages do
    local dot = Instance.new("TextButton")
    dot.Size = UDim2.new(0, 18, 0, 18)
    dot.BackgroundColor3 = i == 1 and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(50, 50, 100)
    dot.BorderSizePixel = 1
    dot.BorderColor3 = Color3.fromRGB(0, 150, 255)
    dot.Text = ""
    dot.ZIndex = 8
    dot.Parent = dotsFrame
    dot.AutoButtonColor = false
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot
    
    dot.MouseButton1Click:Connect(function()
        goToPage(i)
    end)
    
    dotButtons[i] = dot
end

-- BOTTOM BUTTONS
local bottomFrame = Instance.new("Frame")
bottomFrame.Size = UDim2.new(1, 0, 0.08, 0)
bottomFrame.Position = UDim2.new(0, 0, 0.92, 0)
bottomFrame.BackgroundTransparency = 1
bottomFrame.ZIndex = 6
bottomFrame.Parent = contentFrame

-- Previous button
local prevBtn = Instance.new("TextButton")
prevBtn.Name = "PrevBtn"
prevBtn.Size = UDim2.new(0.2, 0, 0.7, 0)
prevBtn.Position = UDim2.new(0.02, 0, 0.15, 0)
prevBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
prevBtn.BorderSizePixel = 2
prevBtn.BorderColor3 = Color3.fromRGB(0, 150, 255)
prevBtn.Text = "◀ PREV"
prevBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
prevBtn.TextSize = 14
prevBtn.Font = Enum.Font.GothamBold
prevBtn.ZIndex = 8
prevBtn.Parent = bottomFrame
prevBtn.AutoButtonColor = false

local prevCorner = Instance.new("UICorner")
prevCorner.CornerRadius = UDim.new(0, 4)
prevCorner.Parent = prevBtn

prevBtn.MouseButton1Click:Connect(function()
    goToPage(math.max(1, currentPage - 1))
end)

prevBtn.MouseEnter:Connect(function()
    TweenService:Create(prevBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    }):Play()
end)

prevBtn.MouseLeave:Connect(function()
    TweenService:Create(prevBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(0, 100, 150)
    }):Play()
end)

-- Next button
local nextBtn = Instance.new("TextButton")
nextBtn.Name = "NextBtn"
nextBtn.Size = UDim2.new(0.2, 0, 0.7, 0)
nextBtn.Position = UDim2.new(0.78, 0, 0.15, 0)
nextBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
nextBtn.BorderSizePixel = 2
nextBtn.BorderColor3 = Color3.fromRGB(0, 150, 255)
nextBtn.Text = "NEXT ▶"
nextBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
nextBtn.TextSize = 14
nextBtn.Font = Enum.Font.GothamBold
nextBtn.ZIndex = 8
nextBtn.Parent = bottomFrame
nextBtn.AutoButtonColor = false

local nextCorner = Instance.new("UICorner")
nextCorner.CornerRadius = UDim.new(0, 4)
nextCorner.Parent = nextBtn

nextBtn.MouseButton1Click:Connect(function()
    goToPage(math.min(#tutorialPages, currentPage + 1))
end)

nextBtn.MouseEnter:Connect(function()
    TweenService:Create(nextBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    }):Play()
end)

nextBtn.MouseLeave:Connect(function()
    TweenService:Create(nextBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(0, 100, 150)
    }):Play()
end)

-- Switch page function
function goToPage(pageNum)
    currentPage = pageNum
    local page = tutorialPages[pageNum]
    
    -- Animate title change
    local titleTween = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(pageTitle, titleTween, {TextColor3 = page.color}):Play()
    pageTitle.Text = page.title
    pageSubtitle.Text = page.subtitle
    pageDesc.Text = page.description
    
    -- Update progress dots
    for i, dot in ipairs(dotButtons) do
        if i == pageNum then
            TweenService:Create(dot, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            }):Play()
        else
            TweenService:Create(dot, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(50, 50, 100)
            }):Play()
        end
    end
end

-- Show tutorial function
function showTutorial()
    tutorialOpen = true
    screenGui.Enabled = true
end

-- Hide tutorial function
function hideTutorial()
    tutorialOpen = false
    screenGui.Enabled = false
end

-- Tutorial button click
floatingBtn.MouseButton1Click:Connect(function()
    showTutorial()
end)

-- Keyboard and gamepad controls
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not tutorialOpen then return end
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Right or input.KeyCode == Enum.KeyCode.D then
        goToPage(math.min(#tutorialPages, currentPage + 1))
    elseif input.KeyCode == Enum.KeyCode.Left or input.KeyCode == Enum.KeyCode.A then
        goToPage(math.max(1, currentPage - 1))
    elseif input.KeyCode == Enum.KeyCode.Escape then
        hideTutorial()
    end
end)

-- Pulsing glow animation
RunService.RenderStepped:Connect(function()
    if not screenGui or not screenGui.Parent then return end
    
    local pulse = math.sin(tick() * 1.5) * 0.15 + 0.5
    glowFrame.BackgroundTransparency = 0.7 - (pulse * 0.2)
    glowBg1.BackgroundTransparency = 0.95 - (pulse * 0.1)
end)

-- Hide tutorial on startup
screenGui.Enabled = false

print("✨ Death Note Tutorial GUI - Compact Edition Loaded!")
print("Click the 📖 TUTORIAL banner to open | Use LEFT/RIGHT or A/D to navigate | ESC to close")
