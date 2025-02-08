
-- ToDo:
-- button parse SRs
    -- people can type their SR in raid chat "SR:item1#item2"
    -- people get infos whispered (SRs registered, if item was found, display rank and prio)
    -- if someone else SRs their item, whisper info as well


-- ##############
-- # PARAMETERS #
-- ##############

local config = {
    max_rarity = 2, -- 0 grey, 1 white and quest items, 2 green, 3 blue, ...
    rarities = {[-1]="Nothing", [0]="Grey", [1]="White", [2]="Green", [3]="Blue", [4]="Purple"},
    refresh_time = 5,
    channel = "RAID",
    window_height = 20,
    window_width = 110,
    button_width = 60,
    button_height = 20,
    button_rarity_width = 40,
    button_rarity_height = 20,
    text_size = 9,
    parse_sr = false
}

-- ################
-- # INIT SR DATA #
-- ################

local data_sr = {}

-- ####################
-- # SPREADSHEET DATA #
-- ####################

local data_ss = {}
data_ss["Lavashard Axe"] = "Soft Reserve -> Warrior Fury"
data_ss["Core Forged Helmet"] = "Soft Reserve -> Paladin Tank"
data_ss["Boots of Blistering Flames"] = "Soft Reserve -> Mage"
data_ss["Ashskin Belt"] = "Soft Reserve -> Rogue"
data_ss["Shoulderpads of True Flight"] = "Soft Reserve -> Shaman Enh/Hunter"
data_ss["Lost Dark Iron Chain"] = "Soft Reserve -> Warrior Tank /Paladin Tank"
data_ss["T1 Wrist"] = "Soft Reserve -> Class Specific"
data_ss["T1 Belt"] = "Soft Reserve -> Class Specific"
data_ss["Garb of Royal Ascension"] = "Soft Reserve -> Warlock Shadow Resistance>Druid Moonkin"
data_ss["Gloves of the Immortal"] = "Soft Reserve -> Everyone"
data_ss["Neretzek, The Blood Drinker"] = "Soft Reserve -> Everyone"
data_ss["Anubisath Warhammer"] = "Soft Reserve -> Non Orc Tank / Dual Fury"
data_ss["Ritssyn's Ring of Chaos"] = "Soft Reserve -> Casters Dps"
data_ss["Shard of the Fallen Star"] = "Soft Reserve -> Everyone"
data_ss["Breastplate of Annihilation"] = "Soft Reserve -> Warrior Fury Only"
data_ss["Boots of the Unwavering Will"] = "Soft Reserve -> Tank"
data_ss["Cloak of Concentrated Hatred"] = "Soft Reserve -> Tank/Fury/Rogue/Ret Paladin/Enh Shaman/Feral"
data_ss["Amulet of Foul Warding"] = "Soft Reserve -> Tank/Melee Dps/Hunters Nature Resistance"
data_ss["Barrage Shoulders"] = "Soft Reserve -> Hunter"
data_ss["Beetle Scaled Wristguards"] = "Soft Reserve -> Everyone Leather Nature Resistance"
data_ss["Boots of the Fallen Prophet"] = "Soft Reserve -> Shaman Enh"
data_ss["Hammer of Ji'zhi"] = "Soft Reserve -> Shaman/Paladin / DE"
data_ss["Leggings of Immersion"] = "Soft Reserve -> Druid /Shaman Caster"
data_ss["Pendant of the Qiraji Guardian"] = "Soft Reserve -> Tank"
data_ss["Ring of Swarming Thought"] = "Soft Reserve -> Casters Dps"
data_ss["Staff of the Qiraji Prophets"] = "Soft Reserve -> Casters Dps"
data_ss["Imperial Qiraji Armaments"] = "Soft Reserve -> Dagger/1h Axe/Shield"
data_ss["Imperial Qiraji Regalia"] = "Soft Reserve -> Hit Staff/Healing Staff/Feral Mace"
data_ss["Guise of the Devourer"] = "Soft Reserve -> Druid Tank"
data_ss["Ukko's Ring of Darkness"] = "Soft Reserve -> Warlock Shadow Resistance"
data_ss["Boots of the Fallen Hero"] = "Soft Reserve -> Warrior Fury Prot/ Dual Wield Fury"
data_ss["Ternary Mantle"] = "Soft Reserve -> Priest Healer Prio"
data_ss["Angelista's Touch"] = "Soft Reserve -> Tank"
data_ss["Mantle of the Desert Crusade"] = "Soft Reserve -> Paladin Holy"
data_ss["Mantle of the Desert's Fury"] = "Soft Reserve -> Shaman Resto Or Elemental"
data_ss["Vest of Swift Execution"] = "Soft Reserve -> Druid Cat > Rogue / Feral Tank"
data_ss["Angelista's Charm"] = "Soft Reserve -> Healers"
data_ss["Bile-Covered Gauntlets"] = "Soft Reserve -> Everyone"
data_ss["Cape of the Trinity"] = "Soft Reserve -> Casters Dps"
data_ss["Gloves of Ebru"] = "Soft Reserve -> Shaman Elemental / Druid Boomkin"
data_ss["Mantle of Phrenic Power"] = "Soft Reserve -> Mage"
data_ss["Ooze-ridden Gauntlets"] = "Soft Reserve -> Nature Resist Gear"
data_ss["Petrified Scarab"] = "Soft Reserve -> Everyone"
data_ss["Ring of the Devoured"] = "Soft Reserve -> Druid /Shaman Caster"
data_ss["Robes of the Triumvirate"] = "Soft Reserve -> Casters/Healers Nature Resistance"
data_ss["Triad Girdle"] = "Soft Reserve -> Warrior Fury/Paladin Ret"
data_ss["Wand of Qiraji Nobility"] = "Soft Reserve -> Casters Dps"
data_ss["Imperial Qiraji Armaments"] = "Soft Reserve -> Dagger/1h Axe/Shield"
data_ss["Imperial Qiraji Regalia"] = "Soft Reserve -> Hit Staff/Healing Staff/Feral Mace"
data_ss["Badge of the Swarmguard"] = "Core Raider -> Hunter = Fury Warrior  = Rogue"
data_ss["Thick Qirajihide Belt"] = "Soft Reserve -> Druid Tank"
data_ss["Sartura's Might"] = "Soft Reserve -> Priests/Druids > Shamans/Pallies"
data_ss["Creeping Vine Helm"] = "Soft Reserve -> Druid Heal/Paladin>Shaman"
data_ss["Gauntlets of Steadfast Determination"] = "Soft Reserve -> Tank"
data_ss["Gloves of Enforcement"] = "Soft Reserve -> Rogue/Feral Cat/Enh Shaman"
data_ss["Leggings of the Festering Swarm"] = "Soft Reserve -> Mage"
data_ss["Silithid Claw"] = "Soft Reserve -> Hunter"
data_ss["Necklace of Purity"] = "Soft Reserve -> Everyone"
data_ss["Recomposed Boots"] = "Soft Reserve -> Caster/Healer Nature Resistance"
data_ss["Robes of the Battleguard"] = "Soft Reserve -> Casters Dps"
data_ss["Scaled Leggings of Qiraji Fury"] = "Soft Reserve -> Shaman Elemental"
data_ss["Imperial Qiraji Armaments"] = "Soft Reserve -> Dagger/1h Axe/Shield"
data_ss["Imperial Qiraji Regalia"] = "Soft Reserve -> Hit Staff/Healing Staff/Feral Mace"
data_ss["Cloak of Untold Secrets"] = "Soft Reserve -> Warlock Shadow Resistance"
data_ss["Fetish of the Sand Reaver"] = "Soft Reserve -> Mage / Warlock"
data_ss["Ancient Qiraji Ripper"] = "Soft Reserve -> Rogue Sword  Prio"
data_ss["Barb of the Sand Reaver"] = "Soft Reserve -> Hunter"
data_ss["Barbed Choker"] = "Soft Reserve -> Warrior 2H Fury/Shaman Enh/Rogue"
data_ss["Totem of Life"] = "Soft Reserve -> Shaman Resto"
data_ss["Hive Tunneler's Boots"] = "Soft Reserve -> Druid Tank"
data_ss["Mantle of Wicked Revenge"] = "Soft Reserve -> Druid Tank / Enh Shaman"
data_ss["Pauldrons of the Unrelenting"] = "Soft Reserve -> Warrior Tank"
data_ss["Robes of the Guardian Saint"] = "Soft Reserve -> Healer Druid/Shaman /Paladin > Other Healers"
data_ss["Scaled Sand Reaver Leggings"] = "Soft Reserve -> Shaman Enh"
data_ss["Libram of Grace"] = "Soft Reserve -> Paladin Healer"
data_ss["Silithid Carapace Chestguard"] = "Soft Reserve -> WarriorTank,Fury /Paladin Ret"
data_ss["Imperial Qiraji Armaments"] = "Soft Reserve -> Dagger/1h Axe/Shield"
data_ss["Imperial Qiraji Regalia"] = "Soft Reserve -> Hit Staff/Healing Staff/ 1H Feral Mace"
data_ss["Sharpened Silithid Femur"] = "Soft Reserve -> Caster Dps"
data_ss["Ring of the Qiraji Fury"] = "Soft Reserve -> Rogue >Warrior Fury/Shaman Enh"
data_ss["Gauntlets of Kalimdor"] = "Soft Reserve -> Shaman"
data_ss["Gauntlets of the Righteous Champion"] = "Soft Reserve -> Ret Paladin"
data_ss["Idol of Health"] = "Soft Reserve -> Druid"
data_ss["Scarab Brooch"] = "Soft Reserve -> Paladin/Priest>Shaman"
data_ss["Slime-coated Leggings"] = "Soft Reserve -> Shaman Enh"
data_ss["Imperial Qiraji Armaments"] = "Soft Reserve -> Dagger/1h Axe/Shield"
data_ss["Imperial Qiraji Regalia"] = "Soft Reserve -> Hit Staff/Healing Staff/Feral Mace"
data_ss["Qiraji Bindings of Command"] = "Soft Reserve -> T 2.5 Shoulders & Boots"
data_ss["Qiraji Bindings of Dominance"] = "Soft Reserve -> T 2.5 Shoulders & Boots"
data_ss["Ring of the Martyr"] = "Core Raider -> Healers"
data_ss["Cloak of the Golden Hive"] = "Soft Reserve -> Tank"
data_ss["Hive Defiler Wristguards"] = "Soft Reserve -> Warrior Fury/Paladin Ret"
data_ss["Wasphide Gauntlets"] = "Soft Reserve -> Druid/Shaman Resto"
data_ss["Gloves of the Messiah"] = "Soft Reserve -> All Healers"
data_ss["Huhuran's Stinger"] = "Soft Reserve -> Rogue"
data_ss["Imperial Qiraji Armaments"] = "Soft Reserve -> Dagger/1h Axe/Shield"
data_ss["Imperial Qiraji Regalia"] = "Soft Reserve -> Hit Staff/Healing Staff/Feral Mace"
data_ss["Qiraji Bindings of Command"] = "Soft Reserve -> T 2.5 Shoulders & Boots"
data_ss["Qiraji Bindings of Dominance"] = "Soft Reserve -> T 2.5 Shoulders & Boots"
data_ss["Ring of Emperor Vek'lor"] = "Soft Reserve -> Bear Tank > Tank"
data_ss["Qiraji Execution Bracers"] = "Soft Reserve -> Tank Druid > Enh Shaman  / Warrior 1H Fury"
data_ss["Gloves of the Hidden Temple"] = "Soft Reserve -> Tank Druid"
data_ss["Amulet of Vek'nilash"] = "Soft Reserve -> Caster Dps"
data_ss["Royal Scepter of Vek'lor"] = "Soft Reserve -> Warlock / Mage"
data_ss["Kalimdor's Revenge"] = "Soft Reserve -> Ret Paladin / 2H Fury"
data_ss["Regenerating Belt of Vek'nilash"] = "Soft Reserve -> Paladin/Druid > Shaman Resto"
data_ss["Belt of the Fallen Emperor"] = "Soft Reserve -> Paladin Healer"
data_ss["Boots of Epiphany"] = "Soft Reserve -> Shadiw Priest >Caster Dps"
data_ss["Bracelets of Royal Redemption"] = "Soft Reserve -> Druid/Paladin>Priest > Shaman"
data_ss["Vek'lor's Gloves of Devastation"] = "Soft Reserve -> Shaman Enh/Hunter"
data_ss["Royal Qiraji Belt"] = "Soft Reserve -> Tank"
data_ss["Grasp of the Fallen Emperor"] = "Soft Reserve -> Shaman Elemental"
data_ss["Imperial Qiraji Armaments"] = "Soft Reserve -> Dagger/1h Axe/Shield"
data_ss["Imperial Qiraji Regalia"] = "Soft Reserve -> Hit Staff/Healing Staff/Feral Mace"
data_ss["Vek'lor's Diadem"] = "Soft Reserve -> T 2.5 Helm"
data_ss["Vek'nilash's Circlet"] = "Soft Reserve -> T 2.5 Helm"
data_ss["Ivanor. Maiden's Mallet"] = "Core Raider -> Heakers"
data_ss["Gloves of the Primordial Burrower"] = "Core Raider -> 1H Fury Warriors / Rogue"
data_ss["Carpace Handguards"] = "Core Raider -> 2H Fury Warriors"
data_ss["Wormhide Boots"] = "Soft Reserve -> Druid Fera/ Warrio 2H Fury / Shaman Enh"
data_ss["Jom Gabbar"] = "Soft Reserve -> Fury , Shaman Enh . Rogue and Hunter"
data_ss["Don Rigoberto's Lost Hat"] = "Soft Reserve -> Druid / Paladin / Priest > Shaman"
data_ss["Burrower Bracers"] = "Soft Reserve -> Shadow Priest = Spell Paladin > Caster DPS"
data_ss["Larvae of the Great Worm"] = "Soft Reserve -> Hunter"
data_ss["Wormscale Blocker"] = "Soft Reserve -> Shaman / Paladin Healers"
data_ss["The Burrower's Shell"] = "Soft Reserve -> Everyone"
data_ss["Wormscale Stompers"] = "Soft Reserve -> Paladin/Shaman Caster"
data_ss["Imperial Qiraji Armaments"] = "Soft Reserve -> Dagger/1h Axe/Shield"
data_ss["Imperial Qiraji Regalia"] = "Soft Reserve -> Hit Staff/Healing Staff/Feral Mace"
data_ss["Ouro's Intact Hide"] = "Soft Reserve -> T 2.5 Legs"
data_ss["Skin of the Great Sandworm"] = "Soft Reserve -> T 2.5 Legs"
data_ss["Gauntlets of Annihilation"] = "Core Raider -> Fury Warrior/Tank> Paladin Ret"
data_ss["Mark of C'Thun"] = "Core Raider -> Warrior/Druid Tank > Paladin Tank"
data_ss["Scepter of the False Prophet"] = "Core Raider -> Healers"
data_ss["Yshgo'lar, Cowl of Fanatical Devotion"] = "Core Raider -> Mage / Warlock/Druid Boomkin"
data_ss["Grasp of the Old God"] = "Core Raider -> Priest Healer Prio"
data_ss["Eyestalk Waist Cord"] = "Raider -> Caster DPS / Spell Paladin"
data_ss["Cloak of the Devoured"] = "Soft Reserve -> Caster Dps / Spell Paladin"
data_ss["Belt of Never-ending Agony"] = "Soft Reserve -> Rogue/Druid (Cat / Bear) > Enh shaman"
data_ss["Dark Storm Gauntlets"] = "Soft Reserve -> Warlock/Druid Boomkin  > Other Casters"
data_ss["Death's Sting"] = "Soft Reserve -> Rogue Dagger > Warrior 1H Goblin"
data_ss["Ring of the Godslayer"] = "Soft Reserve -> Hunter"
data_ss["Cloak of Clarity"] = "Soft Reserve -> All Healers"
data_ss["Vanquished Tentacle of C'Thun"] = "Soft Reserve -> Everyone"
data_ss["Dark Edge of Insanity"] = "Soft Reserve -> PvP enjoyers"
data_ss["Remnants of an Old God"] = "Soft Reserve -> Rogue/Warrior 1H Fury"
data_ss["Eye of C'Thun"] = "Soft Reserve -> Fury Tank/Caster Dps/Healers/Hunters/Feral Cat"
data_ss["Carapace of the Old God"] = "Soft Reserve -> T 2.5 Chest"
data_ss["Husk of the Old God"] = "Soft Reserve -> T 2.5 Chest"

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


-- ##########################################
-- # ITEM FILTER (exact/wildcard_roll/loot) #
-- ##########################################

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
            for player_name, items in pairs(data_sr) do
                if items[1] == item_name then
                    item_sr = item_sr..player_name.." "
                end
                if items[2] == item_name then
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

local data_sr_parser = CreateFrame("Frame")

local window = CreateFrame("Frame", "Kikiloot", UIParent)
WindowLayout(window)

window.button_sr = CreateFrame("Button", nil, window) -- Soft Reserve
ButtonLayout(window, window.button_sr, "Unlock SR", "Enable parsing SR from raid chat", 0, 0, config.button_width, config.button_height)
window.import_sr = CreateFrame("EditBox", nil, UIParent)
EditBoxLayout(window, window.import_sr)

window.button_ar = CreateFrame("Button", nil, window) -- Autoloot Rarity
window.button_ar.sub = {}
ButtonLayout(window, window.button_ar, config.rarities[config.max_rarity], "Select Autoloot Rarity (lower or equal will be looted)", config.button_width, 0, config.button_rarity_width, config.button_rarity_height)
for idx_rarity=-1,4 do
    local idx_rarity_f = idx_rarity
    local txt_rarity_f = config.rarities[idx_rarity_f]
    window.button_ar.sub[idx_rarity_f] = CreateFrame("Button", nil, window)
    ButtonLayout(window.button_ar, window.button_ar.sub[idx_rarity_f], txt_rarity_f, "Select Autoloot Rarity (lower or equal will be looted)", 0, (idx_rarity_f+2)*config.button_rarity_height, config.button_rarity_width, config.button_rarity_height)
    
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
    if config.parse_sr then
        window.button_sr.text:SetText("Unlock SR")
        SendChatMessage("--> SR has been locked <--" , config.channel, nil, nil)
        config.parse_sr = false
        data_sr_parser:UnregisterEvent("CHAT_MSG_RAID")
        data_sr_parser:UnregisterEvent("CHAT_MSG_RAID_LEADER")
    else
        window.button_sr.text:SetText("Lock SR")
        SendChatMessage("--> SR has been unlocked <--" , config.channel, nil, nil)
        SendChatMessage("--> Type item1#item2 to SR <--" , config.channel, nil, nil)
        config.parse_sr = true
        data_sr_parser:RegisterEvent("CHAT_MSG_RAID")
        data_sr_parser:RegisterEvent("CHAT_MSG_RAID_LEADER")
    end
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

-- arg1:message, arg2:author
data_sr_parser:SetScript("OnEvent", function()
    local pattern = '(.-)#(.+)' -- modifier - gets 0 or more repetitions and matches the shortest sequence
    if arg1 ~= "--> Type item1#item2 to SR <--" then -- ugly, but otherwise the info would be parsed as well
        for item1, item2 in string.gfind(arg1, pattern) do
            print(item1..", "..item2)
            data_sr[arg2] = {}
            data_sr[arg2][1] = item1
            data_sr[arg2][2] = item2
            if data_ss[item1] then
                SendChatMessage("SR registered: "..item1.." - "..data_ss[item1] , "WHISPER", nil, arg2)
            else
                SendChatMessage("SR registered: "..item1.." - ITEM NOT FOUND" , "WHISPER", nil, arg2)
            end
            if data_ss[item2] then
                SendChatMessage("SR registered: "..item2.." - "..data_ss[item2] , "WHISPER", nil, arg2)
            else
                SendChatMessage("SR registered: "..item2.." - ITEM NOT FOUND" , "WHISPER", nil, arg2)
            end
        end
    end
end)

-- Lavashard Axe#Core Forged Helmet

window:RegisterEvent("LOOT_OPENED")
window:SetScript("OnEvent", function()
    if UnitName("player")==GetLootMaster() then
        ShowLoot(data_sr, data_ss, data_if)
    end
end)