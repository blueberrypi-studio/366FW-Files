------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- The Boomiest of Target Ranges - By TheDude
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--DISCLAIMER:  THIS SCRIPT IS A WIP< DO NOT ATTEMPT TO USE.  IT WILL ABSOLUTELY CRASH YOUR SHIT.





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
local CBRange = ZONE:New("CBRANGE"):SmokeZone(SMOKECOLOR.Blue)
--precision bombing range
local PBRange = ZONE:New("PBRANGE"):SmokeZone(SMOKECOLOR.Green)
--strafing range
local STRange = ZONE:New("STRANGE"):SmokeZone(SMOKECOLOR.Orange)
--static target range (spawnables)
local StaticRange = ZONE:New("STATICRANGE"):SmokeZone(SMOKECOLOR.White)
--live target range
local LiveRange = ZONE:New("LIVERANGE"):SmokeZone(SMOKECOLOR.White)
--SAM Range
local SAMRange = ZONE:New("SAMRANGE"):SmokeZone(SMOKECOLOR.Red)


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

clientSet = SET_CLIENT:New():FilterTypes({"plane", "helicopter"}):FilterStart()
targetSet = SET_GROUP:New():FilterCoalitions("red"):FilterStart()


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

end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO MESSAGES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

nospawnmessage = MESSAGE:New("You may not spawn anymore of these targets",10)
preparefordeathmessage = MESSAGE:New("Prepare for Death.",10)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO TABLES/GROUPS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO EVENT HANDLERS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

clientSet:HandleEvent(EVENTS.PlayerEnterAircraft)
clientSet:HandleEvent(EVENTS.Crash)


--Target Event Handlers
targetSet:HandleEvent(EVENTS.Hit)
targetSet:HandleEvent(EVENTS.Dead)
targetSet:HandleEvent(EVENTS.Birth)
targetSet:HandleEvent(EVENTS.Kill)


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


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SETUP RANGES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


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



function CLEAR_RANGE()
  local zoneScanSet = SET_GROUP:New():FilterCoalitions("red"):FilterOnce()
    BASE:I(zoneScanSet)
  zoneScanSet:ForEachGroup(
    function(Group)
      Group:Destroy()
    end)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO MENU
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--both menus need to be rebuilt into one


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



--Build Menu Object
menumgr = CLIENTMENUMANAGER:New(clientSet, "Range Menu")
--Main Menu
MenuLevel1 = menumgr:NewEntry("Range Menu")
--Sub Menu Under Main
MenuLevel2_1 = menumgr:NewEntry("Easy Non Complex Sites", MenuLevel1)
MenuLevel2_2 = menumgr:NewEntry("Medium Non Complex Sites", MenuLevel1)
MenuLevel2_3 = menumgr:NewEntry("Hard Long Range Complex Sites", MenuLevel1)
MenuLevel2_4 = menumgr:NewEntry("I Hate Myself Mode", MenuLevel1)
MenuLevel2_5 = menumgr:NewEntry("Clear Range", MenuLevel1, CLEAR_RANGE)


--Sub Menus
--non complex sam sites  shorter range, less close range defenses

Menu1 = menumgr:NewEntry("SA2", MenuLevel2_1, TARGET_SA2)
Menu2 = menumgr:NewEntry("SA3", MenuLevel2_1, TARGET_SA3)
Menu3 = menumgr:NewEntry("SA5", MenuLevel2_1, TARGET_SA5)

--Medium Non Complex Sites

Menu4 = menumgr:NewEntry("SA6", MenuLevel2_2, TARGET_SA6)
Menu5 = menumgr:NewEntry("SA8", MenuLevel2_2, TARGET_SA8)
Menu6 = menumgr:NewEntry("Manpads", MenuLevel2_2, TARGET_MANPADS)

--Hard Long Range, Complex Sites

Menu7 = menumgr:NewEntry("SA10 Complex", MenuLevel2_3, TARGET_SA10)
Menu8 = menumgr:NewEntry("SA11 Complex", MenuLevel2_3, TARGET_SA11)
Menu9 = menumgr:NewEntry("SA12 Complex", MenuLevel2_3, TARGET_SA12)


--I hate myself mode
--Long Range, Short Range, Manpads, Mod Systems, Shorad, Mantis
Menu10 = menumgr:NewEntry("I choose Death", MenuLevel2_4, TARGET_DEATHMODE)






function clientSet:OnEventPlayerEnterAircraft(EventData)
 menumgr:Propagate(EventData.IniUnit)
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO START RANGE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--start ranges



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO AIR TO AIR ZONE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--rework the Air gauntlet then drop here, then work into menu
--this is the main innards of the gauntlet script, you will need to work this into either a menu start, or
--place inside a set_group ongroup to only allow certain airframes to participate, make those airframes airstarts

--Zones

local ZoneTable = { ZONE:New("Zone1"), ZONE:New("Zone2"), ZONE:New("Zone3"), ZONE:New("Zone4") }

local engageZone = ZONE:New("EngagementZone"):DrawZone(coalition.side.BLUE, {1,0,0},1, {1,0,0}, {0,1}, 2, true)

--Tables

local TemplateTable = { "Mig15", "Mig19", "Mig21", "Mig23", "Mig25", "Mig29", "Mig31", "Mirage F1", "SU27", "SU30", "Mirage2000" }

local TargetSet = SET_GROUP:New():FilterCoalitions(coalition.side.RED):FilterStart()

--Event Handlers

--Target Event Handlers
TargetSet:HandleEvent(EVENTS.Hit)
TargetSet:HandleEvent(EVENTS.Dead)
TargetSet:HandleEvent(EVENTS.Birth)
TargetSet:HandleEvent(EVENTS.Kill)



--Client Event Handlers
clientSet:HandleEvent(EVENTS.Hit)
clientSet:HandleEvent(EVENTS.Dead)
clientSet:HandleEvent(EVENTS.Land)
clientSet:HandleEvent(EVENTS.PlayerEnterAircraft)


local targetUnitNames = { "Mig15", "Mig19", "Mig21", "Mig23", "Mig25", "Mig29", "Mig31", "Mirage F1", "SU27", "SU30", "Mirage2000" }

--Main function of gauntlet

local randNum = math.random(1,4)

local SpawnTarget = SPAWN:New("SpawnTarget")
  :InitKeepUnitNames(true)
  :InitGrouping(randNum)
  :InitLimit(1, 0)
  :InitRandomizeTemplate(TemplateTable)
  :InitRandomizeZones(ZoneTable)
  :SpawnScheduled(5,.5)
  
--Get targets for scoring if scoring is inadequate


TIMER:New(function()
  randNum = math.random(1,4)
  SpawnTarget:InitGrouping(randNum)
  end):Start(5,5)
  
  
  
local Scoring = SCORING:New("Air Gauntlet")

Scoring:SetMessagesHit(Off)
Scoring:SetMessagesDestroy(On)
Scoring:SetMessagesToCoalition()

--Client Sound Functions
function ClientSet:OnEventDead(EventData)
  local file = "Oh Jesus.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function ClientSet:OnEventLand(EventData)
  local file = "GreatSuccess.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function ClientSet:OnEventPlayerEnterAircraft(EventData)
  local file = "allyourshit.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

--Target Sound Functions

function TargetSet:OnEventKill(EventData)
  local file = "GreatSuccess.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function TargetSet:OnEventBirth(EventData)
  local file = "pieceofcandy.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

