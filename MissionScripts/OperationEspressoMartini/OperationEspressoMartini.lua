--[[


OPERATION ESPRESSO MARTINI

by: TheDude

TODO

Armor Spawns Balanced--STATIC
CTLD Tested--NEEDED
Waypoints for CTLD implemented (Make a mission specific Copy of CTLD Script)--DONE
Client Slots--DONE

Blue support forces: CAP, and Helo Escorts--MAYBE

Distribute scaled based scoring


Distribute initial armor for redfor at khasab--DONE

assemble small representation of flotilla--TEST

assemble bluefor flotilla--carrier done, two assault ships, two tarawas (1 for hueys cargo and 1 for apaches)



UPDATE SOUNDS
  Need to add to mission file
  add CTLD beacon sounds also


SET MISSION and MISSION STAGES--in progress



Destruction of Qeshm Island and Larak Island CommandCenters and Bunkers  (this will shutdown spawns of helo troops, and cap)

Destruction of Redfor Armor Landing Supply Vessel

Elimination of Redfor Forces at Khasab

Construction of FOB by Huey CTLD at Khasab



SPLASH DAMAGE SCRIPT IS ALL KINDS OF FUCKED.  Fix it.  <---still no clue


]]--



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local DEBUG = true
local DEBUG_PARKING = true



if DEBUG then
BASE:TraceClass("OPS_TRANSPORT")
BASE:TraceClass("SPAWN")
BASE:TraceClass("ARMYGROUP")
BASE:TraceClass("AI_CARGO")
BASE:TraceClass("AI_CARGO_HELICOPTER")
BASE:TraceOn()

end


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO ZONES
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO PARKING
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---DEBUGS
--
--
if DEBUG_PARKING then
AIRBASE:FindByName(AIRBASE.PersianGulf.Sharjah_Intl):MarkParkingSpots()
end

--Sharjah

local heloParkingSharjah = ({45, 46, 47, 48, 49})--troop transport helos
local fPlaneParkingSharjah = ({})--fighters,escorts,smallplane parking
local bPlaneParkingSharjah = ({})--transport plane parking



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO TABLES / ARRAYS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local redCAPzone = ZONE:New("REDCAPZONE")

local redLarakFarp1 = STATIC:FindByName("LARAK-RED-FARP-1")
local redLarakFarp2 = STATIC:FindByName("LARAK-RED-FARP-2")
local redLarakFarp3 = STATIC:FindByName("LARAK-RED-FARP-3")
local redLarakFarp4 = STATIC:FindByName("LARAK-RED-FARP-4")


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

--RED
DetectionSetGroupRed = SET_GROUP:New()
DetectionSetGroupRed:FilterPrefixes({ "EWRRED", "AWACSRED", "FACRED", "JTACRED" })
DetectionSetGroupRed:FilterStart()

DetectionRed = DETECTION_AREAS:New( DetectionSetGroupRed, 30000 )



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SCORING
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--ScoringGroups

--Name Scoring Object
Scoring = SCORING:New("Operation Espresso Martini")

--Scale Scoring
Scoring:SetScaleDestroyScore( 10 )
Scoring:SetScaleDestroyPenalty( 40 )

Scoring:SetMessagesHit(false)
Scoring:SetMessagesDestroy(true)
Scoring:SetMessagesScore(true)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO AIRBASE MAINTENANCE
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Function to check and cleanup stuck aircraft

--CleanUpAirports = CLEANUP_AIRBASE:New( { AIRBASE.Caucasus.Sochi_Adler, AIRBASE.Caucasus.Novorossiysk } )


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SETUP SHORAD
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--RED SHORAD
local samredSET = SET_GROUP:New():FilterPrefixes("SAMRED"):FilterCoalitions("red"):FilterStart()
-- usage: SHORAD:New(name, prefix, samset, radius, time, coalition)
redShorad = SHORAD:New("RedShorad", "Red SHORAD", samredSET, 22000, 600, "red")


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

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO BLUE REAPER DRONE
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--NO REAPER DRONE.  USE CTLD DROPPED JTAC INSTEAD.

--OR REAPER DRONE.  WHO TF KNOWS?


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO Sounds for Client
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Event Handlers
ClientSet:HandleEvent(EVENTS.Hit)
ClientSet:HandleEvent(EVENTS.Dead)
ClientSet:HandleEvent(EVENTS.Land)


--UPDATE SOUNDS--


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
-- TODO AWACS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local AwacsRed = AIRWING:New("WarehouseBandar", "AWACSRED")
  AwacsRed:SetReportOn()
  AwacsRed:SetMarker(false)
  AwacsRed:SetAirbase(AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl))
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
local AwacsEscortsRed = SQUADRON:New("✈ MIG29ESCORT",4,"✈ MIG29ESCORT")
  AwacsEscortsRed:AddMissionCapability({AUFTRAG.Type.ESCORT})
  AwacsEscortsRed:SetFuelLowRefuel(true)
  AwacsEscortsRed:SetFuelLowThreshold(0.3)
  AwacsEscortsRed:SetTurnoverTime(10,20)
  AwacsEscortsRed:SetTakeoffAir()
  AwacsEscortsRed:SetRadio(275,radio.modulation.AM)
  AwacsRed:AddSquadron(AwacsEscortsRed)
  AwacsRed:NewPayload("✈ MIG29ESCORT",-1,{AUFTRAG.Type.ESCORT},100)


local RedAwacs = AWACS:New("Awacs-Red", AwacsRed, "red", AIRBASE.PersianGulf.Bandar_Abbas_Intl, "REDAWACSORBIT", ZONE:FindByName("FEZ"), "AWACSREDCAPZONE", 275, radio.modulation.AM )

  RedAwacs:SetEscort(2)
  RedAwacs:SetAwacsDetails(CALLSIGN.AWACS.Magic,1,30,280,88,25)

  RedAwacs:__Start(5)

-- We need an AirWing
local AwacsBlue = AIRWING:New("WarehouseAkrotiri", "AWACSBLUE")
AwacsBlue:SetMarker(false)
AwacsBlue:SetAirbase(AIRBASE:FindByName(AIRBASE.PersianGulf.Sharjah_Intl))
AwacsBlue:SetRespawnAfterDestroyed(900)
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
local AwacsEscortsRed = SQUADRON:New("AWACSBLUEESCORT",4,"Awacs Blue Escorts")
AwacsEscortsRed:AddMissionCapability({AUFTRAG.Type.ESCORT})
AwacsEscortsRed:SetFuelLowRefuel(true)
AwacsEscortsRed:SetFuelLowThreshold(0.3)
AwacsEscortsRed:SetTurnoverTime(10,20)
AwacsEscortsRed:SetTakeoffAir()
AwacsEscortsRed:SetRadio(275,radio.modulation.AM)
AwacsBlue:AddSquadron(AwacsEscortsRed)
AwacsBlue:NewPayload("AWACSBLUEESCORT",-1,{AUFTRAG.Type.ESCORT},100)

--ZONE:FindByName() may need to be just the string name of the zone.  Fix this here if errors during testing
local AwacsBlue = AWACS:New("Awacs-Blue", AwacsBlue, "blue", AIRBASE.PersianGulf.Sharjah_Intl, "AWACSBLUEORBIT", ZONE:FindByName("FEZ"), "AWACSBLUECAPZONE", 264, radio.modulation.AM )

AwacsBlue:SetEscort(2)
AwacsBlue:SetAwacsDetails(CALLSIGN.AWACS.Darkstar,1,30,280,88,25)
AwacsBlue:SetTOS(4, 4)

AwacsBlue:__Start(5)



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO HELO TRANSPORT
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local larakHQ = STATIC:FindByName("LarakHQ")
local heloPickupZone = ZONE:New("RedTroopPickupZone")
local redInfantryDeployZone = ZONE:New("RedTroopLandingZone")


if larakHQ:IsAlive() then

  TIMER:New(function()
  
  local redInfantrySet = SET_GROUP:New():FilterPrefixes("RedInfantry"):FilterOnce()
    :Activate()
    
  local redOpsTransport = OPSTRANSPORT:New(redInfantrySet,heloPickupZone,redInfantryDeployZone)

  
  local redHelo1 = FLIGHTGROUP:New("RedTransportHelo")
    :Activate(5)
    
  local redHelo2 = FLIGHTGROUP:New("RedTransportHelo2")
    :Activate(15)
    
  local redHelo3 = FLIGHTGROUP:New("RedTransportHelo3")
    :Activate(25)
    
  local redHelo4 = FLIGHTGROUP:New("RedTransportHelo4")
    :Activate(35)

    redHelo1:AddOpsTransport(redOpsTransport)
    redHelo2:AddOpsTransport(redOpsTransport)
    redHelo3:AddOpsTransport(redOpsTransport)
    redHelo4:AddOpsTransport(redOpsTransport)

  end):Start(60,600)


else
return
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO AMPHIBIOUS LANDING
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--local redSupplyShip = GROUP:FindByName("RedSupplyShip")
--
--local redArmorZones = { ZONE:New("RA1"), ZONE:New("RA2")}
--local redArmorTemplates = { "REDFOR APC", "REDFOR BMP", "REDFOR T80", "REDFOR SHILKA"}
--
--local redArmorGroupAlpha = ARMYGROUP:New("Red Armor Group Alpha")
--local redArmorGroupBravo = ARMYGROUP:New("Red Armor Group Bravo")
--local redArmorGroupCharlie = ARMYGROUP:New("Red Armor Group Charlie")


--[[







]]

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO REDFOR FLIGHTGROUPS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--✈


--CAP SQUADRONS

local redCapOne=SQUADRON:New("✈ MIG29S", 16, "✈ MIG29S") --Ops.Squadron#SQUADRON
  redCapOne:AddMissionCapability(AUFTRAG.Type.CAP)
  redCapOne:SetGrouping(2)
  redCapOne:SetModex(100)
  redCapOne:SetSkill(AI.Skill.ACE)
  redCapOne:SetDespawnAfterHolding(true)


local redCapTwo=SQUADRON:New("✈ SU33", 16, "✈ SU33") --Ops.Squadron#SQUADRON
  redCapTwo:AddMissionCapability(AUFTRAG.Type.CAP)
  redCapTwo:SetGrouping(2)
  redCapTwo:SetModex(200)
  redCapTwo:SetSkill(AI.Skill.ACE)
  redCapTwo:SetTakeoffHot()
  redCapTwo:SetDespawnAfterHolding(true)

local redCapThree=SQUADRON:New("✈ MIRAGE2000", 16, "✈ MIRAGE2000") --Ops.Squadron#SQUADRON
  redCapThree:AddMissionCapability(AUFTRAG.Type.CAP)
  redCapThree:SetGrouping(2)
  redCapThree:SetModex(300)
  redCapThree:SetSkill(AI.Skill.ACE)
  redCapThree:SetTakeoffHot()
  redCapThree:SetDespawnAfterHolding(true)

--REDFOR AIRWING

local redAirwingOne = AIRWING:New("WarehouseQeshm", "Mocha Frappe")

  redAirwingOne:NewPayload("✈ MIG29S", 99, AUFTRAG.Type.CAP, 100)
  redAirwingOne:NewPayload("✈ SU33", 99, AUFTRAG.Type.CAP, 100)
  redAirwingOne:NewPayload("✈ MIRAGE2000", 99, AUFTRAG.Type.CAP, 100)

  redAirwingOne:AddSquadron(redCapOne)
  redAirwingOne:AddSquadron(redCapTwo)
  redAirwingOne:AddSquadron(redCapThree)


--REDFOR CAP MISSION

local missionRedCAPzone = AUFTRAG:NewCAP(redCAPzone, 15000, 350, nil, 90, 20, {"Air"})
  missionRedCAPzone:SetRequiredAssets(2)
  missionRedCAPzone:SetRepeatOnFailure(16)
  missionRedCAPzone:SetROE(ENUMS.ROE.OpenFire)


  redAirwingOne:AddMission(missionRedCAPzone)

  redAirwingOne:AddPatrolPointCAP(ZONE:New("REDCAPZONE"):GetCoordinate(),math.random(15000, 25000),math.random(300, 450),math.random(1,360),math.random(20, 50))
  redAirwingOne:SetTakeoffAir()
  redAirwingOne:SetNumberCAP(2)


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO REDFOR COMMANDER TO HANDLE FLIGHTGROUP RESPONSE
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local redforCommander = COMMANDER:New(coalition.side.RED)

  redforCommander:AddAirwing(redAirwingOne)

  redforCommander:__Start(3)
  
  
  

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


local blueTankerWing=AIRWING:New("WarehouseSharjah", "Need Gas?") --Ops.AirWing#AIRWING
  blueTankerWing:AddPatrolPointTANKER(ZonePointBoom, 20000, 350, 180, 30, Unit.RefuelingSystem.BOOM_AND_RECEPTACLE)
  blueTankerWing:AddPatrolPointTANKER(ZonePointProbe, 20000, 350, 0, 30, Unit.RefuelingSystem.PROBE_AND_DROGUE)
  blueTankerWing:SetNumberTankerBoom(1)
  blueTankerWing:SetNumberTankerProbe(1)
  blueTankerWing:AddSquadron(kc135)
  blueTankerWing:AddSquadron(kc130)
  blueTankerWing:SetTakeoffAir()



  blueTankerWing:Start()

local function NewTankerMission(RefuelSystem)

  local Coordinate
  if RefuelSystem==Unit.RefuelingSystem.BOOM_AND_RECEPTACLE then
    Coordinate=ZoneBoom:GetCoordinate()
  elseif RefuelSystem==Unit.RefuelingSystem.PROBE_AND_DROGUE then
    Coordinate=ZoneProbe:GetCoordinate()
  end

  local mission=AUFTRAG:NewTANKER(Coordinate, 20000, 350, 000, 25, RefuelSystem)

  blueTankerWing:AddMission(mission)
  

  function mission:OnAfterDone()
    MESSAGE:New(string.format("Mission %s done. Creating new TANKER mission for refuel system type %d", mission:GetName(), RefuelSystem), 360):ToAll():ToLog()
    NewTankerMission(RefuelSystem)
  end
  
end

NewTankerMission(Unit.RefuelingSystem.BOOM_AND_RECEPTACLE)

NewTankerMission(Unit.RefuelingSystem.PROBE_AND_DROGUE)


--- Function called each time a flight group goes on a mission. Can be used to fine tune.
function blueTankerWing:OnAfterFlightOnMission(From, Event, To, Flightgroup, Mission)
  local flightgroup=Flightgroup --Ops.FlightGroup#FLIGHTGROUP
  local mission=Mission --Ops.Auftrag#AUFTRAG
  

  local tacanChannel, tacanMorse, tacanBand=flightgroup:GetTACAN()
  
  local text=string.format("Flight %s on %s mission %s. TACAN Channel %s%s (%s)", flightgroup:GetName(), mission:GetType(), mission:GetName(), tostring(tacanChannel), tostring(tacanBand), tostring(tacanMorse))
  MESSAGE:New(text):ToAll():ToLog()  
  
  
  flightgroup:SetFuelLowThreshold(25)
end  
  


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO ZONE CAPTURE
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local CaptureZoneAlpha = ZONE_AIRBASE:New(AIRBASE.PersianGulf.Khasab, 5000):DrawZone(0)

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



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO OPERATION PHASES
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Operation Messages
local opStartMessage = MESSAGE:New("Welcome to Operation Espresso Martini",10)

--Define Operation Targets

local target1 = TARGET:New(TargetObject)
local target2 = TARGET:New(TargetObject)
local target3 = TARGET:New(TargetObject)
local target4 = TARGET:New(TargetObject)



--Define Operation

local operationTargets = { 
  [1] = {       
    TargetName = "Qeshm Island HQ",
    TargetStatic = true,
    TargetBriefing = "",
    TargetAuftrag = AUFTRAG.Type.STRIKE,
  },
  [2] = {       
    TargetName = "",
    TargetStatic = false,
    TargetBriefing = "",
    TargetAuftrag = AUFTRAG.Type.STRIKE,
  },
  }
  --FINISH ADDING TARGETS HERE
  
--Create TARGET objects

local BlueTargets = {}
for i=1,5 do
  if operationTargets[i].TargetStatic then
    -- static
    BlueTargets[i] = TARGET:New(STATIC:FindByName(operationTargets[i].TargetName))
  else
    -- group
    BlueTargets[i] = TARGET:New(GROUP:FindByName(operationTargets[i].TargetName))
  end
end


--Setup Operation
local operation = OPERATION:New("Operation Espresso Martini")


if DEBUG then
  operation.verbose = 1
end


--Add Operation Phases
for i=1,5 do
  
  local phase = operation:AddPhase(i)
  
  --add completion
  operation:AddPhaseConditonOverAll(phase,
  function(target)
    local Target = target -- Ops.Target#TARGET
    if Target:IsDead() or Target:IsDestroyed() or Target:CountTargets() == 0 then
      return true
    else
     return false
    end 
  end,BlueTargets[i])
end  


--Start Operation
operation:__Start(30)


--Operation Start Sound
function InitialSound()
  local file = string.format("Korean War %d.ogg",ogg)
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

local Stimer = TIMER:New(InitialSound)
Stimer:Start(11)

  

--function called at start of operation  
function operation:OnAfterStart(From,Event,To)
  opStartMessage:ToBlue()
end



--function called on phase change
  
-- next phase
function operation:OnAfterPhaseChange(From,Event,To,Phase)
  -- Next phase, this is Phase done
  local phase = operation:GetPhaseActive()
  local ind = phase.name
  local type = operationTargets[ind].TargetAuftrag
  local brief = operationTargets[ind].TargetBriefing
  if DEBUG then
    BlueTargets[ind].verbose = 3
  end
  local task = PLAYERTASK:New(type,BlueTargets[ind],true,99,type)
  task:AddFreetext(brief)
  if DEBUG then
    task.verbose = true
  end
  taskmanager:AddPlayerTaskToQueue(task)
  local file = "That Is Our Target.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end 
  
  
-- Operation finished
function operation:OnAfterOver(From,Event,To,Phase)
  MESSAGE:New("Operation Espresso Martini Victory!!",15):ToBlue()
  local file = "campaignvictory.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end  

 































