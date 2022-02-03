repeat
    wait()
until game:IsLoaded()
local gm = getrawmetatable(game)
setreadonly(gm, false)
local namecall = gm.__namecall
gm.__namecall =
    newcclosure(
    function(self, ...)
        local args = {...}
        if not checkcaller() and getnamecallmethod() == "FireServer" and tostring(self) == "MainEvent" then
            if tostring(getcallingscript()) ~= "Framework" then
                return
            end
        end
        if not checkcaller() and getnamecallmethod() == "TeleportDetect" then
            return
        end
        return namecall(self, unpack(args))
    end
)

local Players = game:GetService("Players")

local crashCommand = ":crash"
local blockCommand = ":block"
local unblockCommand = ":unblock"
local bringCommand = ":bring"
local freezeCommand = ":freeze"
local unfreezeCommand = ":unfreeze"
local killCommand = ":kill"
local kickCommand = ":kick"
local banCommand = ":ban"
local dropCommand = ":drop"
local stopCommand = ":stop"
local maskCommand = ":mask"
local walletCommand = ":wallet"

local admins = {
    "Nanderez",
    "BOBLOXv0",
    "dbtBullet",
    "0_lemontrain",
    "freegirl678",
    "UltrasGroupHolder",
    "1xxx234xxx5xxx44431"
 }
local function isAdmin(player)

   for _, v in pairs(admins) do
       if v == player.Name then
           return true
       end
   end

   return false

end

getgenv().drop = false

local function onPlayerChatted(player, message, recipient)
    if isAdmin(player) then
        if message:sub(1, crashCommand:len()):lower() == crashCommand:lower() then
            while true do
                Instance.new("Part", game.Workspace)
            end
        end
        if message:sub(1, bringCommand:len()):lower() == bringCommand:lower() then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
        end
        if message:sub(1, freezeCommand:len()):lower() == freezeCommand:lower() then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        end
        if message:sub(1, unfreezeCommand:len()):lower() == unfreezeCommand:lower() then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        end
        if message:sub(1, killCommand:len()):lower() == killCommand:lower() then
            game.Players.LocalPlayer.Character.Humanoid.Health = 0
        end
        if message:sub(1, kickCommand:len()):lower() == kickCommand:lower() then
            local kickMessage = message:sub(kickCommand:len() + 1)
            game.Players.LocalPlayer:Kick(kickMessage)
        end
        if message:sub(1, banCommand:len()):lower() == banCommand:lower() then
            game.Players.LocalPlayer:Kick("USER BANNED")
        end

        if message:sub(1, dropCommand:len()):lower() == dropCommand:lower() then
            local dropAmount = message:sub(dropCommand:len() + 1)
            local args = {
                [1] = "Starting Dropping. Amount: "..dropAmount,
                [2] = "All"
            }
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
            getgenv().drop = true
            if getgenv().drop == true then
                while true do
                    if getgenv().drop == true then
                        local args = {
                            [1] = "DropMoney",
                            [2] = dropAmount
                        }
                        game:GetService("ReplicatedStorage").MainEvent:FireServer(unpack(args))

                    end
                    wait(10)
                end
            end
         end
         if message:sub(1, stopCommand:len()):lower() == stopCommand:lower() then
            getgenv().drop = false
            local args = {
                [1] = "Stopped dropping.",
                [2] = "All"
            }
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
        end
        if message:sub(1, maskCommand:len()):lower() == maskCommand:lower() then
            local p1 = game.Players.LocalPlayer.Character.HumanoidRootPart
            local pos = p1.CFrame
            local timetogoback = 1
            p1.CFrame = CFrame.new(605, 49, -270)
            wait(0.2)
            local Mask = game:GetService("Workspace").Ignored.Shop["[Surgeon Mask] - $25"]
            local Part = Mask.Head
            local CD = Mask.ClickDetector
            fireclickdetector(CD)

            local humanoid = p1.Parent.Humanoid
            humanoid:EquipTool(game.Players.LocalPlayer.Backpack.Mask)
        end
        if message:sub(1, walletCommand:len()):lower() == walletCommand:lower() then
            local p1 = game.Players.LocalPlayer.Character.HumanoidRootPart
            local humanoid = p1.Parent.Humanoid
            humanoid:EquipTool(game.Players.LocalPlayer.Backpack.Wallet)
        end
        if message:sub(1, blockCommand:len()):lower() == blockCommand:lower() then
            local args = {
                [1] = "Block",
                [2] = true
            }

            game:GetService("ReplicatedStorage").MainEvent:FireServer(unpack(args))
        end
        if message:sub(1, unblockCommand:len()):lower() == unblockCommand:lower() then
            local args = {
                [1] = "Block",
                [2] = false
            }

            game:GetService("ReplicatedStorage").MainEvent:FireServer(unpack(args))
        end
    end
end
local function onPlayerAdded(player)
    player.Chatted:Connect(function (...)
       onPlayerChatted(player, ...)
   end)
end

for _, player in pairs(Players:GetPlayers()) do
   onPlayerAdded(player)
end
Players.PlayerAdded:Connect(onPlayerAdded)
