local RemoteChat = {}
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

function RemoteChat:Send(Message)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local ChatInputBar = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
        if ChatInputBar and ChatInputBar.TargetTextChannel then
            pcall(function()
                ChatInputBar.TargetTextChannel:SendAsync(Message)
            end)
        else
            warn("!.")
        end
    else
        local DefaultChatSystemChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if DefaultChatSystemChatEvents then
            local SayMessageRequest = DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
            if SayMessageRequest then
                pcall(function()
                    SayMessageRequest:FireServer(Message, "All")
                end)
            else
                warn("!.")
            end
        else
            warn("!.")
        end
    end
end

return RemoteChat
