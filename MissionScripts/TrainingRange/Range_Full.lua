------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- The Boomiest of Target Ranges - By TheDude
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--DISCLAIMER:  THIS SCRIPT IS A WIP< DO NOT ATTEMPT TO USE.  IT WILL ABSOLUTELY CRASH YOUR SHIT.

--[[
TODO

BTR and BMP spawns/ random zones in precision range
Stoppage of Gauntlet
Clear script not breaking fucking everything
write Antishipping section/  still need to finish templates in ME



TODO Testing

CBrange spawns
PBrange spawns
STrange dimensions and setup, check headings to ensure propper strafe pass results
StaticRange spawns
LiveRange Spawns
SAMRange spawns and clear
Shipping range spawns

Scoring
Range Functions




]]


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SETUP
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local DEBUG = true

if DEBUG then
 BASE:TraceOnOff(true)
 BASE:TraceLevel(1)
 BASE:TraceClass("RANGE")
end



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO RANGE ZONES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--conventional bombing range target circles
local CBRange = ZONE:New("CBRANGE")
--precision bombing range
local PBRange = ZONE:New("PBRANGE")
--strafing range
local STRange = ZONE:New("STRANGE")
--static target range (spawnables)
local StaticRange = ZONE:New("STATICRANGE")
--live target range
local LiveRange = ZONE:New("LIVERANGE")
--SAM Range
local SAMRange = ZONE:New("SAMRANGE")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SPAWN ZONES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local t90SpawnZone = ZONE:New("T90Zone")
local t80SpawnZone = ZONE:New("T80Zone")
local t72SpawnZone = ZONE:New("T72Zone")
local uralSpawnZone = ZONE:New("UralZone")
local t90HostSpawnZone = ZONE:New("T90ZoneHostile")
local t80HostSpawnZone = ZONE:New("T80ZoneHostile")
local t72HostSpawnZone = ZONE:New("T72ZoneHostile")
local armoredTruckSpawnZone = ZONE:New("ArmoredTruckZone")
local jeepSpawnZone = ZONE:New("JeepZone")


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SETS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local clientSet = SET_CLIENT:New():FilterTypes({"plane", "helicopter"}):FilterStart()
local targetSet = SET_GROUP:New():FilterCoalitions("red"):FilterStart()


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO FLAGS FOR SPAWN LIMITERS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function flagReset()

  T72Flag = USERFLAG:New("T72Spawned")
  T72Flag:Set(0,0)

  T80Flag = USERFLAG:New("T80Spawned")
  T80Flag:Set(0,0)

  T90Flag = USERFLAG:New("T90Spawned")
  T90Flag:Set(0,0)

  UralFlag = USERFLAG:New("UralSpawned")
  UralFlag:Set(0,0)

  ArmoredTruckFlag = USERFLAG:New("ArmoredTruckSpawned")
  ArmoredTruckFlag:Set(0,0)

  JeepFlag = USERFLAG:New("JeepSpawned")
  JeepFlag:Set(0,0)

  T72HFlag = USERFLAG:New("T72HSpawned")
  T72HFlag:Set(0,0)

  T80HFlag = USERFLAG:New("T80HSpawned")
  T80HFlag:Set(0,0)

  T90HFlag = USERFLAG:New("T90HSpawned")
  T90HFlag:Set(0,0)

  BTRFlag = USERFLAG:New("BTRSpawned")
  BTRFlag:Set(0,0)

  BMPFlag = USERFLAG:New("BMPSpawned")
  BMPFlag:Set(0,0)

  ZU23Flag = USERFLAG:New("ZU23Spawned")
  ZU23Flag:Set(0,0)

  ShilkaFlag = USERFLAG:New("ShilkaSpawned")
  ShilkaFlag:Set(0,0)

  InfantryFlag = USERFLAG:New("InfantrySpawned")
  InfantryFlag:Set(0,0)

  Static1Flag = USERFLAG:New("Static1Spawned")
  Static1Flag:Set(0,0)

  Static2Flag = USERFLAG:New("Static2Spawned")
  Static2Flag:Set(0,0)

  Static3Flag = USERFLAG:New("Static3Spawned")
  Static3Flag:Set(0,0)

  Static4Flag = USERFLAG:New("Static4Spawned")
  Static4Flag:Set(0,0)
--SAMRANGE flags  
  SA2Flag = USERFLAG:New("SA2Spawned")
  SA2Flag:Set(0,0)

  SA3Flag = USERFLAG:New("SA3Spawned")
  SA3Flag:Set(0,0)

  SA5Flag = USERFLAG:New("SA5Spawned")
  SA5Flag:Set(0,0)

  SA6Flag = USERFLAG:New("SA6Spawned")
  SA6Flag:Set(0,0)

  SA8Flag = USERFLAG:New("SA8Spawned")
  SA8Flag:Set(0,0)

  ManpadFlag = USERFLAG:New("ManpadSpawned")
  ManpadFlag:Set(0,0)

  SA10Flag = USERFLAG:New("SA10Spawned")
  SA10Flag:Set(0,0)

  SA11Flag = USERFLAG:New("SA11Spawned")
  SA11Flag:Set(0,0)

  SA12Flag = USERFLAG:New("SA12Spawned")
  SA12Flag:Set(0,0)
  
  IHMSFlag = USERFLAG:New("IHMSSpawned")
  IHMSFlag:Set(0,0)
  
  GAUNTLETFLAG = USERFLAG:New("Gauntlet")
  GAUNTLETFLAG:Set(0.0)

end

local initialReset = flagReset()

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO MESSAGES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local nospawnmessage = MESSAGE:New("You may not spawn anymore of these targets",10)
local preparefordeathmessage = MESSAGE:New("Prepare for Death.",10)
local gauntletstart = MESSAGE:New("Air to Air Gauntlet Started, Targets will spawn inside the defined engagement zone.")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO TABLES/GROUPS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO EVENT HANDLERS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




--Target Event Handlers
targetSet:HandleEvent(EVENTS.Hit)
targetSet:HandleEvent(EVENTS.Dead)
targetSet:HandleEvent(EVENTS.Birth)
targetSet:HandleEvent(EVENTS.Kill)


--Client Event Handlers
clientSet:HandleEvent(EVENTS.Crash)
clientSet:HandleEvent(EVENTS.Hit)
clientSet:HandleEvent(EVENTS.Dead)
clientSet:HandleEvent(EVENTS.Land)
clientSet:HandleEvent(EVENTS.PlayerEnterAircraft)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SOUNDS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--consider adding a timer here to avoid sound playing before client fully loads in
function clientSet:OnEventPlayerEnterAircraft(EventData)
  local file = "sparta.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end


function clientSet:OnEventCrash(EventData)
  local file = "jackpot.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function targetSet:OnEventKill(EventData)
  local file = "ohyeah.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

--Client Sound Functions
function clientSet:OnEventDead(EventData)
  local file = "Oh Jesus.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function clientSet:OnEventLand(EventData)
  local file = "GreatSuccess.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function clientSet:OnEventPlayerEnterAircraft(EventData)
  local file = "allyourshit.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

--Target Sound Functions

function targetSet:OnEventKill(EventData)
  local file = "GreatSuccess.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function targetSet:OnEventBirth(EventData)
  local file = "pieceofcandy.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SETUP RANGES AND SCORING
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----conventional bombing range target circles
--local CBRange = ZONE:New("CBRANGE"):SmokeZone(SMOKECOLOR.Blue)
----precision bombing range
--local PBRange = ZONE:New("PBRANGE"):SmokeZone(SMOKECOLOR.Green)
----strafing range
--local STRange = ZONE:New("STRANGE"):SmokeZone(SMOKECOLOR.Orange)
----static target range (spawnables)
--local StaticRange = ZONE:New("STATICRANGE"):SmokeZone(SMOKECOLOR.White)
----live target range
--local LiveRange = ZONE:New("LIVERANGE"):SmokeZone(SMOKECOLOR.White)
----SAM Range
--local SAMRange = ZONE:New("SAMRANGE"):SmokeZone(SMOKECOLOR.Red)
--

--RANGE SCORE

local rangeScore = SCORING:New("Training Range")

  rangeScore:SetDisplayMessagePrefix("Rangemaster")
  rangeScore:SetMessagesDestroy(true)
  rangeScore:SetMessagesHit(true)
  rangeScore:SetScaleDestroyScore(3)
  rangeScore:AddZoneScore(SAMRange,100)  


--conventional range

local cbRange = RANGE:New("Conventional Bombing Range")

  cbRange:SetRangeZone(ZONE:FindByName("CBRANGE"))
  cbRange:AddBombingTargets({"BC1", "BC2", "BC3", "BC4", "BC5"}, 10, false)
  cbRange:AddBombingTargets({"BC6", "BC7"}, 5, false)

  cbRange:Start()
--precision range

local pbRange = RANGE:New("Precision Bombing Range")
  
  pbRange:SetRangeZone(ZONE:FindByName("PBRANGE"))
  
  pbRange:Start()
--strafing range

local stRange = RANGE:New("Strafing Range")

  stRange:SetRangeZone(ZONE:FindByName("STRANGE"))

  stRange:Start()
--staticrange

local staticRange = RANGE:New("Static Spawn Range")

  staticRange:SetRangeZone(ZONE:FindByName("STATICRANGE"))

  staticRange:Start()
--live range

local liveRange = RANGE:New("Live Hostile Range")

  liveRange:SetRangeZone(ZONE:FindByName("LIVERANGE"))
  
  liveRange:Start()
--sam range

local samRange = RANGE:New("Live SAM Range")

  samRange:SetRangeZone(ZONE:FindByName("SAMRANGE"))

  samRange:Start()



--shipping range

local shippingRange = RANGE:New("Anti Shipping Range")

  shippingRange:SetRangeZone(ZONE:FindByName("ANTISHIPRANGE"))

  shippingRange:Start()

--scoring for gauntlet

--use rangescore here instead of RANGE


--scoring for afstrikesim

--use rangescore here instead of RANGE

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO MAIN
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--TODO SPAWN FUNCTIONS

function TARGET_T72()
  if T72Flag:Is(0) then
  local spawnT72 = SPAWN:NewWithAlias("T72", "T72")
    spawnT72:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        staticRange:AddBombingTargetGroup(Target,10)
        T72Flag:Set(1,0)
      end)
    :InitLimit(5,5)
--    :InitGrouping(5)
    :InitAIOnOff(false)
    :SpawnInZone(t72SpawnZone,true)
    :SmokeRed()
  else if T72Flag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end


function TARGET_T80()
  if T80Flag:Is(0) then
  local spawnT80 = SPAWN:NewWithAlias("T80", "T80")
    spawnT80:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        staticRange:AddBombingTargetGroup(Target,10)
        T80Flag:Set(1,0)
      end)
    :InitLimit(5,5)
    :InitGrouping(5)
    :InitAIOnOff(false)
    :SpawnInZone(t80SpawnZone,true)
    :SmokeRed()
  else if T80Flag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end



function TARGET_T90()
  if T90Flag:Is(0) then
  local spawnT90 = SPAWN:NewWithAlias("T90", "T90")
    spawnT90:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        staticRange:AddBombingTargetGroup(Target,10)
        T90Flag:Set(1,0)
      end)
    :InitLimit(5,5)
    :InitGrouping(5)
    :InitAIOnOff(false)
    :SpawnInZone(t90SpawnZone,true)
    :SmokeRed()
  else if T90Flag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end



function TARGET_URALS()
  if UralFlag:Is(0) then
  local spawnUral = SPAWN:NewWithAlias("Ural", "Ural")
    spawnUral:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        staticRange:AddBombingTargetGroup(Target,10)
        UralFlag:Set(1,0)
      end)
    :InitLimit(5,5)
    :InitGrouping(5)
    :InitAIOnOff(true)
    :SpawnInZone(uralSpawnZone,true)
    :SmokeRed()
  else if UralFlag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end


function TARGET_ARMORED()
  if ArmoredTruckFlag:Is(0) then
    local spawnArmoredTruck = SPAWN:NewWithAlias("ArmoredTruck", "ArmoredTruck")
    spawnArmoredTruck:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        staticRange:AddBombingTargetGroup(Target, 10)
        ArmoredTruckFlag:Set(1, 0)
      end)
     :InitLimit(5,5)
     :InitGrouping(5)
     :InitAIOnOff(true)
     :SpawnInZone(armoredTruckSpawnZone, true)
     :SmokeRed()
  else if ArmoredTruckFlag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end



function TARGET_JEEPS()
  if JeepFlag:Is(0) then
    local spawnJeep = SPAWN:NewWithAlias("Jeep", "Jeep")
    spawnJeep:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        staticRange:AddBombingTargetGroup(Target, 10)
        JeepFlag:Set(1, 0)
      end)
     :InitLimit(5,5)
     :InitGrouping(5)
     :InitAIOnOff(true)
     :SpawnInZone(jeepSpawnZone, true)
     :SmokeRed()
  else if JeepFlag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end


function TARGET_T72_HOSTILE()
  if T72HFlag:Is(0) then
    local spawnT72Hostile = SPAWN:NewWithAlias("T72", "T72Hostile")
    spawnT72Hostile:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        liveRange:AddBombingTargetGroup(Target, 10)
        T72HFlag:Set(1, 0)
      end)
     :InitLimit(5,5)
     :InitGrouping(5)
     :InitAIOnOff(true)
     :SpawnInZone(t72HostSpawnZone, true)
     :SmokeRed()
  else if T72HFlag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end


function TARGET_T80_HOSTILE()
  if T80HFlag:Is(0) then
    local spawnT80Hostile = SPAWN:NewWithAlias("T80", "T80Hostile")
    spawnT80Hostile:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        liveRange:AddBombingTargetGroup(Target, 10)
        T80HFlag:Set(1,0)
      end)
     :InitLimit(5,5)
     :InitGrouping(5)
     :InitAIOnOff(true)
     :SpawnInZone(t80HostSpawnZone,true)
     :SmokeRed()
  else if T80HFlag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end


function TARGET_T90_HOSTILE()
  if T90HFlag:Is(0) then
    local spawnT90Hostile = SPAWN:NewWithAlias("T90", "T90Hostile")
    spawnT90Hostile:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        liveRange:AddBombingTargetGroup(Target,10)
        T90HFlag:Set(1,0)    
      end)    
    :InitLimit(5,5)
    :InitGrouping(5)
    :InitAIOnOff(true)
    :SpawnInZone(t90HostSpawnZone,true)
    :SmokeRed()
  else if T90HFlag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end

--REWORK BTR for use IN precision range
--function TARGET_BTR()
--  if BTRFlag:Is(0) then
--    local spawnBTR = SPAWN:NewWithAlias("BTR", "BTR")
--    spawnBTR:OnSpawnGroup(
--      function(SpawnGroup)
--        local Target = SpawnGroup
--        Range:AddBombingTargetGroup(Target,1)
--        BTRFlag:Set(1,0)
--      end)
--    :InitLimit(1,0)
--    :InitAIOnOff(false)
--    :SpawnInZone(enclosedTargetZone, false)
--  else if BTRFlag:Is(1) then
--    nospawnmessage:ToAll()
--    return
--    end
--  end
--end


--rework BMP for use in Precision Range
--function TARGET_BMP()
--  if BMPFlag:Is(0) then
--    local spawnBMP = SPAWN:NewWithAlias("BMP", "BMP")
--    spawnBMP:OnSpawnGroup(
--      function(SpawnGroup)
--        local Target = SpawnGroup
--        Range:AddBombingTargetGroup(Target,2)
--        BMPFlag:Set(1,0)
--      end)
--    :InitLimit(5,5)
--    :InitAIOnOff(false)
--    :InitRandomizeZones(rZoneTable)
--    :SpawnScheduled(2,.5)
--  else if BMPFlag:Is(1) then
--    nospawnmessage:ToAll()
--    return
--    end
--  end
--end



function TARGET_ZU23()
  if ZU23Flag:Is(0) then
    local spawnZU23 = SPAWN:NewWithAlias("ZU23", "ZU23")
    spawnZU23:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        liveRange:AddBombingTargetGroup(Target,5)
        ZU23Flag:Set(1,0)
      end)
    :InitGrouping(2)
    :InitLimit(2,2)
    :InitAIOnOff(true)
    :SpawnInZone(AAASpawnZone,true)
    :SmokeRed()
  else if ZU23Flag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end



function TARGET_SHILKA()
  if ShilkaFlag:Is(0) then
    local spawnShilka = SPAWN:NewWithAlias("Shilka", "Shilka")
    spawnShilka:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        liveRange:AddBombingTargetGroup(Target,5)
        ShilkaFlag:Set(1,0)
      end)
    :InitGrouping(2)
    :InitLimit(2,2)
    :InitAIOnOff(true)
    :SpawnInZone(AAASpawnZone,true)
    :SmokeRed()
  else if ShilkaFlag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end



function TARGET_INFANTRY()
  if InfantryFlag:Is(0) then
    local spawnInfantry = SPAWN:NewWithAlias("Infantry", "Infantry")
    spawnInfantry:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        liveRange:AddBombingTargetGroup(Target,5)
        InfantryFlag:Set(1,0)
      end)
    :InitGrouping(20)
    :SpawnInZone(infantrySpawnZone,false)
    :SmokeRed()
  else if InfantryFlag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end




--SAMRANGE

--TODO SPAWN FUNCTIONS
--Easy Non Complex Spawns
--SA2, SA3, SA5 with AAA defending radars.  No close range sams.  No Shorad.


function TARGET_SA2()
  if SA2Flag:Is(0) then
  local spawn = SPAWN:NewWithAlias("SA2", "SA2")
    spawn:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        SA2Flag:Set(1,0)
      end)
    :InitAIOnOff(true)
    :SpawnInZone(rangeZone,true)
    :SmokeRed()
    
--  samRange:AddBombingTargetGroup(Target,10,false)  --this is potentially a bad way to score, as it will require killing the entire group.  Potential fix would be a zone score multiplier
  else if SA2Flag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end

function TARGET_SA3()
  if SA3Flag:Is(0) then
  local spawn = SPAWN:NewWithAlias("SA3", "SA3")
    spawn:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        SA3Flag:Set(1,0)
      end)
    :InitAIOnOff(true)
    :SpawnInZone(rangeZone,true)
    :SmokeRed()
  else if SA3Flag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end


function TARGET_SA5()
  if SA5Flag:Is(0) then
  local spawn = SPAWN:NewWithAlias("SA5", "SA5")
    spawn:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        SA5Flag:Set(1,0)
      end)
    :InitAIOnOff(true)
    :SpawnInZone(rangeZone,true)
    :SmokeRed()
  else if SA5Flag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end


--Medium Non Complex Sites
--SA6, SA8, MANPADS
--Close range AAA protecting Radars
--No Shorad

function TARGET_SA6()
  if SA6Flag:Is(0) then
  local spawn = SPAWN:NewWithAlias("SA6", "SA6")
    spawn:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        SA6Flag:Set(1,0)
      end)
    :InitAIOnOff(true)
    :SpawnInZone(rangeZone,true)
    :SmokeRed()
  else if SA6Flag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end

function TARGET_SA8()
  if SA8Flag:Is(0) then
  local spawn = SPAWN:NewWithAlias("SA8", "SA8")
    spawn:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        SA8Flag:Set(1,0)
      end)
    :InitAIOnOff(true)
    :SpawnInZone(rangeZone,true)
    :SmokeRed()
  else if SA8Flag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end

function TARGET_MANPADS()
  if ManpadFlag:Is(0) then
  local spawn = SPAWN:NewWithAlias("MANPADS", "MANPADS")
    spawn:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        ManpadFlag:Set(1,0)
      end)
    :InitAIOnOff(true)
    :SpawnInZone(rangeZone,true)
    :SmokeRed()
  else if ManpadFlag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end

function TARGET_SA10()
  if SA10Flag:Is(0) then
  local spawn = SPAWN:NewWithAlias("SA10", "SA10")
    spawn:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        SA10Flag:Set(1,0)
      end)
    :InitAIOnOff(true)
    :SpawnInZone(rangeZone,true)
    :SmokeRed()
  else if SA10Flag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end

function TARGET_SA11()
  if SA11Flag:Is(0) then
  local spawn = SPAWN:NewWithAlias("SA11", "SA11")
    spawn:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        SA11Flag:Set(1,0)
      end)
    :InitAIOnOff(true)
    :SpawnInZone(rangeZone,true)
    :SmokeRed()
  else if SA11Flag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end

function TARGET_SA12()
  if SA12Flag:Is(0) then
  local spawn = SPAWN:NewWithAlias("SA12", "SA12")
    spawn:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        SA12Flag:Set(1,0)
      end)
    :InitAIOnOff(true)
    :SpawnInZone(rangeZone,true)
    :SmokeRed()
  else if SA12Flag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end

function TARGET_DEATHMODE()
  if IHMSFlag:Is(0) then
  local spawnIHMS1 = SPAWN:NewWithAlias("IHMS1", "IHMS1")
    spawnIHMS1:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        IHMSFlag:Set(1,0)
        preparefordeathmessage:ToAll()
      end)
     :InitAIOnOff(true)
     :SpawnInZone(rangeZone,true)
     :SmokeRed()
  local spawnIHMS2 = SPAWN:NewWithAlias("IHMS2", "IHMS2")
     :InitAIOnOff(true)
     :SpawnInZone(rangeZone,true)
     :SmokeRed()
  local spawnIHMS3 = SPAWN:NewWithAlias("SA2", "IHMS3")
     :InitAIOnOff(true)
     :SpawnInZone(rangeZone,true)
     :SmokeRed()
  local spawnIHMS4 = SPAWN:NewWithAlias("SA3", "IHMS4")
     :InitAIOnOff(true)
     :SpawnInZone(rangeZone,true)
     :SmokeRed()     
  local spawnIHMS5 = SPAWN:NewWithAlias("SA5", "IHMS5")
     :InitAIOnOff(true)
     :SpawnInZone(rangeZone,true)
     :SmokeRed()
  local spawnIHMS6 = SPAWN:NewWithAlias("SA6", "IHMS6")
     :InitAIOnOff(true)
     :SpawnInZone(rangeZone,true)
     :SmokeRed()
  local spawnIHMS7 = SPAWN:NewWithAlias("SA8", "IHMS7")
     :InitAIOnOff(true)
     :SpawnInZone(rangeZone,true)
     :SmokeRed()
  local spawnIHMS8 = SPAWN:NewWithAlias("MANPADS", "IHMS8")
     :InitAIOnOff(true)
     :SpawnInZone(rangeZone,true)
     :SmokeRed()
  local spawnIHMS9 = SPAWN:NewWithAlias("SA10", "IHMS9")
     :InitAIOnOff(true)
     :SpawnInZone(rangeZone,true)
     :SmokeRed()
  local spawnIHMS10 = SPAWN:NewWithAlias("SA11", "IHMS10")
     :InitAIOnOff(true)
     :SpawnInZone(rangeZone,true)
     :SmokeRed()
  local spawnIHMS11 = SPAWN:NewWithAlias("SA12", "IHMS11")
     :InitAIOnOff(true)
     :SpawnInZone(rangeZone,true)
     :SmokeRed()
  else if IHMSFlag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end


--AntiShipping Range

--Build Two Versions, one with Options set to fire, one with AI off
--Add random waypoints to spawns inside zone.  Static ships are boring









--THHIS WILL BREAK THE REST OF THE RANGE --CONFINE THE SCAN TO THE SAMRANGE ZONE

--THANKFULLY THIS DOES NOT CLEAR STATICS


function CLEAR_RANGE()
  local zoneScanSet = SET_GROUP:New():FilterCoalitions("red"):FilterOnce()
    BASE:I(zoneScanSet)
  zoneScanSet:ForEachGroup(
    function(Group)
      Group:Destroy()
    end)
  flagReset()
end






------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO AIR TO AIR ZONE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--rework the Air gauntlet then drop here, then work into menu
--this is the main innards of the gauntlet script, you will need to work this into either a menu start, or
--place inside a set_group ongroup to only allow certain airframes to participate, make those airframes airstarts

--Zones

local ZoneTable = { ZONE:New("AAZONE1"), ZONE:New("AAZONE2"), ZONE:New("AAZONE3"), ZONE:New("AAZONE4"), ZONE:New("AAZONE5"), ZONE:New("AAZONE6") }

local engageZone = ZONE:New("AAGAUNTLET"):DrawZone(coalition.side.BLUE, {1,0,0},1, {1,0,0}, {0,1}, 2, true)

--Tables

local TemplateTable = { "Mig15", "Mig19", "Mig21", "Mig23", "Mig25", "Mig29", "Mig31", "Mirage F1", "SU27", "SU30", "Mirage2000" }

local TargetSet = SET_GROUP:New():FilterCoalitions(coalition.side.RED):FilterStart()




local targetUnitNames = { "Mig15", "Mig19", "Mig21", "Mig23", "Mig25", "Mig29", "Mig31", "Mirage F1", "SU27", "SU30", "Mirage2000" }




--Main function of gauntlet

function AAGauntlet()

  if GAUNTLETFLAG:Is(0) then
  
    gauntletstart:ToAll()--Start Message

    local randNum = math.random(1,4)

    local SpawnTarget = SPAWN:New("SpawnTarget")
      :InitKeepUnitNames(true)
      :InitGrouping(randNum)
      :InitLimit(1, 0)
      :InitRandomizeTemplate(TemplateTable)
      :InitRandomizeZones(ZoneTable)
      :SpawnScheduled(5,.5)
    
    TIMER:New(function()
      randNum = math.random(1,4)
      SpawnTarget:InitGrouping(randNum)
      end):Start(5,5)    
      
    GAUNTLETFLAG:Set(1,0)  
    
  else
    
      return
    
  end    
end
  
--Starting of gauntlet is working, you still need to figure out a way to Stop the gauntlet though, your breakpoint is that the group doesnt exist until spawn and the variable is inside the function.
--can possibly use a boolean to establish a global gauntlet on or off




------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO MENU
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--both menus need to be rebuilt into on--
--

--[[

Menu Layout

Menu One - Range Menu
  Sub Menu 1 - 1 - StaticRange (Spawnables)
  Sub Menu 1 - 2 - PrecisionRange
  Sub Menu 1 - 3 - LiveRange
  Sub Menu 1 - 4 - SAMRange
  Sub Menu 1 - 5 - AA Gauntlet
  Sub Menu 1 - 6 - ShipRange
  Sub Menu 1 - 7 - Airfield Strike



]]
--Build Menu Object
menumgr = CLIENTMENUMANAGER:New(clientSet, "Range Menu")
--Main Menu
MenuLevel1 = menumgr:NewEntry("Range Menu")
--Sub Menu Under Main

MenuLevel2_1 = menumgr:NewEntry("Static Range", MenuLevel1)
MenuLevel2_2 = menumgr:NewEntry("Precision Range", MenuLevel1)
MenuLevel2_3 = menumgr:NewEntry("Live Range - HOSTILE", MenuLevel1)
MenuLevel2_4 = menumgr:NewEntry("SAM Range - HOSTILE", MenuLevel1)
MenuLevel2_5 = menumgr:NewEntry("Air to Air Gauntlet", MenuLevel1)
MenuLevel2_6 = menumgr:NewEntry("Anti Shipping Range", MenuLevel1)


--STATIC RANGE MENU
MenuLevel2_1_1 = menumgr:NewEntry("T-72s", MenuLevel2_1, TARGET_T72)
MenuLevel2_1_2 = menumgr:NewEntry("T-80s", MenuLevel2_1, TARGET_T80)
MenuLevel2_1_3 = menumgr:NewEntry("T-90s", MenuLevel2_1, TARGET_T90)
MenuLevel2_1_4 = menumgr:NewEntry("Trucks", MenuLevel2_1, TARGET_URALS)
MenuLevel2_1_5 = menumgr:NewEntry("Armored Trucks", MenuLevel2_1, TARGET_ARMORED)
MenuLevel2_1_6 = menumgr:NewEntry("Jeeps", MenuLevel2_1, TARGET_JEEPS)
MenuLevel2_1_7 = menumgr:NewEntry("Infantry - Enclosed", MenuLevel2_1, TARGET_INFANTRY)

--PRECISION RANGE MENU
--enclosed or vision obscured targets
MenuLevel2_3_1 = menumgr:NewEntry("BTR - Enclosed", MenuLevel2_2, TARGET_BTR)
MenuLevel2_3_2 = menumgr:NewEntry("BMP - Enclosed", MenuLevel2_2, TARGET_BMP)

--LIVE RANGE MENU
--hostile targets
MenuLevel2_3_1 = menumgr:NewEntry("T-72 Hostile", MenuLevel2_3, TARGET_T72_HOSTILE)
MenuLevel2_3_2 = menumgr:NewEntry("T-80 Hostile", MenuLevel2_3, TARGET_T80_HOSTILE)
MenuLevel2_3_3 = menumgr:NewEntry("T-90 Hostile", MenuLevel2_3, TARGET_T90_HOSTILE)




--SAMRANGE
MenuLevel2_4_1 = menumgr:NewEntry("Spawn AAA Targets", MenuLevel2_4)
MenuLevel2_4_2 = menumgr:NewEntry("Easy Non Complex Sites", MenuLevel2_4)
MenuLevel2_4_3 = menumgr:NewEntry("Medium Non Complex Sites", MenuLevel2_4)
MenuLevel2_4_4 = menumgr:NewEntry("Hard Long Range Complex Sites", MenuLevel2_4)
MenuLevel2_4_5 = menumgr:NewEntry("I Hate Myself Mode", MenuLevel2_4)

--AAA targets LIVE
MenuLevel2_4_1_1 = menumgr:NewEntry("ZU-23", MenuLevel2_4_1, TARGET_ZU23)
MenuLevel2_4_1_2 = menumgr:NewEntry("Shilka", MenuLevel2_4_1, TARGET_SHILKA)

--Sub Menus
--non complex sam sites  shorter range, less close range defenses

MenuLevel2_4_2_1 = menumgr:NewEntry("SA2", MenuLevel2_4_2, TARGET_SA2)
MenuLevel2_4_2_2 = menumgr:NewEntry("SA3", MenuLevel2_4_2, TARGET_SA3)
MenuLevel2_4_2_3 = menumgr:NewEntry("SA5", MenuLevel2_4_2, TARGET_SA5)


--Medium Non Complex Sites

MenuLevel2_4_3_1 = menumgr:NewEntry("SA6", MenuLevel2_4_3, TARGET_SA6)
MenuLevel2_4_3_2 = menumgr:NewEntry("SA8", MenuLevel2_4_3, TARGET_SA8)
MenuLevel2_4_3_3 = menumgr:NewEntry("Manpads", MenuLevel2_4_3, TARGET_MANPADS)

--Hard Long Range, Complex Sites

MenuLevel2_4_4_1 = menumgr:NewEntry("SA10 Complex", MenuLevel2_4_4, TARGET_SA10)
MenuLevel2_4_4_2 = menumgr:NewEntry("SA11 Complex", MenuLevel2_4_4, TARGET_SA11)
MenuLevel2_4_4_3 = menumgr:NewEntry("SA12 Complex", MenuLevel2_4_4, TARGET_SA12)




--I hate myself mode
--Long Range, Short Range, Manpads, Mod Systems, Shorad, Mantis
MenuLevel2_4_5_1 = menumgr:NewEntry("I choose Death", MenuLevel2_4_5, TARGET_DEATHMODE)

--CLEAR RANGE FUNCTION
MenuLevel2_4_6 = menumgr:NewEntry("Clear Range", MenuLevel1, CLEAR_RANGE)

--air gauntlet menu
MenuLevel2_5_1 = menumgr:NewEntry("Start Air Gauntlet", MenuLevel2_5, AAGauntlet)



function clientSet:OnEventPlayerEnterAircraft(EventData)
 menumgr:Propagate(EventData.IniUnit)
end
