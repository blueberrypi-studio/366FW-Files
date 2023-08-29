------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Target Range - By TheDude
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--[[

Spawning functions are working beautifully, tested 8/19
All spawns are adding to the bombing targets list.

TODO
1. Setup Instructor--DONE
2. Setup Seperate Ranges for:
  a.Strafing
  b.Precision Bombing
  c.Static Bombing
  d.Spawnable Targets
3. Setup Waypoints for Flights to Each Range--DONE
4. Smoke Each Range Zone Seperately but only if Player is inside the range.  this should reduce smoke latency--UNNEEDED UNTIL EXPANSION




--]]


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
---TODO ZONES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local rangeZone = ZONE:New("RangeZone"):SmokeZone(SMOKECOLOR.Blue)
local strafeZone = ZONE:New("StrafeZone")
local bombCircleZone1 = ZONE:New("BombCircle1")
local bombCircleZone2 = ZONE:New("BombCircle2")
local t90SpawnZone = ZONE:New("T90Zone")
local t80SpawnZone = ZONE:New("T80Zone")
local t72SpawnZone = ZONE:New("T72Zone")
local uralSpawnZone = ZONE:New("UralZone")
local t90HostSpawnZone = ZONE:New("T90ZoneHostile")
local t80HostSpawnZone = ZONE:New("T80ZoneHostile")
local t72HostSpawnZone = ZONE:New("T72ZoneHostile")
local armoredTruckSpawnZone = ZONE:New("ArmoredTruckZone")
local jeepSpawnZone = ZONE:New("JeepZone")

local enclosedTargetZone = ZONE:New("EnclosedTargetZone1")

local rZone1 = ZONE:New("RZone1")
local rZone2 = ZONE:New("RZone2")
local rZone3 = ZONE:New("RZone3")
local rZone4 = ZONE:New("RZone4")
local rZone5 = ZONE:New("RZone5")

--ADD RANDOM ZONE SET FOR ENCLOSURES  USE AIR GAUNTLET SCRIPT FOR THE RANDOMIZATION OF THE SPAWNS

local AAASpawnZone = ZONE:New("AAAZone")
local staticSpawnZone = ZONE:New("StaticZone")
local infantrySpawnZone = ZONE:New("InfantryZone")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SETS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

clientSet = SET_CLIENT:New():FilterTypes({"plane", "helicopter"}):FilterStart()
targetSet = SET_GROUP:New():FilterCoalitions("red"):FilterStart()


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SET FLAGS FOR SPAWN LIMITERS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO MESSAGES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

nospawnmessage = MESSAGE:New("You may not spawn anymore of these targets",10)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO TABLES/GROUPS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Targets
local strafePit1 = STATIC:FindByName("StrafePit1")
local strafePit2 = STATIC:FindByName("StrafePit2")
local bombCircle1 = STATIC:FindByName("BombCircle1")
local bombCircle2 = STATIC:FindByName("BombCircle2")

--Carpet Circles

local carpetCircle1 = STATIC:FindByName("CarpetCircle1")
local carpetCircle2 = STATIC:FindByName("CarpetCircle2")
local carpetCircle3 = STATIC:FindByName("CarpetCircle3")
local carpetCircle4 = STATIC:FindByName("CarpetCircle4")


local staticTarget1 = STATIC:FindByName("StaticTarget1")

local t90Group = GROUP:FindByName("T90")
local t80Group = GROUP:FindByName("T80")
local t72Group = GROUP:FindByName("T72")

local urals = GROUP:FindByName("Ural")
local armoredTrucks = GROUP:FindByName("Armored Truck")
local jeeps = GROUP:FindByName("Jeep")

--AAA Targets

local zu23 = GROUP:FindByName("ZU23")
local shilka = GROUP:FindByName("Shilka")



--STATIC TARGET ENCLOSURES

--Zone Table for BMP Enclosure Spawn

local rZoneTable = {rZone1, rZone2, rZone3, rZone4, rZone5}





------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO EVENT HANDLERS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

clientSet:HandleEvent(EVENTS.PlayerEnterAircraft)

--Target Event Handlers
targetSet:HandleEvent(EVENTS.Hit)
targetSet:HandleEvent(EVENTS.Dead)
targetSet:HandleEvent(EVENTS.Birth)
targetSet:HandleEvent(EVENTS.Kill)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SOUNDS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--[[

Sound Files:

Ohyeah.ogg
ohnofg.ogg

snoop.ogg


--]]

function clientSet:OnEventPlayerEnterAircraft(EventData)
  local file = "snoop.ogg"
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



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SCORING
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SETUP RANGE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--RangeTarget = nil

Range = RANGE:New("366th Airwing Training Range")


Range:AddBombingTargets({"BombCircle1", "BombCircle2"}, 1, false)

Range:AddBombingTargets({"EnclosedTargetZone1", "StaticTarget1"}, 0, false)

Range:AddBombingTargets({"CarpetCircle1", "CarpetCircle2", "CarpetCircle3", "CarpetCircle4"}, 1, false)


Range:AddStrafePit("StrafePit1",600,152,90,false,20,269)
Range:AddStrafePit("StrafePit2",600,152,270,false,20,269)

Range:SetMaxStrafeAlt(1000)

Range:GetFoullineDistance("StrafePit1", "StrafePitFoulLine1")
Range:GetFoullineDistance("StrafePit2", "StrafePitFoulLine2")


Range:SetRangeZone(ZONE:FindByName("RangeZone"))

Range:SetInstructorRadio(305,"relay")

Range:SetRangeControl(265,"relay")

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
        Range:AddBombingTargetGroup(Target,10)
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
        Range:AddBombingTargetGroup(Target,10)
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
        Range:AddBombingTargetGroup(Target,10)
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
        Range:AddBombingTargetGroup(Target,10)
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
        Range:AddBombingTargetGroup(Target, 10)
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
        Range:AddBombingTargetGroup(Target, 10)
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
        Range:AddBombingTargetGroup(Target, 10)
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
        Range:AddBombingTargetGroup(Target, 10)
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
        Range:AddBombingTargetGroup(Target,10)
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


function TARGET_BTR()
  if BTRFlag:Is(0) then
    local spawnBTR = SPAWN:NewWithAlias("BTR", "BTR")
    spawnBTR:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        Range:AddBombingTargetGroup(Target,1)
        BTRFlag:Set(1,0)
      end)
    :InitLimit(1,0)
    :InitAIOnOff(false)
    :SpawnInZone(enclosedTargetZone, false)
  else if BTRFlag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end



function TARGET_BMP()
  if BMPFlag:Is(0) then
    local spawnBMP = SPAWN:NewWithAlias("BMP", "BMP")
    spawnBMP:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        Range:AddBombingTargetGroup(Target,2)
        BMPFlag:Set(1,0)
      end)
    :InitLimit(5,5)
    :InitAIOnOff(false)
    :InitRandomizeZones(rZoneTable)
    :SpawnScheduled(2,.5)
  else if BMPFlag:Is(1) then
    nospawnmessage:ToAll()
    return
    end
  end
end



function TARGET_ZU23()
  if ZU23Flag:Is(0) then
    local spawnZU23 = SPAWN:NewWithAlias("ZU23", "ZU23")
    spawnZU23:OnSpawnGroup(
      function(SpawnGroup)
        local Target = SpawnGroup
        Range:AddBombingTargetGroup(Target,5)
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
        Range:AddBombingTargetGroup(Target,5)
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
        Range:AddBombingTargetGroup(Target,5)
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


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO MENU
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Build Menu Object
menumgr = CLIENTMENUMANAGER:New(clientSet, "Range Menu")
--Main Menu
MenuLevel1 = menumgr:NewEntry("Range Menu")
--Sub Menu Under Main
MenuLevel2_1 = menumgr:NewEntry("Spawn Hard Targets", MenuLevel1)
MenuLevel2_2 = menumgr:NewEntry("Spawn Soft Targets", MenuLevel1)
MenuLevel2_3 = menumgr:NewEntry("Spawn Hostile Targets", MenuLevel1)
MenuLevel2_4 = menumgr:NewEntry("Spawn Precision Targets", MenuLevel1)
MenuLevel2_5 = menumgr:NewEntry("Spawn AAA Targets", MenuLevel1)

--Sub Menus
--hard targets
Menu1 = menumgr:NewEntry("T-72s", MenuLevel2_1, TARGET_T72)
Menu2 = menumgr:NewEntry("T-80s", MenuLevel2_1, TARGET_T80)
Menu3 = menumgr:NewEntry("T-90s", MenuLevel2_1, TARGET_T90)
--soft targets
Menu4 = menumgr:NewEntry("Trucks", MenuLevel2_2, TARGET_URALS)
Menu5 = menumgr:NewEntry("Armored Trucks", MenuLevel2_2, TARGET_ARMORED)
Menu6 = menumgr:NewEntry("Jeeps", MenuLevel2_2, TARGET_JEEPS)
--hostile targets
Menu7 = menumgr:NewEntry("T-72 Hostile", MenuLevel2_3, TARGET_T72_HOSTILE)
Menu8 = menumgr:NewEntry("T-80 Hostile", MenuLevel2_3, TARGET_T80_HOSTILE)
Menu9 = menumgr:NewEntry("T-90 Hostile", MenuLevel2_3, TARGET_T90_HOSTILE)
--enclosed or vision obscured targets
Menu10 = menumgr:NewEntry("BTR - Enclosed", MenuLevel2_4, TARGET_BTR)
Menu11 = menumgr:NewEntry("BMP - Enclosed", MenuLevel2_4, TARGET_BMP)
Menu12 = menumgr:NewEntry("Infantry - Enclosed", MenuLevel2_4, TARGET_INFANTRY)
--AAA targets LIVE
Menu13 = menumgr:NewEntry("ZU-23", MenuLevel2_5, TARGET_ZU23)
Menu14 = menumgr:NewEntry("Shilka", MenuLevel2_5, TARGET_SHILKA)



function clientSet:OnEventPlayerEnterAircraft(EventData)
 menumgr:Propagate(EventData.IniUnit)
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO START RANGE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Range:Start()
