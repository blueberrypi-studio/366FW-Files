-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local DEBUG = false
local DEBUG_COMMANDERS = false
local DEBUG_PARKING = false


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO ZONES
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

zone1 = ZONE:New("ZoneBlueArmorAlpha")
zone2 = ZONE:New("ZoneBlueArmorBravo")
zone3 = ZONE:New("ZoneBlueArmorAirAlpha")
zone4 = ZONE:New("ZoneRedArmorAlpha")
zone5 = ZONE:New("ZoneRedArmorBravo")
zone6 = ZONE:New("ZoneBlueArmorAirBravo")
zone7 = ZONE:New("BLUECHIEFBORDER")
zone8 = ZONE:New("REDCHIEFBORDER")
zone9 = ZONE:New("BLUECAPZONE")
zone10 = ZONE:New("REDCAPZONE")
zone11 = ZONE:New("BLUEAWACSORBIT")
zone12 = ZONE:New("REDAWACSORBIT")
zone13 = ZONE:New("MAINCAP")
zone14 = ZONE:New("CA Zone1")
zone15 = ZONE:New("ZoneRedArmorAirBravo")
zone16 = ZONE:New("ZoneRedArmorAirAlpha")
reconZone = SET_ZONE:New():FilterPrefixes("CA"):FilterOnce()

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO OPSZONES for CAPTURE FUNCTION
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--use these for strategic zones also

opzone1 = OPSZONE:New("CA Zone1")

opzone2 = OPSZONE:New("FEZ")

--CREATE OPSZONES SET for Capture function
opszonesSET=SET_OPSZONE:New():FilterPrefixes("CA"):FilterOnce()

-- Start all opszones in the SET.
opszonesSET:Start()

--This is the capture zone function.
-- Capture Time (60seconds)
opszonesSET:ForEachZone(

function (_opszoneSET)
  local opszoneSET=_opszoneSET --Ops.OpsZone#OPSZONE
  opszoneSET:SetCaptureTime(60)
end
)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO TABLES
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO PARKING
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---DEBUGS
--
--
if DEBUG_PARKING then
AIRBASE:FindByName(AIRBASE.Caucasus.Sochi_Adler):MarkParkingSpots()
end

--Sochi
Parking = ({33, 34, 35, 46, 36, 47, 37, 48, 38, 39, 49, 40, 50, 41, 51, 42, 52, 43, 53, 44, 104, 44, 55})


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO TABLES / ARRAYS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Target Groups for Scoring --ONLY USE THIS FOR MODDED ITEMS

local blueTargetIronDome = GROUP:FindByName("RedIronDome")
local blueTargetSA23 = GROUP:FindByName("SAMRED4")
--local blueTargetTrain = GROUP:FindByName("RU Supply Train")



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO UTILITY FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Get Client Slots
local ClientSet = SET_CLIENT:New():FilterPrefixes("366th"):FilterStart()


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO INIT / SETUP
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

_SETTINGS:SetPlayerMenuOn()
_SETTINGS:SetImperial()
_SETTINGS:SetA2G_BR()
_SETTINGS:SetA2A_BRAA()

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SETUP SRS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--local hereSRSPath = "C:\Program Files\DCS-SimpleRadio-Standalone"
local hereSRSPath = "Z:\DCS-SimpleRadio-Standalone"
local hereSRSPort = 5002

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO RADIO FREQUENCY SCHEMATIC
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--AIRPORT ATIS 13####
--AIRPORT TOWER 18###
--AIRPORT ILS 11###
--AIRPORT VOR 12###
--AIRPORT TACAN 17#

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO ATIS Sochi on 131.1 MHz AM
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
atisSochi = ATIS:New(AIRBASE.Caucasus.Sochi_Adler, 131.1)
atisSochi:SetRadioRelayUnitName( "RadioRelaySochi" )
atisSochi:SetTowerFrequencies({181.1, 188.1})
atisSochi:SetRunwayHeadingsMagnetic( {"24", "06"})
atisSochi:SetActiveRunwayTakeoff("24")
atisSochi:SetActiveRunwayLanding("06")
atisSochi:AddILS( 110.1, "24" )
atisSochi:AddILS( 112.1, "06" )
atisSochi:SetVOR( 121.1 )
atisSochi:SetTACAN(24)
atisSochi:SetElevation()
atisSochi:SetRunwayLength()
atisSochi:GetMissionWeather()
atisSochi:Start()


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO MENU
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--for i=1,1000 do
--  math.random(1,10000)
--end

local menu = MENU_COALITION:New(coalition.side.BLUE,"Operation Menu")

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO HEADQUARTERS/COMMANDCENTERS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Static Declaration should you need them later--THESE COULD BE TARGETS FOR SCORING LATER>BUT KEEP IN MIND WILL BRING MISSION TO A HALT FOR THE RELATIVE SIDE

blueHQ = STATIC:FindByName("BLUEHQ")
redHQ = STATIC:FindByName("REDHQ")

---COMMANDCENTERS

--RED

RU_CC = COMMANDCENTER:New( GROUP:FindByName( "REDCC" ), "Russian Command" )
US_CC = COMMANDCENTER:New( GROUP:FindByName( "BLUECC" ), "Allied Command")



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO DETECTION
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--BLUE

DetectionSetGroupBlue = SET_GROUP:New()
DetectionSetGroupBlue:FilterPrefixes( { "EWRBLUE", "AWACSBLUE", "FACBLUE", "JTACBLUE", "366th" } )
DetectionSetGroupBlue:FilterStart()

DetectionBlue = DETECTION_AREAS:New( DetectionSetGroupBlue, 30000 )

--RED
DetectionSetGroupRed = SET_GROUP:New()
DetectionSetGroupRed:FilterPrefixes({ "EWRRED", "AWACSRED", "FACRED", "JTACRED" })
DetectionSetGroupRed:FilterStart()

DetectionRed = DETECTION_AREAS:New( DetectionSetGroupRed, 30000 )

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO Warehouses
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NOT CURRENTLY IN USE, BUT COULD BE IN FUTURE MISSIONS
ware1 = WAREHOUSE:New(STATIC:FindByName("WarehouseSochiAirwing"), "Sochi Airwing Warehouse")
ware2 = WAREHOUSE:New(STATIC:FindByName("WarehouseBlueAlphaBrigade"), "US Alpha Brigade Warehouse")
ware3 = WAREHOUSE:New(STATIC:FindByName("WarehouseBlueBravoBrigade"), "US Bravo Brigade Warehouse")

ware5 = WAREHOUSE:New(STATIC:FindByName("WarehouseRedAlphaBrigade"), "RU Alpha Brigade Warehouse")
ware6 = WAREHOUSE:New(STATIC:FindByName("WarehouseRedBravoBrigade"), "RU Bravo Brigade Warehouse")

ware8 = WAREHOUSE:New(STATIC:FindByName("WarehouseGeleAirwing"), "Gele Airwing Warehouse")
ware9 = WAREHOUSE:New(STATIC:FindByName("WarehouseNovoAirwing"), "Novo Airwing Warehouse")

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SCORING
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--ScoringGroups

--Name Scoring Object
Scoring = SCORING:New("River Crossing")

--Scale Scoring
Scoring:SetScaleDestroyScore( 10 )
Scoring:SetScaleDestroyPenalty( 40 )


--Add Scoring Groups
Scoring:AddScoreGroup(blueTargetIronDome, 200)
Scoring:AddScoreGroup(blueTargetSA23, 200)
--Scoring:AddScoreGroup(blueTargetTrain, 1000)

--Add Individual Scoring Units if Necessary
--Scoring:AddUnitScore(ScoreUnit,Score)
--Add Static Scoring
Scoring:AddStaticScore(STATIC:FindByName("WarehouseRedAlphaBrigade"), 200)
Scoring:AddStaticScore(STATIC:FindByName("WarehouseRedBravoBrigade"), 200)
Scoring:AddStaticScore(STATIC:FindByName("WarehouseRedAlphaAirBrigade"), 200)
Scoring:AddStaticScore(STATIC:FindByName("WarehouseRedBravoAirBrigade"), 200)



Scoring:SetMessagesHit(false)
Scoring:SetMessagesDestroy(true)
Scoring:SetMessagesScore(true)


--Add Zone Scoring

--Set the Zone scoring multiplier to award a higher score for kills inside the engagement zone of the air defenses.

ScoringMultiplierZone = ZONE:New( "DoubleScoreZone" )
Scoring:AddZoneScore( ScoringMultiplierZone, 100 )

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO AIRBASE MAINTENANCE
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Function to check and cleanup stuck aircraft

CleanUpAirports = CLEANUP_AIRBASE:New( { AIRBASE.Caucasus.Sochi_Adler, AIRBASE.Caucasus.Novorossiysk } )


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SETUP SHORAD
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--RED SHORAD
local samredSET = SET_GROUP:New():FilterPrefixes("SAMRED"):FilterCoalitions("red"):FilterStart()
-- usage: SHORAD:New(name, prefix, samset, radius, time, coalition)
redShorad = SHORAD:New("RedShorad", "Red SHORAD", samredSET, 22000, 600, "red")


--BLUE SHORAD
local samblueSET = SET_GROUP:New():FilterPrefixes("SAMBLUE"):FilterCoalitions("blue"):FilterStart()
-- usage: SHORAD:New(name, prefix, samset, radius, time, coalition)
blueShorad = SHORAD:New("BlueShorad", "Blue SHORAD", samblueSET, 22000, 600, "blue")

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SETUP MANTIS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--RED MANTIS
redMantis = MANTIS:New( "Red MANTIS", "SAMRED", "EWRRED", "REDHQ", "red", true, "AWACSRED" )
--can customize mantis further here
redMantis:AddShorad( redShorad, 720 )


if DEBUG then
redMantis:Debug(on)
end

redMantis:Start()

--BLUE MANTIS
blueMantis = MANTIS:New( "Blue MANTIS", "SAMBLUE", "EWRBLUE", "BLUEHQ", "blue", true, "AWACSBLUE" )
blueMantis:AddShorad(blueShorad, 720)

if DEBUG then
blueMantis:Debug(on)
end

blueMantis:Start()

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO BLUE REAPER DRONE
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local ReaperReconSet = SET_GROUP:New():FilterPrefixes("JTACBLUE"):FilterStart()


local ReaperReconDetection = DETECTION_AREAS:New(ReaperReconSet,5000)


-- create a group of targets that can be targeted
local AttackSet = SET_GROUP:New():FilterCoalitions(coalition.side.BLUE):FilterStart()

-- Setup designation for the Attack set
local ReaperReconDesignation = DESIGNATE:New(US_CC,ReaperReconDetection,AttackSet)

ReaperReconDesignation:GenerateLaserCodes()
ReaperReconDesignation:SetAutoLase(true,true)


GetDetectedUnitList = SCHEDULER:New(nil,
  function()
    if ReaperReconDetection:GetDetectedItemsByIndex() then
      local DetectedItems = ReaperReconDetection:GetDetectedItemsByIndex()
      for _,items in ipairs(DetectedItems ) do
        BASE:E("DetectedUnits" .. items)
      end
    else
      BASE:ClearState("Waiting for populated units in Detected Areas")
    end
      end,
  {},1,600)
  
----BASE:TraceLevel(1)
BASE:TraceClass("DESIGNATE")


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO INTEL
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local BlueIntel = INTEL:New(DetectionSetGroupBlue, "blue", "CIA")
BlueIntel:SetDetectStatics(true)
BlueIntel:SetClusterAnalysis(true, true, true)--CHANGE THESE AFTER TESTING
BlueIntel:SetVerbosity(0)
BlueIntel:__Start(2)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SETUP TASKMANAGER
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Set up A2G task controller
local a2gtaskmanager = PLAYERTASKCONTROLLER:New("366th Fighter Wing A2G",coalition.side.BLUE,PLAYERTASKCONTROLLER.Type.A2G)

-- Set up detection
a2gtaskmanager:SetupIntel("JTACBLUE")


a2gtaskmanager:AddAgentSet(ReaperReconSet)
--a2gtaskmanager:AddAgent(GROUP:FindByName("JTACBLUE Reaper"))  --This is possibly breaking the detection

--local taskTargetSet = SET_GROUP:New():FilterPrefixes({"☮","☢"}):FilterCoalitions(coalition.side.RED):FilterStart()
--a2gtaskmanager:AddTarget(taskTargetSet)
-- Set the menu
a2gtaskmanager:SetMenuName("Deathstar")

-- Add accept- and reject-zones for detection
a2gtaskmanager:AddAcceptZone(ZONE:New("CA Zone1"))
a2gtaskmanager:DisableTaskInfoMenu()
a2gtaskmanager:EnableTaskInfoMenu()
a2gtaskmanager:SetLocale("en")
a2gtaskmanager:SetTargetRadius(750)
a2gtaskmanager:SetParentMenu(menu)
a2gtaskmanager:SetAllowFlashDirection(true)

-- auto-add map markers when tasks are added
--function a2gtaskmanager:OnAfterTaskAdded(From,Event,To,Task)
--  local task = Task -- Ops.PlayerTask#PLAYERTASK
--  local coord = task.Target:GetCoordinate()
--  local taskID = string.format("Task ID #%03d | Type: %s | Threat: %d",task.PlayerTaskNr,task.Type,task.Target:GetThreatLevelMax())
--  local mark = MARKER:New(coord,taskID)
--  mark:ReadWrite()
--  mark:ToCoalition(2,10)
--end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO Sounds for Smoke and Mirrors
----------------------------------------------------------------
function a2gtaskmanager:OnAfterTaskTargetSmoked(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function a2gtaskmanager:OnAfterTaskTargetFlared(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function a2gtaskmanager:OnAfterTaskTargetIlluminated(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO Sounds for Client
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Event Handlers
ClientSet:HandleEvent(EVENTS.Hit)
ClientSet:HandleEvent(EVENTS.Dead)
ClientSet:HandleEvent(EVENTS.Land)

function ClientSet:OnEventDead(EventData)
  local file = "Oh Jesus.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function ClientSet:OnEventLand(EventData)
  local file = "GreatSuccess.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

--EventData.IniUnit



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO Mission Targets
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local BLUEOperation = { 
  [1] = {       
    TargetName = "WarehouseRedAlphaBrigade",
    TargetStatic = true,
    TargetBriefing = "Destroy the Warehouse",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [2] = {       
    TargetName = "WarehouseRedBravoBrigade",
    TargetStatic = true,
    TargetBriefing = "Destroy the Warehouse",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [3] = {       
    TargetName = "WarehouseRedAlphaAirBrigade",
    TargetStatic = true,
    TargetBriefing = "Destroy the Warehouse",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [4] = {       
    TargetName = "WarehouseRedBravoAirBrigade",
    TargetStatic = true,
    TargetBriefing = "Destroy the Warehouse",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [5] = {       
    TargetName = "REDARMORCOLUMN1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Platoon",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [6] = {       
    TargetName = "REDARMORCOLUMN2",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Column",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [7] = {       
    TargetName = "RedIronDome",
    TargetStatic = false,
    TargetBriefing = "Destroy the Iron Dome System protecting the Warehouses at Waypoint 1",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [8] = {        
    TargetName = "SAMRED4",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-20 Site in Grid [DK6549]",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [9] = {        
    TargetName = "SAMRED5",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-6 Site protecting the EW Radar at Waypoint 2",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [10] = {        
    TargetName = "EWRRED1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Russian Early Warning Radar at Waypoint 2",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [11] = {        
    TargetName = "EWRRED2",
    TargetStatic = false,
    TargetBriefing = "Destroy the Russian Early Warning Radar at [Insert location here]",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [12] = {        
    TargetName = "SAMRED1",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-10 Site at Novo",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [13] = {        
    TargetName = "SAMRED2",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-2 Site at Novo",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  }


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO Randomize mission setup and create TARGET objects
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BLUEOperation = UTILS.ShuffleTable(BLUEOperation)

local BlueTargets = {}
for i=1,13 do
  if BLUEOperation[i].TargetStatic then
    -- static
    BlueTargets[i] = TARGET:New(STATIC:FindByName(BLUEOperation[i].TargetName))
    
  else     
    BlueTargets[i] = TARGET:New(GROUP:FindByName(BLUEOperation[i].TargetName))
  end
end


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO OPERATION
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Define Operation to help guide mission progress

local BlueOps = OPERATION:New("Port Authority")

if DEBUG then
  BlueOps.verbose = 1
end


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO Add Operation Phases
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

for i=1,13 do
  -- Add Phases
  local phase = BlueOps:AddPhase(i)
  -- Add condition over
  BlueOps:AddPhaseConditonOverAll(phase,
  function(target)
    local Target = target -- Ops.Target#TARGET
    if Target:IsDead() or Target:IsDestroyed() or Target:CountTargets() == 0 then
      return true
    else
     return false
    end 
  end,BlueTargets[i])
end
-- start operation
BlueOps:__Start(60)

function InitialSound()
  local file = string.format("Korean War 3.ogg")
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end
local Stimer = TIMER:New(InitialSound)
Stimer:Start(11)



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO Operation start and phase changes
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function BlueOps:OnAfterStart(From,Event,To)
  MESSAGE:New("Operation Port Authority Started!",15,"Port Authority"):ToBlue()
end


-- next phase
function BlueOps:OnAfterPhaseChange(From,Event,To,Phase)
  -- Next phase, this is Phase done
  local phase = BlueOps:GetPhaseActive()
  local ind = phase.name
  local type = BLUEOperation[ind].TargetAuftrag
  local brief = BLUEOperation[ind].TargetBriefing
  if DEBUG then
    BlueTargets[ind].verbose = 3
  end
  local task = PLAYERTASK:New(type,BlueTargets[ind],true,99,type)
  task:AddFreetext(brief)
  if DEBUG then
    task.verbose = true
  end
  a2gtaskmanager:AddPlayerTaskToQueue(task)
  local file = "That Is Our Target.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

-- Operation finished
function BlueOps:OnAfterOver(From,Event,To,Phase)
  MESSAGE:New("Port Authority - We won!",15,"Port Authority Win"):ToBlue()
  local file = "Campaign Victory 1.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO PLAYER TASKING MISSIONS BASED ON DETECTION
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Mission = MISSION
  :New( US_CC, "Overlord", "High", "Attack Detect Mission Briefing", coalition.side.BLUE )
  :AddScoring( Scoring )

local FACSet = SET_GROUP:New():FilterPrefixes({ "EWRBLUE", "AWACSBLUE", "FACBLUE", "JTACBLUE", "366th" }):FilterStart()

local FACAreas = DETECTION_AREAS:New( FACSet, 5000 )
FACAreas:BoundDetectedZones()


local AttackGroups = SET_GROUP:New():FilterPrefixes("366th"):FilterCoalitions(coalition.side.BLUE):FilterStart()

A2GTaskDispatcher = TASK_A2G_DISPATCHER:New( Mission, AttackGroups, FACAreas )

--- @param #TaskDispatcher self
-- @param From 
-- @param Event
-- @param To
-- @param Tasking.Task_A2G#TASK_A2G Task
-- @param Wrapper.Unit#UNIT TaskUnit
-- @param #string PlayerName
function A2GTaskDispatcher:OnAfterAssign( From, Event, To, Task, TaskUnit, PlayerName )
  Task:SetScoreOnProgress( "Player " .. PlayerName .. " destroyed a target", 20, TaskUnit )
  Task:SetScoreOnSuccess( "The task has been successfully completed!", 200, TaskUnit )
  Task:SetScoreOnFail( "The task has failed completion!", -100, TaskUnit )
end

function A2GTaskDispatcher:OnAfterSuccess(From,Event,To,Task)
  local file = "GreatSuccess.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function Mission:OnBeforeComplete( From, Event, To )
  local targetRedHQ = STATIC:FindByName( "REDHQ" )
  if targetRedHQ:IsAlive() == false then
    Mission:GetCommandCenter():MessageToCoalition( "Mission Complete!" )
    return true
  end
  return false
end

---Could use the same structure for the zone clear phase using DETECTION_UNITS to build target table of all units left alive inside the battlezone

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO RED ARMOR
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--RED PLATOONS
--Red Mobile Air Defense
-- ☢
--Red Alpha Air Defense
local strelaPlatoonAlpha = PLATOON:New( "☢ Strela", 15, "☢ Strela Alpha" )
strelaPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

local geckoPlatoonAlpha = PLATOON:New( "☢ SA8 Gecko", 15, "☢ SA8 Gecko Alpha" )
geckoPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

local shilkaPlatoonAlpha = PLATOON:New( "☢ ZSU-23 Shilka", 15, "☢ ZSU-23 Shilka Alpha" )
shilkaPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

--Red Bravo Air Defense
local strelaPlatoonBravo = PLATOON:New( "☢ Strela", 15, "☢ Strela Bravo" )
strelaPlatoonBravo:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

local geckoPlatoonBravo = PLATOON:New( "☢ SA8 Gecko", 15, "☢ SA8 Gecko Bravo" )
geckoPlatoonBravo:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

local shilkaPlatoonBravo = PLATOON:New( "☢ ZSU-23 Shilka", 15, "☢ ZSU-23 Shilka Bravo" )
shilkaPlatoonBravo:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

--Red Tanks

-- ☮
--Initial Starting Platoon
local t80uPlatoonAlpha = PLATOON:New( "☮ T80U", 35, "☮ T80U Alpha")
t80uPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
t80uPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
t80uPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.PATROLZONE, 70)
t80uPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.ONGUARD, 70)


local t90PlatoonAlpha = PLATOON:New( "☮ T90", 35, "☮ T90 Alpha")
t90PlatoonAlpha:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
t90PlatoonAlpha:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
t90PlatoonAlpha:AddMissionCapability(AUFTRAG.Type.PATROLZONE, 80)
t90PlatoonAlpha:AddMissionCapability(AUFTRAG.Type.ONGUARD, 80)

local t72PlatoonAlpha = PLATOON:New( "☮ T72B3", 35, "☮ T72B3 Alpha")
t72PlatoonAlpha:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
t72PlatoonAlpha:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
t72PlatoonAlpha:AddMissionCapability(AUFTRAG.Type.PATROLZONE, 80)
t72PlatoonAlpha:AddMissionCapability(AUFTRAG.Type.ONGUARD, 80)

local t80uPlatoonBravo = PLATOON:New( "☮ T80U", 35, "☮ T80U Bravo")
t80uPlatoonBravo:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
t80uPlatoonBravo:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
t80uPlatoonBravo:AddMissionCapability(AUFTRAG.Type.PATROLZONE, 80)
t80uPlatoonBravo:AddMissionCapability(AUFTRAG.Type.ONGUARD, 80)

local t90PlatoonBravo = PLATOON:New( "☮ T90", 35, "☮ T90 Bravo")
t90PlatoonBravo:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
t90PlatoonBravo:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
t90PlatoonBravo:AddMissionCapability(AUFTRAG.Type.PATROLZONE, 80)
t90PlatoonBravo:AddMissionCapability(AUFTRAG.Type.ONGUARD, 80)

local t72PlatoonBravo = PLATOON:New( "☮ T72B3", 35, "☮ T72B3 Bravo")
t72PlatoonBravo:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
t72PlatoonBravo:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
t72PlatoonBravo:AddMissionCapability(AUFTRAG.Type.PATROLZONE, 80)
t72PlatoonBravo:AddMissionCapability(AUFTRAG.Type.ONGUARD, 80)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO BUILD RED BRIGADES
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--RED ARMOR BRIGADES
local redBrigadeArmorAlpha = BRIGADE:New( "WarehouseRedAlphaBrigade", "Jelly Rolls")
redBrigadeArmorAlpha:AddPlatoon(t80uPlatoonAlpha)
redBrigadeArmorAlpha:AddPlatoon(t90PlatoonAlpha)
redBrigadeArmorAlpha:AddPlatoon(t72PlatoonAlpha)
redBrigadeArmorAlpha:SetSpawnZone(zone4)
redBrigadeArmorAlpha:Start()

local redBrigadeArmorBravo = BRIGADE:New( "WarehouseRedBravoBrigade", "Jelly Donuts")
redBrigadeArmorBravo:AddPlatoon(t80uPlatoonBravo)
redBrigadeArmorBravo:AddPlatoon(t90PlatoonBravo)
redBrigadeArmorBravo:AddPlatoon(t72PlatoonBravo)
redBrigadeArmorBravo:SetSpawnZone(zone5)
redBrigadeArmorBravo:Start()


--RED AIR DEFENSE BRIGADES

local redBrigadeAirDefenseAlpha = BRIGADE:New( "WarehouseRedAlphaAirBrigade", "Strawberry Jelly")
redBrigadeAirDefenseAlpha:AddPlatoon(strelaPlatoonAlpha)
redBrigadeAirDefenseAlpha:AddPlatoon(geckoPlatoonAlpha)
redBrigadeAirDefenseAlpha:AddPlatoon(shilkaPlatoonAlpha)
redBrigadeAirDefenseAlpha:SetSpawnZone(zone16)
redBrigadeAirDefenseAlpha:Start()

local redBrigadeAirDefenseBravo = BRIGADE:New( "WarehouseRedBravoAirBrigade", "Grape Jelly")
redBrigadeAirDefenseBravo:AddPlatoon(strelaPlatoonBravo)
redBrigadeAirDefenseBravo:AddPlatoon(geckoPlatoonBravo)
redBrigadeAirDefenseBravo:AddPlatoon(shilkaPlatoonBravo)
redBrigadeAirDefenseBravo:SetSpawnZone(zone15)
redBrigadeAirDefenseBravo:Start()


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO BLUE ARMOR
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--BLUE PLATOONS

--Blue Mobile Air Defense
--Alpha Platoon
local rolandPlatoonAlpha = PLATOON:New( "☢ Roland", 15, "☢ Roland Alpha" )
rolandPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

local chaparralPlatoonAlpha = PLATOON:New( "☢ Chaparral", 15, "☢ Chaparral Alpha" )
chaparralPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

local avengerPlatoonAlpha = PLATOON:New( "☢ Avenger", 15, "☢ Avenger Alpha" )
avengerPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

--Bravo Platoon
local rolandPlatoonBravo = PLATOON:New( "☢ Roland", 15, "☢ Roland Bravo" )
rolandPlatoonBravo:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

local chaparralPlatoonBravo = PLATOON:New( "☢ Chaparral", 15, "☢ Chaparral Bravo" )
chaparralPlatoonBravo:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

local avengerPlatoonBravo = PLATOON:New( "☢ Avenger", 15, "☢ Avenger Bravo" )
avengerPlatoonBravo:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )


--Blue Tanks

--☮
--Alpha Platoons

local abramsPlatoonAlpha = PLATOON:New( "☮ M1A2 Abrams", 35, "☮ M1A2 Abrams Alpha")
abramsPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
abramsPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
abramsPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.PATROLZONE, 70)
abramsPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.ONGUARD, 70)

local strykermgsPlatoonAlpha = PLATOON:New( "☮ Stryker MGS", 35, "☮ Stryker MGS Alpha")
strykermgsPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
strykermgsPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
strykermgsPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.PATROLZONE, 70)
strykermgsPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.ONGUARD, 70)

local strykeratgmPlatoonAlpha = PLATOON:New( "☮ ATGM Stryker", 35, "☮ ATGM Stryker Alpha")
strykeratgmPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
strykeratgmPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
strykeratgmPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.PATROLZONE, 70)
strykeratgmPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.ONGUARD, 70)

--Bravo Platoons
local abramsPlatoonBravo = PLATOON:New( "☮ M1A2 Abrams", 35, "☮ M1A2 Abrams Bravo")
abramsPlatoonBravo:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
abramsPlatoonBravo:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
abramsPlatoonBravo:AddMissionCapability(AUFTRAG.Type.PATROLZONE, 70)
abramsPlatoonBravo:AddMissionCapability(AUFTRAG.Type.ONGUARD, 70)

local strykermgsPlatoonBravo = PLATOON:New( "☮ Stryker MGS", 35, "☮ Stryker MGS Bravo")
strykermgsPlatoonBravo:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
strykermgsPlatoonBravo:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
strykermgsPlatoonBravo:AddMissionCapability(AUFTRAG.Type.PATROLZONE, 70)
strykermgsPlatoonBravo:AddMissionCapability(AUFTRAG.Type.ONGUARD, 70)

local strykeratgmPlatoonBravo = PLATOON:New( "☮ ATGM Stryker", 35, "☮ ATGM Stryker Bravo")
strykeratgmPlatoonBravo:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
strykeratgmPlatoonBravo:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
strykeratgmPlatoonBravo:AddMissionCapability(AUFTRAG.Type.PATROLZONE, 70)
strykeratgmPlatoonBravo:AddMissionCapability(AUFTRAG.Type.ONGUARD, 70)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO BLUE BRIGADE
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Blue Armor Brigades

local blueBrigadeArmorAlpha = BRIGADE:New( "WarehouseBlueAlphaBrigade", "Crunchy Peanutbutter")
blueBrigadeArmorAlpha:AddPlatoon(abramsPlatoonAlpha)
blueBrigadeArmorAlpha:AddPlatoon(strykermgsPlatoonAlpha)
blueBrigadeArmorAlpha:AddPlatoon(strykeratgmPlatoonAlpha)
blueBrigadeArmorAlpha:SetSpawnZone(zone1)
blueBrigadeArmorAlpha:Start()


local blueBrigadeArmorBravo = BRIGADE:New( "WarehouseBlueBravoBrigade", "Peanut Butter Crackers")
blueBrigadeArmorBravo:AddPlatoon(abramsPlatoonBravo)
blueBrigadeArmorBravo:AddPlatoon(strykermgsPlatoonBravo)
blueBrigadeArmorBravo:AddPlatoon(strykeratgmPlatoonBravo)
blueBrigadeArmorBravo:SetSpawnZone(zone2)
blueBrigadeArmorBravo:Start()


--Blue Air Defense Brigades

local blueBrigadeAirDefensesAlpha = BRIGADE:New( "WarehouseBlueAlphaAirBrigade", "Nut Crackers")
blueBrigadeAirDefensesAlpha:AddPlatoon(rolandPlatoonAlpha)
blueBrigadeAirDefensesAlpha:AddPlatoon(chaparralPlatoonAlpha)
blueBrigadeAirDefensesAlpha:AddPlatoon(avengerPlatoonAlpha)
blueBrigadeAirDefensesAlpha:SetSpawnZone(zone3)
blueBrigadeAirDefensesAlpha:Start()

local blueBrigadeAirDefensesBravo = BRIGADE:New( "WarehouseBlueBravoAirBrigade", "Jiffy")
blueBrigadeAirDefensesBravo:AddPlatoon(rolandPlatoonBravo)
blueBrigadeAirDefensesBravo:AddPlatoon(chaparralPlatoonBravo)
blueBrigadeAirDefensesBravo:AddPlatoon(avengerPlatoonBravo)
blueBrigadeAirDefensesBravo:SetSpawnZone(zone6)
blueBrigadeAirDefensesBravo:Start()


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO BUILD SQUADRONS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--✈
--Red Squadrons

--CAP
local redCapOne=SQUADRON:New("✈ MIG29S", 16, "✈ MIG29S") --Ops.Squadron#SQUADRON
redCapOne:AddMissionCapability(AUFTRAG.Type.CAP)
redCapOne:SetModex(100)
redCapOne:SetSkill(AI.Skill.ACE)
redCapOne:SetTakeoffHot()
redCapOne:SetDespawnAfterHolding(true)

local redCapTwo=SQUADRON:New("✈ SU33", 16, "✈ SU33") --Ops.Squadron#SQUADRON
redCapTwo:AddMissionCapability(AUFTRAG.Type.CAP)
redCapTwo:SetModex(100)
redCapTwo:SetSkill(AI.Skill.ACE)
redCapTwo:SetTakeoffHot()
redCapTwo:SetDespawnAfterHolding(true)
--INTERCEPT
local redIntOne=SQUADRON:New("✈ MIG31", 16, "✈ MIG31") --Ops.Squadron#SQUADRON
redIntOne:AddMissionCapability(AUFTRAG.Type.INTERCEPT)
redIntOne:SetModex(100)
redIntOne:SetSkill(AI.Skill.ACE)
redIntOne:SetTakeoffHot()
redIntOne:SetDespawnAfterHolding(true)
local redIntTwo=SQUADRON:New("✈ SU35S", 16, "✈ SU35S") --Ops.Squadron#SQUADRON
redIntTwo:AddMissionCapability(AUFTRAG.Type.INTERCEPT)
redIntTwo:SetModex(100)
redIntTwo:SetSkill(AI.Skill.ACE)
redIntTwo:SetTakeoffHot()
redIntTwo:SetDespawnAfterHolding(true)
--SEAD
local redSeadOne=SQUADRON:New("✈ SU25", 16, "✈ SU25") --Ops.Squadron#SQUADRON
redSeadOne:AddMissionCapability(AUFTRAG.Type.SEAD)
redSeadOne:SetModex(100)
redSeadOne:SetSkill(AI.Skill.ACE)
redSeadOne:SetTakeoffHot()
redSeadOne:SetDespawnAfterHolding(true)

local redSeadTwo=SQUADRON:New("✈ SU34", 16, "✈ SU34") --Ops.Squadron#SQUADRON
redSeadTwo:AddMissionCapability(AUFTRAG.Type.SEAD)
redSeadTwo:SetModex(100)
redSeadTwo:SetSkill(AI.Skill.ACE)
redSeadTwo:SetTakeoffHot()
redSeadTwo:SetDespawnAfterHolding(true)

--BOMBERS
local redBomberOne=SQUADRON:New("✈ SU34BOMBER", 16, "✈ SU34BOMBER") --Ops.Squadron#SQUADRON
redBomberOne:AddMissionCapability({AUFTRAG.Type.BOMBRUNWAY}, 80)
redBomberOne:SetModex(100)
redBomberOne:SetGrouping(2)
redBomberOne:SetSkill(AI.Skill.ACE)
redBomberOne:SetDespawnAfterHolding(true)

local redBomberTwo=SQUADRON:New("✈ SU33BOMBER", 16, "✈ SU33BOMBER") --Ops.Squadron#SQUADRON
redBomberTwo:AddMissionCapability({AUFTRAG.Type.BOMBRUNWAY}, 80)
redBomberTwo:SetModex(100)
redBomberTwo:SetGrouping(2)
redBomberTwo:SetSkill(AI.Skill.ACE)
redBomberTwo:SetDespawnAfterHolding(true)

--CAS
local redCasOne=SQUADRON:New("✈ KA50", 16, "✈ KA50")
redCasOne:AddMissionCapability(AUFTRAG.Type.CAS, 80)
redCasOne:SetTakeoffAir()
redCasOne:SetModex(100)
redCasOne:SetSkill(AI.Skill.ACE)
redCasOne:SetDespawnAfterHolding(true)

local redCasTwo=SQUADRON:New("✈ MI24V", 16, "✈ MI24V")
redCasTwo:AddMissionCapability(AUFTRAG.Type.CAS, 80)
redCasTwo:SetModex(100)
redCasTwo:SetSkill(AI.Skill.ACE)
redCasTwo:SetTakeoffHot()
redCasTwo:SetDespawnAfterHolding(true)

--BLUE SQUADRONS

--CAP
local blueCapOne=SQUADRON:New("✈ F18C", 8, "✈ F18C") --Ops.Squadron#SQUADRON
blueCapOne:AddMissionCapability(AUFTRAG.Type.CAP)
blueCapOne:SetModex(100)
blueCapOne:SetCallsign(CALLSIGN.Aircraft.Ford)
blueCapOne:SetParkingIDs(Parking)
blueCapOne:SetTakeoffHot()
blueCapOne:SetDespawnAfterHolding(true)
blueCapOne:SetSkill(AI.Skill.ACE)

local blueCapTwo=SQUADRON:New("✈ F16CM", 8, "✈ F16CM") --Ops.Squadron#SQUADRON
blueCapTwo:AddMissionCapability(AUFTRAG.Type.CAP)
blueCapTwo:SetModex(100)
blueCapTwo:SetCallsign(CALLSIGN.Aircraft.Chevy)
blueCapTwo:SetParkingIDs(Parking)
blueCapTwo:SetTakeoffHot()
blueCapTwo:SetDespawnAfterHolding(true)
blueCapTwo:SetSkill(AI.Skill.ACE)

--INTERCEPT
local blueIntOne=SQUADRON:New("✈ F14B", 8, "✈ F14B") --Ops.Squadron#SQUADRON
blueIntOne:AddMissionCapability(AUFTRAG.Type.INTERCEPT)
blueIntOne:SetModex(100)
blueIntOne:SetCallsign(CALLSIGN.Aircraft.Pontiac)
blueIntOne:SetParkingIDs(Parking)
blueIntOne:SetTakeoffHot()
blueIntOne:SetDespawnAfterHolding(true)
blueIntOne:SetSkill(AI.Skill.ACE)

--SEAD
local blueSeadOne=SQUADRON:New("✈ F16CSEAD", 8, "✈ F16CSEAD") --Ops.Squadron#SQUADRON
blueSeadOne:AddMissionCapability(AUFTRAG.Type.SEAD)
blueSeadOne:SetModex(100)
blueSeadOne:SetCallsign(CALLSIGN.Aircraft.Boar)
blueSeadOne:SetParkingIDs(Parking)
blueSeadOne:SetTakeoffHot()
blueSeadOne:SetDespawnAfterHolding(true)
blueSeadOne:SetSkill(AI.Skill.ACE)

local blueSeadTwo=SQUADRON:New("✈ F18CSEAD", 8, "✈ F18CSEAD") --Ops.Squadron#SQUADRON
blueSeadTwo:AddMissionCapability(AUFTRAG.Type.SEAD)
blueSeadTwo:SetModex(100)
blueSeadTwo:SetCallsign(CALLSIGN.Aircraft.Boar)
blueSeadTwo:SetParkingIDs(Parking)
blueSeadTwo:SetTakeoffHot()
blueSeadTwo:SetDespawnAfterHolding(true)
blueSeadTwo:SetSkill(AI.Skill.ACE)

--BOMBERS

--B52 is antiship
local blueBomberOne=SQUADRON:New("✈ B52BOMBER", 8, "✈ B52BOMBER") --Ops.Squadron#SQUADRON
blueBomberOne:AddMissionCapability(AUFTRAG.Type.BOMBRUNWAY, 100)
blueBomberOne:SetModex(100)
blueBomberOne:SetCallsign(CALLSIGN.Aircraft.Tusk)
blueBomberOne:SetTakeoffAir()
blueBomberOne:SetGrouping(3)
blueBomberOne:SetDespawnAfterHolding(true)
blueBomberOne:SetSkill(AI.Skill.ACE)

local blueBomberTwo=SQUADRON:New("✈ B1BOMBER", 8, "✈ B1BOMBER") --Ops.Squadron#SQUADRON
blueBomberTwo:AddMissionCapability(AUFTRAG.Type.BOMBRUNWAY, 100)
blueBomberTwo:AddMissionCapability(AUFTRAG.Type.BOMBCARPET, 100)
blueBomberTwo:SetModex(100)
blueBomberTwo:SetCallsign(CALLSIGN.Aircraft.Tusk)
blueBomberTwo:SetDespawnAfterHolding(true)
blueBomberTwo:SetTakeoffAir()
blueBomberTwo:SetGrouping(3)
blueBomberTwo:SetSkill(AI.Skill.ACE)

--CAS
local blueCasOne=SQUADRON:New("✈ AH64DCAS", 8, "✈ AH64DCAS")
blueCasOne:AddMissionCapability(AUFTRAG.Type.CAS, 100)
blueCasOne:SetModex(100)
blueCasOne:SetSkill(AI.Skill.ACE)
blueCasOne:SetDespawnAfterHolding(true)
blueCasOne:SetTakeoffAir()
blueCasOne:SetParkingIDs(Parking)

local blueCasTwo=SQUADRON:New("✈A10CIICAS", 8, "✈A10CIICAS")
blueCasTwo:AddMissionCapability(AUFTRAG.Type.CAS, 100)
blueCasTwo:SetModex(100)
blueCasTwo:SetSkill(AI.Skill.ACE)
blueCasTwo:SetDespawnAfterHolding(true)
blueCasTwo:SetTakeoffHot()
blueCasTwo:SetParkingIDs(Parking)

--RECON
local blueRecon=SQUADRON:New("JTACBLUE Reaper", 8, "JTACBLUE Reaper")
blueRecon:AddMissionCapability(AUFTRAG.Type.ORBIT, 100)
blueRecon:SetCallsign(CALLSIGN.JTAC.Deathstar)
blueRecon:SetSkill(AI.Skill.ACE)
blueRecon:SetTakeoffAir()
blueRecon:SetModex(100)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO AWACS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--RED AWACS

local AwacsRed = AIRWING:New("WarehouseGeleAwacsAirwing", "AWACSRED")
AwacsRed:SetReportOn()
AwacsRed:SetMarker(false)
AwacsRed:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Gelendzhik))
AwacsRed:SetRespawnAfterDestroyed(300)
AwacsRed:SetTakeoffAir()
AwacsRed:__Start(2)

-- AWACS itself
local AwacsRedSquadron = SQUADRON:New("AWACSRED", 2, "AWACSRED")
AwacsRedSquadron:AddMissionCapability({AUFTRAG.Type.ORBIT},100)
AwacsRedSquadron:SetFuelLowRefuel(true)
AwacsRedSquadron:SetFuelLowThreshold(0.2)
AwacsRedSquadron:SetTurnoverTime(10,20)
AwacsRed:AddSquadron(AwacsRedSquadron)
AwacsRed:NewPayload("AWACSRED",-1,{AUFTRAG.Type.ORBIT},100)



-- Escorts
local AwacsEscortsRed = SQUADRON:New("✈ SU35SESCORT",4,"✈ SU35SESCORT")
AwacsEscortsRed:AddMissionCapability({AUFTRAG.Type.ESCORT})
AwacsEscortsRed:SetFuelLowRefuel(true)
AwacsEscortsRed:SetFuelLowThreshold(0.3)
AwacsEscortsRed:SetTurnoverTime(10,20)
AwacsEscortsRed:SetTakeoffAir()
AwacsEscortsRed:SetRadio(275,radio.modulation.AM)
AwacsRed:AddSquadron(AwacsEscortsRed)
AwacsRed:NewPayload("✈ SU35SESCORT",-1,{AUFTRAG.Type.ESCORT},100)


local RedAwacs = AWACS:New("Awacs-Red", AwacsRed, "red", AIRBASE.Caucasus.Gelendzhik, "REDAWACSORBIT", ZONE:FindByName("REDCHIEFBORDER"), "REDCAPZONE", 275, radio.modulation.AM )

RedAwacs:SetEscort(2)
RedAwacs:SetAwacsDetails(CALLSIGN.AWACS.Magic,1,30,280,88,25)

RedAwacs:__Start(5)


--BLUE AWACS
-- We need an AirWing
local AwacsBlue = AIRWING:New("WarehouseSochiAwacsAirwing", "AWACSBLUE")
--AwacsAW:SetReportOn()
AwacsBlue:SetMarker(false)
AwacsBlue:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Sochi_Adler))
AwacsBlue:SetRespawnAfterDestroyed(300)
AwacsBlue:SetTakeoffAir()
AwacsBlue:__Start(2)

-- AWACS itself
local AwacsBlueSquadron = SQUADRON:New("AWACSBLUE", 2, "AWACSBLUE")
AwacsBlueSquadron:AddMissionCapability({AUFTRAG.Type.ORBIT},100)
AwacsBlueSquadron:SetFuelLowRefuel(true)
AwacsBlueSquadron:SetFuelLowThreshold(0.2)
AwacsBlueSquadron:SetTurnoverTime(10,20)
AwacsBlue:AddSquadron(AwacsBlueSquadron)
AwacsBlue:NewPayload("AWACSBLUE",-1,{AUFTRAG.Type.ORBIT},100)


-- Escorts
local AwacsEscortsRed = SQUADRON:New("✈ F14BESCORT",4,"✈ F14BESCORT")
AwacsEscortsRed:AddMissionCapability({AUFTRAG.Type.ESCORT})
AwacsEscortsRed:SetFuelLowRefuel(true)
AwacsEscortsRed:SetFuelLowThreshold(0.3)
AwacsEscortsRed:SetTurnoverTime(10,20)
AwacsEscortsRed:SetTakeoffAir()
AwacsEscortsRed:SetRadio(275,radio.modulation.AM)
AwacsBlue:AddSquadron(AwacsEscortsRed)
AwacsBlue:NewPayload("✈ F14BESCORT",-1,{AUFTRAG.Type.ESCORT},100)


local AwacsBlue = AWACS:New("Awacs-Blue", AwacsBlue, "blue", AIRBASE.Caucasus.Sochi_Adler, "BLUEAWACSORBIT", ZONE:FindByName("FEZ"), "BLUECAPZONE", 264, radio.modulation.AM )

AwacsBlue:SetEscort(2)
AwacsBlue:SetAwacsDetails(CALLSIGN.AWACS.Darkstar,1,30,280,88,25)
AwacsBlue:SetTOS(4, 4)


AwacsBlue:__Start(5)

-- Set up SRS
--if hereSRSGoogle then
--  -- use Google
--  AwacsBlue:SetSRS(hereSRSPath,"female","en-US",hereSRSPort,"en-US-Wavenet-F",0.9,hereSRSGoogle)
--else
   --use Windows
AwacsBlue:SetSRS(hereSRSPath,"male","en-US",hereSRSPort, nil, 0.9)
--end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO BLUE TANKER
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local ZoneBoom=ZONE:FindByName("Zone Boom")
local ZoneProbe=ZONE:FindByName("Zone Probe")
local ZonePointBoom=ZONE:FindByName("Point Boom")
local ZonePointProbe=ZONE:FindByName("Point Probe")

-- KC-135 squadron, callsign "Arco".
local kc135=SQUADRON:New("✈ KC135", 5, "✈ KC135") --Ops.Squadron#SQUADRON
kc135:SetModex(100)
kc135:SetCallsign(CALLSIGN.Tanker.Arco)
kc135:SetRadio(260)
kc135:SetSkill(AI.Skill.EXCELLENT)
kc135:AddMissionCapability({AUFTRAG.Type.TANKER}, 100)
kc135:AddTacanChannel(70, 75)

-- KC-130 squadron, callsign "Texaco".
local kc130=SQUADRON:New("✈ KC130", 5, "✈ KC130") --Ops.Squadron#SQUADRON
kc130:SetModex(200)
kc130:SetCallsign(CALLSIGN.Tanker.Texaco)
kc130:SetRadio(261)
kc130:SetSkill(AI.Skill.EXCELLENT)
kc130:AddMissionCapability({AUFTRAG.Type.TANKER}, 100)
kc130:AddTacanChannel(80, 85)

-- Create an airwing.
local blueTankerWing=AIRWING:New("WarehouseSochiAwacsAirwing", "Need Gas?") --Ops.AirWing#AIRWING


-- Add a patrol point for tanker with boom and receptacle.
blueTankerWing:AddPatrolPointTANKER(ZonePointBoom, 20000, 350, 180, 30, Unit.RefuelingSystem.BOOM_AND_RECEPTACLE)

-- Add a patrol point for tankers with probe and drogue.
blueTankerWing:AddPatrolPointTANKER(ZonePointProbe, 20000, 350, 0, 30, Unit.RefuelingSystem.PROBE_AND_DROGUE)

-- Set number of tankers constantly in the air.
blueTankerWing:SetNumberTankerBoom(1)
blueTankerWing:SetNumberTankerProbe(1)


-- Add squadrons to airwing.
blueTankerWing:AddSquadron(kc135)
blueTankerWing:AddSquadron(kc130)

blueTankerWing:SetTakeoffAir()


-- Start airwing.
blueTankerWing:Start()

-- Function to create a new tanker mission.
local function NewTankerMission(RefuelSystem)

  -- Get coordinate depending on refuel system type.
  local Coordinate
  if RefuelSystem==Unit.RefuelingSystem.BOOM_AND_RECEPTACLE then
    Coordinate=ZoneBoom:GetCoordinate()
  elseif RefuelSystem==Unit.RefuelingSystem.PROBE_AND_DROGUE then
    Coordinate=ZoneProbe:GetCoordinate()
  end

  -- Tanker mission.
  local mission=AUFTRAG:NewTANKER(Coordinate, 20000, 350, 000, 25, RefuelSystem)
  
  -- Assign mission to airwing.
  blueTankerWing:AddMission(mission)
  
  -- Create a new mission when this one is done. Keeps tankers in the air at all times.
  function mission:OnAfterDone()
    MESSAGE:New(string.format("Mission %s done. Creating new TANKER mission for refuel system type %d", mission:GetName(), RefuelSystem), 360):ToAll():ToLog()
    NewTankerMission(RefuelSystem)
  end
  
end

-- Create a tanker mission with boom.
NewTankerMission(Unit.RefuelingSystem.BOOM_AND_RECEPTACLE)

-- Create a tanker mission with probe.
NewTankerMission(Unit.RefuelingSystem.PROBE_AND_DROGUE)


--- Function called each time a flight group goes on a mission. Can be used to fine tune.
function blueTankerWing:OnAfterFlightOnMission(From, Event, To, Flightgroup, Mission)
  local flightgroup=Flightgroup --Ops.FlightGroup#FLIGHTGROUP
  local mission=Mission --Ops.Auftrag#AUFTRAG
  
  -- Get info about TACAN channel.
  local tacanChannel, tacanMorse, tacanBand=flightgroup:GetTACAN()
  
  -- Print some info.
  local text=string.format("Flight %s on %s mission %s. TACAN Channel %s%s (%s)", flightgroup:GetName(), mission:GetType(), mission:GetName(), tostring(tacanChannel), tostring(tacanBand), tostring(tacanMorse))
  MESSAGE:New(text):ToAll():ToLog()  
  
  
  flightgroup:SetFuelLowThreshold(25)
end


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO BUILD AIRWINGS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--RED AIRWING

local redAirwing = AIRWING:New("WarehouseNovoAirwing", "Jelly Smashers")


redAirwing:NewPayload("✈ MIG31", 99, AUFTRAG.Type.INTERCEPT, 100)
redAirwing:NewPayload("✈ SU35S", 99, AUFTRAG.Type.INTERCEPT, 100)
redAirwing:NewPayload("✈ MIG29S", 99, AUFTRAG.Type.CAP, 100)
redAirwing:NewPayload("✈ SU33", 99, AUFTRAG.Type.CAP, 100)
redAirwing:NewPayload("✈ SU25", 99, AUFTRAG.Type.SEAD, 100)
redAirwing:NewPayload("✈ SU34", 99, AUFTRAG.Type.SEAD, 100)
redAirwing:NewPayload("✈ SU34BOMBER", 99, AUFTRAG.Type.BOMBRUNWAY, 100)
redAirwing:NewPayload("✈ SU33BOMBER", 99, AUFTRAG.Type.BOMBRUNWAY, 100)
redAirwing:NewPayload("✈ KA50", 99, AUFTRAG.Type.CAS, 100)
redAirwing:NewPayload("✈ MI24V", 99, AUFTRAG.Type.CAS, 100)

--redAirwing:SetAirbase(AIRBASE.Caucasus.Novorossiysk)

redAirwing:AddSquadron(redCapOne)
redAirwing:AddSquadron(redCapTwo)
redAirwing:AddSquadron(redIntOne)
redAirwing:AddSquadron(redIntTwo)
redAirwing:AddSquadron(redSeadOne)
redAirwing:AddSquadron(redSeadTwo)
redAirwing:AddSquadron(redBomberOne)
redAirwing:AddSquadron(redBomberTwo)
redAirwing:AddSquadron(redCasOne)
redAirwing:AddSquadron(redCasTwo)


redAirwing:Start()




--BLUE AIRWING

local blueAirwing = AIRWING:New("WarehouseSochiAirwing", "Peanut Butter Crackers")

blueAirwing:NewPayload("✈ F14B", 99, AUFTRAG.Type.INTERCEPT, 100)
blueAirwing:NewPayload("✈ F16CM", 99, AUFTRAG.Type.CAP, 100)
blueAirwing:NewPayload("✈ F18C", 99, AUFTRAG.Type.CAP, 100)
blueAirwing:NewPayload("✈ F16CSEAD", 99, AUFTRAG.Type.SEAD, 100)
blueAirwing:NewPayload("✈ F18CSEAD", 99, AUFTRAG.Type.SEAD, 100)
blueAirwing:NewPayload("✈ B52BOMBER", 99, AUFTRAG.Type.BOMBRUNWAY, 100)
blueAirwing:NewPayload("✈ B1BOMBER", 99, {AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBCARPET}, 100)
blueAirwing:NewPayload("✈A10CIICAS", 99, AUFTRAG.Type.CAS, 100)
blueAirwing:NewPayload("✈ AH64DCAS", 99, AUFTRAG.Type.CAS, 100)
blueAirwing:NewPayload("JTACBLUE Reaper", 99, AUFTRAG.Type.ORBIT, 100)

blueAirwing:AddSquadron(blueCapOne)
blueAirwing:AddSquadron(blueCapTwo)
blueAirwing:AddSquadron(blueIntOne)
blueAirwing:AddSquadron(blueSeadOne)
blueAirwing:AddSquadron(blueSeadTwo)
blueAirwing:AddSquadron(blueRecon)
blueAirwing:AddSquadron(blueCasOne)
blueAirwing:AddSquadron(blueCasTwo)
blueAirwing:AddSquadron(blueBomberOne)
blueAirwing:AddSquadron(blueBomberTwo)

blueAirwing:Start()


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO MISSIONS FOR CHIEFS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--RED
--
--Red Capture Mission
local missionRedCaptureZone1=AUFTRAG:NewCAPTUREZONE(opzone1, coalition.side.RED)
missionRedCaptureZone1:SetRequiredAssets(8)
missionRedCaptureZone1:SetRepeatOnFailure(10)
missionRedCaptureZone1:SetROE(ENUMS.ROE.OpenFire)

--Red CAP Mission for Red Side Preclashzone
local missionRedCAPzone1 = AUFTRAG:NewCAP(zone10, 15000, 350, nil, 90, 20, {"Air"})
missionRedCAPzone1:SetRequiredAssets(2)
missionRedCAPzone1:SetRepeatOnFailure(5)
missionRedCAPzone1:SetROE(ENUMS.ROE.OpenFire)

--Red CAP Mission for MainClashZone
local missionRedCAPzone2 = AUFTRAG:NewCAP(zone13, 15000, 350, nil, 90, 20, {"Air"})
missionRedCAPzone2:SetRequiredAssets(2)
missionRedCAPzone2:SetRepeatOnFailure(5)
missionRedCAPzone2:SetROE(ENUMS.ROE.OpenFire)

--Red CAS Mission for MainClashZone
local missionRedCASzone2 = AUFTRAG:NewCAS(zone13, 8000, 250)
missionRedCASzone2:SetRequiredAssets(2)
missionRedCASzone2:SetRepeatOnFailure(5)
missionRedCASzone2:SetROE(ENUMS.ROE.OpenFire)

--Air Defense Missions -- use Capzones Zone7 Zone8 Zone9
local missionRedAirDefenseOne = AUFTRAG:NewAIRDEFENSE(zone14)
missionRedAirDefenseOne:SetRequiredAssets(6)
missionRedAirDefenseOne:SetRepeatOnFailure(5)
missionRedAirDefenseOne:SetROE(ENUMS.ROE.OpenFireWeaponFree)

--Bombing Mission To Airbase
local SochiRunwayTarget=AIRBASE:FindByName(AIRBASE.Caucasus.Sochi_Adler)

local missionRedRunwayBombing=AUFTRAG:NewBOMBRUNWAY(SochiRunwayTarget, 30000)
missionRedRunwayBombing:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
missionRedRunwayBombing:SetFormation(ENUMS.Formation.FixedWing.LineAbreast.Close)
missionRedRunwayBombing:SetMissionAltitude(30000)

--
--BLUE
--
--Blue Capture Mission to Take Main Clash Zone
local missionBlueCaptureZone6 = AUFTRAG:NewCAPTUREZONE(opzone1, coalition.side.BLUE)
missionBlueCaptureZone6:SetROE(ENUMS.ROE.OpenFireWeaponFree)
missionBlueCaptureZone6:SetRequiredAssets(6)
missionBlueCaptureZone6:SetRepeatOnFailure(10)


--Blue CAP Mission for MainClashZone
local missionBlueCAPzone2 = AUFTRAG:NewCAP(zone14, 15000, 350, nil, 90, 20, {"Air"})
missionBlueCAPzone2:SetRequiredAssets(2)
missionBlueCAPzone2:SetRepeatOnFailure(20)
missionBlueCAPzone2:SetROE(ENUMS.ROE.OpenFireWeaponFree)

--Blue CAP Mission for Blue Side PreClashZone
local missionBlueCAPzone3 = AUFTRAG:NewCAP(zone9, 15000, 350, nil, 90, 20, {"Air"})
missionBlueCAPzone3:SetRequiredAssets(2)
missionBlueCAPzone3:SetRepeatOnFailure(20)
missionBlueCAPzone3:SetROE(ENUMS.ROE.OpenFireWeaponFree)

--Blue CAS Mission for MainClashZone
local missionBlueCASzone2 = AUFTRAG:NewCAS(zone14, 5000, 250, nil, 90, 5, {"Ground Units"})
missionBlueCASzone2:SetRequiredAssets(2)
missionBlueCASzone2:SetRepeatOnFailure(15)
missionBlueCASzone2:SetROE(ENUMS.ROE.OpenFireWeaponFree)

--Blue RECON Mission for Drone
local missionBlueRecon = AUFTRAG:NewORBIT(zone14:GetCoordinate(), 45000, 300, 90, 30)
missionBlueRecon:SetRequiredAssets(1)
missionBlueRecon:SetRepeatOnFailure(5)
missionBlueRecon:SetROE(ENUMS.ROE.OpenFireWeaponFree)

--Air Defense Missions -- use Capzones Zone7 Zone8 Zone9
local missionBlueAirDefenseOne = AUFTRAG:NewAIRDEFENSE( zone14 )
missionBlueAirDefenseOne:SetRequiredAssets(4)
missionBlueAirDefenseOne:SetRepeatOnFailure(5)
missionBlueAirDefenseOne:SetROE(ENUMS.ROE.OpenFireWeaponFree)

--Bombing Mission To Airbase
local NovoRunwayTarget=AIRBASE:FindByName(AIRBASE.Caucasus.Novorossiysk)

local missionBlueRunwayBombing=AUFTRAG:NewBOMBRUNWAY(NovoRunwayTarget, 30000)
missionBlueRunwayBombing:SetRequiredAssets(1)
missionBlueRunwayBombing:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
missionBlueRunwayBombing:SetFormation(ENUMS.Formation.FixedWing.LineAbreast.Close)
missionBlueRunwayBombing:SetMissionAltitude(30000)
missionBlueRunwayBombing:SetRepeatOnFailure(10)

--Carpet Bombing Mission
local bombingTarget = STATIC:FindByName("REDHQ")
local missionBlueCarpetBomb = AUFTRAG:NewBOMBCARPET(bombingTarget, 35000, 1000)
missionBlueCarpetBomb:SetRequiredAssets(1)
missionBlueCarpetBomb:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
missionBlueCarpetBomb:SetFormation(ENUMS.Formation.FixedWing.BomberElement.Close)
missionBlueCarpetBomb:SetRepeatOnFailure(10)

--Bombing Mission
local bombingTarget = TARGET:New(ZONE:FindByName("BombingZone"))
local targCoord = bombingTarget:GetCoordinate()
local missionBlueBombing = AUFTRAG:NewBOMBING(targCoord, 35000)
missionBlueBombing:SetRequiredAssets(1)
missionBlueBombing:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
missionBlueBombing:SetFormation(ENUMS.Formation.FixedWing.BomberElement.Close)
missionBlueBombing:SetRepeatOnFailure(10)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO BUILD CHIEFS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--RED

--Agents
local RedAgents = DetectionSetGroupRed

--Define the CHIEF.  
local RUChief=CHIEF:New(coalition.side.RED, RedAgents)

--Add border zone.
RUChief:AddBorderZone(zone8)

--Enable tactical overview.
--RUChief:SetTacticalOverviewOn()

--Response on targets
RUChief:SetResponseOnTarget(1, 2, 2, TARGET.Category.AIRCRAFT, AUFTRAG.Type.INTERCEPT)
RUChief:SetResponseOnTarget(8, 10, 3, TARGET.Category.ZONE, AUFTRAG.Type.CAPTUREZONE)
RUChief:SetResponseOnTarget(2, 4, 3, TARGET.Category.GROUND, AUFTRAG.Type.SEAD)


--Strategy--  ADJUST THIS IF TOO MUCH
RUChief:SetStrategy(RUChief.Strategy.TOTALWAR)

--ADD BRIGADES

RUChief:AddBrigade(redBrigadeArmorAlpha)
RUChief:AddBrigade(redBrigadeArmorBravo)
RUChief:AddBrigade(redBrigadeAirDefenseAlpha)
RUChief:AddBrigade(redBrigadeAirDefenseBravo)


--ADD AIRWINGS

RUChief:AddAirwing(redAirwing)


--ADD MISSIONS
RUChief:AddMission(missionRedCaptureZone1)
RUChief:AddMission(missionRedCAPzone1)
RUChief:AddMission(missionRedCAPzone2)
RUChief:AddMission(missionRedCASzone2)
RUChief:AddMission(missionRedRunwayBombing)
RUChief:AddMission(missionRedAirDefenseOne)

RUChief:SetLimitMission(2, AUFTRAG.Type.CAS)
RUChief:SetLimitMission(2, AUFTRAG.Type.SEAD)
RUChief:SetLimitMission(2, AUFTRAG.Type.CAP)
RUChief:SetLimitMission(2, AUFTRAG.Type.CAPTUREZONE)
RUChief:SetLimitMission(1, AUFTRAG.Type.BOMBRUNWAY)
RUChief:SetLimitMission(1, AUFTRAG.Type.INTERCEPT)
RUChief:SetLimitMission(2, AUFTRAG.Type.AIRDEFENSE)

--RED RESOURCES
-- Add strategic (OPS) zones.
local RedStratZone1 =RUChief:AddStrategicZone(opzone1, 100, 100)

--Red Chief Resources

local RedCAPTUREResourceOccupied = RUChief:CreateResource(AUFTRAG.Type.CAPTUREZONE, 6, 30, nil, nil)
RUChief:AddToResource(RedCAPTUREResourceOccupied, AUFTRAG.Type.PATROLZONE, 2, 16, nil, nil)

local RedCAPTUREResourceEmpty = RUChief:CreateResource(AUFTRAG.Type.ONGUARD, 2, 4)
RUChief:AddToResource(RedCAPTUREResourceEmpty, AUFTRAG.Type.PATROLZONE, 2, 3)


--Assign StratZones to resource lists

--StratZone1 - CAPTUREZONE
RUChief:SetStrategicZoneResourceOccupied(RedStratZone1, RedCAPTUREResourceOccupied)
RUChief:SetStrategicZoneResourceEmpty(RedStratZone1, RedCAPTUREResourceEmpty)


--Start Chief
RUChief:Start(5)



--
--BLUE
--Agents
local BlueAgents = DetectionSetGroupBlue
--Define the CHIEF.  
local USChief=CHIEF:New(coalition.side.BLUE, BlueAgents)
--Add border zone.
USChief:AddBorderZone(zone7)
--Enable tactical overview.

if DEBUG then
USChief:SetTacticalOverviewOn()
end

--Response on targets

USChief:SetResponseOnTarget(2, 2, 2, TARGET.Category.AIRCRAFT, AUFTRAG.Type.INTERCEPT)
USChief:SetResponseOnTarget(2, 4, 2, TARGET.Category.GROUND, AUFTRAG.Type.CAS)
USChief:SetResponseOnTarget(8, 8, 3, TARGET.Category.ZONE, AUFTRAG.Type.CAPTUREZONE)
USChief:SetResponseOnTarget(2, 4, 5, TARGET.Category.GROUND, AUFTRAG.Type.SEAD)
USChief:SetResponseOnTarget(1, 1, 2, TARGET.Category.AIRBASE, AUFTRAG.Type.BOMBRUNWAY)

--Strategy--  ADJUST THIS IF TOO MUCH
USChief:SetStrategy(USChief.Strategy.TOTALWAR)

--ADD BRIGADES

USChief:AddBrigade(blueBrigadeArmorAlpha)
USChief:AddBrigade(blueBrigadeArmorBravo)
USChief:AddBrigade(blueBrigadeAirDefensesAlpha)
USChief:AddBrigade(blueBrigadeAirDefensesBravo)


--ADD AIRWINGS

USChief:AddAirwing(blueAirwing)

--ADD MISSIONS

USChief:AddMission(missionBlueCaptureZone6)
USChief:AddMission(missionBlueCAPzone2)
USChief:AddMission(missionBlueCAPzone3)
USChief:AddMission(missionBlueCASzone2)
USChief:AddMission(missionBlueRecon)
USChief:AddMission(missionBlueAirDefenseOne)
USChief:AddMission(missionBlueRunwayBombing)
USChief:AddMission(missionBlueCarpetBomb)
USChief:AddMission(missionBlueBombing)

--USChief:SetLimitMission(5)
USChief:SetLimitMission(2, AUFTRAG.Type.CAS)
USChief:SetLimitMission(2, AUFTRAG.Type.SEAD)
USChief:SetLimitMission(2, AUFTRAG.Type.CAP)
USChief:SetLimitMission(1, AUFTRAG.Type.CAPTUREZONE)
USChief:SetLimitMission(1, AUFTRAG.Type.BOMBRUNWAY)
USChief:SetLimitMission(2, AUFTRAG.Type.INTERCEPT)
USChief:SetLimitMission(1, AUFTRAG.Type.AIRDEFENSE)
USChief:SetLimitMission(1, AUFTRAG.Type.BOMBCARPET)
USChief:SetLimitMission(1, AUFTRAG.Type.BOMBING)

--Blue Chief Resources
-- Add strategic (OPS) zones.
local BlueStratZone1 = USChief:AddStrategicZone(opzone1, 100, 100)

--Blue Chief Resources

local BlueCAPTUREResourceOccupied = USChief:CreateResource(AUFTRAG.Type.CAPTUREZONE, 6, 20, nil, nil)
USChief:AddToResource(BlueCAPTUREResourceOccupied, AUFTRAG.Type.PATROLZONE, 3, 6, nil, nil)

local BlueCAPTUREResourceEmpty = USChief:CreateResource(AUFTRAG.Type.ONGUARD, 3, 5)
USChief:AddToResource(BlueCAPTUREResourceEmpty, AUFTRAG.Type.PATROLZONE, 2, 4)


--Assign StratZones to resource lists
--StratZone1 - CAPTUREZONE
USChief:SetStrategicZoneResourceOccupied(BlueStratZone1, BlueCAPTUREResourceOccupied)
USChief:SetStrategicZoneResourceEmpty(BlueStratZone1, BlueCAPTUREResourceEmpty)



USChief:Start(5)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO ZONE CAPTURE
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local CaptureZoneAlpha = zone14

local ZoneCaptureCoalitionOne = ZONE_CAPTURE_COALITION:New( CaptureZoneAlpha, coalition.side.RED ) 


--- @param Functional.ZoneCaptureCoalition#ZONE_CAPTURE_COALITION self
function ZoneCaptureCoalitionOne:OnEnterGuarded( From, Event, To )
  if From ~= To then
    local Coalition = self:GetCoalition()
    self:E( { Coalition = Coalition } )
    if Coalition == coalition.side.BLUE then
      ZoneCaptureCoalitionOne:Smoke( SMOKECOLOR.Blue )
      US_CC:MessageTypeToCoalition( string.format( "%s is under protection of the USA", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
      RU_CC:MessageTypeToCoalition( string.format( "%s is under protection of the USA", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
    else
      ZoneCaptureCoalitionOne:Smoke( SMOKECOLOR.Red )
      RU_CC:MessageTypeToCoalition( string.format( "%s is under protection of Russia", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
      US_CC:MessageTypeToCoalition( string.format( "%s is under protection of Russia", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
    end
  end
end

--- @param Functional.Protect#ZONE_CAPTURE_COALITION self
function ZoneCaptureCoalitionOne:OnEnterEmpty()
  ZoneCaptureCoalitionOne:Smoke( SMOKECOLOR.Green )
  --Start Blue Bravo Brigade
  US_CC:MessageTypeToCoalition( string.format( "%s is unprotected, and can be captured!", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
  RU_CC:MessageTypeToCoalition( string.format( "%s is unprotected, and can be captured!", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
end


--- @param Functional.Protect#ZONE_CAPTURE_COALITION self
function ZoneCaptureCoalitionOne:OnEnterAttacked()
  ZoneCaptureCoalitionOne:Smoke( SMOKECOLOR.White )
  local Coalition = self:GetCoalition()
  self:E({Coalition = Coalition})
  if Coalition == coalition.side.BLUE then
    US_CC:MessageTypeToCoalition( string.format( "%s is under attack by Russia", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
    RU_CC:MessageTypeToCoalition( string.format( "We are attacking %s", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
  else
    RU_CC:MessageTypeToCoalition( string.format( "%s is under attack by the USA", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
    US_CC:MessageTypeToCoalition( string.format( "We are attacking %s", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
  end
end

--- @param Functional.Protect#ZONE_CAPTURE_COALITION self
function ZoneCaptureCoalitionOne:OnEnterCaptured()
  local Coalition = self:GetCoalition()
  self:E({Coalition = Coalition})
  if Coalition == coalition.side.BLUE then
    RU_CC:MessageTypeToCoalition( string.format( "%s is captured by the USA, we lost it!", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
    US_CC:MessageTypeToCoalition( string.format( "We captured %s, Excellent job!", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
  else
    US_CC:MessageTypeToCoalition( string.format( "%s is captured by Russia, we lost it!", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
    RU_CC:MessageTypeToCoalition( string.format( "We captured %s, Excellent job!", ZoneCaptureCoalitionOne:GetZoneName() ), MESSAGE.Type.Information )
  end
  
  self:AddScore( "Captured", "Zone captured: Extra points granted.", 200 )    
  
  self:__Guard( 30 )
end

ZoneCaptureCoalitionOne:__Guard( 1 )
  
ZoneCaptureCoalitionOne:Start( 30, 120 )


















