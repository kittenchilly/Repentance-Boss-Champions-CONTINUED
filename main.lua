-------------------------------------------------------
-- Repentance Boss Champions by jubbalub
-------------------------------------------------------
RepentanceBossChampions = RegisterMod("Repentance Boss Champions", 1)
local game = Game()
local firstLoaded = true
local version = 1.91
local ebbFilepath = "gfx/bossbars/"

RepentanceBossChampions.BossColorIdx = {
    TUFF_TWINS_BLACK = Isaac.GetBossColorIdxByName("Tuff Twins Black"),
    TUFF_TWINS_PURPLE = Isaac.GetBossColorIdxByName("Tuff Twins Purple"),
    THE_SHELL_RED = Isaac.GetBossColorIdxByName("The Shell Red"),
	-- Shell Champion 2
    THE_PILE_BLACK = Isaac.GetBossColorIdxByName("The Pile Black"),
    THE_PILE_PINK = Isaac.GetBossColorIdxByName("The Pile Pink"),
    REAP_CREEP_WHITE = Isaac.GetBossColorIdxByName("Reap Creep White"),
    REAP_CREEP_RED = Isaac.GetBossColorIdxByName("Reap Creep Red"),
    LIL_BLUB_BLUE = Isaac.GetBossColorIdxByName("Lil Blub Blue"),
    LIL_BLUB_GREEN = Isaac.GetBossColorIdxByName("Lil Blub Green"),
    THE_RAINMAKER_BLUE = Isaac.GetBossColorIdxByName("The Rainmaker Blue"),
	-- Rainmaker Champion 2
    THE_SIREN_BLACK = Isaac.GetBossColorIdxByName("The Siren Black"),
    THE_SIREN_PURPLE = Isaac.GetBossColorIdxByName("The Siren Purple"),
    THE_HERETIC_RED = Isaac.GetBossColorIdxByName("The Heretic Red"),
    THE_HERETIC_PURPLE = Isaac.GetBossColorIdxByName("The Heretic Purple"),
    HORNFEL_BLACK = Isaac.GetBossColorIdxByName("Hornfel Black"),
    HORNFEL_ORANGE = Isaac.GetBossColorIdxByName("Hornfel Orange"),
    GREAT_GIDEON_RED = Isaac.GetBossColorIdxByName("Great Gideon Red"),
    GREAT_GIDEON_GREEN = Isaac.GetBossColorIdxByName("Great Gideon Green"),
    BABY_PLUM_GREY = Isaac.GetBossColorIdxByName("Baby Plum Grey"),
    BABY_PLUM_YELLOW = Isaac.GetBossColorIdxByName("Baby Plum Yellow"),
    MIN_MIN_PURPLE = Isaac.GetBossColorIdxByName("Min-Min Purple"),
    MIN_MIN_RED = Isaac.GetBossColorIdxByName("Min-Min Red"),
    CLOG_BROWN = Isaac.GetBossColorIdxByName("Clog Brown"),
    CLOG_BLACK = Isaac.GetBossColorIdxByName("Clog Black"),
    SINGE_BROWN = Isaac.GetBossColorIdxByName("Singe Brown"),
    SINGE_GREEN = Isaac.GetBossColorIdxByName("Singe Green"),
    BUMBINO_GREY = Isaac.GetBossColorIdxByName("Bumbino Grey"),
    BUMBINO_GREEN = Isaac.GetBossColorIdxByName("Bumbino Green"),
    COLOSTOMIA_RED = Isaac.GetBossColorIdxByName("Colostomia Red"),
    COLOSTOMIA_YELLOW = Isaac.GetBossColorIdxByName("Colostomia Yellow"),
    TURDLET_BLUE = Isaac.GetBossColorIdxByName("Turdlet Blue"),
    TURDLET_BLACK = Isaac.GetBossColorIdxByName("Turdlet Black"),
    THE_HORNY_BOYS_PINK = Isaac.GetBossColorIdxByName("The Horny Boys Pink"),
    THE_HORNY_BOYS_GREEN = Isaac.GetBossColorIdxByName("The Horny Boys Green"),
    CLUTCH_ORANGE = Isaac.GetBossColorIdxByName("Clutch Orange"),
    CLUTCH_BLACK = Isaac.GetBossColorIdxByName("Clutch Black"),
}

--Enhanced Boss Bars
if HPBars then
	print("Repentance Boss Champions: Enhanced Boss Bars detected")
	HPBars.BossDefinitions["908.0"] = {
		bossColors={ "_grey", "_yellow", }
    }
end

-------------------------------------------------------
-- Various functions
-------------------------------------------------------
function RepentanceBossChampions.vecToPos(from, to, speed)
  return (from - to):Normalized() * (speed or 1)
end

function RepentanceBossChampions.choose(...)
  if not ... then
    return nil
  end

  local args = { ... }
  return args[math.random(#args)]
end

local function entCount(type,variant)
	local num = 0
	for i, ent in pairs(Isaac.FindByType(type,variant)) do
		num = num + 1
	end
	return num
end

-- for _, eff in pairs(Isaac.FindByType(1000,-1,-1)) do print(eff.Variant) end

-------------------------------------------------------
-- Check for Champions
-------------------------------------------------------
function RepentanceBossChampions:CheckTuffTwins(npc) -- check for tuff twins champions
	local bossColorIdx = npc:GetBossColorIdx()
	if npc.Variant == 2 then
		if bossColorIdx == RepentanceBossChampions.BossColorIdx.TUFF_TWINS_BLACK then
			RepentanceBossChampions:BlackTuffTwinsAI(npc)
		elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.TUFF_TWINS_PURPLE then
			RepentanceBossChampions:PurpleTuffTwinsAI(npc)
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckTuffTwins, 19)

function RepentanceBossChampions:CheckShell(npc) -- check for the shell champions
	local bossColorIdx = npc:GetBossColorIdx()
	if npc.Variant == 3 then
		if bossColorIdx == RepentanceBossChampions.BossColorIdx.THE_SHELL_RED then
			RepentanceBossChampions:RedShellAI(npc)
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckShell, 19)

function RepentanceBossChampions:CheckPile(npc) -- check for pile champions
	local bossColorIdx = npc:GetBossColorIdx()
	if npc.Variant == 1 then
		if bossColorIdx == RepentanceBossChampions.BossColorIdx.THE_PILE_BLACK then
			RepentanceBossChampions:BlackPileAI(npc)
		elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.THE_PILE_PINK then
			RepentanceBossChampions:PinkPileAI(npc)
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckPile, 269)

function RepentanceBossChampions:CheckReapCreep(npc) -- check for reap creep champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.REAP_CREEP_WHITE then
		RepentanceBossChampions:WhiteReapCreepAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.REAP_CREEP_RED then
		RepentanceBossChampions:RedReapCreepAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckReapCreep, 900)

function RepentanceBossChampions:CheckLilBlub(npc) -- check for lil blub champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.LIL_BLUB_BLUE then
		RepentanceBossChampions:BlueLilBlubAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.LIL_BLUB_GREEN then
		RepentanceBossChampions:GreenLilBlubAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckLilBlub, 901)

function RepentanceBossChampions:CheckRainmaker(npc) -- check for rainmaker champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.THE_RAINMAKER_BLUE then
		RepentanceBossChampions:BlueRainmakerAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckRainmaker, 902)

function RepentanceBossChampions:CheckSiren(npc) -- check for siren champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.THE_SIREN_BLACK then
		RepentanceBossChampions:BlackSirenAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.THE_SIREN_PURPLE then
		RepentanceBossChampions:PurpleSirenAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckSiren, 904)

function RepentanceBossChampions:SetSirenData(npc) -- set data for siren
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.THE_SIREN_PURPLE then
		npc:GetData().FearTimer = 0
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_NPC_INIT, RepentanceBossChampions.SetSirenData, 904)

function RepentanceBossChampions:CheckHeretic(npc) -- check for Heretic champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.THE_HERETIC_RED then
		RepentanceBossChampions:RedHereticAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.THE_HERETIC_PURPLE then
		RepentanceBossChampions:PurpleHereticAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckHeretic, 905)

function RepentanceBossChampions:CheckGideon(npc) -- check for Gideon champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.GREAT_GIDEON_RED then
		RepentanceBossChampions:RedGideonAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.GREAT_GIDEON_GREEN then
		RepentanceBossChampions:GreenGideonAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckGideon, 907)

function RepentanceBossChampions:ReplaceBadGideon(npc) -- check for if the bad dummy gideon champion spawns, and replace it
	if npc.Variant == 0 and npc.SubType == 1 then
		npc:Morph(npc.Type, npc.Variant, npc:GetDropRNG():RandomInt(2) + 2, -1) -- if bad gideon spawns then it was always going to be a champion, so we can just replace it with another random gideon champion
		print("Bad gideon replaced")
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_NPC_INIT, RepentanceBossChampions.ReplaceBadGideon, 907)

function RepentanceBossChampions:CheckClog(npc) -- check for clog champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.CLOG_BROWN then
		RepentanceBossChampions:BrownClogAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.CLOG_BLACK then
		RepentanceBossChampions:BlackClogAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckClog, 914)

function RepentanceBossChampions:SetClogData(npc) -- set data for clog
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.CLOG_BROWN then
		npc:GetData().ShotCounter = 0
		npc:GetData().ShotAngle = 0
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_NPC_INIT, RepentanceBossChampions.SetClogData, 914)

function RepentanceBossChampions:CheckSinge(npc) -- check for singe champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.SINGE_BROWN then
		RepentanceBossChampions:BrownSingeAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.SINGE_GREEN then
		RepentanceBossChampions:GreenSingeAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckSinge, 915)

function RepentanceBossChampions:CheckHornfel(npc) -- check for hornfel champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.HORNFEL_BLACK then
		RepentanceBossChampions:BlackHornfelAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.HORNFEL_ORANGE then
		RepentanceBossChampions:OrangeHornfelAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckHornfel, 906)

function RepentanceBossChampions:CheckPlum(npc) -- check for plum champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.BABY_PLUM_GREY then
		RepentanceBossChampions:GreyPlumAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.BABY_PLUM_YELLOW then
		RepentanceBossChampions:YellowPlumAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckPlum, 908)

function RepentanceBossChampions:CheckMinMin(npc) -- check for min-min champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.MIN_MIN_PURPLE then
		RepentanceBossChampions:PurpleMinMinAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.MIN_MIN_RED then
		RepentanceBossChampions:RedMinMinAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckMinMin, 913)

function RepentanceBossChampions:CheckBumbino(npc) -- check for bumbino champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.BUMBINO_GREY then
		RepentanceBossChampions:GreyBumbinoAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.BUMBINO_GREEN then
		RepentanceBossChampions:GreenBumbinoAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckBumbino, 916)

function RepentanceBossChampions:CheckColostomia(npc) -- check for colostomia champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.COLOSTOMIA_RED then
		RepentanceBossChampions:RedColostomiaAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.COLOSTOMIA_YELLOW then
		RepentanceBossChampions:YellowColostomiaAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckColostomia, 917)

function RepentanceBossChampions:CheckTurdlet(npc) -- check for turdlet champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.TURDLET_BLUE then
		RepentanceBossChampions:BlueTurdletAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.TURDLET_BLACK then
		RepentanceBossChampions:BlackTurdletAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckTurdlet, 918)

function RepentanceBossChampions:SetTurdletTimer(npc) -- set timer for blue turdlet on init
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.TURDLET_BLUE then
		npc:GetData().FlyTimer = math.random(0,500)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.TURDLET_BLACK then
		npc:GetData().ShotTimer = 10
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_NPC_INIT, RepentanceBossChampions.SetTurdletTimer, 918)

function RepentanceBossChampions:CheckHornyBoys(npc) -- check for horny boys champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.THE_HORNY_BOYS_PINK then
		RepentanceBossChampions:PinkHornyBoysAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.THE_HORNY_BOYS_GREEN then
		RepentanceBossChampions:GreenHornyBoysAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckHornyBoys, 920)

function RepentanceBossChampions:CheckClutch(npc) -- check for clutch champions
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.CLUTCH_ORANGE then
		RepentanceBossChampions:OrangeClutchAI(npc)
	elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.CLUTCH_BLACK then
		RepentanceBossChampions:BlackClutchAI(npc)
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckClutch, 921)

function RepentanceBossChampions:CheckClicketyClack(npc) -- clickety clack check for clutch champions
	if npc.FrameCount == 0 then
		for _, clutch in pairs(Isaac.FindByType(921,0,-1)) do -- check for Clutch
			local bossColorIdx = clutch:ToNPC():GetBossColorIdx()
			if bossColorIdx == RepentanceBossChampions.BossColorIdx.CLUTCH_ORANGE then
				npc:Morph(npc.Type, 10, npc.SubType, -1)
				print("Morphed clickety clack")
			elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.CLUTCH_BLACK then
				npc:Morph(npc.Type, 20, npc.SubType, -1)
				print("Morphed clickety clack")
			end
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckClicketyClack, EntityType.ENTITY_CLICKETY_CLACK)

-------------------------------------------------------
-- Boss death routines
-------------------------------------------------------
function RepentanceBossChampions:PlumDeath(npc)
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.BABY_PLUM_GREY then
		for _, splatter in pairs(Isaac.FindByType(1000,77,-1)) do -- remove the blood splatter
			if splatter.SpawnerType == EntityType.ENTITY_BABY_PLUM then
				splatter:Remove()
			end
		end
		Isaac.Explode(npc.Position, npc, 1.5)
	end
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.BABY_PLUM_YELLOW then
		for _, redProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,-1,-1)) do -- recolor the blood shots
			if redProj.SpawnerType == EntityType.ENTITY_BABY_PLUM then
				local piss = Color(1,1,1,1,0,0,0)
				piss:SetColorize(3, 2.5, 0.4, 1)
				redProj.Color = piss
			end
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, RepentanceBossChampions.PlumDeath, 908)

function RepentanceBossChampions:LilBlubDeath(npc)
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.LIL_BLUB_BLUE or bossColorIdx == RepentanceBossChampions.BossColorIdx.LIL_BLUB_GREEN then
		for _, smallLeech in pairs(Isaac.FindByType(EntityType.ENTITY_SMALL_LEECH,-1,-1)) do -- remove small leeches
			if smallLeech.SpawnerType == EntityType.ENTITY_LIL_BLUB then
				smallLeech:Remove()
			end
		end
	end
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.LIL_BLUB_BLUE then
		for i = 1, math.random(3,5) do
			local velocity = Vector(RepentanceBossChampions.choose(math.random(-7, -3), math.random(3, 7)), RepentanceBossChampions.choose(math.random(-7, -3), math.random(3, 7))):Rotated(math.random(-30*i, 30*i)) * 12
			local spider = EntityNPC.ThrowSpider(npc.Position, npc, npc.Position+velocity, false, 1.0)
			spider:ToNPC():Morph(814, 0, 0, -1)
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, RepentanceBossChampions.LilBlubDeath, 901)

function RepentanceBossChampions:BumbinoDeath(npc)
	local bossColorIdx = npc:GetBossColorIdx()
	local data = npc:GetData()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.BUMBINO_GREEN then
		for i=1, math.random(6, 9) do
			data.FlyType = RepentanceBossChampions.choose(18,18,80,256,256,868)
			local fly = Game():Spawn(data.FlyType, 0, npc.Position, Vector.FromAngle(math.random(0, 360)):Resized(1), npc, 0, 1):ToNPC()
			fly:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, RepentanceBossChampions.BumbinoDeath, 916)

function RepentanceBossChampions:ClutchDeath(npc)
	local bossColorIdx = npc:GetBossColorIdx()
	local OrangeColor = Color(1,1,1,0.5,0,0,0)
	OrangeColor:SetColorize(3, 1.5, 0, 1)
	local BlackColor = Color(0,0,0,0.5,0,0,0)
	BlackColor:SetColorize(0.25,0.25, 0.25, 1)
	for _, ghost in pairs(Isaac.FindByType(1000,144,3)) do
		if bossColorIdx == RepentanceBossChampions.BossColorIdx.CLUTCH_ORANGE then
			ghost.SubType = 1
			ghost.Color = Color(1,0,0,0.5,0,0,0)
		elseif bossColorIdx == RepentanceBossChampions.BossColorIdx.CLUTCH_BLACK then
			ghost.SubType = 2
			ghost.Color = BlackColor
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, RepentanceBossChampions.ClutchDeath, 921)

function RepentanceBossChampions:HereticDeath(npc)
	local bossColorIdx = npc:GetBossColorIdx()
	if bossColorIdx == RepentanceBossChampions.BossColorIdx.THE_HERETIC_RED then
		for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT,147,1)) do
			ent:GetSprite().Color = Color(1,0,0,1,0,0,0)
		end
		for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT,148,1)) do
			ent:GetSprite().Color = Color(1,0,0,1,0,0,0)
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, RepentanceBossChampions.HereticDeath, 905)

-------------------------------------------------------
-- Custom projectile behaviors
-------------------------------------------------------
function RepentanceBossChampions:HaemolacriaShot(proj)
	local room = game:GetRoom()
    local projdata = proj:GetData()
    if projdata.Haemolacria == true then
		local trail = Isaac.Spawn(1000, EffectVariant.HAEMO_TRAIL, 0, Vector(proj.Position.X, proj.Position.Y + proj.Height), Vector(0,0), proj):ToEffect()
		trail.Scale = 1.25
		trail:GetSprite().Color = Color(1.25,0, 0, 1, 0, 0, 0)
		if proj:IsDead() or not proj:Exists() then
			for i=1, math.random(4,7) do
				local velocity = Vector(RepentanceBossChampions.choose(math.random(-6, -1), math.random(1, 6)), RepentanceBossChampions.choose(math.random(-6, -1), math.random(1, 6))):Rotated(math.random(-30*i, 30*i))
				local proj = Isaac.Spawn(9, 0, 0, proj.Position, velocity, proj):ToProjectile()
				proj.FallingSpeed = math.random(-22, -12)
				proj.FallingAccel = 1.15
				proj.Scale = math.random(5,15) / 10
            end
			Isaac.Spawn(1000, 2, 3, proj.Position, Vector(0,0), proj).DepthOffset = 40
            Game():ShakeScreen(5)
			SFXManager():Play(SoundEffect.SOUND_PLOP , 1.2, 0, false, (math.random(9,10) / 10) )
			SFXManager():Play(SoundEffect.SOUND_MEAT_IMPACTS, 1.2, 0, false, 1)
			local RedCreep = Isaac.Spawn(1000, EffectVariant.CREEP_RED, 0, proj.Position, Vector(0,0), proj) -- spawn red creep
			if room:GetBackdropType() == BackdropType.DROSS then
				RedCreep.Color = Color(1.8,1.8,1.8,1,0,0,0)
			end
			if projdata.HaemolacriaBig == true then
				RedCreep.SpriteScale = Vector(1.5,1.5)
			else
				RedCreep.SpriteScale = Vector(1,1)
			end
			RedCreep:ToEffect().Timeout = 120
			RedCreep:Update()
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, RepentanceBossChampions.HaemolacriaShot)

function RepentanceBossChampions:BlueHaemolacriaShot(proj)
	local room = game:GetRoom()
    local projdata = proj:GetData()
    if projdata.BlueHaemolacria == true then
		local trail = Isaac.Spawn(1000, EffectVariant.HAEMO_TRAIL, 0, Vector(proj.Position.X, proj.Position.Y + proj.Height), Vector(0,0), proj):ToEffect()
		trail.Scale = 0.7
		local color = Color(1,1,1, 1, 0, 0, 0)
		color:SetColorize(5,7,8, 1)
		trail:GetSprite().Color = color
		if proj:IsDead() or not proj:Exists() then
			for i=1, math.random(3,6) do
				local velocity = Vector(RepentanceBossChampions.choose(math.random(-5, -1), math.random(1, 5)), RepentanceBossChampions.choose(math.random(-5, -1), math.random(1, 5))):Rotated(math.random(-30*i, 30*i))
				local proj = Isaac.Spawn(9, 4, 0, proj.Position, velocity, proj):ToProjectile()
				proj.FallingSpeed = math.random(-22, -12)
				proj.FallingAccel = 1.15
				proj.Scale = math.random(5,15) / 10
            end
            Game():ShakeScreen(5)
			SFXManager():Play(SoundEffect.SOUND_PLOP , 1.2, 0, false, (math.random(9,10) / 10) )
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, RepentanceBossChampions.BlueHaemolacriaShot)

function RepentanceBossChampions:FireShot(proj)
    local projdata = proj:GetData()
	if projdata.FireShot ==  true then
		if projdata.SmallFireShot == true then
			local trail = Isaac.Spawn(1000, EffectVariant.HAEMO_TRAIL, 0, Vector(proj.Position.X, proj.Position.Y + proj.Height), Vector(0,0), proj):ToEffect()
			trail.SpriteScale = Vector(0.5, 0.5)
			trail:GetSprite().Color = Color(1, 1, 1, 0.5, 1, 0.7, 0)
		end
		if proj:IsDead() or not proj:Exists() then
			local fire = Isaac.Spawn(EntityType.ENTITY_FIREPLACE,10,0,proj.Position,Vector(0,0),proj)
			SFXManager():Play(SoundEffect.SOUND_CANDLE_LIGHT , 1.25, 0, false, 1)
			if projdata.SmallFireShot == true then
				Isaac.Spawn(1000,15,1, Vector(proj.Position.X, proj.Position.Y - 6), Vector(0,0), proj).Color = Color(2,1.15,0,0.7,0,0,0)
				fire.HitPoints = 2
			end
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, RepentanceBossChampions.FireShot)

function RepentanceBossChampions:RedCreepShot(proj)
    local projdata = proj:GetData()
    if projdata.RedCreep == true then
		if proj:IsDead() or not proj:Exists() then
			local RedCreep = Isaac.Spawn(1000, EffectVariant.CREEP_RED, 0, proj.Position, Vector(0,0), proj) -- spawn red creep
			RedCreep.SpriteScale = Vector(1.5,1.5)
			RedCreep:ToEffect().Timeout = 200
			RedCreep:Update()
			for i = 1, 6 do -- organized ring of shots
				local proj = Isaac.Spawn(9, 0, 0, proj.Position, (Vector.FromAngle(i*60):Resized(9)), proj):ToProjectile() -- spawn projectile
			end
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, RepentanceBossChampions.RedCreepShot)

function RepentanceBossChampions:GreenCreepShot(proj)
    local projdata = proj:GetData()
	local room = game:GetRoom()
    if projdata.GreenCreep == true then
		if proj:IsDead() or not proj:Exists() then
			local GreenCreep = Isaac.Spawn(1000, EffectVariant.CREEP_GREEN, 0, proj.Position, Vector(0,0), proj) -- spawn green creep
			if room:GetBackdropType() == BackdropType.DROSS or room:GetBackdropType() == BackdropType.DOWNPOUR then
				GreenCreep:GetSprite().Color = Color(1.85,1.85,1.85,1,0,0,0)
			end
			GreenCreep.SpriteScale = Vector(2.5,2.5)
			GreenCreep:ToEffect().Timeout = 150
			GreenCreep:Update()
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, RepentanceBossChampions.GreenCreepShot)

function RepentanceBossChampions:SmallIpecacShot(proj)
    local projdata = proj:GetData()
    if projdata.SmallIpecac == true then
		if proj:IsDead() or not proj:Exists() then
			local GreenCreep = Isaac.Spawn(1000, EffectVariant.CREEP_GREEN, 0, proj.Position, Vector(0,0), proj) -- spawn green creep
			GreenCreep.SpriteScale = Vector(0.5,0.5)
			GreenCreep:ToEffect().Timeout = 250
			GreenCreep:Update()
			local color = Color(1,1,1,1,0,0,0)
			color:SetColorize(0,2,0,1)
			Game():BombExplosionEffects(proj.Position, 1, 0, color, proj, 0.6, false, true)
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, RepentanceBossChampions.SmallIpecacShot)

-------------------------------------------------------
-- Bomb routines
-------------------------------------------------------
function RepentanceBossChampions:OrangeHornfelBomb(bomb)
	if bomb:GetData().OrangeHornfelNormalBomb == true then
		bomb:Remove()
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, RepentanceBossChampions.OrangeHornfelBomb, 0)

function RepentanceBossChampions:BobsCurseBomb(bomb)
	if bomb:GetData().BobsCurse == true then
		if bomb:IsDead() or not bomb:Exists() then
			local cloud = Isaac.Spawn(1000, 141, 0, bomb.Position, Vector(0,0), bomb) -- spawn poison gas cloud
			cloud:ToEffect().Timeout = 250
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, RepentanceBossChampions.BobsCurseBomb, BombVariant.BOMB_POISON)

function RepentanceBossChampions:BloodBomb(bomb)
	if bomb:GetData().BloodBomb == true then
		if bomb:IsDead() or not bomb:Exists() then
			local RedCreep = Isaac.Spawn(1000, EffectVariant.CREEP_RED, 0, bomb.Position, Vector(0,0), bomb) -- spawn creep
			RedCreep.SpriteScale = Vector(2.5,2.5)
			RedCreep:ToEffect().Timeout = 200
			RedCreep:Update()
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, RepentanceBossChampions.BloodBomb, 15)

--------------------------------------------------------
-- Function to apply fear from projectile (doesn't work)
--------------------------------------------------------
function RepentanceBossChampions:FearShotColl(proj, player, mysteryBool)
    local projdata = proj:GetData()
	if projdata.Fear then
		for i = 1,Game():GetNumPlayers() do
			local player = Isaac.GetPlayer(i-1)
			player:ClearEntityFlags(EntityFlag.FLAG_FEAR)
			player.Color = Color(1,1,1,1,0,0,0)
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_PRE_PROJECTILE_COLLISION, RepentanceBossChampions.FearShotColl)

-------------------------------------------------------
-- Purple fire for Purple Heretic fight
-------------------------------------------------------
function RepentanceBossChampions:CheckPurpleFire(npc)
	if npc.Variant ~= 3 then return end
	for _, heretic in pairs(Isaac.FindByType(905,0,-1)) do -- check for heretic
		local bossColorIdx = heretic:ToNPC():GetBossColorIdx()
		if bossColorIdx == RepentanceBossChampions.BossColorIdx.THE_HERETIC_PURPLE then
			RepentanceBossChampions:PurpleFireHereticAI(npc)
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.CheckPurpleFire, 33)

function RepentanceBossChampions:PurpleFireHereticAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	for _, heretic in pairs(Isaac.FindByType(905,0,-1)) do -- check for heretic
		if heretic:GetData().PurpleFire == true then
			if sprite:GetFrame() == 3 or sprite:GetFrame() == 6 or sprite:GetFrame() == 9 then
				local velocity = (RepentanceBossChampions.vecToPos(target.Position, npc.Position)*8):Rotated(math.random(-10,10))
				local proj = Isaac.Spawn(9, 2, 0, npc.Position, velocity, npc):ToProjectile() -- spawn projectile
				local color = Color(1,1,1,1,0,0,0)
				color:SetColorize(1.25,1,2.25,1)
				proj.Color = color
				proj.Height = -6
				proj.FallingSpeed = 0
				proj.FallingAccel = -0.097
			elseif heretic:GetData().PurpleFire == false then
				data.Timer = 0
			end
		end
	end
end

-------------------------------------------------------
-- Clickety Clacks for Orange Champion Clutch
-------------------------------------------------------
--[[
function RepentanceBossChampions:OrangeClicketyClackAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	data.OrangeClicketyClack = true
	sprite:ReplaceSpritesheet(0,"gfx/monsters/repentance/clickety_clack_body_orange.png")
	sprite:ReplaceSpritesheet(1,"gfx/monsters/repentance/clickety_clack_orange.png")
	sprite:LoadGraphics()
	if npc.State == 5 then
		for _, boneProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,1,-1)) do -- remove the bone shots
			if boneProj.SpawnerType == EntityType.ENTITY_CLICKETY_CLACK then
				boneProj:Remove()
			end
		end
	end
	if sprite:IsPlaying("Transition") or sprite:IsPlaying("Burst") then
		if sprite:IsEventTriggered("Shoot") then
			for i = 1, 4 do
				local fire = Isaac.Spawn(EntityType.ENTITY_FIREPLACE,10,2,npc.Position,(Vector.FromAngle(i*90):Resized(10)),npc)
				fire.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
				fire.HitPoints = 4
			end
		end
	end
end

-------------------------------------------------------
-- Clickety Clacks for Black Champion Clutch
-------------------------------------------------------
function RepentanceBossChampions:BlackClicketyClackAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	data.BlackClicketyClack = true
	sprite:ReplaceSpritesheet(0,"gfx/monsters/repentance/clickety_clack_body_black.png")
	sprite:ReplaceSpritesheet(1,"gfx/monsters/repentance/clickety_clack_black.png")
	sprite:LoadGraphics()
	if npc.State == 16 then
		if sprite:IsPlaying("FlameCollapse") or sprite:IsPlaying("Collapse") then
			if sprite:GetFrame() == 1 then
				Isaac.Explode(npc.Position, npc, 1.0)
			end
		end
	end
end
]]--

-------------------------------------------------------
-- Grey Champion Baby Plum
-------------------------------------------------------
function RepentanceBossChampions:GreyPlumAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	if npc.State == 8 then -- twirl attack
		if sprite:IsEventTriggered("Shoot") then
			local velocity = Vector(RepentanceBossChampions.choose(math.random(-3, -1), math.random(1, 3)), RepentanceBossChampions.choose(math.random(-3, -1), math.random(1, 3))):Rotated(math.random(-30, 30))
			local b = Isaac.Spawn(4, 3, 0, npc.Position, velocity, npc):ToBomb()
			b.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
		end
	end
	if npc.State == 9 then -- ground pound attack
		if sprite:IsEventTriggered("Shoot") then
			for _, redCreep in pairs(Isaac.FindByType(1000,EffectVariant.CREEP_RED,-1)) do -- remove the red creep
				redCreep:Remove()
			end
			for _, redProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,-1,-1)) do -- remove the blood shots
				redProj:Remove()
			end
			data.PlumAngle = math.random(-90, 90) -- determine a random angle
			Isaac.Spawn(1000, 2, 3, npc.Position, Vector(0,0), npc).DepthOffset = 40 -- spawn blood splatter
			for i = 1, 4 do
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(i*90):Resized(7)):Rotated(data.PlumAngle), npc):ToProjectile() -- spawn projectile
				local projdata = proj:GetData()
				local params = ProjectileParams()
				projdata.Explode = true
				proj.Scale = 2
				proj.FallingSpeed = math.random(-14,-10)
                proj.FallingAccel = 0.75
				proj.Color = Color(1,1,1,1,1,0.5,0)
			end
		end
	end
	if npc.State == 10 then -- bubble blowing attack
		npc.Velocity = npc.Velocity * 0.99
		if sprite:IsPlaying("Attack3Loop") or sprite:IsPlaying("Attack3BackLoop") then
			if npc:CollidesWithGrid() then
				Isaac.Explode(npc.Position, npc, 1.0)
				Game():ShakeScreen(5)
				local fire = Isaac.Spawn(EntityType.ENTITY_FIREPLACE,10,0,npc.Position,Vector(0,0),npc)
				fire.HitPoints = math.random(3, 4)
			end
		end
	end
end

function RepentanceBossChampions:GreyPlumProj(proj) -- function to create explosive projectile
	if proj.SpawnerType == 908 then
		local projdata = proj:GetData()
		if projdata.Explode then
			if proj:IsDead() or not proj:Exists() then
				Isaac.Explode(proj.Position, npc, 1.0)
				local fire = Isaac.Spawn(EntityType.ENTITY_FIREPLACE,10,0,proj.Position,Vector(0,0),proj)
				fire.HitPoints = math.random(3, 4)
			end
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, RepentanceBossChampions.GreyPlumProj)

-------------------------------------------------------
-- Yellow Champion Baby Plum
-------------------------------------------------------
function RepentanceBossChampions:YellowPlumAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	if npc.State == 8 then -- twirl attack
		for _, redProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,-1,-1)) do -- recolor the blood shots
			if redProj.SpawnerType == EntityType.ENTITY_BABY_PLUM then
				local piss = Color(1,1,1,1,0,0,0)
				piss:SetColorize(3, 2.5, 0.4, 1)
				redProj.Color = piss
			end
		end
		if sprite:GetFrame() >= 7 then
			data.Chance = math.random(0,100)
			if data.Chance <= 25 then
				local YellowCreep = Isaac.Spawn(1000, EffectVariant.CREEP_YELLOW, 0, npc.Position, Vector(0,0), npc) -- spawn yellow creep
				YellowCreep.SpriteScale = Vector(1,1)
				YellowCreep:ToEffect().Timeout = 120
				YellowCreep:Update()
			end
		end
	end
	if npc.State == 9 then -- ground pound attack
		if sprite:IsEventTriggered("Shoot") then
			for _, redCreep in pairs(Isaac.FindByType(1000,EffectVariant.CREEP_RED,-1)) do -- remove the red creep
				if redCreep.SpawnerType == EntityType.ENTITY_BABY_PLUM then
					redCreep:Remove()
				end
			end
			for _, redProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,-1,-1)) do -- remove the blood shots
				if redProj.SpawnerType == EntityType.ENTITY_BABY_PLUM then
					redProj:Remove()
				end
			end
			local Splat = Isaac.Spawn(1000, 2, 3, npc.Position, Vector(0,0), npc) -- spawn blood splatter
			Splat.DepthOffset = 40
			local piss = Color(1,1,1,1,0,0,0)
			piss:SetColorize(4, 3.3, 0.7, 1)
			Splat.Color = piss
			local YellowCreep = Isaac.Spawn(1000, EffectVariant.CREEP_YELLOW, 0, npc.Position, Vector(0,0), npc):ToEffect() -- spawn yellow creep
			YellowCreep.SpriteScale = Vector(2.5,2.5)
			YellowCreep:ToEffect().Timeout = 200
			YellowCreep:Update()
			for i = 1, 16 do -- cluster of shots
				local velocity = RepentanceBossChampions.vecToPos(target.Position, npc.Position):Rotated(math.random(-20, 20)) * math.random(4,9)
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, velocity, npc):ToProjectile() -- spawn projectile
				proj.Scale = math.random(5,15) / 10
				proj.FallingSpeed = math.random(-24,-8)
				proj.FallingAccel = RepentanceBossChampions.choose(0.5,0.6,0.7,0.8,0.9)
				local piss = Color(1,1,1,1,0,0,0)
				piss:SetColorize(3, 2.5, 0.4, 1)
				proj.Color = piss
			end
			data.PlumAngle = math.random(-60, 60) -- determine a random angle
			for i = 1, 6 do -- organized ring of shots
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(i*60):Resized(8)), npc):ToProjectile() -- spawn projectile
				local piss = Color(1,1,1,1,0,0,0)
				piss:SetColorize(3, 2.5, 0.4, 1)
				proj.Color = piss
				proj.Scale = 1
			end
		end
	end
	if npc.State == 10 then -- bubble blowing attack
		for _, redProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,-1,-1)) do -- recolor the blood shots
			if redProj.SpawnerType == EntityType.ENTITY_BABY_PLUM then
				local piss = Color(1,1,1,1,0,0,0)
				piss:SetColorize(3, 2.5, 0.4, 1)
				redProj.Color = piss
			end
		end
		for _, redSplat in pairs(Isaac.FindByType(1000,7,-1)) do -- recolor the blood splatters
			if redSplat.SpawnerType == EntityType.ENTITY_BABY_PLUM then
				local piss = Color(1,1,1,1,0,0,0)
				piss:SetColorize(3, 2.5, 0.4, 1)
				redSplat.Color = piss
			end
		end
		if sprite:IsPlaying("Attack3Loop") or sprite:IsPlaying("Attack3BackLoop") then
			data.Chance = math.random(0,100)
			if data.Chance <= 10 then
				local YellowCreep = Isaac.Spawn(1000, EffectVariant.CREEP_YELLOW, 0, npc.Position, Vector(0,0), npc) -- spawn yellow creep
				YellowCreep.SpriteScale = Vector(0.75,0.75)
				YellowCreep:ToEffect().Timeout = 100
				YellowCreep:Update()
			end
			for _, effect in pairs(Isaac.FindByType(1000,79,-1)) do -- recolor the blood shots
				local piss = Color(1,1,1,0.2,0,0,0)
				piss:SetColorize(3, 3.5, 0.4, 1)
				effect.Color = piss
			end
		end
	end
end

-------------------------------------------------------
-- Red Champion Great Gideon
-------------------------------------------------------
function RepentanceBossChampions:RedGideonAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	local room = game:GetRoom()
	if room:IsClear() then
		for _, gideon in pairs(Isaac.FindByType(907,10,1)) do -- remove
			if gideon:GetSprite():IsPlaying("ClosedEyes") then
				gideon:ToNPC():Morph(907, 0, 1, -1)
			end
		end
	end
	if data.Timer == nil then
		data.Timer = 2
	end
	if npc.State == 6 or npc.State == 3 then -- fire barrage attack OR idle
		for _, fireProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,0,-1)) do -- remove
			if fireProj.SpawnerType == 907 then
				local projdata = fireProj:GetData()
				if not projdata.New == true then
					fireProj:Remove()
				end
			end
		end
		if sprite:IsPlaying("Attack2Loop") then
			data.Timer = data.Timer + 1
			data.Angle = 180
			if data.Timer >= 4 then
				npc:PlaySound(SoundEffect.SOUND_BLOODSHOOT, 1, 0, false, 1)
				data.Angle = data.Angle + 180
				for i = 1, 2 do
					local velocity = Vector.FromAngle(data.Angle+i*180):Resized(7)
					local proj = Isaac.Spawn(9, 0, 0, Vector(npc.Position.X, npc.Position.Y + math.random(30,530)), velocity, npc):ToProjectile()
					local projdata = proj:GetData()
					proj.Scale = RepentanceBossChampions.choose(1,1.25,1.5)
					proj.FallingSpeed = 0
					proj.FallingAccel = -0.05
					proj.Color = Color(1,1,1,1,0.35,0,0)
					projdata.New = true
					data.Timer = 0
					local Splat = Isaac.Spawn(1000,2,2, Vector(proj.Position.X, proj.Position.Y), Vector(0,0), proj)
					Splat.DepthOffset = 200
					Splat.Color = Color(1.5,1.5,1.5,0.75,0,0,0)
				end
			end
		end
	end
	if npc.State == 8 then -- projectile spread attack
		for _, proj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,0,-1)) do -- remove
			if proj.SpawnerType == 907 then
				local projdata = proj:GetData()
				if not projdata.New == true then
					proj:Remove()
				end
			end
		end
		if sprite:IsEventTriggered("Shoot") then
			for i = 1, 3 do
				local velocity = ((target.Position - npc.Position):Rotated(math.random(-1, 1)) * 0.025 * 12 * 0.1):Rotated(math.random(-50,50))
				local length = velocity:Length()
				if length > 12 then
					velocity = (velocity / length) * 12
				end
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, velocity, npc):ToProjectile()
				local projdata = proj:GetData()
				proj.FallingAccel = 0.8
				proj.FallingSpeed = math.random(-24, -16)
				proj.Scale = 2.5
				projdata.New = true
				projdata.Haemolacria = true
				projdata.HaemolacriaBig = true
			end
		end
	end
	if npc.State == 9 then -- fire barrage prep
		if sprite:GetFrame() == 1 then
			data.Angle = 180
			local tracer = Isaac.Spawn(1000, EffectVariant.GENERIC_TRACER, 0, npc.Position, Vector(0,0), npc):ToEffect()
			tracer.LifeSpan = 45
			tracer.Timeout = 45
			tracer.TargetPosition = Vector(0,1)
			local tracerColor = Color(2,0.3,0.3,0.2)
			tracer:SetColor(tracerColor, 110, 1, false, false)
			tracer.SpriteScale = Vector(4,6)
		end
		if sprite:GetFrame() == 50 then
			local brimstone = EntityLaser.ShootAngle(11, npc.Position, 90, 55, Vector(0,-30), npc)
			brimstone.DepthOffset = 200
		end
	end
end

-------------------------------------------------------
-- Green Champion Great Gideon
-------------------------------------------------------
function RepentanceBossChampions:GreenGideonAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	local room = game:GetRoom()
	if room:IsClear() then
		for _, gideon in pairs(Isaac.FindByType(907,20,1)) do -- remove
			if gideon:GetSprite():IsPlaying("ClosedEyes") then
				gideon:ToNPC():Morph(907, 0, 1, -1)
			end
		end
	end
	if npc.State == 6 or npc.State == 3 then -- fire barrage attack OR idle
		for _, fireProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,0,-1)) do -- remove
			if fireProj.SpawnerType == 907 then
				local projdata = fireProj:GetData()
				if not projdata.New == true then
					fireProj:Remove()
				end
			end
		end
		if sprite:IsPlaying("Attack2Loop") then
			local proj = Isaac.Spawn(9, 0, 0, Vector(npc.Position.X + math.random(-56,56), npc.Position.Y), Vector(0, 10), npc):ToProjectile()
			local projdata = proj:GetData()
			proj.FallingAccel = 1.5
			proj.FallingSpeed = math.random(-56,-1)
			proj.Scale = RepentanceBossChampions.choose(0.5,0.75,0.1)
			projdata.New = true
			projdata.SmallIpecac = true
			local color = Color(1,1,1,1,0,0,0)
			color:SetColorize(0,2,0,1)
			proj.Color = color
		end
	end
	if npc.State == 8 then -- projectile spread attack
		for _, proj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,0,-1)) do -- remove
			if proj.SpawnerType == 907 then
				local projdata = proj:GetData()
				if not projdata.New == true then
					proj:Remove()
				end
			end
		end
		if sprite:IsEventTriggered("Shoot") then
			local velocity = (target.Position - npc.Position):Rotated(math.random(-1, 1)) * 0.025 * 12 * 0.1
			local length = velocity:Length()
			if length > 12 then
				velocity = (velocity / length) * 12
			end
			local proj = Isaac.Spawn(9, 0, 0, npc.Position, velocity, npc):ToProjectile()
			local projdata = proj:GetData()
			proj.FallingAccel = 0.8
			proj.FallingSpeed = math.random(-24, -16)
			proj.Scale = 2
			proj.ProjectileFlags = ProjectileFlags.EXPLODE
			projdata.New = true
			projdata.GreenCreep = true
			local color = Color(1,1,1,1,0,0,0)
			color:SetColorize(0,2,0,1)
			proj.Color = color
			data.SmallFallingSpeed = math.random(-24, -16)
			for i=1, 2 do
				local smallvelocity = ((target.Position - npc.Position):Rotated(math.random(-1, 1)) * 0.025 * 12 * 0.1):Rotated(-48+i*32)
				local length = smallvelocity:Length()
				if length > 12 then
					smallvelocity = (smallvelocity / length) * 12
				end
				local smallproj = Isaac.Spawn(9,0,0, npc.Position,smallvelocity, npc):ToProjectile()
				local projdata = smallproj:GetData()
				smallproj.FallingAccel = 0.8
				smallproj.FallingSpeed = data.SmallFallingSpeed
				smallproj.Scale = 0.75
				projdata.New = true
				projdata.SmallIpecac = true
				local color = Color(1,1,1,1,0,0,0)
				color:SetColorize(0,2,0,1)
				smallproj.Color = color
			end
		end
	end
	if npc.State == 9 then -- fire barrage prep
		if sprite:GetFrame() >= 50 then
			local proj = Isaac.Spawn(9, 0, 0, Vector(npc.Position.X + math.random(-56,56), npc.Position.Y), Vector(0, 10), npc):ToProjectile()
			local projdata = proj:GetData()
			proj.FallingAccel = 1.5
			proj.FallingSpeed = math.random(-64,-4)
			proj.Scale = RepentanceBossChampions.choose(0.5,0.75,0.1)
			projdata.New = true
			projdata.SmallIpecac = true
			local color = Color(1,1,1,1,0,0,0)
			color:SetColorize(0,2,0,1)
			proj.Color = color
		end
	end
	if npc.State == 11 then -- suction prep
		print("Changed state")
		SFXManager():Stop(SoundEffect.SOUND_MONSTER_ROAR_3)
		npc:PlaySound(SoundEffect.SOUND_LOW_INHALE , 1, 0, false, 0.9)
		sprite:Play("Attack1")
		npc.State = 8
	end
end

-------------------------------------------------------
-- Black Champion The Pile
-------------------------------------------------------
function RepentanceBossChampions:BlackPileAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	if npc.State == 6 then -- burrow into ground
		if sprite:IsPlaying("GoUnder") then
			if sprite:GetFrame() == 4 then -- spawn troll bomb on frame 4
				local velocity = Vector(RepentanceBossChampions.choose(math.random(-3, -1), math.random(1, 3)), RepentanceBossChampions.choose(math.random(-3, -1), math.random(1, 3))):Rotated(math.random(-30, 30))
				local b = Isaac.Spawn(4, 3, 0, npc.Position, velocity, npc):ToBomb()
				b.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
			end
		end
	end
	if npc.State == 8 then -- emerged bone shot attack
		if sprite:IsEventTriggered("Shoot") then
			data.ShotAngle = math.random(0,36)
			for _, boneProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,1,-1)) do -- remove the bone shots
				if boneProj.SpawnerType == EntityType.ENTITY_POLYCEPHALUS then
					boneProj:Remove()
				end
			end
			for i = 1, 10 do -- organized ring of shots
				local proj = Isaac.Spawn(9, 1, 0, npc.Position, (Vector.FromAngle(i*36):Resized(10)):Rotated(data.ShotAngle), npc):ToProjectile() -- spawn projectile
				proj.Color = Color(0.35,0.35,0.35,1,0,0,0)
			end
		end
	end
	if npc.State == 9 then -- dash atack
		if sprite:IsEventTriggered("StartCharge") then
			local velocity = Vector(RepentanceBossChampions.choose(math.random(-3, -1), math.random(1, 3)), RepentanceBossChampions.choose(math.random(-3, -1), math.random(1, 3))):Rotated(math.random(-30, 30))
			local b = Isaac.Spawn(4, 3, 0, npc.Position, velocity, npc):ToBomb()
			b.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
		end
		for _, boneProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,1,-1)) do -- recolor the bone shots
			if boneProj.SpawnerType == EntityType.ENTITY_POLYCEPHALUS then
				boneProj.Color = Color(0.35,0.35,0.35,1,0,0,0)
			end
		end
	end
	if npc.State == 13 then -- bony summoning attack
		if sprite:IsEventTriggered("Shoot") then
			for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_BONY,-1,-1)) do
				if ent.SpawnerType == EntityType.ENTITY_POLYCEPHALUS then
					ent:Remove()
				end
			end
		Isaac.Spawn(EntityType.ENTITY_BLACK_BONY, 1, 0, npc.Position, npc.Velocity, npc)
		end
	end
end

-------------------------------------------------------
-- Pink Champion The Pile
-------------------------------------------------------
function RepentanceBossChampions:PinkPileAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	data.ShotCount = 0
	local summonCount = entCount(25,4)
	npc.Velocity = npc.Velocity * 0.9
	if npc.State == 3 then -- movement
		npc.Velocity = npc.Velocity * 1.1
	end
	if npc.State == 8 then -- emerged bone shot attack
		if sprite:IsEventTriggered("Shoot") then
			for _, boneProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,1,-1)) do -- remove the bone shots
				if boneProj.SpawnerType == EntityType.ENTITY_POLYCEPHALUS then
					boneProj:Remove()
				end
			end
			local params = ProjectileParams()
			params.Variant = 1
			npc:FireProjectiles(Vector(npc.Position.X, npc.Position.Y),RepentanceBossChampions.vecToPos(target.Position, npc.Position)*12, 0, params)
		end
		if sprite:IsEventTriggered("ShootAlt") then
			local params = ProjectileParams()
			params.Variant = 1
			npc:FireProjectiles(Vector(npc.Position.X, npc.Position.Y),RepentanceBossChampions.vecToPos(target.Position, npc.Position)*12, 0, params)
			npc:PlaySound(SoundEffect.SOUND_GHOST_SHOOT , 1, 0, false, 1)
		end
	end
	if npc.State == 13 then -- bony summoning attack
		if sprite:IsEventTriggered("Shoot") then
			for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_BONY,-1,-1)) do
				if ent.SpawnerType == EntityType.ENTITY_POLYCEPHALUS then
					ent:Remove()
				end
			end
		Isaac.Spawn(EntityType.ENTITY_BOOMFLY, 4, 0, npc.Position, npc.Velocity, npc)
		end
	end
	if npc.State == 14 then -- spikes attack
		SFXManager():Stop(SoundEffect.SOUND_GRROOWL)
		npc.State = 13
	end
end

-------------------------------------------------------
-- Blue Champion Lil Blub
-------------------------------------------------------
function RepentanceBossChampions:BlueLilBlubAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local room = game:GetRoom()
	local striderCount = entCount(814,0)
	npc.Velocity = npc.Velocity * 0.9
	if striderCount >= 6 then -- if there are 6 striders, attacks are no longer possible
		npc.State = 3
	end
	if npc.State == 8 then -- spawn small leeches
		for _, smallLeech in pairs(Isaac.FindByType(EntityType.ENTITY_SMALL_LEECH,-1,-1)) do -- remove small leeches
			if smallLeech.SpawnerType == EntityType.ENTITY_LIL_BLUB then
				smallLeech:Remove()
			end
		end
		if sprite:IsEventTriggered("Shoot") then -- spawn striders
			for i = 1, RepentanceBossChampions.choose(1,1,1,2) do
				local spider = EntityNPC.ThrowSpider(npc.Position, npc, room:FindFreePickupSpawnPosition(npc.Position, 20, true, true), false, 1.0)
				spider:ToNPC():Morph(814, 0, 0, -1)
			end
		end
	end
	if npc.State == 9 then -- if tries to spawn a big leech, go to tear shot attack
		npc.State = 10
	end
	if npc.State == 11 then -- if tries to jump, go to tear shot attack
		npc.State = 10
	end
end

-------------------------------------------------------
-- Green Champion Lil Blub
-------------------------------------------------------
function RepentanceBossChampions:GreenLilBlubAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	local room = game:GetRoom()
	if room:GetBackdropType() == BackdropType.DROSS then
		data.projVariant = 3
		data.DrossColor = true
	else
		data.projVariant = 4
	end
	npc.Velocity = npc.Velocity * 1.1
	if npc.State == 8 then -- spawn small leeches
		data.PissTimer = 0
		for _, smallLeech in pairs(Isaac.FindByType(EntityType.ENTITY_SMALL_LEECH,-1,-1)) do -- remove small leeches
			if smallLeech.SpawnerType == EntityType.ENTITY_LIL_BLUB then
				smallLeech:Remove()
			end
		end
		if sprite:IsEventTriggered("Shoot") then -- spawn striders
			data.ShotAngle = math.random(0,36)
			for i = 1, 10 do
				local proj = Isaac.Spawn(9, data.projVariant, 0, npc.Position, (Vector.FromAngle(i*36):Resized(8)):Rotated(data.ShotAngle), npc):ToProjectile() -- spawn projectile
				local projdata = proj:GetData()
				projdata.New = true
				proj.FallingSpeed = 0
				proj.FallingAccel = -0.08
			end
		end
	end
	if npc.State == 9 then -- spawn big leech
		if sprite:GetFrame() == 1 then
			data.NextState = RepentanceBossChampions.choose(9,9,10)
			if data.NextState == 10 then
				sprite:Play("Attack3")
				npc.State = 10
			end
		end
		for _, smallLeech in pairs(Isaac.FindByType(EntityType.ENTITY_SMALL_LEECH,-1,-1)) do -- remove small leeches
			if smallLeech.SpawnerType == EntityType.ENTITY_LIL_BLUB then
				smallLeech:Remove()
			end
		end
		if sprite:IsEventTriggered("Shoot") then -- shoot big projectiles
			for i = 1, 5 do
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, (RepentanceBossChampions.vecToPos(target.Position, npc.Position) * 9):Rotated(i*72), npc):ToProjectile() -- spawn projectile
				local color = Color(1,1,1,1,0,0,0)
				color:SetColorize(0.4, 1.6, 0.4, 1)
				proj.Color = color
				local projdata = proj:GetData()
				projdata.GreenCreep = true
				projdata.New = true
				proj.FallingSpeed = 0
				proj.FallingAccel = -0.08
				proj.Scale = 2
			end
		end
	end
	if npc.State == 10 then -- tear shot attack
		for _, proj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,data.projVariant,-1)) do -- remove projectiles
			if proj.SpawnerType == EntityType.ENTITY_LIL_BLUB then
				local projdata = proj:GetData()
				if not projdata.New == true then
					proj:Remove()
				end
			end
		end
		if sprite:GetFrame() == 16 then
			local color = Color(1, 1, 1, 1, 0, 0, 0)
            local effect = Isaac.Spawn(1000, 16, 3, npc.Position, Vector.Zero, npc):ToEffect()
            color:SetColorize(0.4, 1.6, 0.4, 1)
            effect:GetSprite().Color = color
			npc:PlaySound(SoundEffect.SOUND_SINK_DRAIN_GURGLE, 1, 0, false, 1)
			local GreenCreep = Isaac.Spawn(1000, EffectVariant.CREEP_GREEN, 0, npc.Position, Vector(0,0), npc) -- spawn green creep
			GreenCreep:GetSprite().Color = Color(1.85,1.85,1.85,1,0,0,0)
			GreenCreep.SpriteScale = Vector(1.5,1.5)
			GreenCreep:ToEffect().Timeout = 250
			GreenCreep:Update()
		end
	end
	if npc.State == 11 then -- jump attack
		if sprite:IsEventTriggered("Land") then
			local GreenCreep = Isaac.Spawn(1000, EffectVariant.CREEP_GREEN, 0, npc.Position, Vector(0,0), npc) -- spawn green creep
			GreenCreep:GetSprite().Color = Color(1.85,1.85,1.85,1,0,0,0)
			GreenCreep.SpriteScale = Vector(1.5,1.5)
			GreenCreep:ToEffect().Timeout = 200
			GreenCreep:Update()
		end
	end
end

-------------------------------------------------------
-- Blue Champion Rainmaker
-------------------------------------------------------
function RepentanceBossChampions:BlueRainmakerAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	if npc.State == 9 then -- piroutette
		data.NextState = RepentanceBossChampions.choose(8, 10)
		if data.NextState == 8 then
			sprite:Play("Attack1")
			npc.State = 8
		elseif data.NextState == 10 then
			sprite:Play("Attack3")
			npc.State = 10
		end
	end
	if npc.State == 10 then -- bubble burst
		if sprite:IsPlaying("Attack3") then
			if sprite:GetFrame() == 50 then
				for _, proj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,4,-1)) do -- remove the tears
					if proj.SpawnerType == 902 then
						local projdata = proj:GetData()
						if not projdata.BlueHaemolacria == true then
							proj:Remove()
						end
					end
				end
				data.ShotAngle = math.random(0,120)
				for i = 1, 3 do
					velocity = (Vector.FromAngle(data.ShotAngle+i*120):Resized(5))
					local proj = Isaac.Spawn(9, 4, 0, npc.Position, velocity, npc):ToProjectile() -- spawn projectile
					local projdata = proj:GetData()
					projdata.BlueHaemolacria = true
					proj.Height = -80
					proj.FallingSpeed = math.random(-20,-12)
					proj.FallingAccel = 1.05
					proj.Scale = 2.5
				end
			end
		end
	end
end

-------------------------------------------------------
-- Purple Champion Min-Min
-------------------------------------------------------
function RepentanceBossChampions:PurpleMinMinAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()

	for _, effect in pairs(Isaac.FindByType(1000,157,-1)) do
		local color = Color(1,1,1,1,0,0,0)
		color:SetColorize(1.15,0.6,2,1)
		effect.Color = color
	end
	if npc.State == 6 then -- dive into water and spawn willos
		for _, willo in pairs(Isaac.FindByType(EntityType.ENTITY_WILLO,0,1)) do
			if willo.SpawnerType == EntityType.ENTITY_MIN_MIN then
				willo:ToNPC():Morph(808, 32, 1, -1)
				willo:ToNPC().State = 7
			end
		end

	end
	if npc.State ==	13 then -- willo spit
		for _, willo in pairs(Isaac.FindByType(EntityType.ENTITY_WILLO,0,0)) do
			if willo.SpawnerType == EntityType.ENTITY_MIN_MIN then
				willo:ToNPC():Morph(808, 32, 0, -1)
				willo:ToNPC().State = 9
				willo:GetSprite():Play("Attack")
				if willo:GetSprite():IsFinished("Attack") then
					willo:ToNPC().State = 3
				end
			end
		end
	end
	if npc.State == 14 then -- willo summon from ground attack
		for _, willo in pairs(Isaac.FindByType(EntityType.ENTITY_WILLO,0,0)) do
			if willo.SpawnerType == EntityType.ENTITY_MIN_MIN then
				willo:ToNPC():Morph(808, 32, 0, -1)
			end
		end
	end
	if npc.State == 16 then -- phase 2 transition
		if sprite:IsEventTriggered("Shoot") then
			for _, effect in pairs(Isaac.FindByType(1000,16,-1)) do
				local color = Color(1,1,1,1,0,0,0)
				color:SetColorize(3.5,1,4.8,1)
				effect.Color = color
			end
			data.ShotAngle = math.random(0,119)
			for i = 1, 3 do
				Isaac.Spawn(EntityType.ENTITY_FIREPLACE,13,0,npc.Position,Vector.FromAngle(data.ShotAngle+i*120):Resized(6),npc)
			end
		end
	end
	if npc:IsDead() then
		for _, fire in pairs(Isaac.FindByType(EntityType.ENTITY_FIREPLACE,13,0)) do
			fire:Kill()
			Isaac.Spawn(1000,15,0, fire.Position, Vector(0,0), fire).Color = Color(2,1,2,1,0,0,0)
		end
	end
end

function RepentanceBossChampions:PurpleWilloAI(npc, dmgAmount, flags, source, frames)
	local sprite = npc:GetSprite()
	if npc.Variant == 32 then
		sprite:ReplaceSpritesheet(0, "gfx/monsters/repentance/willo_purple.png")
		sprite:ReplaceSpritesheet(1, "gfx/monsters/repentance/willo_purple.png")
		sprite:LoadGraphics()
		local color = Color(1,1,1,1,0,0,0)
		color:SetColorize(1.3,0.5,1.5,1)
		npc.SplatColor = color
		for _, proj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,-1,0)) do
			if proj.SpawnerType == EntityType.ENTITY_WILLO then
				proj:ToProjectile().ProjectileFlags = ProjectileFlags.SMART
			end
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.PurpleWilloAI, 808)

-------------------------------------------------------
-- Red Champion Min-Min
-------------------------------------------------------
function RepentanceBossChampions:RedMinMinAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	if data.Angle == nil then data.Angle = 0 end
	if data.Rotation == nil then data.Rotation = 0 end
	for _, willo in pairs(Isaac.FindByType(EntityType.ENTITY_WILLO,-1,-1)) do
		if willo.SpawnerType == EntityType.ENTITY_MIN_MIN then
			willo:Remove()
		end
	end
	if npc.State == 8 then -- twirl
		if sprite:IsPlaying("Spin") or sprite:IsPlaying("SpinReverse") or sprite:IsPlaying("Spin2") then
			if sprite:GetFrame() == 19 then
				data.Rotation = 0
				data.Angle = math.random(0,90)
				local Splat = Isaac.Spawn(1000, 2, 5, Vector(npc.Position.X, npc.Position.Y - 30), Vector(0,0), npc)
				Splat.DepthOffset = 40
				Splat.Color = Color(1.4,1.4,1.4,0.7,0,0,0)
				for i = 1, 4 do -- rings of shots
					local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(i*90):Resized(9)):Rotated(data.Angle), npc):ToProjectile() -- spawn projectile
					proj.Color = Color(1,1,1,1,0.3,0,0)
					proj.Height = -34
					proj.Scale = RepentanceBossChampions.choose(0.5,1,1.5)
				end
			end
			if sprite:GetFrame() == 21 or sprite:GetFrame() == 23 or sprite:GetFrame() == 25 or sprite:GetFrame() == 27 then
				if sprite:IsPlaying("SpinReverse") then
					data.Rotation = data.Rotation + 15
				elseif sprite:IsPlaying("Spin") or sprite:IsPlaying("Spin2") then
					data.Rotation = data.Rotation - 15
				end
				npc:PlaySound(SoundEffect.SOUND_BLOODSHOOT, 1.1, 0, false, 1.05)
				for i = 1, 4 do -- rings of shots
					local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(i*90):Resized(9)):Rotated(data.Angle + data.Rotation), npc):ToProjectile() -- spawn projectile
					proj.Color = Color(1,1,1,1,0.3,0,0)
					proj.Height = -34
					proj.Scale = RepentanceBossChampions.choose(0.5,1,1.5)
				end
			end
		end
	end
	if npc.State == 9 then -- boomerang
		if sprite:GetFrame() == 14 or sprite:GetFrame() == 16 or sprite:GetFrame() == 18 or sprite:GetFrame() == 20 or sprite:GetFrame() == 22 or sprite:GetFrame() == 24 or sprite:GetFrame() == 26 then
			npc:PlaySound(SoundEffect.SOUND_BLOODSHOOT, 1.1, 0, false, 1.05)
			local Splat = Isaac.Spawn(1000, 2, 5, Vector(npc.Position.X, npc.Position.Y - 30), Vector(0,0), npc)
			Splat.DepthOffset = 40
			Splat.SpriteRotation = math.random(0,360)
			Splat.Color = Color(1.4,1.4,1.4,0.7,0,0,0)
			local proj = Isaac.Spawn(9,0,0, npc.Position, (RepentanceBossChampions.vecToPos(target.Position, npc.Position) * math.random(11,13)):Rotated(math.random(-10,10)), npc):ToProjectile()
			proj.Color = Color(1,1,1,1,0.3,0,0)
			proj.Height = -34
			proj.Scale = RepentanceBossChampions.choose(0.5,1,1.5)
		end
	end
	if npc.State == 13 then -- willo spit
		if sprite:IsEventTriggered("Shoot") then
			local Splat = Isaac.Spawn(1000, 2, 5, Vector(npc.Position.X, npc.Position.Y - 30), Vector(0,0), npc)
			Splat.DepthOffset = 40
			Splat.Color = Color(1.4,1.4,1.4,0.7,0,0,0)
			local proj = Isaac.Spawn(9,0,0, npc.Position, RepentanceBossChampions.vecToPos(target.Position, npc.Position) * 14, npc):ToProjectile()
			proj.Scale = 2
			proj.Color = Color(1,1,1,1,0.3,0,0)
			proj.Height = -34
		end
	end
	if npc.State == 14 then -- prep for twirl
		if sprite:GetFrame() == 1 then
			npc:PlaySound(SoundEffect.SOUND_CUTE_GRUNT , 1.1, 0, false, 1)
		end
		if sprite:IsEventTriggered("Shoot") then
			local Splat = Isaac.Spawn(1000, 2, 5, Vector(npc.Position.X, npc.Position.Y - 30), Vector(0,0), npc)
			Splat.DepthOffset = 40
			Splat.Color = Color(1.4,1.4,1.4,0.7,0,0,0)
			npc:PlaySound(SoundEffect.SOUND_BLOODSHOOT, 1.2, 0, false, 1)
			data.ShotAngle = math.random(0,36)
			for i = 1, 10 do -- organized ring of shots
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(data.ShotAngle+i*36):Resized(8)), npc):ToProjectile() -- spawn projectile
				proj.Color = Color(1,1,1,1,0.3,0,0)
				proj.Height = -34
			end
		end
	end
	if npc.State == 16 then -- phase 2 transition
		if sprite:IsEventTriggered("Shoot") then
			for _, effect in pairs(Isaac.FindByType(1000,16,-1)) do
				effect.Color = Color(1,0,0,1,0.25,0,0)
			end
			data.ShotAngle = math.random(0,119)
			for i = 1, 10 do -- organized ring of shots
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(data.ShotAngle+i*36):Resized(9)), npc):ToProjectile() -- spawn projectile
				proj.Color = Color(1,1,1,1,0.3,0,0)
				proj.Height = -34
			end
		end
	end
	if npc.State == 6 then -- dive attack
		sprite:Play("Throw")
		npc.State = 9
	end
end

-------------------------------------------------------
-- Black Champion Tuff Twins
-------------------------------------------------------
function RepentanceBossChampions:BlackTuffTwinsAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	npc.Velocity = npc.Velocity * 0.95
	if npc.State == 4 then
		for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_SUCKER,-1,-1)) do -- morph inks into moters
			if ent.SpawnerType == EntityType.ENTITY_LARRYJR then
				ent:ToNPC():Morph(80, 0, 0, -1)
			end
		end
	end
	if sprite:IsPlaying("ButtUpB") or sprite:IsPlaying("ButtHoriB") or sprite:IsPlaying("ButtDownB") then
		data.Chance = math.random(0,100)
		if data.Chance <= 25 then
			local BlackCreep = Isaac.Spawn(1000, EffectVariant.CREEP_BLACK, 0, npc.Position, Vector(0,0), npc) -- spawn yellow creep
			BlackCreep.SpriteScale = Vector(0.75,0.75)
			BlackCreep:ToEffect().Timeout = 120
			BlackCreep:Update()
		end
	end
	for _, bloodProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,0,-1)) do -- recolor the blood shots
		if bloodProj.SpawnerType == EntityType.ENTITY_LARRYJR then
			local tar = Color(1,1,1,1,0,0,0)
			tar:SetColorize(1,1,1,1)
			tar:SetTint(0.5,0.5,0.5,1)
			bloodProj.Color = tar
		end
	end
end

-------------------------------------------------------
-- Purple Champion Tuff Twins
-------------------------------------------------------
function RepentanceBossChampions:PurpleTuffTwinsAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	npc.Velocity = npc.Velocity * 0.95
	if npc.State == 4 then
		for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_SUCKER,-1,-1)) do -- morph inks into moters
			if ent.SpawnerType == EntityType.ENTITY_LARRYJR then
				ent:Remove()
			end
		end
	end
	if sprite:IsPlaying("AttackHeadHori") or sprite:IsPlaying("AttackHeadDown") or sprite:IsPlaying("AttackHeadUp") or sprite:IsPlaying("AttackHeadHoriB") or sprite:IsPlaying("AttackHeadDownB") or sprite:IsPlaying("AttackHeadUpB") then
		if sprite:GetFrame() == 11 then
			local proj = Isaac.Spawn(9,0,0, npc.Position, RepentanceBossChampions.vecToPos(target.Position, npc.Position) * 9, npc):ToProjectile()
			local projdata = proj:GetData()
			projdata.Haemolacria = true
			proj.FallingSpeed = -22
			proj.FallingAccel = 1.05
			proj.Scale = 2.5
		end
	end
	if sprite:IsPlaying("ButtUpB") or sprite:IsPlaying("ButtHoriB") or sprite:IsPlaying("ButtDownB") then
		data.Chance = math.random(0,100)
		if data.Chance <= 25 then
			local BlackCreep = Isaac.Spawn(1000, EffectVariant.CREEP_RED, 0, npc.Position, Vector(0,0), npc) -- spawn yellow creep
			BlackCreep.SpriteScale = Vector(0.75,0.75)
			BlackCreep:ToEffect().Timeout = 45
			BlackCreep:Update()
		end
	end
end

-------------------------------------------------------
-- Red Champion The Shell
-------------------------------------------------------
function RepentanceBossChampions:RedShellAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	for _, flyBomb in pairs(Isaac.FindByType(EntityType.ENTITY_FLY_BOMB,-1,-1)) do -- morph fly bombs into dark balls
		if flyBomb.SpawnerType == EntityType.ENTITY_LARRYJR then
			flyBomb:Remove()
		end
	end
	if npc.State == 4 then -- moving
		if sprite:IsOverlayPlaying("WalkBodyOverlay") then
			data.CreepChance = math.random(1,300)
			if data.CreepChance >= 295 then
				local RedCreep = Isaac.Spawn(1000, EffectVariant.CREEP_RED, 0, npc.Position, Vector(0,0), npc) -- spawn yellow creep
				RedCreep.SpriteScale = Vector(1,1)
				RedCreep:ToEffect().Timeout = 120
				RedCreep:Update()
			end
		end
	end
	if sprite:IsPlaying("ButtIdle") then
		data.CreepChance = math.random(1,100)
		if data.CreepChance >= 85 then
			local RedCreep = Isaac.Spawn(1000, EffectVariant.CREEP_RED, 0, npc.Position, Vector(0,0), npc) -- spawn yellow creep
			RedCreep.SpriteScale = Vector(1,1)
			RedCreep:ToEffect().Timeout = 120
			RedCreep:Update()
		end
	end
	if sprite:IsPlaying("ButtAttack") then
		if sprite:IsEventTriggered("Shoot") then
			local proj = Isaac.Spawn(9,0,0, npc.Position, RepentanceBossChampions.vecToPos(target.Position, npc.Position) * 9, npc):ToProjectile()
			local projdata = proj:GetData()
			projdata.Haemolacria = true
			proj.FallingSpeed = -22
			proj.FallingAccel = 1.05
			proj.Scale = 2.5
		end
	end
end

-------------------------------------------------------
-- White Champion Reap Creep
-------------------------------------------------------
function RepentanceBossChampions:WhiteReapCreepAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_WALL_CREEP,0,-1)) do -- morph wall creep into soy creep
		ent:ToNPC():Morph(EntityType.ENTITY_WALL_CREEP, 1, 0, -1)
	end
	if npc.State == 8 then -- Phase 1 shot stream attack
		for _, bloodProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,-1,-1)) do -- recolor the blood shots
			if bloodProj.SpawnerType == EntityType.ENTITY_REAP_CREEP then
				local color = Color(1,1,1,1,0.5,0.5,0.5)
				color:SetColorize(4, 4, 4, 1)
				bloodProj.Color = color
			end
		end
		if sprite:IsPlaying("Attack1Fire") then
			if sprite:GetFrame() == 2 then
				local velocity = Vector(math.random(-4,4), math.random(4, 7)):Rotated(math.random(-10, 10))
				local proj = Isaac.Spawn(9, 4, 0, npc.Position, velocity, npc):ToProjectile() -- spawn projectile
				local projdata = proj:GetData()
				projdata.WhiteCreep = true
				projdata.SmallWhiteCreep = true
				proj.Scale = RepentanceBossChampions.choose(0.2, 0.3, 0.4, 0.5)
				proj.FallingSpeed = math.random(-24,-8)
				proj.FallingAccel = RepentanceBossChampions.choose(0.9,1,1.1)
				proj.Color = Color(1,1,1,1,0.8,0.7,0.5)
			end
		end
	end
	if npc.State == 9 then -- Phase 2 spit attack
		for _, bloodProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,0,-1)) do -- remove the blood shots
			if bloodProj.SpawnerType == EntityType.ENTITY_REAP_CREEP then
				bloodProj:Remove()
			end
		end
		if sprite:GetFrame() == 48 or sprite:GetFrame() == 50 or sprite:GetFrame() == 52 or sprite:GetFrame() == 54 or sprite:GetFrame() == 56 or sprite:GetFrame() == 58 or sprite:GetFrame() == 60 then
			npc:PlaySound(SoundEffect.SOUND_BLOODSHOOT, 1, 0, false, 1)
			for i=1, RepentanceBossChampions.choose(1,2) do
				local velocity = Vector(math.random(-6,6), math.random(3, 7)):Rotated(math.random(-10, 10))
				local proj = Isaac.Spawn(9,4,0, npc.Position, velocity, npc):ToProjectile()
				local projdata = proj:GetData()
				projdata.WhiteCreep = true
				proj.Color = Color(1,1,1,1,0.8,0.7,0.5)
				proj.Scale = math.random(20,25) / 10
				proj.FallingSpeed = math.random(-24,-16)
				proj.FallingAccel = RepentanceBossChampions.choose(0.7,0.8,0.9)
            end
			for i= 1, 2 do
				local velocity = Vector(math.random(-4,4), math.random(4, 7)):Rotated(math.random(-10, 10))
				local proj = Isaac.Spawn(9, 4, 0, npc.Position, velocity, npc):ToProjectile() -- spawn projectile
				local projdata = proj:GetData()
				projdata.WhiteCreep = true
				projdata.SmallWhiteCreep = true
				proj.Scale = RepentanceBossChampions.choose(0.5, 0.75, 1)
				proj.FallingSpeed = math.random(-24,-8)
				proj.FallingAccel = RepentanceBossChampions.choose(0.9,1,1.1)
				proj.Color = Color(1,1,1,1,0.8,0.7,0.5)
			end
		end
	end
	if npc.State == 10 then -- brimstone attack
		if sprite:IsPlaying("Attack3BeamStart") then
			if sprite:GetFrame() == 40 or sprite:GetFrame() == 37 or sprite:GetFrame() == 34 or sprite:GetFrame() == 31 or sprite:GetFrame() == 28  or sprite:GetFrame() == 25 then
				local velocity = Vector(math.random(-4,4), math.random(4, 7)):Rotated(math.random(-10, 10))
				local proj = Isaac.Spawn(9, 4, 0, npc.Position, velocity, npc):ToProjectile() -- spawn projectile
				local projdata = proj:GetData()
				projdata.WhiteCreep = true
				projdata.SmallWhiteCreep = true
				proj.Scale = RepentanceBossChampions.choose(0.2, 0.3, 0.4, 0.5)
				proj.FallingSpeed = math.random(-24,-8)
				proj.FallingAccel = RepentanceBossChampions.choose(0.9,1,1.1)
				proj.Color = Color(1,1,1,1,0.8,0.7,0.5)
				npc:PlaySound(SoundEffect.SOUND_BLOODSHOOT, 1, 0, false, 1)
			end
		end
		if sprite:IsPlaying("Attack3BeamLoop") then
			if sprite:GetFrame() == 1 or sprite:GetFrame() == 4 or sprite:GetFrame() == 7 then
				local velocity = Vector(math.random(-4,4), math.random(4, 7)):Rotated(math.random(-10, 10))
				local proj = Isaac.Spawn(9, 4, 0, npc.Position, velocity, npc):ToProjectile() -- spawn projectile
				local projdata = proj:GetData()
				projdata.WhiteCreep = true
				projdata.SmallWhiteCreep = true
				proj.Scale = RepentanceBossChampions.choose(0.2, 0.3, 0.4, 0.5)
				proj.FallingSpeed = math.random(-24,-8)
				proj.FallingAccel = RepentanceBossChampions.choose(0.9,1,1.1)
				proj.Color = Color(1,1,1,1,0.8,0.7,0.5)
				npc:PlaySound(SoundEffect.SOUND_BLOODSHOOT, 1, 0, false, 1)
			end
		end
	end
	if npc.State == 14 then -- Phase 2 trite / spider spawning attack
		for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_HOPPER,1,-1)) do -- delete trite
			ent:Remove()
		end
		for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_SPIDER,-1,-1)) do -- delete spiders
			ent:Remove()
		end
		if sprite:IsPlaying("Summon2") then
			if sprite:GetFrame() == 14 or sprite:GetFrame() == 15 or sprite:GetFrame() == 16 or sprite:GetFrame() == 17 then -- spawn swarm spider on frame 14, 15, 16, and 17
				Isaac.Spawn(884, 0, 0, npc.Position, Vector(math.random(3,3),5), npc):ClearEntityFlags(EntityFlag.FLAG_APPEAR)
			end
		end
	end
end

function RepentanceBossChampions:WhiteCreepShot(proj)
	local projdata = proj:GetData()
	if projdata.WhiteCreep == true then
		if proj:IsDead() or not proj:Exists() then
			local splash = Isaac.Spawn(1000, 2, 2, proj.Position, Vector(0,0), proj)
			splash.Color = Color(0, 0, 0, 1, 0.95, 0.95, 0.95)
			local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT,EffectVariant.CREEP_WHITE,1,proj.Position, Vector(0,0), proj)
			if projdata.SmallWhiteCreep == true then
				creep:GetSprite().Scale = Vector(0.75,0.75)
			else
				creep:GetSprite().Scale = Vector(1.5,1.5)
			end
			creep:ToEffect().Timeout = 200
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, RepentanceBossChampions.WhiteCreepShot)

-------------------------------------------------------
-- Red Champion Reap Creep
-------------------------------------------------------
function RepentanceBossChampions:RedReapCreepAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	if npc.State == 3 then
		data.ShotTimer = 13
	end
	if npc.State == 13 then
		sprite:Play("Attack1Start")
		npc.State = 8
	end
	if npc.State == 7 then
		sprite:Play("Attack3Start")
		npc.State = 10
	end
	if npc.State == 8 then -- Phase 1 shot stream attack
		for _, bloodProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,0,-1)) do -- remove the blood shots
			if bloodProj.SpawnerType == EntityType.ENTITY_REAP_CREEP then
				local projdata = bloodProj:GetData()
				if not projdata.Ring == true then
					bloodProj:Remove()
				end
			end
		end
		if sprite:IsPlaying("Attack1Start") then
			data.ShotTimer = 13
		end
		if sprite:IsPlaying("Attack1Fire") then
			data.ShotTimer = data.ShotTimer + 1
			if data.ShotTimer == 14 then
				local Splat = Isaac.Spawn(1000, 2, 2, Vector(npc.Position.X, npc.Position.Y - 18), Vector(0,0), npc)
				Splat.DepthOffset = 40
				npc:PlaySound(SoundEffect.SOUND_BLOODSHOOT, 1.2, 0, false, 0.95)
				data.ShotAngle = math.random(0,30)
				data.ShotAngle2 = math.random(0,90)
				for i = 1, 12 do
					velocity = (Vector.FromAngle(data.ShotAngle+i*30):Resized(9))
					local proj = Isaac.Spawn(9, 0, 0, npc.Position, velocity, npc):ToProjectile() -- spawn projectile
					local projdata = proj:GetData()
					projdata.Ring = true
					proj.Scale = 1.5
					proj.FallingAccel = -0.05
					data.ShotTimer = 0
				end
				for i = 1, 4 do
					velocity = (Vector.FromAngle(data.ShotAngle2+i*90):Resized(6))
					local proj = Isaac.Spawn(9, 0, 0, npc.Position, velocity, npc):ToProjectile() -- spawn projectile
					local projdata = proj:GetData()
					projdata.Ring = true
					proj.Scale = 1
					proj.FallingAccel = -0.05
					data.ShotTimer = 0
				end
			end
		end
	end
	if npc.State == 9 then
		if sprite:GetFrame() == 1 then
			data.NextState = RepentanceBossChampions.choose(9,14,14)
			if data.NextState == 14 then
				sprite:Play("Summon2")
				npc.State = 14
			end
		end
	end
	if npc.State == 10 then
		if sprite:IsPlaying("Attack3Start") then
			data.ShotTimer = 11
		end
		if sprite:IsPlaying("Attack3BeamLoop") then
			data.ShotTimer = data.ShotTimer + 1
			if data.ShotTimer == 12 then
				npc:PlaySound(SoundEffect.SOUND_BLOODSHOOT, 1.2, 0, false, 0.95)
				data.ShotAngle = math.random(0,36)
				for i = 1, 10 do
					velocity = (Vector.FromAngle(data.ShotAngle+i*36):Resized(7))
					local proj = Isaac.Spawn(9, 0, 0, npc.Position, velocity, npc):ToProjectile() -- spawn projectile
					local projdata = proj:GetData()
					projdata.Ring = true
					proj.FallingAccel = -0.05
					proj.Scale = 1.5
					data.ShotTimer = 0
				end
			end
		end
	end
	if npc.State == 14 then -- Phase 2 trite / spider spawning attack
		for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_HOPPER,1,-1)) do -- morph trite
			ent:Remove()
		end
		for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_SPIDER,-1,-1)) do -- delete spiders
			ent:Remove()
		end
		if sprite:IsPlaying("Summon2") then
			if sprite:IsEventTriggered("Shoot") then
				local Splat = Isaac.Spawn(1000, 2, 2, Vector(npc.Position.X, npc.Position.Y - 28), Vector(0,0), npc)
				Splat.DepthOffset = 40
				for i = 1, 2 do
					local velocity = (RepentanceBossChampions.vecToPos(target.Position, npc.Position) * math.random(6,10)):Rotated(-60+i*40)
					local proj = Isaac.Spawn(9, 0, 0, npc.Position, velocity, npc):ToProjectile()
					local projdata = proj:GetData()
					projdata.Haemolacria = true
					proj.FallingSpeed = -22
					proj.FallingAccel = 1.05
					proj.Scale = 3
				end
			end
		end
	end
end

-------------------------------------------------------
-- Black Champion Hornfel
-------------------------------------------------------
function RepentanceBossChampions:BlackHornfelAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_BONY,0,-1)) do -- morph bony into black bony
		if ent.SpawnerType == EntityType.ENTITY_HORNFEL then
			ent:ToNPC():Morph(EntityType.ENTITY_BLACK_BONY, 0, 0, -1)
		end
	end
	for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_FACELESS,0,-1)) do -- morph faceless into bouncer
		if ent.SpawnerType == EntityType.ENTITY_HORNFEL then
			ent:ToNPC():Morph(EntityType.ENTITY_BOUNCER, 0, 0, -1)
		end
	end
	for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_DANNY,-1,-1)) do -- morph danny into black globin
		if ent.SpawnerType == EntityType.ENTITY_HORNFEL then
			ent:ToNPC():Morph(278, 0, 0, -1)
		end
	end
	for _, ent in pairs(Isaac.FindByType(87,-1,-1)) do -- morph gurgle into hard host
		if ent.SpawnerType == EntityType.ENTITY_HORNFEL then
			ent:ToNPC():Morph(27, 3, 0, -1)
		end
	end
	for _, ent in pairs(Isaac.FindByType(823,-1,-1)) do -- morph quakey into chubber
		if ent.SpawnerType == EntityType.ENTITY_HORNFEL then
			ent:ToNPC():Morph(39, 2, 0, -1)
		end
	end
	for _, flyBomb in pairs(Isaac.FindByType(EntityType.ENTITY_FLY_BOMB,-1,-1)) do -- morph fly bombs into dark balls
		if flyBomb.SpawnerType == EntityType.ENTITY_HORNFEL then
			flyBomb:ToNPC():Morph(404, 1, 0, -1)
		end
	end
	if npc.State == 9 then -- brimstone bombs attack
		if sprite:IsEventTriggered("Shoot") then
			Isaac.Spawn(404, 1, 1, npc.Position, Vector(math.random(-6,6),math.random(-6,6)), npc):ClearEntityFlags(EntityFlag.FLAG_APPEAR)
		end
	end
	if npc.State == 11 then -- fire wave ball spit attack
		for _, proj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,-1,-1)) do -- remove projectile
			if proj.SpawnerType == EntityType.ENTITY_HORNFEL then
				proj:Remove()
			end
		end
		if sprite:IsEventTriggered("Shoot") then -- spawn dark ball
			npc:PlaySound(SoundEffect.SOUND_WHEEZY_COUGH, 1, 0, false, 1)
			for i = 1, 2 do
				Isaac.Spawn(404, 1, 1, Vector(npc.Position.X+math.random(-6,6), npc.Position.Y+8), Vector(math.random(-2,2),math.random(-2,2)), npc):ClearEntityFlags(EntityFlag.FLAG_APPEAR)
			end
		end
	end
	if npc.State == 13 then -- minecart broken
		if sprite:GetFrame() == 1 then
			for i = 1, 3 do
				Isaac.Spawn(404, 1, 0, Vector(npc.Position.X+math.random(-6,6), npc.Position.Y+8), Vector(math.random(-6,6),math.random(-6,6)), npc):ClearEntityFlags(EntityFlag.FLAG_APPEAR)
			end
		end
	end
end

-------------------------------------------------------
-- Orange Champion Hornfel
-------------------------------------------------------
function RepentanceBossChampions:OrangeHornfelAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_BONY,0,-1)) do -- morph bony into red fireplace
		if ent.SpawnerType == EntityType.ENTITY_HORNFEL then
			ent:ToNPC():Morph(33, 0, 1, -1)
		end
	end
	for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_FACELESS,0,-1)) do -- morph faceless into clotty
	if ent.SpawnerType == EntityType.ENTITY_HORNFEL then
			ent:ToNPC():Morph(15, 0, 0, -1)
		end
	end
	for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_DANNY,-1,-1)) do -- morph danny into flaming fatty
		if ent.SpawnerType == EntityType.ENTITY_HORNFEL then
			ent:ToNPC():Morph(208, 2, 0, -1)
		end
	end
	for _, ent in pairs(Isaac.FindByType(87,-1,-1)) do -- morph gurgle into mulliboom
		if ent.SpawnerType == EntityType.ENTITY_HORNFEL then
			ent:ToNPC():Morph(16, 2, 0, -1)
		end
	end
	for _, ent in pairs(Isaac.FindByType(823,-1,-1)) do -- morph quakey into red fireplace
		if ent.SpawnerType == EntityType.ENTITY_HORNFEL then
			ent:ToNPC():Morph(33, 0, 1, -1)
		end
	end
	if npc.State == 4 then
		if sprite:GetFrame() == 1  then
			local velocity = Vector(RepentanceBossChampions.choose(math.random(-2, -1), math.random(1, 2)), RepentanceBossChampions.choose(math.random(-2, -1), math.random(1, 2))):Rotated(math.random(-30, 30))
			local fire = Isaac.Spawn(EntityType.ENTITY_FIREPLACE,10,2,npc.Position,velocity,npc)
			fire.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
			fire.HitPoints = RepentanceBossChampions.choose(2,3)
		end
	end
	if npc.State == 8 then -- bomb throwing attack
		for _, bomb in pairs(Isaac.FindByType(4,-1,-1)) do -- morph bombs into fires
			if bomb.SpawnerType == EntityType.ENTITY_HORNFEL then
				bomb:GetData().OrangeHornfelNormalBomb = true
			end
		end
		if sprite:IsEventTriggered("Shoot") then
			local fire = Isaac.Spawn(EntityType.ENTITY_FIREPLACE,10,2,npc.Position,RepentanceBossChampions.vecToPos(target.Position, npc.Position)*14,npc)
			fire.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
		end
	end
	if npc.State == 11 then -- fire wave ball spit attack
		if sprite:IsEventTriggered("Shoot") then -- spawn fires
			npc:PlaySound(SoundEffect.SOUND_WHEEZY_COUGH, 1, 0, false, 1)
			for i = 1, math.random(3,5) do
				local velocity = Vector(RepentanceBossChampions.choose(math.random(-3, -1), math.random(1, 3)), RepentanceBossChampions.choose(math.random(-3, -1), math.random(1, 3))):Rotated(math.random(-30, 30))
				local fire = Isaac.Spawn(EntityType.ENTITY_FIREPLACE,10,2,npc.Position,velocity,npc)
				fire.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
				fire.HitPoints = math.random(3,5)
			end
		end
	end
end

-------------------------------------------------------
-- Brown Champion Clog
-------------------------------------------------------
function RepentanceBossChampions:BrownClogAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	local room = game:GetRoom()
	if npc.State == 8 then -- drip spit attack
		for _, drip in pairs(Isaac.FindByType(EntityType.ENTITY_DRIP,-1,-1)) do -- remove drips
			if drip.SpawnerType == EntityType.ENTITY_CLOG then
				drip:Remove()
			end
		end
		if sprite:IsEventTriggered("Shoot") then -- spawn a corn or big corn
			local velocity = Vector(math.random(-20,20), math.random(4, 6))
			Isaac.Spawn(217, RepentanceBossChampions.choose(2,2,3), 0, npc.Position, velocity, npc):ClearEntityFlags(EntityFlag.FLAG_APPEAR)
		end
	end
	if npc.State == 9 then -- whirlpool attack
		npc.State = 10 -- set state to projectile attack
	end
	if npc.State == 10 then -- projectile spiral attack
		for _, poopProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,3,-1)) do -- remove puke shots
			if poopProj.SpawnerType == EntityType.ENTITY_CLOG then
				poopProj:Remove()
			end
		end
		if sprite:IsPlaying("BulletHellLoop") then
			if sprite:GetFrame() == 0 then
				data.ShotCounter = data.ShotCounter + 1
				if data.ShotCounter == 2 then
					data.ShotAngle = data.ShotAngle + 22.5
					for i = 1, 4 do -- organized ring of shots
						local proj = Isaac.Spawn(9, 5, 0, npc.Position, (Vector.FromAngle(i*90):Resized(7)):Rotated(data.ShotAngle), npc):ToProjectile() -- spawn projectile
						proj.Scale = 1.5
						data.ShotCounter = 0
					end
				end
			end
			if sprite:IsEventTriggered("Shoot") then
				local proj = Isaac.Spawn(9, 5, 0, npc.Position, RepentanceBossChampions.vecToPos(target.Position, npc.Position)*math.random(8,11), npc):ToProjectile() -- spawn projectile
				proj.Scale = RepentanceBossChampions.choose(1,1.5,2)
			end
		end
		if sprite:IsFinished("BulletHellLoop") then
			data.ShotAngle = 0
			data.ShotCounter = 0
		end
	end
	if npc.State == 11 then -- fart wave attack
		if sprite:IsEventTriggered("CornMine") then
			game:Fart(npc.Position, 0, npc, 1.2)
			for i = 1, 3 do
				local minepos = room:FindFreePickupSpawnPosition(npc.Position, 80, true, false)
				local mine = Isaac.Spawn(EntityType.ENTITY_CORN_MINE, 0, 0, minepos, Vector(0,0), npc) -- spawn corn mine
			end
		end
	end
end

-------------------------------------------------------
-- Black Champion Clog
-------------------------------------------------------
function RepentanceBossChampions:BlackClogAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	if npc.State == 8 then -- drip spit attack
		data.ProjTimer = 0
		for _, drip in pairs(Isaac.FindByType(EntityType.ENTITY_DRIP,-1,-1)) do -- remove drips
			if drip.SpawnerType == EntityType.ENTITY_CLOG then
				drip:Remove()
			end
		end
		if sprite:IsEventTriggered("Shoot") then
			local velocity = Vector(math.random(-20,20), math.random(3, 8))
			Isaac.Spawn(810, 0, 0, npc.Position, velocity, npc):ClearEntityFlags(EntityFlag.FLAG_APPEAR)
		end
	end
	if npc.State == 9 then -- whirlpool attack
		if sprite:IsPlaying("SpinLoop") or sprite:IsPlaying("SpinLoop2") then
			data.ProjTimer = data.ProjTimer + 1
			if data.ProjTimer >= 20 then
				data.ShotAngle = math.random(0,90)
				for i = 1, 4 do -- 4 shots
					local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(data.ShotAngle+i*90):Resized(8)):Rotated(data.ShotAngle), npc):ToProjectile() -- spawn projectile
					local tar = Color(1,1,1,1,0,0,0)
					tar:SetColorize(1,1,1,1)
					tar:SetTint(0.5,0.5,0.5,1)
					proj.Color = tar
					proj.Scale = 1.5
				end
				data.ProjTimer = 0
			end
		end
		if sprite:IsFinished("SpinLoop") then
			data.ProjTimer = 0
		end
	end
	if npc.State == 10 then -- projectile spiral attack
		for _, poopProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,-1,-1)) do -- recolor the blood shots
			if poopProj.SpawnerType == EntityType.ENTITY_CLOG then
				local tar = Color(1,1,1,1,0,0,0)
			    tar:SetColorize(1,1,1,1)
			    tar:SetTint(0.5,0.5,0.5,1)
			    poopProj.Color = tar
				poopProj:ToProjectile().ProjectileFlags = ProjectileFlags.SINE_VELOCITY
			end
		end
	end
	if npc.State == 11 then -- fart wave attack
		if sprite:IsEventTriggered("Shoot") then
			for i = 1, 16 do -- random cluster of shots
				local velocity = Vector(RepentanceBossChampions.choose(math.random(-6, -1), math.random(1, 6)), RepentanceBossChampions.choose(math.random(-6, -1), math.random(1, 6))):Rotated(math.random(-30*i, 30*i))
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, velocity, npc):ToProjectile() -- spawn projectile
				proj.Scale = math.random(5,15) / 10
				proj.FallingSpeed = math.random(-24,-8)
				proj.FallingAccel = RepentanceBossChampions.choose(0.8,0.9,1,1.1)
				local tar = Color(1,1,1,1,0,0,0)
			    tar:SetColorize(1,1,1,1)
			    tar:SetTint(0.5,0.5,0.5,1)
			    proj.Color = tar
			end
		end
	end
end

-------------------------------------------------------
-- Brown Champion Singe
-------------------------------------------------------
function RepentanceBossChampions:BrownSingeAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	if npc.State == 8 then -- normal explosion attack
		if sprite:IsEventTriggered("Shoot") then
		data.Angle = math.random(0,45)
			for i = 1, 8 do -- organized ring of shots
				Isaac.Spawn(9, 3, 0, npc.Position, (Vector.FromAngle(data.Angle+i*45):Resized(10)), npc):ToProjectile() -- spawn projectile
			end
		end
	end
	if npc.State == 9 then -- hop explosion attack
		if sprite:IsEventTriggered("Shoot") then
		data.Angle = math.random(0,45)
			for i = 1, 8 do -- organized ring of shots
				Isaac.Spawn(9, 3, 0, npc.Position, (Vector.FromAngle(data.Angle+i*45):Resized(10)), npc):ToProjectile() -- spawn projectile
			end
		end
	end
	if npc.State == 10 then -- fart attack
		for _, gas in pairs(Isaac.FindByType(1000,141,1)) do -- remove gas cloud
			if gas.SpawnerType == EntityType.ENTITY_SINGE then
				gas:Remove()
			end
		end
		if not sprite.FlipX then
			data.Pos = Vector(npc.Position.X + 48, npc.Position.Y)
			data.CreepPos = Vector(npc.Position.X + 70, npc.Position.Y)
			data.Velocity = Vector(24,0)
		else
			data.Pos = Vector(npc.Position.X - 48, npc.Position.Y)
			data.CreepPos = Vector(npc.Position.X - 70, npc.Position.Y)
			data.Velocity = Vector(-24,0)
		end
		if sprite:IsEventTriggered("Shoot") then
			Isaac.Spawn(245, 0, 0, data.Pos, data.Velocity, npc)
			local effect = Isaac.Spawn(1000, 16, 2, data.Pos, Vector(0,0), npc):ToEffect()
			local color = Color(0.6, 0.15, 0, 1, 0.2, 0.1, 0)
			color:SetColorize(1, 1, 1, 1)
			effect:GetSprite().Color = color
			local BrownCreep = Isaac.Spawn(1000, EffectVariant.CREEP_SLIPPERY_BROWN, 0, data.CreepPos, Vector(0,0), npc) -- spawn creep
			BrownCreep.SpriteScale = Vector(2.5,2.5)
			BrownCreep:ToEffect().Timeout = 200
			BrownCreep:Update()
		end
	end
	if npc.State == 12 then
		if sprite:IsPlaying("SuperBlastLand") then
			if sprite:IsEventTriggered("Land") then
				local BrownCreep = Isaac.Spawn(1000, EffectVariant.CREEP_SLIPPERY_BROWN, 0, npc.Position, Vector(0,0), npc) -- spawn creep
				BrownCreep.SpriteScale = Vector(2.5,2.5)
				BrownCreep:ToEffect().Timeout = 200
				BrownCreep:Update()
			end
		end
	end
end

-------------------------------------------------------
-- Green Champion Singe
-------------------------------------------------------
function RepentanceBossChampions:GreenSingeAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	if npc.State == 4 then -- chasing
		npc.Velocity = npc.Velocity * 0.85
	end
	if npc.State == 8 then -- normal explosion attack
		if sprite:IsEventTriggered("Shoot") then
			local cloud = Isaac.Spawn(1000, 141, 0, npc.Position, Vector(0,0), npc) -- spawn poison gas cloud
			cloud:ToEffect().Timeout = 250
		end
	end
	if npc.State == 9 then -- hop explosion attack
		if sprite:IsEventTriggered("Shoot") then
			local cloud = Isaac.Spawn(1000, 141, 0, npc.Position, Vector(0,0), npc) -- spawn poison gas cloud
			cloud:ToEffect().Timeout = 250
		end
	end
	if npc.State == 10 then -- fart attack
		for _, gas in pairs(Isaac.FindByType(1000,141,1)) do -- remove gas cloud
			if gas.SpawnerType == EntityType.ENTITY_SINGE then
				gas:Remove()
			end
		end
		if not sprite.FlipX then
			data.Pos = Vector(npc.Position.X + 16, npc.Position.Y)
		else
			data.Pos = Vector(npc.Position.X - 16, npc.Position.Y)
		end
		if sprite:IsEventTriggered("Shoot") then
			Isaac.Spawn(1000,15,0, data.Pos, Vector(0,0), npc).Color = Color(1,1.5,1,1,0,0,0)
			local Velocity = RepentanceBossChampions.vecToPos(target.Position, data.Pos)*12
			local bomb = Isaac.Spawn(4, BombVariant.BOMB_POISON, 0, data.Pos, Velocity, npc):ToBomb()
			bomb:GetData().BobsCurse = true
		end
	end
	if npc.State == 11 then -- flamethrower
		for _, fire in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,2,0)) do -- recolor flamethrower to green
			if fire.SpawnerType == EntityType.ENTITY_SINGE then
				local color = Color(0.5,1,0.5,1,0,0,0)
				color:SetColorize(1, 1.5, 0, 1)
				fire:GetSprite().Color = color
			end
		end
	end
	if npc.State == 12 then -- big explosion attack
		if sprite:IsPlaying("SuperBlast") then
			if sprite:IsEventTriggered("Shoot") then
				for i = 1, 8 do
					local cloud = Isaac.Spawn(1000, 141, 0, npc.Position, (Vector.FromAngle(i*45):Resized(12)), npc) -- spawn poison gas cloud
					cloud:ToEffect().Timeout = 250
				end
			end
		end
	end
end

-------------------------------------------------------
-- Grey Champion Bumbino
-------------------------------------------------------
function RepentanceBossChampions:GreyBumbinoAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	if npc.State == 8 then -- side swipe attack
		if sprite:IsPlaying("Swipe") then
			if sprite:IsEventTriggered("Shoot") then
				if not sprite.FlipX then
					params = ProjectileParams()
					params.Variant = 9
					params.Spread = 1
					npc:FireProjectiles(Vector(npc.Position.X, npc.Position.Y),Vector(-10,0), 4, params)
				else
					params = ProjectileParams()
					params.Variant = 9
					params.Spread = 1
					npc:FireProjectiles(Vector(npc.Position.X, npc.Position.Y),Vector(10,0), 4, params)
				end
			end
		end
	end
	if npc.State == 9 then
		if sprite:IsEventTriggered("Shoot") then
			for i = 1, 12 do -- organized ring of shots
				local params = ProjectileParams()
				params.Variant = 9
				params.HeightModifier = 16
				params.FallingAccelModifier = -0.125
				npc:FireProjectiles(Vector(npc.Position.X, npc.Position.Y + 20), Vector.FromAngle(15+i*30):Resized(7), 0, params)
			end
		end
	end
	if npc.State == 10 then -- vertical dash attack
		data.NextState = RepentanceBossChampions.choose(9,9,9,11)
		if data.NextState == 9 then
			sprite:Play("GroundSlam")
			npc.State = 9
		elseif data.NextState == 11 then
			sprite:Play("ButtBomb")
			npc.State = 11
		end
	end
	if npc.State == 11 then -- butt bomb attack
		if sprite:IsEventTriggered("Shoot") then
			for _, buttBomb in pairs(Isaac.FindByType(4,BombVariant.BOMB_BUTT,-1)) do -- remove the butt bomb
				if buttBomb.SpawnerType == EntityType.ENTITY_BUMBINO then
					buttBomb:Remove()
				end
			end
			if sprite.FlipX then
				local velocity = RepentanceBossChampions.vecToPos(target.Position, npc.Position)*8
				local Keeper = Game():Spawn(EntityType.ENTITY_KEEPER, 0, Vector(npc.Position.X - 22, npc.Position.Y + 18), velocity, npc, 0, 1)
				Keeper:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
			else
				local velocity = RepentanceBossChampions.vecToPos(target.Position, npc.Position)*8
				local Keeper = Game():Spawn(EntityType.ENTITY_KEEPER, 0, Vector(npc.Position.X + 22, npc.Position.Y + 18), velocity, npc, 0, 1)
				Keeper:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
				Keeper.HitPoints = 15
			end
		end
	end
end

-------------------------------------------------------
-- Green Champion Bumbino
-------------------------------------------------------
function RepentanceBossChampions:GreenBumbinoAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local room = game:GetRoom()
	local target = npc:GetPlayerTarget()
	if npc.State == 3 then
		data.RandomState = RepentanceBossChampions.choose(8,8,8,11)
	end
	if npc.State == 8 then -- side swipe attack
		if data.RandomState == 11 then
			sprite:Play("ButtBomb")
			SFXManager():Stop(SoundEffect.SOUND_BUMBINO_PUNCH)
			npc.State = 11
		end
		if sprite:IsPlaying("Swipe") then
			if sprite:IsEventTriggered("Shoot") then
				local cloud = Isaac.Spawn(1000, 141, 0, npc.Position, Vector(0,0), npc)
				cloud:ToEffect():SetTimeout(200)
			end
		end
	end
	if npc.State == 9 then
		if sprite:IsEventTriggered("Shoot") then
			for _, rockProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,9,-1)) do -- remove the rock shots
				if rockProj.SpawnerType == EntityType.ENTITY_BUMBINO then
					rockProj:Remove()
				end
			end
			for i = 1, 32 do -- disorganized cluster of blood shots
				local velocity = Vector(RepentanceBossChampions.choose(math.random(-6, -1), math.random(1, 6)), RepentanceBossChampions.choose(math.random(-6, -1), math.random(1, 6))):Rotated(math.random(-30, 30))
				local params = ProjectileParams()
				params.FallingSpeedModifier = math.random(-32, -4)
				params.FallingAccelModifier = RepentanceBossChampions.choose(0.9,1,1.1,1.2)
				params.Scale = math.random(5,20) / 10
				params.Variant = 0
				npc:FireProjectiles(npc.Position, velocity, 0, params)
			end
		end
	end
	if npc.State == 10 then -- vertical dash attack
		if sprite:GetFrame() == 1 then
			data.NextState = RepentanceBossChampions.choose(10,10,10,11)
			if data.NextState == 11 then
				sprite:Play("ButtBomb")
				npc.State = 11
			end
		end
		if sprite:IsPlaying("UpCharge") or sprite:IsPlaying("DownCharge") then
			if sprite:IsEventTriggered("Shoot") then
				local cloud = Isaac.Spawn(1000, 141, 0, npc.Position, Vector(0,0), npc)
				cloud:ToEffect():SetTimeout(200)
			end
		end
	end
	if npc.State == 11 then -- butt bomb attack
		if sprite:IsEventTriggered("Shoot") then
			for _, buttBomb in pairs(Isaac.FindByType(4,BombVariant.BOMB_BUTT,-1)) do -- remove the butt bomb
				if buttBomb.SpawnerType == EntityType.ENTITY_BUMBINO then
					buttBomb:Remove()
				end
			end
			for i=1, math.random(2, 3) do
				data.FlyType = RepentanceBossChampions.choose(18,18,80,256,256,868)
				local fly = Game():Spawn(data.FlyType, 0, npc.Position, Vector.FromAngle(math.random(0, 360)):Resized(6), npc, 0, 1):ToNPC()
				fly:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
			end
		end
	end
end

-------------------------------------------------------
-- Red Champion Colostomia
-------------------------------------------------------
function RepentanceBossChampions:RedColostomiaAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	for _, poopProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,3,-1)) do -- remove poop shots
		if poopProj.SpawnerType == EntityType.ENTITY_COLOSTOMIA then
			poopProj:Remove()
		end
	end
	for _, puddle in pairs(Isaac.FindByType(1000,168,-1)) do -- change sprite of puddle
		if puddle.SpawnerType == EntityType.ENTITY_COLOSTOMIA then
			puddle:GetSprite():ReplaceSpritesheet(0, "gfx/bosses/repentance/colostomia_puddle_red.png")
			puddle:GetSprite():ReplaceSpritesheet(1, "gfx/bosses/repentance/colostomia_puddle_red.png")
			puddle:GetSprite():ReplaceSpritesheet(2, "gfx/bosses/repentance/colostomia_puddle_red.png")
			puddle:GetSprite():ReplaceSpritesheet(3, "gfx/bosses/repentance/colostomia_puddle_red.png")
			puddle:GetSprite():ReplaceSpritesheet(4, "gfx/bosses/repentance/colostomia_puddle_red.png")
			puddle:GetSprite():LoadGraphics()
		end
	end
	for _, bubble in pairs(Isaac.FindByType(1000,124,-1)) do -- change sprite of bubbles
		bubble:GetSprite():ReplaceSpritesheet(0, "gfx/effects/poop_bubble_red.png")
		bubble:GetSprite():LoadGraphics()
	end
	if npc.State == 8 then
		if sprite:IsPlaying("ChargeLoopDown") or sprite:IsPlaying("ChargeLoopUp") or sprite:IsPlaying("ChargeLoopHori") then
			if sprite:GetFrame() == 0 or sprite:GetFrame() == 2 or sprite:GetFrame() == 4 or sprite:GetFrame() == 6 or sprite:GetFrame() == 8 then
				local velocity = Vector(RepentanceBossChampions.choose(math.random(-5, -1), math.random(1, 5)), RepentanceBossChampions.choose(math.random(-5, -1), math.random(1, 5))):Rotated(math.random(-30, 30))
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, velocity, npc):ToProjectile() -- spawn projectile
				proj.Scale = math.random(5,15) / 10
				proj.FallingSpeed = math.random(-24,-8)
				proj.FallingAccel = RepentanceBossChampions.choose(0.6,0.7,0.8,0.9)
			end
		end
	end
	if npc.State == 6 or npc.State == 16 then
		for _, gas in pairs(Isaac.FindByType(1000,141,1)) do -- remove gas cloud
			if gas.SpawnerType == EntityType.ENTITY_COLOSTOMIA then
				gas:Remove()
			end
		end
		if sprite:IsEventTriggered("Land") then
			for i = 1, 10 do -- organized ring of shots
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(i*36):Resized(10)), npc):ToProjectile() -- spawn projectile
			end
		end
	end
	if npc.State == 10 then -- butt bomb attack
		for _, buttBomb in pairs(Isaac.FindByType(EntityType.ENTITY_BOMB,9,-1)) do -- remove butt bomb
			if buttBomb.SpawnerType == EntityType.ENTITY_COLOSTOMIA then
				buttBomb:Remove()
			end
		end
		if sprite:GetFrame() == 38 then -- fire haemolacria shots
			local Splat = Isaac.Spawn(1000, 2, 2, Vector(npc.Position.X, npc.Position.Y - 28), Vector(0,0), npc)
			Splat.DepthOffset = 40
			for i = 1, 3 do
				local velocity = (RepentanceBossChampions.vecToPos(target.Position, npc.Position) * math.random(7,10)):Rotated(math.random(-40,40))
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, velocity, npc):ToProjectile()
				local projdata = proj:GetData()
				projdata.Haemolacria = true
				proj.FallingSpeed = math.random(-24,-18)
				proj.FallingAccel = RepentanceBossChampions.choose(1,1.05,1.1)
				proj.Scale = 3
			end
		end
	end
	if npc.State == 11 then -- gas cloud attack
		for _, gas in pairs(Isaac.FindByType(1000,141,1)) do -- remove gas cloud
			if gas.SpawnerType == EntityType.ENTITY_COLOSTOMIA then
				gas:Remove()
			end
		end
		if sprite:GetFrame() == 30 then
			data.CurveDir = RepentanceBossChampions.choose(0,1)
			for i = 1, 8 do -- organized ring of shots
				local params = ProjectileParams()
				if data.CurveDir == 1 then
					params.BulletFlags = ProjectileFlags.CURVE_LEFT
				else
					params.BulletFlags = ProjectileFlags.CURVE_RIGHT
				end
				params.Scale = 1.5
				npc:FireProjectiles(npc.Position, Vector.FromAngle(i*45):Resized(10), 0, params)
			end
		end
	end
end

-------------------------------------------------------
-- Yellow Champion Colostomia
-------------------------------------------------------
function RepentanceBossChampions:YellowColostomiaAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	for _, poopProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,3,-1)) do -- remove poop shots
		if poopProj.SpawnerType == EntityType.ENTITY_COLOSTOMIA then
			poopProj:Remove()
		end
	end
	for _, puddle in pairs(Isaac.FindByType(1000,168,-1)) do -- change sprite of puddle
		if puddle.SpawnerType == EntityType.ENTITY_COLOSTOMIA then
			puddle:GetSprite():ReplaceSpritesheet(0, "gfx/bosses/repentance/colostomia_puddle_yellow.png")
			puddle:GetSprite():ReplaceSpritesheet(1, "gfx/bosses/repentance/colostomia_puddle_yellow.png")
			puddle:GetSprite():ReplaceSpritesheet(2, "gfx/bosses/repentance/colostomia_puddle_yellow.png")
			puddle:GetSprite():ReplaceSpritesheet(3, "gfx/bosses/repentance/colostomia_puddle_yellow.png")
			puddle:GetSprite():ReplaceSpritesheet(4, "gfx/bosses/repentance/colostomia_puddle_yellow.png")
			puddle:GetSprite():LoadGraphics()
		end
	end
	for _, bubble in pairs(Isaac.FindByType(1000,124,-1)) do -- change sprite of bubbles
		bubble:GetSprite():ReplaceSpritesheet(0, "gfx/effects/poop_bubble_yellow.png")
		bubble:GetSprite():LoadGraphics()
	end
	for _, gas in pairs(Isaac.FindByType(1000,141,1)) do -- remove gas cloud
		if gas.SpawnerType == EntityType.ENTITY_COLOSTOMIA then
			gas:Remove()
		end
	end
	if npc.State == 6 or npc.State == 16 then -- phase 2 transition or phase 2 jump attack
		for _, gas in pairs(Isaac.FindByType(1000,141,1)) do -- remove gas cloud
			if gas.SpawnerType == EntityType.ENTITY_COLOSTOMIA then
				gas:Remove()
			end
		end
		if sprite:IsEventTriggered("Land") then
			for i = 1, 8 do -- organized ring of shots
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(i*45):Resized(10)), npc):ToProjectile() -- spawn projectile
				local piss = Color(1,1,1,1,0,0,0)
				piss:SetColorize(3, 2.5, 0.4, 1)
				proj.Color = piss
			end
		end
	end
	if npc.State == 8 then -- charge attack
		if sprite:IsPlaying("ChargeLoopDown") or sprite:IsPlaying("ChargeLoopUp") or sprite:IsPlaying("ChargeLoopHori") then
			data.Chance = math.random(0,100)
			if data.Chance >= 50 then
				local YellowCreep = Isaac.Spawn(1000, EffectVariant.CREEP_YELLOW, 0, npc.Position, Vector(0,0), npc) -- spawn yellow creep
				YellowCreep.SpriteScale = Vector(1.5,1.5)
				YellowCreep.Color = Color(2.5,2.5,2.5,1,0,0,0)
				YellowCreep:ToEffect().Timeout = 120
				YellowCreep:Update()
			end
		end
		if sprite:IsPlaying("ChargeEndDown") or sprite:IsPlaying("ChargeEndUp") or sprite:IsPlaying("ChargeEndHori") then
			if sprite:GetFrame() == 1 then
				for i = 1, 10 do -- organized ring of shots
					local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(i*36):Resized(8)), npc):ToProjectile() -- spawn projectile
					local piss = Color(1,1,1,1,0,0,0)
					piss:SetColorize(3, 2.5, 0.4, 1)
					proj.Color = piss
					proj.Scale = 1
				end
			end
		end
	end
	if npc.State == 9 then -- replace butt bomb attack with basic proj attack
		for _, buttBomb in pairs(Isaac.FindByType(EntityType.ENTITY_BOMB,9,-1)) do -- remove butt bomb
			if buttBomb.SpawnerType == EntityType.ENTITY_COLOSTOMIA then
				buttBomb:Remove()
			end
		end
		if sprite:IsEventTriggered("Shoot") then
			for i = 1, 12 do -- organized ring of shots
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(i*30):Resized(10)), npc):ToProjectile() -- spawn projectile
				local piss = Color(1,1,1,1,0,0,0)
				piss:SetColorize(3, 2.5, 0.4, 1)
				proj.Color = piss
			end
		end
	end
	if npc.State == 10 then -- butt bomb attack
		for _, buttBomb in pairs(Isaac.FindByType(EntityType.ENTITY_BOMB,9,-1)) do -- remove butt bomb
			if buttBomb.SpawnerType == EntityType.ENTITY_COLOSTOMIA then
				buttBomb:Remove()
			end
		end
		if sprite:GetFrame() == 38 then -- fire projectile spread
			for i=1, 5 do
				local proj = Isaac.Spawn(9,0,0, npc.Position, (RepentanceBossChampions.vecToPos(target.Position, npc.Position) * 11):Rotated(-60+i*20), npc):ToProjectile()
				local piss = Color(1,1,1,1,0,0,0)
				piss:SetColorize(3, 2.5, 0.4, 1)
				proj.Color = piss
			end
		end
	end
	if npc.State == 11 then -- gas cloud attack
		for _, gas in pairs(Isaac.FindByType(1000,141,1)) do -- remove gas cloud
			if gas.SpawnerType == EntityType.ENTITY_COLOSTOMIA then
				gas:Remove()
			end
		end
		if sprite:GetFrame() == 30 then
			data.ChooseDir = RepentanceBossChampions.choose(0,1)
			data.Rotation = 0
			data.Angle = math.random(0,90)
			for i = 1, 4 do -- rings of shots
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(i*90):Resized(10)):Rotated(data.Angle), npc):ToProjectile() -- spawn projectile
				local piss = Color(1,1,1,1,0,0,0)
				piss:SetColorize(3, 2.5, 0.4, 1)
				proj.Color = piss
				proj.Scale = 1.75
			end
		end
		if sprite:IsEventTriggered("Shoot2") then
			if data.ChooseDir == 0 then
				data.Rotation = data.Rotation + 15
			elseif data.ChooseDir == 1 then
				data.Rotation = data.Rotation - 15
			end
			npc:PlaySound(SoundEffect.SOUND_BLOODSHOOT, 1.1, 0, false, 1.05)
			for i = 1, 4 do -- rings of shots
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(i*90):Resized(10)):Rotated(data.Angle + data.Rotation), npc):ToProjectile() -- spawn projectile
				local piss = Color(1,1,1,1,0,0,0)
				piss:SetColorize(3, 2.5, 0.4, 1)
				proj.Color = piss
			end
		end
	end
end

-------------------------------------------------------
-- Blue Champion Turdlet
-------------------------------------------------------
function RepentanceBossChampions:BlueTurdletAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	npc.Velocity = npc.Velocity * 0.925
	data.FlyTimer = data.FlyTimer + 1
	if data.FlyTimer >= 600 then
		Game():Spawn(18, 0, npc.Position, Vector(0,0), npc, 0, 1)
		data.FlyTimer = math.random(0,360)
	end
end

-------------------------------------------------------
-- Black Champion Turdlet
-------------------------------------------------------
function RepentanceBossChampions:BlackTurdletAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	npc.Velocity = npc.Velocity * 0.95
	for _, brownCreep in pairs(Isaac.FindByType(1000,EffectVariant.CREEP_SLIPPERY_BROWN,-1)) do -- morph brown creep into black creep
		if brownCreep.SpawnerType == EntityType.ENTITY_TURDLET then
			brownCreep.Variant = EffectVariant.CREEP_BLACK
			local color = Color(0.2,0.2,0.2,1,0,0,0)
			color:SetColorize(1, 1, 1, 1)
			brownCreep:GetSprite().Color = color
		end
	end
	if npc.State == 16 then -- split
		if sprite:IsPlaying("DeathHead") then
			if sprite:GetFrame() == 13 then
				for i = 1, 2 do
					Isaac.Spawn(EntityType.ENTITY_CLOTTY, 1, 0, npc.Position, npc.Velocity, npc)
				end
			end
		end
	end
end

-------------------------------------------------------
-- Pink Champion Horny Boys
-------------------------------------------------------
function RepentanceBossChampions:PinkHornyBoysAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	for _, boomFly in pairs(Isaac.FindByType(EntityType.ENTITY_BOOMFLY,0,-1)) do -- remove boom fly
		if boomFly.SpawnerType == EntityType.ENTITY_HORNY_BOYS then
			boomFly:Remove()
		end
	end
	for _, flyBomb in pairs(Isaac.FindByType(EntityType.ENTITY_FLY_BOMB,1,-1)) do -- remove boom fly
		if flyBomb.SpawnerType == EntityType.ENTITY_HORNY_BOYS then
			flyBomb:Remove()
		end
	end
	if npc.State == 9 then -- smokescreen attack
		sprite:Play("TeleportUp")
		npc.State = 6
	end
	if npc.State == 8 then -- brimstone bombs
		for _, brimstonebomb in pairs(Isaac.FindByType(4,15,-1)) do -- add data to brimstone bombs
			if brimstonebomb.SpawnerType == EntityType.ENTITY_HORNY_BOYS then
				brimstonebomb:GetData().BloodBomb = true
			end
		end
	end
	if npc.State == 11 then -- projectile barrage
		if sprite:IsPlaying("LokiDance5") then
			if sprite:IsEventTriggered("Sound") then
				for _, fireProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,-1,-1)) do -- remove fire projectiles
					if fireProj.SpawnerType == EntityType.ENTITY_HORNY_BOYS then
						if fireProj:ToProjectile().ProjectileFlags == ProjectileFlags.FIRE_WAVE then
							fireProj:Remove()
						end
					end
				end
				for i = 1, 7 do
					local velocity = RepentanceBossChampions.vecToPos(target.Position, npc.Position):Rotated(math.random(-30, 30)) * math.random(5,10)
					local proj = Isaac.Spawn(9, 0, 0, npc.Position, velocity, npc):ToProjectile()
					local projdata = proj:GetData()
					projdata.FireShot = true
					proj.FallingAccel = 0.6
					proj.FallingSpeed = math.random(-24, -16)
					proj.Scale = 2
					proj.Color = Color(1, 1, 1, 1, 0.7, 0.4, 0)
				end
			end
		end
	end
	if npc.State == 13 then -- boom fly spawning attack
		if sprite:IsEventTriggered("Shoot") then
			for i = 1, 3 do
				local position = Vector(npc.Position.X + RepentanceBossChampions.choose(14,-14), npc.Position.Y + RepentanceBossChampions.choose(14,-14)):Rotated(math.random(-6,6))
				Isaac.Spawn(EntityType.ENTITY_BOOMFLY, 3, RepentanceBossChampions.choose(0,1), position, Vector(0,0), npc)
			end
		end
	end
end

-------------------------------------------------------
-- Green Champion Horny Boys
-------------------------------------------------------
function RepentanceBossChampions:GreenHornyBoysAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	for _, boomFly in pairs(Isaac.FindByType(EntityType.ENTITY_BOOMFLY,0,-1)) do -- remove boom fly
		if boomFly.SpawnerType == EntityType.ENTITY_HORNY_BOYS then
			boomFly:ToNPC():Morph(25,5,0,-1)
		end
	end
	for _, flyBomb in pairs(Isaac.FindByType(EntityType.ENTITY_FLY_BOMB,1,-1)) do -- remove boom fly
		if flyBomb.SpawnerType == EntityType.ENTITY_HORNY_BOYS then
			flyBomb:Remove()
		end
	end
	for _, bloodProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,0,-1)) do -- recolor the blood shots
		if bloodProj.SpawnerType == EntityType.ENTITY_HORNY_BOYS then
			local color = Color(1,1,1,1,0,0,0)
			color:SetColorize(0.9, 1.9, 0.9, 1)
			bloodProj.Color = color
		end
	end
	if npc.State == 6 then -- brimstone bomb prep
		sprite:Play("BombPoof")
		npc.State = 9
	end
	if npc.State == 9 then
		for _, bloodProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,0,-1)) do -- recolor the blood shots
			if bloodProj.SpawnerType == EntityType.ENTITY_HORNY_BOYS then
				local projdata = bloodProj:GetData()
				if not projdata.New == true then
					bloodProj:Remove()
				end
			end
		end
		if sprite:IsPlaying("BombPoof") then
			if sprite:IsEventTriggered("Shoot") then
				local cloud = Isaac.Spawn(1000, 141, 0, npc.Position, Vector(0,0), npc) -- spawn poison gas cloud
				cloud:ToEffect().Timeout = 250
				data.Angle = math.random(0,45)
				for i = 1, 8 do -- organized ring of shots
					local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(data.Angle+i*45):Resized(10)), npc):ToProjectile() -- spawn projectile
					local color = Color(1,1,1,1,0,0,0)
					color:SetColorize(0.9, 1.9, 0.9, 1)
					proj.Color = color
					local projdata = proj:GetData()
					projdata.New = true
				end
			end
		end
	end
	if npc.State == 11 then -- projectile barrage
		if sprite:IsPlaying("LokiDance5") then
			if sprite:IsEventTriggered("Sound") then
				for _, fireProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,-1,-1)) do -- remove fire projectiles
					if fireProj.SpawnerType == EntityType.ENTITY_HORNY_BOYS then
						if fireProj:ToProjectile().ProjectileFlags == ProjectileFlags.FIRE_WAVE then
							fireProj:Remove()
						end
					end
				end
				for i = 1, 4 do
					local velocity = RepentanceBossChampions.vecToPos(target.Position, npc.Position):Rotated(math.random(-30, 30)) * math.random(5,10)
					local proj = Isaac.Spawn(9, 0, 0, npc.Position, velocity, npc):ToProjectile()
					proj.FallingAccel = 0.6
					proj.FallingSpeed = math.random(-24, -16)
					proj.Scale = 2
					proj.ProjectileFlags = ProjectileFlags.EXPLODE
					proj.Color = Color(0,0.5,0,1,0,0,0)
				end
				for i = 1, 6 do
					local velocity = RepentanceBossChampions.vecToPos(target.Position, npc.Position):Rotated(math.random(-40, 40)) * math.random(16,24)
					local cloud = Isaac.Spawn(1000, 141, 0, npc.Position, velocity, npc) -- spawn poison gas cloud
					cloud:ToEffect().Timeout = 200
					cloud.SpriteScale = Vector(0.75,0.75)
				end
			end
		end
	end
end

-------------------------------------------------------
-- Orange Champion Clutch
-------------------------------------------------------
function RepentanceBossChampions:OrangeClutchAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()

	local splatcolor = Color(1,1,1,0.5,0,0,0)
	splatcolor:SetColorize(5, 3, 0, 1)
	npc.SplatColor = splatcolor

	for _, beam in pairs(Isaac.FindByType(1000,175,-1)) do -- recolor kineti beam
		local beamcolor = Color(1,1,1,0.05,0,0,0)
		beamcolor:SetColorize(2, 1, 0, 1)
		beam:GetSprite().Color = beamcolor
	end

	if npc.State == 7 then -- stunned
		if sprite:IsPlaying("StunEnd") then
			if sprite:IsEventTriggered("Shoot") then
				for i = 1, math.random(3,5) do
					local velocity = Vector(RepentanceBossChampions.choose(math.random(-6, -3), math.random(3, 6)), RepentanceBossChampions.choose(math.random(-6, -3), math.random(3, 6))):Rotated(math.random(-30, 30))
					local fire = Isaac.Spawn(EntityType.ENTITY_FIREPLACE,10,2,npc.Position,velocity,npc)
					fire.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
					fire.HitPoints = math.random(3,5)
				end
			end
		end
	end
	--[[
	if npc.State == 8 then -- moving to another clickety clack
		for _, effect in pairs(Isaac.FindByType(1000,-1,-1)) do -- check effects
			print(effect.Variant)
		end
	end
	--]]
	if npc.State == 9 then
		if sprite:IsPlaying("MoveStart2") then
			if sprite:IsEventTriggered("Shoot") then
				local fire = Isaac.Spawn(EntityType.ENTITY_FIREPLACE,10,2,npc.Position,Vector(0,0),npc)
					fire.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
				end
			end
		end
		if sprite:IsPlaying("MoveLoop2") then
			if sprite:GetFrame() == 2 then
				local fire = Isaac.Spawn(EntityType.ENTITY_FIREPLACE,10,2,npc.Position,Vector(0,0),npc)
				fire.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
				fire.HitPoints = 2
			end
		end
	if npc.State == 10 then -- phase 2 fire shooting attack
		for _, fire in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,2,0)) do -- recolor fire to orange
			if fire.SpawnerType == EntityType.ENTITY_CLUTCH then
				fire:GetSprite().Color = Color(1,1,1,1,0,0,0)
			end
		end
	end
	if npc.State == 16 then -- transition
		for _, purpleFire in pairs(Isaac.FindByType(EntityType.ENTITY_FIREPLACE,13,0)) do -- remove fireplace
			purpleFire:Remove()
		end
	end
end

function RepentanceBossChampions:OrangeClicketyClackAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	if npc.Variant == 10 then
		if npc.State == 16 then -- downed
			if sprite:IsPlaying("FlameShoot") then
				if sprite:IsEventTriggered("Footstep") then
					npc:PlaySound(SoundEffect.SOUND_CANDLE_LIGHT , 1.25, 0, false, 1)
					Isaac.Spawn(1000,15,1, Vector(npc.Position.X + 4, npc.Position.Y - 16), Vector(0,0), npc).Color = Color(2,1.15,0,0.7,0,0,0)
				end
				if sprite:IsEventTriggered("ShootAlt") then
					local eff = Isaac.Spawn(1000,147,0, Vector(npc.Position.X + 3, npc.Position.Y), Vector(0,0), npc)
					npc:PlaySound(SoundEffect.SOUND_SCAMPER , 1, 0, false, 1)
					local velocity = RepentanceBossChampions.vecToPos(target.Position, npc.Position)*6
					local proj = Isaac.Spawn(9,1,0, npc.Position, velocity, npc):ToProjectile()
					local projdata = proj:GetData()
					projdata.FireShot = true
					projdata.SmallFireShot = true
					projdata.New = true
					proj.FallingSpeed = -20
					proj.FallingAccel = 1.2
				end
			end
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.OrangeClicketyClackAI, 889)

-------------------------------------------------------
-- Black Champion Clutch
-------------------------------------------------------
function RepentanceBossChampions:BlackClutchAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()

	local splatcolor = Color(1,1,1,0.5,0,0,0)
	splatcolor:SetColorize(0.25, 0.25, 0.25, 1)
	npc.SplatColor = splatcolor

	if data.BallTimer == nil then
		data.BallTimer = 1
	end

	for _, beam in pairs(Isaac.FindByType(1000,175,-1)) do -- recolor kineti beam
		local beamcolor = Color(1,1,1,0.05,0,0,0)
		beamcolor:SetColorize(1, 1, 1.2, 1)
		beam:GetSprite().Color = beamcolor
	end

	if npc.State == 7 then -- stunned
		if sprite:IsPlaying("Stun") then
			if sprite:GetFrame() == 1 then
				Isaac.Spawn(404, 1, 0, npc.Position, Vector(math.random(-6,6),math.random(-6,6)), npc):ClearEntityFlags(EntityFlag.FLAG_APPEAR)
			end
		end
		if sprite:IsPlaying("StunEnd") then
			if sprite:IsEventTriggered("Shoot") then
				for i = 1, 2 do
					Isaac.Spawn(404, 1, 0, npc.Position, Vector(math.random(-6,6),math.random(-6,6)), npc):ClearEntityFlags(EntityFlag.FLAG_APPEAR)
				end
			end
		end
	end
	if npc.State == 9 then -- phase 2 fire shooting attack prep
		if sprite:IsPlaying("MoveStart2") then
			if sprite:IsEventTriggered("Shoot") then
				data.BallTimer = data.BallTimer + 1
				if data.BallTimer == 2 then
					Isaac.Spawn(1000,15,0, npc.Position, Vector(0,0), npc).Color = Color(0.35,0.35,0.35,0.75,0,0,0)
					Isaac.Spawn(404, 1, 0, npc.Position, Vector(math.random(-12,12),math.random(-12,12)), npc):ClearEntityFlags(EntityFlag.FLAG_APPEAR)
					data.BallTimer = 0
				end
			end
		end
	end
	if npc.State == 10 then -- phase 2 fire shooting attack
		for _, fire in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,2,0)) do -- recolor fire to orange
			if fire.SpawnerType == EntityType.ENTITY_CLUTCH then
				local whitefire = Color(1,1,1,1,0,0,0)
				whitefire:SetColorize(1.2,1.2,1.5,1)
				fire:GetSprite().Color = whitefire
			end
		end
	end
	if npc.State == 16 then -- transition
		for _, purpleFire in pairs(Isaac.FindByType(EntityType.ENTITY_FIREPLACE,13,0)) do -- remove fireplace
			purpleFire:Remove()
		end
	end
end

function RepentanceBossChampions:BlackClicketyClackAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	if npc.Variant == 20 then
		if npc.State == 16 then
			if sprite:IsPlaying("FlameCollapse") or sprite:IsPlaying("Collapse") then
				if sprite:GetFrame() == 1 then
					Isaac.Explode(npc.Position, npc, 1.0)
				end
			end
		end
	end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_NPC_UPDATE, RepentanceBossChampions.BlackClicketyClackAI, 889)

-------------------------------------------------------
-- Black Champion The Siren
-------------------------------------------------------
function RepentanceBossChampions:BlackSirenAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	if npc.State == 8 then -- projecitle ring
	end
	if npc.State == 10 then -- charm familiars
		data.NextState = RepentanceBossChampions.choose(6,8)
		if data.NextState == 6 then
			sprite:Play("Teleport")
			npc.State = 6
		elseif data.NextState == 8 then
			sprite:Play("Attack1Start")
			npc.State = 8
		end
	end

	--[[

	if npc.State == 9 then -- CUT MUSICAL NOTE ATTACK!
		if sprite:IsPlaying("Attack2Start") then
			if sprite:IsEventTriggered("Shoot") then
				npc:PlaySound(SoundEffect.SOUND_SIREN_SING, 1, 0, false, 1)
			end
		end
		if sprite:IsPlaying("Attack2Loop") or (sprite:IsPlaying("Attack2Start") and sprite:GetFrame() >= 29) then
			for _, bloodProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,0,-1)) do -- recolor the blood shots
				if bloodProj.SpawnerType == EntityType.ENTITY_SIREN then
					local color = Color(1,1,1,1,0,0,0)
					color:SetColorize(3,0.6,2.5,1)
					bloodProj.Color = color
					bloodProj:ToProjectile().Scale = 1.5
					bloodProj.Velocity = bloodProj.Velocity * 0.99
				end
			end
		end
		if sprite:IsFinished("Attack2End") then
			npc.StateFrame = 0
			npc.State = 3
		end
	end

	]]--

	if npc.State == 11 then -- tear swipe
	end
	if npc.State == 12 then -- summon minions
		data.NextState = RepentanceBossChampions.choose(6,8)
		if data.NextState == 6 then
			sprite:Play("Teleport")
			npc.State = 6
		elseif data.NextState == 8 then
			sprite:Play("Attack1Start")
			npc.State = 8
		end
	end
	if npc.State ==  6 then -- phasing into ground
		data.SplatTimer = 0
		for _, blackCreep in pairs(Isaac.FindByType(1000,EffectVariant.CREEP_BLACK,-1)) do -- morph black creep into red creep
			blackCreep:Remove()
		end
		data.Chance = math.random(0,100)
		if data.Chance <= 65 then
			local RedCreep = Isaac.Spawn(1000, EffectVariant.CREEP_RED, 0, npc.Position, Vector(0,0), npc) -- spawn creep
			RedCreep.SpriteScale = Vector(1,1)
			RedCreep:ToEffect().Timeout = 200
			RedCreep:Update()
		end
		if sprite:IsEventTriggered("Shoot") then
			local Splat = Isaac.Spawn(1000,2,2, Vector(npc.Position.X, npc.Position.Y), Vector(0,0), npc)
			Splat.DepthOffset = 100
		end
	end
	if npc.State == 4 then -- black creep phase
		npc.Velocity = npc.Velocity * 0.8
		for _, blackCreep in pairs(Isaac.FindByType(1000,EffectVariant.CREEP_BLACK,-1)) do -- morph black creep into red creep
			blackCreep:Remove()
		end
		data.Chance = math.random(0,100)
		if data.Chance <= 35 then
			local RedCreep = Isaac.Spawn(1000, EffectVariant.CREEP_RED, 0, npc.Position, Vector(0,0), npc) -- spawn creep
			RedCreep.SpriteScale = Vector(1,1)
			RedCreep:ToEffect().Timeout = 200
			RedCreep:Update()
		end
		data.SplatTimer = data.SplatTimer + 1
		if data.SplatTimer >= 4 then
			data.SplatTimer = 0
			local Splat = Isaac.Spawn(1000,2,2, Vector(npc.Position.X, npc.Position.Y), Vector(0,0), npc)
			Splat.DepthOffset = 100
			Splat.SpriteRotation = math.random(0,360)
		end
	end
	if npc.State == 7 then -- emerge
		for _, blackCreep in pairs(Isaac.FindByType(1000,EffectVariant.CREEP_BLACK,-1)) do -- morph black creep into red creep
			blackCreep:Remove()
		end
		if sprite:IsEventTriggered("Shoot") then
			npc:PlaySound(SoundEffect.SOUND_BLOODSHOOT, 1, 0, false, 1)
			data.Angle = math.random(0,36)
			for i = 1, 10 do -- organized ring of shots
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(data.Angle+i*36):Resized(10)), npc):ToProjectile() -- spawn projectile
			end
		end
	end
end

-------------------------------------------------------
-- Red Champion The Siren
-------------------------------------------------------
function RepentanceBossChampions:PurpleSirenAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	if data.FearTimer == nil then data.FearTimer = 0 end
	for i = 1,Game():GetNumPlayers() do
		local player = Isaac.GetPlayer(i-1)
		if player:HasEntityFlags(EntityFlag.FLAG_FEAR) then
			data.FearTimer = data.FearTimer + 1
			if data.FearTimer >= 150 then
				player:ClearEntityFlags(EntityFlag.FLAG_FEAR)
				player.Color = Color(1,1,1,1,0,0,0)
				data.FearTimer = 0
			end
		end
	end

	if npc.State == 8 then -- projecitle ring
		if sprite:IsPlaying("Attack1Start") then
			if sprite:GetFrame() == 0 then
				data.NextState = RepentanceBossChampions.choose(8,9)
				if data.NextState == 9 then
					sprite:Play("Attack2Start")
					npc.State = 9
				end
			end
		end
	end

	if npc.State ==  6 then -- phasing into ground
		if sprite:IsEventTriggered("Shoot") then
			Isaac.Spawn(212, 2, 32, npc.Position, Vector(0,0), npc) -- Siren's Cursed Death's Head
			npc:PlaySound(SoundEffect.SOUND_SIREN_MINION_SMOKE, 1, 0, false, 1)
		end
	end

	if npc.State == 9 then -- CUT MUSICAL NOTE ATTACK!
		if sprite:IsPlaying("Attack2Start") then
			if sprite:IsEventTriggered("Shoot") then
				npc:PlaySound(SoundEffect.SOUND_SIREN_SING, 1, 0, false, 1)
			end
		end
		if sprite:IsPlaying("Attack2Loop") or (sprite:IsPlaying("Attack2Start") and sprite:GetFrame() >= 29) then
			for _, bloodProj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,0,-1)) do -- recolor the blood shots
				if bloodProj.SpawnerType == EntityType.ENTITY_SIREN then
					bloodProj.Color = Color(1,1,1,1,0.25,0,0)
					bloodProj.Velocity = bloodProj.Velocity * 0.985
					bloodProj:ToProjectile().Height = -23
					bloodProj:ToProjectile().FallingSpeed = 0
					bloodProj:ToProjectile().FallingAccel = -0.05
					bloodProj:ToProjectile().Scale = 1.5
					projdata = bloodProj:GetData()
					projdata.Fear = true
				end
			end
			--for i = 1,Game():GetNumPlayers() do
				--local player = Isaac.GetPlayer(i-1)
				--player:AddEntityFlags(EntityFlag.FLAG_FEAR)
				--player.Color = Color(0.5,0.1,0.5,1,0,0,0)
			--end
		end
		if sprite:IsFinished("Attack2End") then
			npc.StateFrame = 0
			npc.State = 3
		end
	end

	if npc.State == 11 then -- tear swipe
	end
	if npc.State == 12 then -- summon minions
		if sprite:IsPlaying("Recall") then
			if sprite:IsEventTriggered("Sound") then
				Isaac.Spawn(212, 2, 32, Vector(npc.Position.X, npc.Position.Y + 48), Vector(0,0), npc) -- Siren's Cursed Death's Head
			end
		end
	end
end

function RepentanceBossChampions:RedCursedDeathsHead(npc, dmgAmount, flags, source, frames)
 if npc.Variant == 2 and npc.SubType == 32 then
	npc.SplatColor = Color(1,1,1,1,0,0,0)
    local data = npc:GetData()
	   npc:SetColor(Color(1, 1, 1, 1, 150/255, 0/255, 0/255), 2, 10, false, true )
    if data.RealHp == nil then
      data.RealHp = npc.HitPoints
    end
    data.RealHp = data.RealHp - dmgAmount
    if data.RealHp <= 0 then
       npc:Kill()
    end
 end
end
RepentanceBossChampions:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, RepentanceBossChampions.RedCursedDeathsHead, 212)

-------------------------------------------------------
-- Red Champion The Heretic
-------------------------------------------------------
function RepentanceBossChampions:RedHereticAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()
	if npc.State == 7 then -- lighting fires
		sprite:Play("Attack1")
		npc.State = 8
		for i=1,4 do
			local targetPos = Vector(1,0):Rotated(i*90)
			local tracer = Isaac.Spawn(1000, EffectVariant.GENERIC_TRACER, 0, npc.Position, Vector(0,0), npc):ToEffect()
			tracer.LifeSpan = 20
			tracer.Timeout = 20
			tracer.TargetPosition = targetPos
			tracer:FollowParent(npc)
			local tracerColor = Color(2,0.3,0.3,0.2)
			tracer:SetColor(tracerColor, 110, 1, false, false)
		end
	end
	if npc.State == 8 then -- brimstone
		if sprite:IsPlaying("Attack1") then
			if sprite:IsEventTriggered("Shoot") then
				for _, brimstone in pairs(Isaac.FindByType(EntityType.ENTITY_LASER,-1,-1)) do -- remove brimstone
					if brimstone.SpawnerType == EntityType.ENTITY_HERETIC then
						local brimstonedata = brimstone:GetData()
						if not brimstonedata.New == true then
							brimstone:Remove()
						end
					end
				end
				data.Angle = 0
				for i = 1, 4 do
					data.Angle = data.Angle + 90
					local brimstone = Isaac.Spawn(7,1,0,npc.Position, Vector(0,0), npc):ToLaser()
					brimstone.AngleDegrees = data.Angle
					brimstone.PositionOffset = Vector(0, -26)
					brimstone.SpawnerEntity = npc
					brimstone.Parent = npc
					brimstone:SetTimeout(40)
					brimstone:Update()
				end
			end
			if sprite:GetFrame() == 30 or sprite:GetFrame() == 45 or sprite:GetFrame() == 60 then
				npc:PlaySound(SoundEffect.SOUND_BLOODSHOOT, 1, 0, false, 1)
				data.ShotAngle = math.random(0,36)
				for i = 1, 16 do -- organized ring of shots
					local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(data.ShotAngle+i*22.5):Resized(10)), npc):ToProjectile() -- spawn projectile
					proj.FallingSpeed = 0
					proj.FallingAccel = -0.05
				end
			end
		end
	end
	--[[
	if npc.State == 12 then -- bite attack
		if sprite:IsPlaying("ChargeEndLeft") or sprite:IsPlaying("ChargeEndRight") then
			if sprite:IsEventTriggered("Shoot") then
				for i = 1, 8 do -- organized ring of shots
					local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(i*45):Resized(10)), npc):ToProjectile() -- spawn projectile
				end
			end
		end
	end
	]]
	if npc.State == 14 then -- shot lobbing attack
		for _, proj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,2,-1)) do -- remove fire shots
			if proj.SpawnerType == EntityType.ENTITY_HERETIC then
				proj:Remove()
			end
		end
		if sprite:IsEventTriggered("ShootAlt") then
			local Splat = Isaac.Spawn(1000,2,2, Vector(npc.Position.X, npc.Position.Y - 56), Vector(0,0), npc)
			Splat.DepthOffset = 100
			local Target = Isaac.Spawn(1000, 153, 0, target.Position, Vector(0,0), npc):ToEffect()
			Target.Color = Color(1.25,0,0,1,0,0,0)
			Target:SetTimeout(50)
			npc:PlaySound(SoundEffect.SOUND_MONSTER_GRUNT_2 , 1, 0, false, 1)
			local velocity = (target.Position - npc.Position) * 0.05 * 4.4 * 0.1
			local length = velocity:Length()
			local proj = Isaac.Spawn(9,0,0, npc.Position, velocity, npc):ToProjectile()
			local projdata = proj:GetData()
			projdata.RedCreep = true
			proj.ProjectileFlags = ProjectileFlags.EXPLODE
			proj.Color = Color(1,1,1,1,0.5,0,0)
			proj.FallingSpeed = -44
			proj.FallingAccel = 1.05
			proj.Scale = 3
		end
	end
	if npc.State == 15 then -- slam attack
		for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT,147,1)) do
			if ent.SpawnerType == 905 then
				ent:Remove()
			end
		end
		for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT,148,1)) do
			if ent.SpawnerType == 905 then
				ent:Remove()
			end
		end
		for _, proj in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE,2,-1)) do -- remove fire shots
			if proj.SpawnerType == EntityType.ENTITY_HERETIC then
				proj:Remove()
			end
		end
		if sprite:IsEventTriggered("Shoot") then
			local RedCreep = Isaac.Spawn(1000, EffectVariant.CREEP_RED, 0, npc.Position, Vector(0,0), npc) -- spawn yellow creep
			RedCreep.SpriteScale = Vector(2.5,2.5)
			RedCreep:ToEffect().Timeout = 200
			RedCreep:Update()
		end
		if sprite:IsEventTriggered("Sound") then
			for i = 1, 8 do -- organized ring of shots
				local proj = Isaac.Spawn(9, 0, 0, npc.Position, (Vector.FromAngle(22.5+i*45):Resized(10)), npc):ToProjectile() -- spawn projectile
			end
		end
	end
end

-------------------------------------------------------
-- Purple Champion The Heretic
-------------------------------------------------------
function RepentanceBossChampions:PurpleHereticAI(npc)
	local data = npc:GetData()
	local sprite = npc:GetSprite()
	local target = npc:GetPlayerTarget()

	if npc.State ~= 8 then
		data.PurpleFire = false
	end
	if npc.State == 8 then -- brimstone
		if sprite:IsPlaying("Attack1") then
			for _, purplefire in pairs(Isaac.FindByType(EntityType.ENTITY_FIREPLACE,3,-1)) do -- shoot from purple fires
				if sprite:IsEventTriggered("Shoot") then
					data.PurpleFire = true
					npc:PlaySound(SoundEffect.SOUND_FIRE_RUSH , 1, 0, false, 1)
				end
			end
		end
		for _, brimstone in pairs(Isaac.FindByType(EntityType.ENTITY_LASER,-1,-1)) do -- remove brimstone
			if brimstone.SpawnerType == EntityType.ENTITY_HERETIC then
				brimstone:Remove()
			end
		end
	end
	if npc.State == 14 then -- shot lobbing attack
		if sprite:IsEventTriggered("ShootAlt") then
			npc:PlaySound(SoundEffect.SOUND_MONSTER_GRUNT_2 , 1, 0, false, 1)
			data.CurveDir = RepentanceBossChampions.choose(1,2)
			data.ShotAngle = math.random(0,45)
			for i = 1, 8 do --  ring of shots
				local proj = Isaac.Spawn(9, 2, 0, npc.Position, (Vector.FromAngle(data.ShotAngle+i*45):Resized(10)), npc):ToProjectile() -- spawn projectile
				if data.CurveDir == 1 then
					proj.ProjectileFlags = ProjectileFlags.CURVE_LEFT
				elseif data.CurveDir == 2 then
					proj.ProjectileFlags = ProjectileFlags.CURVE_RIGHT
				end
				local color = Color(1,1,1,1,0,0,0)
				color:SetColorize(1.25,1,2.25,1)
				proj.Color = color
				proj.CurvingStrength = 0.005
				proj.Height = -6
				proj.FallingSpeed = 0
				proj.FallingAccel = -0.097
			end
		end
	end
end

print("Repentance Boss Champions "..version..": has been loaded!")