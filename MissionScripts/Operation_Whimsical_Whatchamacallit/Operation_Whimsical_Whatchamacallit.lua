--[[







]]




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SETUP
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

_SETTINGS:SetPlayerMenuOff()
_SETTINGS:SetImperial()
_SETTINGS:SetA2G_BR()
_SETTINGS:SetA2A_BRAA()


local DEBUG = false
local DEBUG_COMMANDERS = false
local DEBUG_PARKING = false

if DEBUG_PARKING then
  AIRBASE:FindByName(AIRBASE.Caucasus.Sochi_Adler):MarkParkingSpots()
end

--Sochi
local Parking = ({33, 34, 35, 46, 36, 47, 37, 48, 38, 39, 49, 40, 50, 41, 51, 42, 52, 43, 53, 44, 104, 44, 55})

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO ZONES
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local zone1 = ZONE:New("BLUECHIEF")  --rename after testing due to intel being named this
local zone2 = ZONE:New("REDCHIEF")
local zone3 = ZONE:New("BLUECAPZONE")
local zone4 = ZONE:New("REDCAPZONE")
local zone5 = ZONE:New("REDARMORSPAWN")
local zone6 = ZONE:New("BLUEARMORSPAWN")
local zone7 = ZONE:New("INDUSTRIALZONE")
local zone8 = ZONE:New("PORTZONE")
local zone9 = ZONE:New("TRAINDEPOT")

local zone10 = ZONE:New("CAPTUREZONE")


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO OPSZONES for CAPTURE FUNCTION
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--use these for strategic zones also

local opzone1 = OPSZONE:New("CAPTUREZONE")


--CREATE OPSZONES SET for Capture function
local opszonesSET=SET_OPSZONE:New():FilterPrefixes("CAPTUREZONE"):FilterOnce()

-- Start all opszones in the SET.
  opszonesSET:Start()

--This is the capture zone function.
-- Capture Time (60seconds)
  opszonesSET:ForEachZone(

    function (_opszoneSET)
      local opszoneSET=_opszoneSET --Ops.OpsZone#OPSZONE
      opszoneSET:SetCaptureTime(60)
    end)
    

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO TABLES
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local clientSet = SET_CLIENT:New():FilterPrefixes("366th"):FilterStart()



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO ATIS Sochi on 131.1 MHz AM
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
local atisSochi = ATIS:New(AIRBASE.Caucasus.Sochi_Adler, 131.1)
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

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO FUNCTIONS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO AIRBASE MAINTENANCE
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Function to check and cleanup stuck aircraft

CleanUpAirports = CLEANUP_AIRBASE:New( { AIRBASE.Caucasus.Sochi_Adler, AIRBASE.Caucasus.Novorossiysk } )


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO HEADQUARTERS/COMMANDCENTERS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


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


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SCORING
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--ScoringGroups

--Name Scoring Object
Scoring = SCORING:New("Operation Whimsical Whatchamacallit")

--Scale Scoring
Scoring:SetScaleDestroyScore( 10 )
Scoring:SetScaleDestroyPenalty( 40 )


--Add Scoring Groups


--Add Individual Scoring Units if Necessary
--Scoring:AddUnitScore(ScoreUnit,Score)
--Add Static Scoring

Scoring:SetMessagesHit(false)
Scoring:SetMessagesDestroy(true)
Scoring:SetMessagesScore(true)


--Add Zone Scoring

--Set the Zone scoring multiplier to award a higher score for kills inside the engagement zone of the air defenses.

--ScoringMultiplierZone = ZONE:New( "DoubleScoreZone" )
--Scoring:AddZoneScore( ScoringMultiplierZone, 100 )

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SETUP SHORAD
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SETUP MANTIS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO REDFOR
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Red Platoons

--Red Alpha Air Defense
local strelaPlatoonAlpha = PLATOON:New( "☢ Strela", 15, "☢ Strela Alpha" )
  strelaPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

local geckoPlatoonAlpha = PLATOON:New( "☢ SA8 Gecko", 15, "☢ SA8 Gecko Alpha" )
  geckoPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

local shilkaPlatoonAlpha = PLATOON:New( "☢ ZSU-23 Shilka", 15, "☢ ZSU-23 Shilka Alpha" )
  shilkaPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE )

--Red Tanks

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

--RED ARMOR BRIGADES
local redBrigadeArmorAlpha = BRIGADE:New( "WarehouseRedAlphaBrigade", "Jelly Rolls")
  redBrigadeArmorAlpha:AddPlatoon(t80uPlatoonAlpha)
  redBrigadeArmorAlpha:AddPlatoon(t90PlatoonAlpha)
  redBrigadeArmorAlpha:AddPlatoon(t72PlatoonAlpha)
  redBrigadeArmorAlpha:SetSpawnZone(zone4)
  redBrigadeArmorAlpha:Start()
  
--REDFOR SQUADRONS

--CAP
local redCapOne=SQUADRON:New("✈ MIG29S", 16, "✈ MIG29S") --Ops.Squadron#SQUADRON
  redCapOne:AddMissionCapability(AUFTRAG.Type.CAP)
  redCapOne:SetModex(100)
  redCapOne:SetSkill(AI.Skill.ACE)
  redCapOne:SetTakeoffHot()
  redCapOne:SetDespawnAfterHolding(true)

--INTERCEPT
local redIntOne=SQUADRON:New("✈ MIG31", 16, "✈ MIG31") --Ops.Squadron#SQUADRON
  redIntOne:AddMissionCapability(AUFTRAG.Type.INTERCEPT)
  redIntOne:SetModex(100)
  redIntOne:SetSkill(AI.Skill.ACE)
  redIntOne:SetTakeoffHot()
  redIntOne:SetDespawnAfterHolding(true)

--CAS
local redCasOne=SQUADRON:New("✈ KA50", 16, "✈ KA50")
  redCasOne:AddMissionCapability(AUFTRAG.Type.CAS, 80)
  redCasOne:SetTakeoffAir()
  redCasOne:SetModex(100)
  redCasOne:SetSkill(AI.Skill.ACE)
  redCasOne:SetDespawnAfterHolding(true)

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
  
  
--RED AIRWING

local redAirwing = AIRWING:New("WarehouseNovoAirwing", "Jelly Smashers")


  redAirwing:NewPayload("✈ MIG31", 99, AUFTRAG.Type.INTERCEPT, 100)
  redAirwing:NewPayload("✈ MIG29S", 99, AUFTRAG.Type.CAP, 100)
  redAirwing:NewPayload("✈ KA50", 99, AUFTRAG.Type.CAS, 100)

  redAirwing:AddSquadron(redCapOne)
  redAirwing:AddSquadron(redIntOne)
  redAirwing:AddSquadron(redCasOne)
  
  redAirwing:Start()
  
--MISSIONS

--Red Capture Mission
local missionRedCaptureZone1=AUFTRAG:NewCAPTUREZONE(opzone1, coalition.side.RED)
missionRedCaptureZone1:SetRequiredAssets(8)
missionRedCaptureZone1:SetRepeatOnFailure(10)
missionRedCaptureZone1:SetROE(ENUMS.ROE.OpenFire)

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

--RED CHIEF

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



--Strategy--  ADJUST THIS IF TOO MUCH
RUChief:SetStrategy(RUChief.Strategy.TOTALWAR)

--ADD BRIGADES

RUChief:AddBrigade(redBrigadeArmorAlpha)



--ADD AIRWINGS

RUChief:AddAirwing(redAirwing)


--ADD MISSIONS
RUChief:AddMission(missionRedCaptureZone1)
RUChief:AddMission(missionRedCAPzone2)
RUChief:AddMission(missionRedCASzone2)
RUChief:AddMission(missionRedAirDefenseOne)

RUChief:SetLimitMission(2, AUFTRAG.Type.CAS)
RUChief:SetLimitMission(2, AUFTRAG.Type.CAP)
RUChief:SetLimitMission(2, AUFTRAG.Type.CAPTUREZONE)
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
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO BLUEFOR
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO ZONE CAPTURE
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local CaptureZoneAlpha = zone10

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

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO EXTRAS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
