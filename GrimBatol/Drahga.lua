
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Drahga Shadowburner", "Grim Batol")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40319)
mod.toggleOptions = {
	75218, -- Invocation of Flame
	90950, -- Valiona's Flame / Devouring Flames
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then--@do-not-package@
L["summon_trigger"] = "%s casts the spell"--@end-do-not-package@ -- need someone with a english client!
--@localization(locale="enUS", namespace="GrimBatol/Drahga", format="lua_additive_table", handle-unlocalized="ignore")@
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	-- normal
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")

	-- heroic
	self:Log("SPELL_CAST_START", "Flame", 90950)

	self:Death("Win", 40319)
end

function mod:VerifyEnable()
	if not UnitInVehicle("player") then return true end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find(L["summon_trigger"]) then
		self:Message(75218, spellName, player, "Urgent", spellId, "Alarm")
	end
end

function mod:Flame(_, spellId, _, _, spellName)
	self:Message(90950, spellName, "Important", spellId, "Long")
end

