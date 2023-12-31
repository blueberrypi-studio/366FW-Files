--[[


OPERATION ESPRESSO MARTINI

by: TheDude

Mission Briefting:

**Mission Briefing: Operation Espresso Martini**

Ladies and gentlemen, distinguished pilots and strategists, welcome to the high-octane world of Operation Espresso Martini. The fate of Khasab Airbase in the Persian Gulf hangs in the balance, and it's up to Bluefor to channel their inner James Bond meets Top Gun and save the day.

**Mission Name:** Operation Espresso Martini

**Situation:**
Redfor, apparently fueled by their excessive caffeine intake, has hatched a master plan to invade Khasab Airbase from all possible directions – land, sea, and air. They've even ordered armored divisions and infantry for home delivery. Clearly, their ambitions know no bounds, or limits, or decaf options.

**Objective 1: Caffeine Chaos**
Redfor's transport madness must be halted. Your mission, should you choose to accept it (which you have no choice but to), is to intercept these transport vessels and armor columns. No half-caf lattes for them – just a whole latte trouble.

**Objective 2: Defending Khasab**
Our beloved Khasab Airbase needs a serious pep talk – and by "pep talk," we mean reinforcements. Rearm, refuel, and refurbish the base's defenses like it's a coffee shop on its grand reopening day. Make it a stronghold that even the strongest brew couldn't penetrate.

**Objective 3: Double Shot Airstrike**
To add a dash of excitement to the mix, we've concocted a double shot airstrike plan. Target the red airbase headquarters on Qeshm Island and Tarak Island. They won't know what hit them – other than a payload of strategic devastation and a hint of caramel flavoring.

**Execution:**
Strap in, pilots, and prepare for a rollercoaster of a mission. Keep an eye on the caffeine-crazed transports, secure Khasab Airbase like your morning cup of joe, and deliver those airstrikes with precision – the kind of precision one needs to extract the last drop of creamer from a tiny packet.

**Commander's Intent:**
Remember, we're not just defending Khasab; we're defending the honor of well-balanced beverages everywhere. Do your duty, and do it with style. Fly like you're in a Hollywood blockbuster, fight like your espresso machine's on the line, and bring victory home in a cup labeled "Bluefor Blend."

**Remarks:**
Expect turbulence, expect caffeine-induced chaos, and expect to have more fun than a barista crafting latte art. This is Operation Espresso Martini, where the stakes are high and the energy levels are higher.

Dismissed and caffeinated!

*Disclaimer: This mission briefing is intended for satirical purposes only. No actual espresso martinis were harmed in the making of this briefing. Remember, safety first – both in the skies and at the coffee machine.*

^^^you were too high when you wrote this.


TODO

UPDATE SOUNDS
  Need to add to mission file
  add CTLD beacon sounds also

SPLASH DAMAGE SCRIPT IS ALL KINDS OF FUCKED.  Fix it.  <---still no clue



AWACS IS BROKEN>>>>MUST FIX LINK TO SRS TO MAKE WORK---still not sure why this breaks
]]



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local DEBUG = false
local DEBUG_PARKING = false



if DEBUG then
BASE:TraceClass("OPS_TRANSPORT")
BASE:TraceClass("SPAWN")
BASE:TraceClass("ARMYGROUP")
BASE:TraceClass("AI_CARGO")
BASE:TraceClass("AI_CARGO_HELICOPTER")
BASE:TraceClass("COMMANDER")
BASE:TraceOn()

end


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO ZONES
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local armorDropZoneCTLD = ZONE:New("ArmorDropZone"):MarkZone(180)
local FOBBuildZone = ZONE:New("FOBBuildZone"):GetCoordinate():SmokeGreen()

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO PARKING
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---DEBUGS
--
--
if DEBUG_PARKING then
AIRBASE:FindByName(AIRBASE.PersianGulf.Sharjah_Intl):MarkParkingSpots()
AIRBASE:FindByName(AIRBASE.PersianGulf.Qeshm_Island):MarkParkingSpots()
end

--Sharjah

--local heloParkingSharjah = ({45, 46, 47, 48, 49})--troop transport helos
--local fPlaneParkingSharjah = ({})--fighters,escorts,smallplane parking
--local bPlaneParkingSharjah = ({})--transport plane parking



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO TABLES / ARRAYS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local redCAPzone = ZONE:New("REDCAPZONE")

--local redLarakFarp1 = STATIC:FindByName("LARAK-RED-FARP-1")
--local redLarakFarp2 = STATIC:FindByName("LARAK-RED-FARP-2")
--local redLarakFarp3 = STATIC:FindByName("LARAK-RED-FARP-3")
--local redLarakFarp4 = STATIC:FindByName("LARAK-RED-FARP-4")


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO UTILITY FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Get Client Slots
local ClientSet = SET_CLIENT:New():FilterPrefixes("366th"):FilterStart()


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO INIT / SETUP
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

_SETTINGS:SetPlayerMenuOff()
_SETTINGS:SetImperial()
_SETTINGS:SetA2G_BR()
_SETTINGS:SetA2A_BRAA()

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SETUP SRS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local hereSRSPath = mySRSPath or "C:\\Program Files\\DCS-SimpleRadio-Standalone"
local hereSRSPort = mySRSPort or 5002
local hereSRSGoogle = mySRSGKey --or "C:\\Program Files\\DCS-SimpleRadio-Standalone\\yourkey.json"


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

--CleanUpAirports = CLEANUP_AIRBASE:New(AIRBASE.PersianGulf.Qeshm_Island)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SETUP SHORAD
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--RED SHORAD

local samredSET = SET_GROUP:New():FilterPrefixes("SR"):FilterCoalitions("red"):FilterStart()
-- usage: SHORAD:New(name, prefix, samset, radius, time, coalition)
local redShorad = SHORAD:New("RedShorad", "SR SA15", samredSET, 12000, 600, "red", false)
  redShorad:SetDefenseLimits(80, 95)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SETUP MANTIS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--RED MANTIS

--well this is just mean as fuck
--system will try to use SA15s and AAA when needed to protect SAM sites.


local redAAAMantis = MANTIS:New( "Red AAA MANTIS", "SR AAA", "EWRRED", "REDHQ", "red", false, "AWACSRED" )
--can customize mantis further here
  redAAAMantis:AddShorad( redShorad, 720 )
  redAAAMantis:Start()
  
local redSA15Mantis = MANTIS:New( "SA 15 MANTIS", "SR SA15", "EWRRED", "REDHQ", "red", false, "AWACSRED" )
  redSA15Mantis:SetSAMRadius(UTILS.NMToMeters(5))--radius in which sam will turn itself on/off
  redSA15Mantis:SetSAMRange(100)--sets sam firing range
  redSA15Mantis:SetAutoRelocate(false,false)--set to autorelocate, use false in this case due to statics
  redSA15Mantis:Start()



local redSA3Mantis = MANTIS:New( "SA3 MANTIS", "SR SA3", "EWRRED", "REDHQ", "red", false, "AWACSRED" )
  redSA3Mantis:SetSAMRadius(UTILS.NMToMeters(40))
  redSA3Mantis:SetSAMRange(75)
  redSA3Mantis:SetDetectInterval(20)
  redSA3Mantis:SetAutoRelocate(false,false)
  redSA3Mantis:AddShorad(redShorad,720)
  redSA3Mantis:Start()
  
local redSA5Mantis = MANTIS:New( "SA5 MANTIS", "SR SA5", "EWRRED", "REDHQ", "red", false, "AWACSRED" )
  redSA5Mantis:SetSAMRadius(UTILS.NMToMeters(50))
  redSA5Mantis:SetSAMRange(60)
  redSA5Mantis:SetDetectInterval(45)
  redSA5Mantis:SetAutoRelocate(false,false)
  redSA5Mantis:AddShorad(redShorad,720)
  redSA5Mantis:Start()
  
local redSA10Mantis = MANTIS:New("SA10 MANTIS","SR SA10", "EWRRED", "REDHQ", "red", false, "AWACSRED" )
  redSA10Mantis:SetSAMRadius(UTILS.NMToMeters(40))
  redSA10Mantis:SetSAMRange(70)
  redSA10Mantis:SetDetectInterval(20)
  redSA10Mantis:AddShorad(redShorad,720)
  redSA10Mantis:SetAutoRelocate(true,false)
  redSA10Mantis:Start()
  
local redS350Mantis = MANTIS:New( "S350 MANTIS", "SR S350 HDS", "EWRRED", "REDHQ", "red", false, "AWACSRED")
  redS350Mantis:SetSAMRadius(UTILS.NMToMeters(50))
  redS350Mantis:SetSAMRange(60)
  redS350Mantis:SetDetectInterval(30)
  redS350Mantis:SetAutoRelocate(false,false)
  redS350Mantis:AddShorad(redShorad,720)
  redS350Mantis:Start()



if DEBUG then
  redAAAMantis:Debug(true)
  redSA15Mantis:Debug(true)
  redSA3Mantis:Debug(true)
  redSA5Mantis:Debug(true)
  redSA10Mantis:Debug(true)
  redS350Mantis:Debug(true)
end





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

--RED AWACS
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


--BLUE AWACS
-- We need an AirWing
local AwacsBlue = AIRWING:New("WarehouseSharjahAwacs", "AWACSBLUE")
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
-- it really sucks when your drinking a glass of tea and you cough.  and tea shoots out of your nose.  burns.  a alot.  
local AwacsEscortsBlue = SQUADRON:New("AWACSBLUEESCORT",4,"Whiskey on the Rocks")
  AwacsEscortsBlue:AddMissionCapability({AUFTRAG.Type.ESCORT})
  AwacsEscortsBlue:SetFuelLowRefuel(true)
  AwacsEscortsBlue:SetFuelLowThreshold(0.3)
  AwacsEscortsBlue:SetTurnoverTime(10,20)
  AwacsEscortsBlue:SetTakeoffAir()
  AwacsEscortsBlue:SetRadio(275,radio.modulation.AM)
  AwacsBlue:AddSquadron(AwacsEscortsBlue)
  AwacsBlue:NewPayload("AWACSBLUEESCORT",-1,{AUFTRAG.Type.ESCORT},100)

--ZONE:FindByName() may need to be just the string name of the zone.  Fix this here if errors during testing
local BlueAwacs = AWACS:New("Awacs-Blue", AwacsBlue, "blue", AIRBASE.PersianGulf.Sharjah_Intl, "AWACSBLUEORBIT", ZONE:FindByName("FEZ"), "AWACSBLUECAPZONE", 264, radio.modulation.AM )

  BlueAwacs:SetEscort(2)
  BlueAwacs:SetAwacsDetails(CALLSIGN.AWACS.Darkstar,1,30,280,88,25)
  BlueAwacs:SetTOS(4, 4)

  BlueAwacs:__Start(5)

-- Set up SRS
--if hereSRSGoogle then
--  -- use Google
--  AwacsBlue:SetSRS(hereSRSPath,"female","en-US",hereSRSPort,"en-US-Wavenet-F",0.9,hereSRSGoogle)
--else
   --use Windows
--  BlueAwacs:SetSRS(hereSRSPath,"male","en-US",hereSRSPort, nil, 0.9)
--end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO HELO TRANSPORT
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Platoon

local redInfantryPlatoon = PLATOON:New("Red Infantry", 10, "Red Infantry")
  redInfantryPlatoon:AddMissionCapability(AUFTRAG.Type.PATROLZONE,100)
  
--Brigade
local redInfantryBrigade = BRIGADE:New("WarehouseInfantryBrigade", "Creamers")

--Set Spawn
  redInfantryBrigade:SetSpawnZone(ZONE:New("RedTroopPickupZone"))
  
  redInfantryBrigade:AddPlatoon(redInfantryPlatoon)


--Squadron

local redHeloSquadron = SQUADRON:New("RedTransportHelo",15,"Cream Slingers")
  redHeloSquadron:AddMissionCapability(AUFTRAG.Type.OPSTRANSPORT,100)
  redHeloSquadron:SetGrouping(1)
  redHeloSquadron:SetModex(100)
  redHeloSquadron:SetSkill(AI.Skill.ACE)
  

--Airwing

local redHeloAirwing = AIRWING:New("WarehouseAirwing", "Mocha Caramel")

--THIS NEEDS A FREAKING AIRBASE!!!  WHY>  WHY>  WHY>  IT HAD A FARP BUT NOOOOOOOOO, MI8s are TOOOO GOOD FOR A FARP.  

  redHeloAirwing:SetAirbase(AIRBASE:FindByName(AIRBASE.PersianGulf.Qeshm_Island))
  redHeloAirwing:NewPayload("RedTransportHelo", -1, AUFTRAG.Type.OPSTRANSPORT, 100)
  redHeloAirwing:SetTakeoffCold()
  redHeloAirwing:AddSquadron(redHeloSquadron)

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

local zonePatrol = ZONE:New("RedTroopPatrolZone")

local missionPatrol = AUFTRAG:NewPATROLZONE(zonePatrol)
  missionPatrol:SetRequiredAssets(8)
  missionPatrol:SetRequiredTransport(zonePatrol, 4, 6)
  
  

local redforCommander = COMMANDER:New(coalition.side.RED)

  redforCommander:AddAirwing(redAirwingOne)
  
  redforCommander:AddLegion(redHeloAirwing)

  redforCommander:AddLegion(redInfantryBrigade)
--  redforCommander:AddAirwing(redHeloAirwing)
--  
--  redforCommander:AddOpsTransport(redOpsTransport)

  redforCommander:__Start(3)
  
  redforCommander:AddMission(missionPatrol)
  

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO BLUE TANKER
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local ZoneBoom=ZONE:FindByName("Zone Boom")
local ZoneProbe=ZONE:FindByName("Zone Probe")
local ZonePointBoom=ZONE:FindByName("Point Boom")
local ZonePointProbe=ZONE:FindByName("Point Probe")

-- KC-135 squadron, callsign "Arco".
local kc135=SQUADRON:New("KC135", 5, "KC135") --Ops.Squadron#SQUADRON
  kc135:SetModex(100)
  kc135:SetCallsign(CALLSIGN.Tanker.Arco)
  kc135:SetRadio(260)
  kc135:SetSkill(AI.Skill.EXCELLENT)
  kc135:AddMissionCapability({AUFTRAG.Type.TANKER}, 100)
  kc135:AddTacanChannel(70, 75)

-- KC-130 squadron, callsign "Texaco".
local kc130=SQUADRON:New("KC130", 5, "KC130") --Ops.Squadron#SQUADRON
  kc130:SetModex(200)
  kc130:SetCallsign(CALLSIGN.Tanker.Texaco)
  kc130:SetRadio(261)
  kc130:SetSkill(AI.Skill.EXCELLENT)
  kc130:AddMissionCapability({AUFTRAG.Type.TANKER}, 100)
  kc130:AddTacanChannel(80, 85)


local blueTankerWing=AIRWING:New("WarehouseSharjahTankers", "Need Gas?") --Ops.AirWing#AIRWING
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



----------------------------------------------------------------
-- TODO Task Controller
----------------------------------------------------------------
local menu = MENU_COALITION:New(coalition.side.BLUE,"Ops Menu")


-- Set up A2G task controller for the blue side named "82nd Airborne"
local taskmanager = PLAYERTASKCONTROLLER:New("366th Airwing",coalition.side.BLUE,PLAYERTASKCONTROLLER.Type.A2G)
taskmanager:DisableTaskInfoMenu()
taskmanager:EnableTaskInfoMenu()
--taskmanager:SetMenuOptions(true,5,45)
taskmanager:SetAllowFlashDirection(true)
taskmanager:SetCallSignOptions(true,true,{Ford="Yankee"})
-- set locale
taskmanager:SetLocale("en")
taskmanager:SetMenuName("Martini")
-- Set up using SRS
--taskmanager:SetSRS({130,255},{radio.modulation.AM,radio.modulation.AM},hereSRSPath,"female","en-US",hereSRSPort,"Microsoft Hazel Desktop",0.7,hereSRSGoogle)
-- Controller will announce itself under these broadcast frequencies
--taskmanager:SetSRSBroadcast({127.5,305},{radio.modulation.AM,radio.modulation.AM})
-- Set target radius
taskmanager:SetTargetRadius(750)
taskmanager:SetParentMenu(menu)


----------------------------------------------------------------
-- TODO Sounds for Smoke and Mirrors
----------------------------------------------------------------
function taskmanager:OnAfterTaskTargetSmoked(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function taskmanager:OnAfterTaskTargetFlared(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function taskmanager:OnAfterTaskTargetIlluminated(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO OPERATION PHASES
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Operation Messages
local opStartMessage = MESSAGE:New("Welcome to Operation Espresso Martini",10)



--Define Operation Targets

--target groups for use later

local ewrTunb = GROUP:FindByName("EWRRED Tunb Island")
local ewrQeshm = GROUP:FindByName("EWRRED Qeshm Island")
local ewrLarak = GROUP:FindByName("EWRRED Larak Island")




local operationTargets = { 
  [1] = {       
    TargetName = "EWRRED Tunb Island",
    TargetStatic = false,
    TargetBriefing = "Destroy the Early Warning Radar located on Tunb Island",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [2] = {       
    TargetName = "EWRRED Qeshm Island",
    TargetStatic = false,
    TargetBriefing = "Destroy the Early Warning Radar located on Qeshm Island",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [3] = {       
    TargetName = "Qeshm Command Center",
    TargetStatic = true,
    TargetBriefing = "Destroy the Command Center located on Qeshm Island",
    TargetAuftrag = AUFTRAG.Type.STRIKE,
  },
  [4] = {       
    TargetName = "EWRRED Larak Island",
    TargetStatic = false,
    TargetBriefing = "Destroy the Early Warning Radar located on Larak Island",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [5] = {       
    TargetName = "Larak Command Center",
    TargetStatic = true,
    TargetBriefing = "Destroy the Command Center located on Larak Island",
    TargetAuftrag = AUFTRAG.Type.STRIKE,
  },
  [6] = {       
    TargetName = "Red Armor Group",
    TargetStatic = false,
    TargetBriefing = "Destroy Redfor Armor Units attacking Khasab Airbase",
    TargetAuftrag = AUFTRAG.Type.GROUNDATTACK,
  },
  }
  --FINISH ADDING TARGETS HERE
  
--Create TARGET objects

local BlueTargets = {}
for i=1,6 do
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
for i=1,6 do
  
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
  local file = "Korean War 3.ogg"
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
  local file = "Campaign Victory 1.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end  

 































