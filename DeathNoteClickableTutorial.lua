--[[
    Death Note Tutorial GUI - Clickable Button Version
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

-- Create floating tutorial button
local floatingBtn = Instance.new("TextButton")
floatingBtn.Name = "TutorialButton"
floatingBtn.Size = UDim2.new(0.12, 0, 0.08, 0)
floatingBtn.Position = UDim2.new(0.02, 0, 0.02, 0)
floatingBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
floatingBtn.BorderSizePixel = 2
floatingBtn.BorderColor3 = Color3.fromRGB(0, 200, 255)
floatingBtn.Text = "📖 TUTORIAL"
floatingBtn.TextColor3 = Color3.fromRGB(100, 200, 255)
floatingBtn.TextSize = 14
floatingBtn.Font = Enum.Font.GothamBold
floatingBtn.ZIndex = 10
floatingBtn.Parent = buttonGui
floatingBtn.AutoButtonColor = false

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = floatingBtn

-- Button glow
local btnGlow = Instance.new("Frame")
btnGlow.Size = UDim2.new(1, 10, 1, 10)
btnGlow.Position = UDim2.new(0, -5, 0, -5)
btnGlow.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
btnGlow.BorderSizePixel = 0
btnGlow.BackgroundTransparency = 0.7
btnGlow.ZIndex = 8
btnGlow.Parent = floatingBtn

local btnGlowCorner = Instance.new("UICorner")
btnGlowCorner.CornerRadius = UDim.new(0, 10)
btnGlowCorner.Parent = btnGlow

-- Button hover effects
floatingBtn.MouseEnter:Connect(function()
    TweenService:Create(floatingBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(0, 150, 255),
        TextColor3 = Color3.fromRGB(200, 220, 255)
    }):Play()
    TweenService:Create(btnGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.3
    }):Play()
end)

floatingBtn.MouseLeave:Connect(function()
    TweenService:Create(floatingBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(0, 100, 150),
        TextColor3 = Color3.fromRGB(100, 200, 255)
    }):Play()
    TweenService:Create(btnGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
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

-- Main content frame with glow border
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(0.9, 0, 0.85, 0)
contentFrame.Position = UDim2.new(0.05, 0, 0.075, 0)
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
glowFrame.Size = UDim2.new(0.9, 6, 0.85, 6)
glowFrame.Position = UDim2.new(0.05, -3, 0.075, -3)
glowFrame.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
glowFrame.BorderSizePixel = 0
glowFrame.BackgroundTransparency = 0.7
glowFrame.ZIndex = 3
glowFrame.Parent = mainContainer

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 22)
glowCorner.Parent = glowFrame

-- HEADER SECTION
local headerFrame = Instance.new("Frame")
headerFrame.Size = UDim2.new(1, 0, 0.15, 0)
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
closeBtn.Size = UDim2.new(0.06, 0, 0.6, 0)
closeBtn.Position = UDim2.new(0.92, 0, 0.2, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
closeBtn.BorderSizePixel = 2
closeBtn.BorderColor3 = Color3.fromRGB(0, 200, 255)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 24
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

-- Main title
local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(0.8, 0, 1, 0)
mainTitle.Position = UDim2.new(0.1, 0, 0, 0)
mainTitle.BackgroundTransparency = 1
mainTitle.Text = "TUTORIAL"
mainTitle.TextColor3 = Color3.fromRGB(100, 200, 255)
mainTitle.TextSize = 48
mainTitle.Font = Enum.Font.GothamBlack
mainTitle.ZIndex = 8
mainTitle.Parent = headerFrame

-- Subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(0.8, 0, 0.5, 0)
subtitle.Position = UDim2.new(0.1, 0, 0.55, 0)
subtitle.BackgroundTransparency = 1
subtitle.Text = "LEARN THE RULES OF KIRA'S JUDGMENT"
subtitle.TextColor3 = Color3.fromRGB(150, 150, 200)
subtitle.TextSize = 14
subtitle.Font = Enum.Font.Gotham
subtitle.ZIndex = 8
subtitle.Parent = headerFrame

-- SIDEBAR WITH NUMBERED TABS
local sidebarFrame = Instance.new("Frame")
sidebarFrame.Size = UDim2.new(0.2, 0, 0.8, 0)
sidebarFrame.Position = UDim2.new(0, 0, 0.15, 0)
sidebarFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 20)
sidebarFrame.BorderSizePixel = 0
sidebarFrame.ZIndex = 6
sidebarFrame.Parent = contentFrame

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 12)
sidebarCorner.Parent = sidebarFrame

-- Sidebar scroll frame
local sidebarScroll = Instance.new("ScrollingFrame")
sidebarScroll.Size = UDim2.new(1, 0, 1, 0)
sidebarScroll.BackgroundTransparency = 1
sidebarScroll.BorderSizePixel = 0
sidebarScroll.ZIndex = 7
sidebarScroll.Parent = sidebarFrame
sidebarScroll.ScrollBarThickness = 4
sidebarScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.Padding = UDim.new(0, 6)
sidebarLayout.FillDirection = Enum.FillDirection.Vertical
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Parent = sidebarScroll

local tabButtons = {}

-- Create tab buttons
for i, page in ipairs(tutorialPages) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = "Tab_" .. i
    tabBtn.Size = UDim2.new(0.95, 0, 0, 45)
    tabBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
    tabBtn.BorderSizePixel = 2
    tabBtn.BorderColor3 = Color3.fromRGB(50, 50, 100)
    tabBtn.Text = ""
    tabBtn.ZIndex = 8
    tabBtn.Parent = sidebarScroll
    tabBtn.AutoButtonColor = false
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabBtn
    
    -- Tab label
    local tabLabel = Instance.new("TextLabel")
    tabLabel.Size = UDim2.new(0.7, 0, 1, 0)
    tabLabel.Position = UDim2.new(0.25, 0, 0, 0)
    tabLabel.BackgroundTransparency = 1
    tabLabel.Text = page.title
    tabLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
    tabLabel.TextSize = 11
    tabLabel.Font = Enum.Font.GothamBold
    tabLabel.TextXAlignment = Enum.TextXAlignment.Left
    tabLabel.ZIndex = 9
    tabLabel.Parent = tabBtn
    
    -- Tab number
    local tabNum = Instance.new("TextLabel")
    tabNum.Size = UDim2.new(0.2, 0, 1, 0)
    tabNum.Position = UDim2.new(0.05, 0, 0, 0)
    tabNum.BackgroundTransparency = 1
    tabNum.Text = tostring(i)
    tabNum.TextColor3 = Color3.fromRGB(0, 150, 255)
    tabNum.TextSize = 16
    tabNum.Font = Enum.Font.GothamBold
    tabNum.ZIndex = 9
    tabNum.Parent = tabBtn
    
    -- Click handler
    tabBtn.MouseButton1Click:Connect(function()
        goToPage(i)
    end)
    
    -- Hover effect
    tabBtn.MouseEnter:Connect(function()
        TweenService:Create(tabBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.fromRGB(20, 30, 60),
            BorderColor3 = Color3.fromRGB(0, 150, 255)
        }):Play()
        TweenService:Create(tabLabel, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextColor3 = Color3.fromRGB(200, 200, 255)
        }):Play()
    end)
    
    tabBtn.MouseLeave:Connect(function()
        if i ~= currentPage then
            TweenService:Create(tabBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(15, 15, 35),
                BorderColor3 = Color3.fromRGB(50, 50, 100)
            }):Play()
            TweenService:Create(tabLabel, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextColor3 = Color3.fromRGB(150, 150, 200)
            }):Play()
        end
    end)
    
    tabButtons[i] = {btn = tabBtn, label = tabLabel, num = tabNum}
end

-- CONTENT AREA
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(0.8, 0, 0.8, 0)
contentArea.Position = UDim2.new(0.2, 0, 0.15, 0)
contentArea.BackgroundTransparency = 1
contentArea.ZIndex = 6
contentArea.Parent = contentFrame

-- Page title
local pageTitle = Instance.new("TextLabel")
pageTitle.Size = UDim2.new(1, 0, 0.1, 0)
pageTitle.Position = UDim2.new(0, 0, 0.05, 0)
pageTitle.BackgroundTransparency = 1
pageTitle.Text = tutorialPages[1].title
pageTitle.TextColor3 = tutorialPages[1].color
pageTitle.TextSize = 42
pageTitle.Font = Enum.Font.GothamBlack
pageTitle.ZIndex = 7
pageTitle.Parent = contentArea

-- Page subtitle
local pageSubtitle = Instance.new("TextLabel")
pageSubtitle.Size = UDim2.new(1, 0, 0.08, 0)
pageSubtitle.Position = UDim2.new(0, 0, 0.16, 0)
pageSubtitle.BackgroundTransparency = 1
pageSubtitle.Text = tutorialPages[1].subtitle
pageSubtitle.TextColor3 = Color3.fromRGB(100, 200, 255)
pageSubtitle.TextSize = 18
pageSubtitle.Font = Enum.Font.GothamBold
pageSubtitle.ZIndex = 7
pageSubtitle.Parent = contentArea

-- Decorative line
local decorLine = Instance.new("Frame")
decorLine.Size = UDim2.new(0.6, 0, 0.005, 0)
decorLine.Position = UDim2.new(0.2, 0, 0.26, 0)
decorLine.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
decorLine.BorderSizePixel = 0
decorLine.ZIndex = 7
decorLine.Parent = contentArea

-- Page description
local pageDesc = Instance.new("TextLabel")
pageDesc.Size = UDim2.new(0.9, 0, 0.4, 0)
pageDesc.Position = UDim2.new(0.05, 0, 0.32, 0)
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
dotsFrame.Size = UDim2.new(1, 0, 0.06, 0)
dotsFrame.Position = UDim2.new(0, 0, 0.75, 0)
dotsFrame.BackgroundTransparency = 1
dotsFrame.ZIndex = 7
dotsFrame.Parent = contentArea

local dotsLayout = Instance.new("UIListLayout")
dotsLayout.FillDirection = Enum.FillDirection.Horizontal
dotsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
dotsLayout.Padding = UDim.new(0, 6)
dotsLayout.Parent = dotsFrame

local dotButtons = {}
for i = 1, #tutorialPages do
    local dot = Instance.new("TextButton")
    dot.Size = UDim2.new(0, 16, 0, 16)
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
bottomFrame.Size = UDim2.new(1, 0, 0.05, 0)
bottomFrame.Position = UDim2.new(0, 0, 0.95, 0)
bottomFrame.BackgroundTransparency = 1
bottomFrame.ZIndex = 6
bottomFrame.Parent = contentFrame

-- Previous button
local prevBtn = Instance.new("TextButton")
prevBtn.Name = "PrevBtn"
prevBtn.Size = UDim2.new(0.15, 0, 0.8, 0)
prevBtn.Position = UDim2.new(0.02, 0, 0.1, 0)
prevBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
prevBtn.BorderSizePixel = 2
prevBtn.BorderColor3 = Color3.fromRGB(0, 150, 255)
prevBtn.Text = "◀ PREVIOUS"
prevBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
prevBtn.TextSize = 12
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
nextBtn.Size = UDim2.new(0.15, 0, 0.8, 0)
nextBtn.Position = UDim2.new(0.83, 0, 0.1, 0)
nextBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
nextBtn.BorderSizePixel = 2
nextBtn.BorderColor3 = Color3.fromRGB(0, 150, 255)
nextBtn.Text = "NEXT ▶"
nextBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
nextBtn.TextSize = 12
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

-- BOTTOM BANNER
local bannerFrame = Instance.new("Frame")
bannerFrame.Size = UDim2.new(0.8, 0, 0.08, 0)
bannerFrame.Position = UDim2.new(0.1, 0, 0.92, 0)
bannerFrame.BackgroundColor3 = Color3.fromRGB(5, 15, 35)
bannerFrame.BorderSizePixel = 2
bannerFrame.BorderColor3 = Color3.fromRGB(0, 150, 255)
bannerFrame.ZIndex = 6
bannerFrame.Parent = mainContainer

local bannerCorner = Instance.new("UICorner")
bannerCorner.CornerRadius = UDim.new(0, 10)
bannerCorner.Parent = bannerFrame

local bannerText1 = Instance.new("TextLabel")
bannerText1.Size = UDim2.new(1, 0, 0.5, 0)
bannerText1.BackgroundTransparency = 1
bannerText1.Text = "📖 LEARN TO PLAY"
bannerText1.TextColor3 = Color3.fromRGB(100, 200, 255)
bannerText1.TextSize = 18
bannerText1.Font = Enum.Font.GothamBold
bannerText1.ZIndex = 8
bannerText1.Parent = bannerFrame

local bannerText2 = Instance.new("TextLabel")
bannerText2.Size = UDim2.new(1, 0, 0.5, 0)
bannerText2.Position = UDim2.new(0, 0, 0.5, 0)
bannerText2.BackgroundTransparency = 1
bannerText2.Text = "LEARN THE RULES BEFORE YOU BEGIN"
bannerText2.TextColor3 = Color3.fromRGB(150, 150, 200)
bannerText2.TextSize = 12
bannerText2.Font = Enum.Font.Gotham
bannerText2.ZIndex = 8
bannerText2.Parent = bannerFrame

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
    
    -- Update tab button style
    for i, tabData in ipairs(tabButtons) do
        if i == pageNum then
            TweenService:Create(tabData.btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(0, 100, 150),
                BorderColor3 = page.color
            }):Play()
            TweenService:Create(tabData.label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
            TweenService:Create(tabData.num, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextColor3 = page.color
            }):Play()
        else
            TweenService:Create(tabData.btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(15, 15, 35),
                BorderColor3 = Color3.fromRGB(50, 50, 100)
            }):Play()
            TweenService:Create(tabData.label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextColor3 = Color3.fromRGB(150, 150, 200)
            }):Play()
            TweenService:Create(tabData.num, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextColor3 = Color3.fromRGB(0, 150, 255)
            }):Play()
        end
    end
    
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

print("✨ Death Note Tutorial GUI - Clickable Button Edition Loaded!")
print("Click the 📖 TUTORIAL button to open | Use LEFT/RIGHT or A/D to navigate | ESC to close")
