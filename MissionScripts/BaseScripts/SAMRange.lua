------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Surface To Air Missile Range - By TheDude
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--[[

TODO

1.  Destroy Method to erase range.
2.  Target score check.


1.2 Update Changelog

--Clear Range Function
--Missile Trainer (Can be disabled)

--In testing the Trainer does not seem to function for AI, You will need to test this as player.

--Missile Trainer removed pending further testing, not stable enough for 1.2



]]--


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SETUP
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local DEBUG = true

if DEBUG then
 BASE:TraceOnOff(true)
 BASE:TraceLevel(1)
 BASE:TraceClass("RANGE")
end

_SETTINGS:SetPlayerMenuOff()

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO ZONES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local rangeZone = ZONE:New("RangeZone")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SETS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

clientSet = SET_CLIENT:New():FilterTypes("plane"):FilterStart()
targetSet = SET_GROUP:New():FilterCoalitions("red"):FilterStart()


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

--[[

Sound Files:

Ohyeah.ogg
ohnofg.ogg

snoop.ogg


--]]

function clientSet:OnEventPlayerEnterAircraft(EventData)
  local file = "sparta.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end
--
function clientSet:OnEventCrash(EventData)
  local file = "jackpot.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end
--
function targetSet:OnEventKill(EventData)
  local file = "GreatSuccess.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SCORING
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local RangeScore = SCORING:New("SAM Range")

RangeScore:SetScaleDestroyScore(2)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO FLAGS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO MAIN
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



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
---TODO MISSILE TRAINER
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--local Trainer = MISSILETRAINER
--  :New( 200, "Welcome to the SAM Site Training Range, Spawn Sites using your Radio Menu" )
--  :InitMessagesOnOff(true)
--  :InitAlertsToAll(true) 
--  :InitAlertsHitsOnOff(true)
--  :InitAlertsLaunchesOnOff(false) -- I'll put it on below ...
--  :InitBearingOnOff(true)
--  :InitRangeOnOff(true)
--  :InitTrackingOnOff(true)
--  :InitTrackingToAll(true)
--  :InitMenusOnOff(true)
--
--Trainer:InitAlertsToAll(true) -- Now alerts are also on








