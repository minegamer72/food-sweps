-- Just made for those who download a mod and never check the steam workshop.

CreateConVar("foodswep_chatprint", "1", FCVAR_ARCHIVE, "", nil, nil) -- create cvar

local chatprints = GetConVar("foodswep_chatprint"):GetInt() -- make it a variable
if chatprints == 1 then -- is it true?
    timer.Simple(8, function() -- chat big block of text
        surface.PlaySound("buttons/lightswitch2.wav") -- play beep sound
        chat.AddText(Color(225, 5, 15), "-- Food SWEPS Addon --")
        chat.AddText(Color(254, 254, 255),"Because a lot of people don't really read updates on the workshop addons, this is probably the best way to reach you all.")
        chat.AddText(Color(254, 254, 255),"If you do not want a broken addon,",Color(225, 5, 15)," uninstall this.")
        chat.AddText(Color(254, 254, 255),"If you do not trust this mod,",Color(225, 5, 15), " uninstall this.")
        chat.AddText(Color(254, 254, 255),"If you want to fix this broken mod, please git clone the github repository linked on the workshop page and submit a pull request.")
        chat.AddText(Color(225, 254, 255),"To disable this huge block of text, you have to set foodswep_chatprint to 0 in the console!")
        chat.AddText(Color(225, 5, 15), "-- Food SWEPS Addon --")
    end)
elseif chatprints == 0 then -- is it false?
    print("Food Sweps: foodswep_chatprint is false, not chatting!") -- don't chat
    return -- go away
end
