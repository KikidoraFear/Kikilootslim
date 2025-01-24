
-- ##############
-- # PARAMETERS #
-- ##############

local config = {
    max_rarity = 2, -- 0 grey, 1 white and quest items, 2 green, 3 blue, ...
    rarities = {[-1]="Nothing", [0]="Grey", [1]="White", [2]="Green", [3]="Blue", [4]="Purple"},
    refresh_time = 5,
    channel = "RAID",
    window_height = 20,
    window_width = 70,
    button_width = 20,
    button_height = 20,
    button_rarity_width = 40,
    button_rarity_height = 20,
    text_size = 9,
}

-- ################
-- # INIT SR DATA #
-- ################

local data_sr = {}

-- ####################
-- # SPREADSHEET DATA #
-- ####################

local data_ss = {}
data_ss["Lavashard Axe"] = "All Ranks -> Warrior Fury"


-- ##############################
-- # TRANSLATE SPREADSHEET DATA #
-- ##############################


local data_tl = {}
-- https://vanilla-wow-archive.fandom.com/wiki/Tier_1
data_tl["T1 Helm"] = {"Cenarion Helm", "Giantstalker's Helmet", "Arcanist Crown", "Lawbringer Helm", "Circlet of Prophecy", "Nightslayer Cover",
    "Earthfury Helmet", "Felheart Horns", "Helm of Might"}
data_tl["T1 Leggings"] = {"Cenarion Leggings", "Giantstalker's Leggings", "Arcanist Leggings", "Lawbringer Legplates", "Pants of Prophecy", "Nightslayer Pants",
    "Earthfury Legguards", "Felheart Pants", "Legplates of Might"}
data_tl["T1 Wrist"] = {"Cenarion Bracers", "Giantstalker's Bracers", "Arcanist Bindings", "Lawbringer Bracers", "Vambraces of Prophecy", "Nightslayer Bracelets",
    "Earthfury Bracers", "Felheart Bracers", "Bracers of Might"}
data_tl["T1 Belt"] = {"Cenarion Belt", "Giantstalker's Belt", "Arcanist Belt", "Lawbringer Belt", "Girdle of Prophecy", "Nightslayer Belt",
    "Earthfury Belt", "Felheart Belt", "Belt of Might"}
data_tl["T1 Boots"] = {"Cenarion Boots", "Giantstalker's Boots", "Arcanist Boots", "Lawbringer Boots", "Boots of Prophecy", "Nightslayer Boots",
    "Earthfury Boots", "Felheart Slippers", "Sabatons of Might"}
data_tl["T1 Gloves"] = {"Cenarion Gloves", "Giantstalker's Gloves", "Arcanist Gloves", "Lawbringer Gauntlets", "Gloves of Prophecy", "Nightslayer Gloves",
    "Earthfury Gauntlets", "Felheart Gloves", "Gauntlets of Might"}
data_tl["T1 Shoulder"] = {"Cenarion Spaulders", "Giantstalker's Epaulets", "Arcanist Mantle", "Lawbringer Spaulders", "Mantle of Prophecy", "Nightslayer Shoulder Pads",
    "Earthfury Epaulets", "Felheart Shoulder Pads", "Pauldrons of Might"}
data_tl["T1 Chest"] = {"Cenarion Vestments", "Giantstalker's Breastplate", "Arcanist Robes", "Lawbringer Chestguard", "Robes of Prophecy", "Nightslayer Chestpiece",
    "Earthfury Vestments", "Felheart Robes", "Breastplate of Might"}

-- https://vanilla-wow-archive.fandom.com/wiki/Tier_2
data_tl["T2 Helm"] = {"Stormrage Cover", "Dragonstalker's Helm", "Netherwind Crown", "Judgement Crown", "Halo of Transcendence", "Bloodfang Hood",
    "Helmet of Ten Storms", "Nemesis Skullcap", "Helm of Wrath"}
data_tl["T2 Leggings"] = {"Stormrage Legguards", "Dragonstalker's Legguards", "Netherwind Pants", "Judgement Legplates", "Leggings of Transcendence", "Bloodfang Pants",
    "Legplates of Ten Storms", "Nemesis Leggings", "Legplates of Wrath"}
data_tl["T2 Wrist"] = {"Stormrage Bracers", "Dragonstalker's Bracers", "Netherwind Bindings", "Judgement Bindings", "Bindings of Transcendence", "Bloodfang Bracers",
    "Bracers of Ten Storms", "Nemesis Bracers", "Bracelets of Wrath"}
data_tl["T2 Belt"] = {"Stormrage Belt", "Dragonstalker's Belt", "Netherwind Belt", "Judgement Belt", "Belt of Transcendence", "Bloodfang Belt",
    "Belt of Ten Storms", "Nemesis Belt", "Waistband of Wrath"}
data_tl["T2 Boots"] = {"Stormrage Boots", "Dragonstalker's Greaves", "Netherwind Boots", "Judgement Sabatons", "Boots of Transcendence", "Bloodfang Boots",
    "Greaves of Ten Storms", "Nemesis Boots", "Sabatons of Wrath"}
data_tl["T2 Gloves"] = {"Stormrage Handguards", "Dragonstalker's Gauntlets", "Netherwind Gloves", "Judgement Gauntlets", "Handguards of Transcendence", "Bloodfang Gloves",
    "Gauntlets of Ten Storms", "Nemesis Gloves", "Gauntlets of Wrath"}
data_tl["T2 Shoulder"] = {"Stormrage Pauldrons", "Dragonstalker's Spaulders", "Netherwind Mantle", "Judgement Spaulders", "Pauldrons of Transcendence", "Bloodfang Spaulders",
    "Epaulets of Ten Storms", "Nemesis Spaulders", "Pauldrons of Wrath"}
data_tl["T2 Chest"] = {"Stormrage Chestguard", "Dragonstalker's Breastplate", "Netherwind Robes", "Judgement Breastplate", "Robes of Transcendence", "Bloodfang Chestpiece",
    "Breastplate of Ten Storms", "Nemesis Robes", "Breastplate of Wrath"}

for alias, items in pairs(data_tl) do
    if data_ss[alias] then
        for _, item in pairs(items) do
            data_ss[item] = data_ss[alias]
        end
    end
end


-- ###############
-- # ITEM FILTER #
-- ###############

local data_if = {}
-- wildcard_roll
data_if["Recipe:"] = "wildcard_roll"
data_if["Book:"] = "wildcard_roll"
data_if["Pattern:"] = "wildcard_roll"

-- exact_roll
data_if["Onyxia Hide Backpack"] = "exact_roll"
data_if["Tome of Tranquilizing Shot"] = "exact_roll"
data_if["Mr. Bigglesworth"] = "exact_roll"
data_if["Dream Frog"] = "exact_roll"
data_if["Blue Qiraji Resonating Crystal"] = "exact_roll"
data_if["Yellow Qiraji Resonating Crystal"] = "exact_roll"
data_if["Green Qiraji Resonating Crystal"] = "exact_roll"
data_if["Red Qiraji Resonating Crystal"] = "exact_roll"
data_if["Moltencore Hound"] = "exact_roll"


-- ##########
-- # LAYOUT #
-- ##########

local function WindowLayout(window)
    window:SetBackdrop({bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background'})
    window:SetBackdropColor(0.2, 0.2, 0.2, 1)
    window:SetPoint('CENTER', UIParent)
    window:SetWidth(config.window_width)
    window:SetHeight(config.window_height)
    window:EnableMouse(true) -- needed for it to be movable
    window:RegisterForDrag("LeftButton")
    window:SetMovable(true)
    window:SetUserPlaced(true) -- saves the place the user dragged it to
    window:SetScript("OnDragStart", function() window:StartMoving() end)
    window:SetScript("OnDragStop", function() window:StopMovingOrSizing() end)
    window:SetClampedToScreen(true) -- so the window cant be moved out of screen
end

local function ButtonLayout(parent, btn, txt, tooltip, ofs_x, ofs_y, width, height)
    btn:ClearAllPoints()
    btn:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", ofs_x, ofs_y)
    btn:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 8,
        insets = { left = 2, right = 2, top = 2, bottom = 2}})
    btn:SetWidth(width)
    btn:SetHeight(height)
    btn:Show()
    if not btn.text then
        btn.text = btn:CreateFontString("Status", "OVERLAY", "GameFontNormal")
    end
    btn.text:SetFont(STANDARD_TEXT_FONT, config.text_size, "THINOUTLINE")
    btn.text:SetFontObject(GameFontWhite)
    btn.text:ClearAllPoints()
    btn.text:SetPoint("CENTER", btn, "CENTER")
    btn.text:SetText(txt)
    btn.text:Show()
    btn:SetBackdropColor(0, 0, 0, 1)
    btn:SetBackdropBorderColor(0, 0, 0, 1)
    btn:SetScript("OnEnter", function()
        btn:SetBackdropBorderColor(1, 1, 1, 1)
        GameTooltip:SetOwner(btn, "ANCHOR_TOP")
        GameTooltip:AddLine(tooltip)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function()
        btn:SetBackdropBorderColor(0, 0, 0, 1)
        GameTooltip:Hide()
    end)
end

local function EditBoxLayout(parent, edb)
    edb:ClearAllPoints()
    edb:SetPoint("TOPRIGHT", parent, "TOPLEFT")
    edb:SetMultiLine(true)
    edb:SetFont(STANDARD_TEXT_FONT, 8, "THINOUTLINE")
    edb:SetFontObject(GameFontWhite)
    edb:SetWidth(500)
    edb:SetHeight(100)
    edb:SetBackdrop({bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background'})
    edb:Hide()
end

-- ####################
-- # HELPER FUNCTIONS #
-- ####################

local function print(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg)
end

local function ResetData(data)
    if data then
        for idx,_ in pairs(data) do data[idx] = nil end
    end
end

function GetTableLength(tbl)
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    return count
end

local function GetLootMaster()
    local loot_method, loot_master_id_party, loot_master_id_raid = GetLootMethod()
    if (loot_method == "master") then
        if loot_master_id_raid then
            if loot_master_id_raid == 0 then
                return UnitName("player")
            else
                return UnitName("raid"..loot_master_id_raid)
            end
        elseif loot_master_id_party then
            if loot_master_id_party == 0 then
                return UnitName("player")
            else
                return UnitName("party"..loot_master_id_party)
            end
        end
    else
        return ""
    end
end

-- 21110,"Thunderfury, Blessed Blade of the Windseeker",Ragnaros,Malgoni,Warrior,Protection,,"04/02/2024, 14:53:38"
local function ParseRaidres(text, data_sr) -- SR data
    text = text..'\n' -- add \n so last line will be matched as well
    local pattern = '(%d+),"(.-)",(.-),(.-),(.-),(.-),"(.-)"\n' -- modifier - gets 0 or more repetitions and matches the shortest sequence
    ResetData(data_sr)
    for id, item, boss, attendee, class, specialization, comment, date in string.gfind(text, pattern) do
        if not data_sr[item] then
            data_sr[item] = {}
        end
        table.insert(data_sr[item], attendee)
    end
end

local function GetPlayerIndex()
    for idx_loop = 1, GetNumRaidMembers() do
        if (GetMasterLootCandidate(idx_loop) == UnitName("player")) then
            return idx_loop -- get master loot candidate index for player
        end
    end
end

local function ItemIsAutolooted(item_name, data_if)
    for item, info in pairs(data_if) do
        if info == "exact_loot" then
            if item_name == item then -- if item_filter equals item_name (Onyxia Hide Backpack)
                return true
            end
        elseif info == "wildcard_loot" then
            if string.find(item_name, item) then -- if item_filter is in item_name (Pattern:, Recipe:)
                return true
            end
        end
    end
    return false
end

local function ItemIsRolled(item_name, data_if)
    for item, info in pairs(data_if) do
        if info == "exact_roll" then
            if item_name == item then -- if item_filter equals item_name (Onyxia Hide Backpack)
                return true
            end
        elseif info == "wildcard_roll" then
            if string.find(item_name, item) then -- if item_filter is in item_name (Pattern:, Recipe:)
                return true
            end
        end
    end
    return false
end

-- ##################
-- # LOOT FUNCTIONS #
-- ##################

local function ShowLoot(data_sr, data_ss, data_if)
    for idx_loot = 1, GetNumLootItems() do
        local item_icon, item_name, item_quantity, item_rarity, item_locked = GetLootSlotInfo(idx_loot)
        local item_is_autolooted = ItemIsAutolooted(item_name, data_if)
        local item_is_rolled = ItemIsRolled(item_name, data_if)

        -- if ((item_rarity > config.max_rarity) and LootSlotIsItem(idx_loot)) or item_filter then -- if rarity>=min and not gold
        if ((item_rarity > config.max_rarity) and item_quantity>0 and (not item_is_autolooted)) or item_is_rolled then -- if item_quantity=0 for gold; cloth maybe isnt a LootSlotItem, idk -> Test that
            local item_link = GetLootSlotLink(idx_loot) or ""
            local item_ss = data_ss[item_name] or ""
            local item_sr = " "
            if data_sr[item_name] then
                for _, player_name in pairs(data_sr[item_name]) do
                    item_sr = item_sr..player_name.." "
                end
            end
            local text = item_link..": "..item_ss.." ("..item_sr..")"
            SendChatMessage(text , config.channel, nil, nil)
        else
            local idx_mlc = GetPlayerIndex()
            GiveMasterLoot(idx_loot, idx_mlc)
        end
    end
end

-- ########
-- # INIT #
-- ########

local window = CreateFrame("Frame", "Kikiloot", UIParent)
WindowLayout(window)

window.button_sr = CreateFrame("Button", nil, window) -- Soft Reserve
ButtonLayout(window, window.button_sr, "SR", "Import SR", 0, 0, config.button_width, config.button_height)
window.import_sr = CreateFrame("EditBox", nil, UIParent)
EditBoxLayout(window, window.import_sr)

window.button_ar = CreateFrame("Button", nil, window) -- Autoloot Rarity
window.button_ar.sub = {}
ButtonLayout(window, window.button_ar, config.rarities[config.max_rarity], "Select Autoloot Rarity", 3*config.button_width, 0, config.button_rarity_width, config.button_rarity_height)
for idx_rarity=-1,4 do
    local idx_rarity_f = idx_rarity
    local txt_rarity_f = config.rarities[idx_rarity_f]
    window.button_ar.sub[idx_rarity_f] = CreateFrame("Button", nil, window)
    ButtonLayout(window.button_ar, window.button_ar.sub[idx_rarity_f], txt_rarity_f, "Select Autoloot Rarity", 0, (idx_rarity_f+2)*config.button_rarity_height, config.button_rarity_width, config.button_rarity_height)
    
    window.button_ar.sub[idx_rarity_f]:SetScript("OnClick", function()
        config.max_rarity = idx_rarity_f
        window.button_ar.text:SetText(txt_rarity_f)
        for idx_btn, _ in pairs(config.rarities) do
            window.button_ar.sub[idx_btn]:Hide()
        end
    end)
    window.button_ar.sub[idx_rarity_f]:Hide()
end

-- #################
-- # INTERACTIVITY #
-- #################

window.button_sr:SetScript("OnClick", function()
    if window.import_sr:IsShown() then
        window.import_sr:Hide()
    else
        window.import_sr:Show()
    end
end)
window.import_sr:SetScript("OnTextChanged", function()
    ParseRaidres(this:GetText(), data_sr)
end)

window.button_ar:SetScript("OnClick", function()
    for idx_rarity,_ in pairs(config.rarities) do
        if window.button_ar.sub[idx_rarity]:IsShown() then
            window.button_ar.sub[idx_rarity]:Hide()
        else
            window.button_ar.sub[idx_rarity]:Show()
        end
    end
end)

-- #######################
-- # ONUPDATE AND EVENTS #
-- #######################

window:RegisterEvent("LOOT_OPENED")
window:SetScript("OnEvent", function()
    if UnitName("player")==GetLootMaster() then
        ShowLoot(data_sr, data_ss, data_if)
    end
end)