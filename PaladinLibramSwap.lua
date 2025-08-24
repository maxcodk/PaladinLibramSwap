local function PlayerHasBuff(buffText)
    local i, s = 0, 0
    while 1 do
        buff = GetPlayerBuff(i, "HELPFUL")
        if buff == -1 then
            break
        end
        if string.find(GetPlayerBuffTexture(buff), buffText) then
            return true
        end
        i = i + 1
    end
    return false
end

local function UnitHasDebuff(unit, debuffText)
    for i = 1, 40 do
        local debuff = UnitDebuff(unit, i)
        if debuff then
            if string.find(debuff, debuffText) then
                return true
            end
        end
    end
    return false
end

local function ItemLinkToName(link)
	if ( link ) then
   	return gsub(link,"^.*%[(.*)%].*$","%1");
	end
end

local function FindItem(item)
    if ( not item ) then return; end
    item = string.lower(ItemLinkToName(item));
    local link;
    for i = 1,23 do
        link = GetInventoryItemLink("player",i);
        if ( link ) then
            if ( item == string.lower(ItemLinkToName(link)) )then
                return i, nil, GetInventoryItemTexture('player', i), GetInventoryItemCount('player', i);
            end
        end
    end
    local count, bag, slot, texture;
    local totalcount = 0;
    for i = 0,NUM_BAG_FRAMES do
        for j = 1,MAX_CONTAINER_ITEMS do
            link = GetContainerItemLink(i,j);
            if ( link ) then
                if ( item == string.lower(ItemLinkToName(link))) then
                    bag, slot = i, j;
                    texture, count = GetContainerItemInfo(i,j);
                    totalcount = totalcount + count;
                end
            end
        end
    end
    return bag, slot, texture, totalcount;
end

local function UseItemByName(item)
    local bag,slot = FindItem(item);
    if ( not bag ) then return; end;
    if ( slot ) then
        UseContainerItem(bag,slot); -- use, equip item in bag
        return bag, slot;
    else
        UseInventoryItem(bag); -- unequip from body
        return bag;
    end
end

local function SpellReady(spell)
    local i,a=0
    while a~=spell do 
        i=i+1 
        a=GetSpellName(i,"spell")
    end 
    if GetSpellCooldown(i,"spell") == 0 then 
        return true
    end
end

local function checkLibramEquip(checkedLibram)
    local libramLink = GetInventoryItemLink("player",18);
    if string.find(libramLink, checkedLibram) then
        return true
    else
        return false
    end
end

function CastEquipByName(spellname,itemName)
    local spellname_no_rank = spellname;

    if spellname == "Consecration(Rank 1)" then
        spellname_no_rank = "Consecration"
    end
    if spellname == "Holy Shield(Rank 1)" then
        spellname_no_rank = "Holy Shield"
    end 

    local spellready = SpellReady(spellname_no_rank);
    if (spellready) then
        if not checkLibramEquip(itemName) then
            UseItemByName(itemName)
        end
        CastSpellByName(spellname);
    end
end

-- function PaladinTaunt()
--     if PlayerHasBuff("SealOfWrath") then
--         CastSpellByName("Judgement")
--         if not CheckRigteousFurry() then
--             UIErrorsFrame:Clear();
--             UIErrorsFrame:AddMessage("No Rigteous Furry");
--             PlaySound("RaidWarning", "master");
--             SendChatMessage("No Rigteous Furry", "PARTY");
--         end
--     elseif SpellReady("Judgement") then
--         CastSpellByName("Seal of Justice")
--         end
-- end

local function CancelBuff(buff)
    local counter = 0
    while GetPlayerBuff(counter) >= 0 do
        local index, untilCancelled = GetPlayerBuff(counter)
        if untilCancelled ~= 1 then
            local texture = GetPlayerBuffTexture(index);
            if texture then                 
                if string.find(texture, buff) then
                    CancelPlayerBuff(index);
                    return
                end
            end
        end
        counter = counter + 1
    end
    return nil
end

function PaladinConsecration()
    if SpellReady("Consecration") then
        if not IsShiftKeyDown() then
            CastEquipByName("Consecration","Libram of the Faithful");
        else
            CastEquipByName("Consecration(Rank 1)","Libram of the Faithful");
        end
    end
end


function PaladinHolyShield()
    if SpellReady("Holy Shield") then
        if IsShiftKeyDown() then
            CastEquipByName("Holy Shield(Rank 1)","Libram of the Dreamguard");
        else
            CastEquipByName("Holy Shield","Libram of the Dreamguard");
        end
    end
end


function PaladinHolyStrike()
    if SpellReady("Holy Strike") then
        if (IsSpellInRange("Holy Strike")) == 1 then
            CastEquipByName("Holy Strike","Libram of the Eternal Tower");
        end
    end
end

function PaladinCrusaderStrike()
    if SpellReady("Crusader Strike") then
        if (IsSpellInRange("Crusader Strike")) == 1 then
            CastEquipByName("Crusader Strike","Libram of the Eternal Tower");
        end
    end
end

function PaladinBubble()
    if IsShiftKeyDown() then
        CastSpellByName("Divine Shield");
        CancelBuff("DivineIntervention");
    else    
        CastSpellByName("Divine Shield");
    end
end


--salva remove part
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_AURAS_CHANGED")

f:SetScript("OnEvent", function()
        if event == "PLAYER_AURAS_CHANGED" then
            if CheckRigteousFurry() then
                CancelSalvationBuff()
            end
        end
    end)

function CheckRigteousFurry()
    local buff = "Spell_Holy_SealOfFury"
    local counter = 0
    while GetPlayerBuff(counter) >= 0 do
        local index, untilCancelled = GetPlayerBuff(counter)
        if untilCancelled == 1 then
            local texture = GetPlayerBuffTexture(index)
            if texture then  
                if string.find(texture, buff) then
                    return true
                end
            end
        end
        counter = counter + 1
    end
    return false
end

function CancelSalvationBuff()
    local buff = {"Spell_Holy_SealOfSalvation", "Spell_Holy_GreaterBlessingofSalvation"}
    local counter = 0
    while GetPlayerBuff(counter) >= 0 do
        local index, untilCancelled = GetPlayerBuff(counter)
        if untilCancelled ~= 1 then
            local texture = GetPlayerBuffTexture(index)
            if texture then 
                local i = 1
                while buff[i] do
                    if string.find(texture, buff[i]) then
                        CancelPlayerBuff(index);
                        UIErrorsFrame:Clear();
                        UIErrorsFrame:AddMessage("Salvation Removed");
                        return
                    end
                    i = i + 1
                end
            end
        end
        counter = counter + 1
    end
    return nil
end
