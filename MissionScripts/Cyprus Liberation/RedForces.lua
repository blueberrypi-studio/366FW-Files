----RED AIR DETECTION--
---- Define a SET_GROUP object that builds a collection of groups that define the EWR network.
DetectionSetGroupRedAir = SET_GROUP:New()
DetectionSetGroupRedAir:FilterPrefixes( { "EWRED", "AWACSRED" } )
DetectionSetGroupRedAir:FilterStart()
--
------RED A2G DETECTION--
DetectionSetGroupRedGround = SET_GROUP:New()
DetectionSetGroupRedGround:FilterPrefixes( { "JTACRED", "FACRED" } )
DetectionSetGroupRedGround:FilterStart()
--
------Define AIR Detection Areas
DetectionRedAir = DETECTION_AREAS:New( DetectionSetGroupRedAir, 30000 )
------DEFINE GROUND DETECTION AREAS--
DetectionRedGround = DETECTION_AREAS:New( DetectionSetGroupRedGround, 10000)

--BUILD INTEL HERE

local RedIntelAir = INTEL:New(DetectionSetGroupRedAir, "red", "KGB")
RedIntelAir:SetClusterAnalysis(true, true, true)--CHANGE THESE AFTER TESTING
RedIntelAir:SetVerbosity(2)
RedIntelAir:__Start(2)

local RedIntelGround = INTEL:New(DetectionSetGroupRedGround, "red", "IRS")
RedIntelGround:SetClusterAnalysis(true, true, true)--CHANGE THESE AFTER TESTING
RedIntelGround:SetVerbosity(2)
RedIntelGround:__Start(2)

---RED SIDE---

--Zone Definition

---BUILD UNITS---
--Platoons
--

--RED TANKS LARNACA
local RedGroupTanksLarnaca=PLATOON:New( "Red Tanks", 10, "Larnaca Armored Forces" )
RedGroupTanksLarnaca:AddMissionCapability({AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.ARMOREDGUARD}, 100)
RedGroupTanksLarnaca:AddMissionCapability({AUFTRAG.Type.ONGUARD, AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE}, 70)
--RED TANKS GECITKALE
local RedGroupTanksGecitkale1=PLATOON:New("Red Tanks", 10, "Gecitkale Armored Forces")
RedGroupTanksGecitkale1:AddMissionCapability({AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.ARMOREDGUARD}, 100)
RedGroupTanksGecitkale1:AddMissionCapability({AUFTRAG.Type.ONGUARD, AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE}, 70)

local RedGroupTanksGecitkale2=PLATOON:New("Red Tanks", 10, "Gecitkale Armored Guard")
RedGroupTanksGecitkale2:AddMissionCapability({AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.ARMOREDGUARD}, 100)
RedGroupTanksGecitkale2:AddMissionCapability({AUFTRAG.Type.ONGUARD, AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE}, 70)

--RED CALVARY LARNACA
local RedGroupCalvaryLarnaca=PLATOON:New( "Red Calvary", 10, "Larnaca Calvary" )
RedGroupCalvaryLarnaca:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE, AUFTRAG.Type.ONGUARD}, 100)

--RED CALVARY GECITKALE
local RedGroupCalvaryGecitkale1=PLATOON:New( "Red Calvary", 10, "Gecitkale Calvary")
RedGroupCalvaryGecitkale1:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE, AUFTRAG.Type.ONGUARD}, 100)

local RedGroupCalvaryGecitkale2=PLATOON:New( "Red Calvary", 10, "Gecitkale Calvary the Second")
RedGroupCalvaryGecitkale2:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE, AUFTRAG.Type.ONGUARD}, 100)

--RED MECHANIZED LARNACA
local RedGroupMechLarnaca=PLATOON:New( "Red Mechanized", 10, "Larnaca Mechanized" )
RedGroupMechLarnaca:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE, AUFTRAG.Type.ONGUARD}, 80)

--RED MECHANIZED GECITKALE
local RedGroupMechGecitkale1=PLATOON:New( "Red Mechanized", 10, "Gecitkale Mechanized" )
RedGroupMechGecitkale1:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE, AUFTRAG.Type.ONGUARD}, 80)
local RedGroupMechGecitkale2=PLATOON:New( "Red Mechanized", 10, "Gecitkale Mechanized a Second Time" )
RedGroupMechGecitkale2:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE, AUFTRAG.Type.ONGUARD}, 80)

--RED ARTILLERY LARNACA
local RedArtilleryLarnaca=PLATOON:New( "Red Artillery", 10, "Larnaca Artillery" )
RedArtilleryLarnaca:AddMissionCapability({AUFTRAG.Type.ARTY, AUFTRAG.Type.GROUNDATTACK}, 90)


--RED ARTILLERY GECITKALE
local RedArtilleryGecitkale=PLATOON:New( "Red Artillery", 10, "Gecitkale Artillery" )
RedArtilleryGecitkale:AddMissionCapability({AUFTRAG.Type.ARTY, AUFTRAG.Type.GROUNDATTACK}, 90)



---BUILD BRIGADES---
--Armor Brigades--DECLARE SPAWNZONES
local ZoneRedArmorSpawnGecitkale=ZONE:New("RedArmorSpawnGecitkale")
local ZoneRedArmorSpawnLarnaca=ZONE:New("RedArmorSpawnLarnaca")

--BUILD BRIGADES
--Alpha Brigade
local brigadeRedOne = BRIGADE:New("WarehouseGecitkale", "Brigade Gecitkale One")
brigadeRedOne:AddPlatoon(RedGroupTanksGecitkale1)
brigadeRedOne:AddPlatoon(RedGroupCalvaryGecitkale1)
brigadeRedOne:AddPlatoon(RedGroupMechGecitkale1)
brigadeRedOne:SetSpawnZone(ZoneRedArmorSpawnGecitkale)
brigadeRedOne:Start()

local brigadeRedTwo = BRIGADE:New("WarehouseGecitkale", "Brigade Gecitkale Two")
brigadeRedTwo:AddPlatoon(RedGroupTanksGecitkale2)
brigadeRedTwo:AddPlatoon(RedGroupCalvaryGecitkale2)
brigadeRedTwo:AddPlatoon(RedGroupMechGecitkale2)
brigadeRedTwo:SetSpawnZone(ZoneRedArmorSpawnGecitkale)
brigadeRedTwo:Start()

local brigadeRedThree = BRIGADE:New("WarehouseLarnaca", "Brigade Larnaca One")
brigadeRedThree:AddPlatoon(RedGroupTanksLarnaca)
brigadeRedThree:AddPlatoon(RedGroupCalvaryLarnaca)
brigadeRedThree:AddPlatoon(RedGroupMechLarnaca)
brigadeRedThree:SetSpawnZone(ZoneRedArmorSpawnLarnaca)
brigadeRedThree:Start()


local artilleryRedOne = BRIGADE:New("WarehouseLarnaca", "Artillery Gecitkale")
artilleryRedOne:AddPlatoon(RedArtilleryLarnaca)
artilleryRedOne:SetSpawnZone(ZoneRedArmorSpawnLarnaca)
artilleryRedOne:Start()

local artilleryRedTwo = BRIGADE:New("WarehouseGecitkale", "Artillery Larnaca")
artilleryRedTwo:AddPlatoon(RedArtilleryGecitkale)
artilleryRedTwo:SetSpawnZone(ZoneRedArmorSpawnGecitkale)
artilleryRedTwo:Start()


---BUILD SQUADRONS and AIRWINGS---

--BUILD SQUADRONS HERE
-- Red Squadrons
local RedCapSquadronOne=SQUADRON:New("MIRAGEF1CAPTEMPLATE", 3, "Red Cap One") --Ops.Squadron#SQUADRON
RedCapSquadronOne:AddMissionCapability({AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
RedCapSquadronOne:SetModex(100)
RedCapSquadronOne:SetCallsign(CALLSIGN.Aircraft.Ford)
RedCapSquadronOne:SetSkill(AI.Skill.GOOD)

local RedCapSquadronTwo=SQUADRON:New("MIG29CAPTEMPLATE", 3, "Red Cap Two") --Ops.Squadron#SQUADRON
RedCapSquadronTwo:AddMissionCapability({AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
RedCapSquadronTwo:SetModex(100)
RedCapSquadronTwo:SetCallsign(CALLSIGN.Aircraft.Chevy)
RedCapSquadronTwo:SetSkill(AI.Skill.GOOD)

local RedSEADSquadronOne=SQUADRON:New("SU25SEADTEMPLATE", 3, "Red SEAD One") --Ops.Squadron#SQUADRON
RedSEADSquadronOne:AddMissionCapability({AUFTRAG.Type.SEAD})
RedSEADSquadronOne:SetModex(100)
RedSEADSquadronOne:SetCallsign(CALLSIGN.Aircraft.Hawg)
RedSEADSquadronOne:SetSkill(AI.Skill.GOOD)

local RedCapSquadronThree=SQUADRON:New("MIRAGEF1CAPTEMPLATE", 3, "Red Cap Three") --Ops.Squadron#SQUADRON
RedCapSquadronThree:AddMissionCapability({AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
RedCapSquadronThree:SetModex(100)
RedCapSquadronThree:SetCallsign(CALLSIGN.Aircraft.Ford)
RedCapSquadronThree:SetSkill(AI.Skill.GOOD)

local RedCapSquadronFour=SQUADRON:New("MIG29CAPTEMPLATE", 3, "Red Cap Four") --Ops.Squadron#SQUADRON
RedCapSquadronFour:AddMissionCapability({AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
RedCapSquadronFour:SetModex(100)
RedCapSquadronFour:SetCallsign(CALLSIGN.Aircraft.Chevy)
RedCapSquadronFour:SetSkill(AI.Skill.GOOD)

local RedSEADSquadronTwo=SQUADRON:New("SU25SEADTEMPLATE", 3, "Red SEAD Two") --Ops.Squadron#SQUADRON
RedSEADSquadronOne:AddMissionCapability({AUFTRAG.Type.SEAD})
RedSEADSquadronOne:SetModex(100)
RedSEADSquadronOne:SetCallsign(CALLSIGN.Aircraft.Hawg)
RedSEADSquadronOne:SetSkill(AI.Skill.GOOD)

--GECITKALE AIRWING
-- Create a new airwing.
local RedAirwingGecitkale=AIRWING:New("WarehouseGecit", "Red Airwing Gecitkale") --Ops.AirWing#AIRWING
  
-- Payload
RedAirwingGecitkale:NewPayload("MIRAGEF1CAPTEMPLATE", 99, AUFTRAG.Type.INTERCEPT, 100)
RedAirwingGecitkale:NewPayload("MIG29CAPTEMPLATE", 99, AUFTRAG.Type.CAP, 100)
RedAirwingGecitkale:NewPayload("SU25SEADTEMPLATE", 99, AUFTRAG.Type.SEAD, 100)
-- Add squadrons to airwing.
RedAirwingGecitkale:AddSquadron(RedCapSquadronThree)
RedAirwingGecitkale:AddSquadron(RedCapSquadronFour)
RedAirwingGecitkale:AddSquadron(RedSEADSquadronTwo)

RedAirwingGecitkale:SetNumberCAP(1)

--LARNACA AIRWING
local RedAirwingLarnaca=AIRWING:New("WarehouseLarnaca", "Red Airwing Larnaca")
RedAirwingLarnaca:NewPayload("MIRAGEF1CAPTEMPLATE", 99, AUFTRAG.Type.INTERCEPT, 100)
RedAirwingLarnaca:NewPayload("MIG29CAPTEMPLATE", 99, AUFTRAG.Type.CAP, 100)
RedAirwingLarnaca:NewPayload("SU25SEADTEMPLATE", 99, AUFTRAG.Type.SEAD, 100)
RedAirwingLarnaca:AddSquadron(RedCapSquadronOne)
RedAirwingLarnaca:AddSquadron(RedCapSquadronTwo)
RedAirwingLarnaca:AddSquadron(RedSEADSquadronOne)

RedAirwingLarnaca:SetNumberCAP(1)


--AWACS--
-- We need an AirWing
local AwacsRed = AIRWING:New("WarehouseLarnaca", "AWACSRED")
--AwacsAW:SetReportOn()
AwacsRed:SetMarker(false)
AwacsRed:SetAirbase(AIRBASE:FindByName(AIRBASE.Syria.Larnaca))
AwacsRed:SetRespawnAfterDestroyed(900)
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
local AwacsEscortsRed = SQUADRON:New("AWACSREDESCORT",4,"Awacs Red Escorts")
AwacsEscortsRed:AddMissionCapability({AUFTRAG.Type.ESCORT})
AwacsEscortsRed:SetFuelLowRefuel(true)
AwacsEscortsRed:SetFuelLowThreshold(0.3)
AwacsEscortsRed:SetTurnoverTime(10,20)
AwacsEscortsRed:SetTakeoffAir()
AwacsEscortsRed:SetRadio(275,radio.modulation.AM)
AwacsRed:AddSquadron(AwacsEscortsRed)
AwacsRed:NewPayload("AWACSREDESCORT",-1,{AUFTRAG.Type.ESCORT},100)


local RedAwacs = AWACS:New("Awacs-Red", AwacsRed, "red", AIRBASE.Syria.Larnaca, "AWACSREDORBIT", ZONE:FindByName("AWACSREDZONE"), "AWACSREDCAPZONE", 275, radio.modulation.AM )

RedAwacs:SetEscort(2)
RedAwacs:SetAwacsDetails(CALLSIGN.AWACS.Darkstar,1,30,280,88,25)

RedAwacs:__Start(5)



---MISSIONS---
--CAPTURE ZONES MISSION--

--ADDMISSION TO HOLD GECITKALE AND LARNACA
local missionRedGecitkale=AUFTRAG:NewCAPTUREZONE(Gecitkale, coalition.side.RED)
missionRedGecitkale:SetRequiredAssets(3, 6)
missionRedGecitkale:SetROE(ENUMS.ROE.OpenFire)
local missionRedLarnaca=AUFTRAG:NewCAPTUREZONE(Larnaca, coalition.side.RED)
missionRedLarnaca:SetROE(ENUMS.ROE.OpenFire)
missionRedLarnaca:SetRequiredAssets(3, 6)




--CAP MISSION RED--
local capZoneRed = ZONE:New("RedCAP")

local CAPRed = AUFTRAG:NewCAP(capZoneRed, 15000, 350, nil, 90, 15, {"Air"})
CAPRed:SetRequiredAssets(2, 4)
CAPRed:SetRepeatOnFailure(5)
CAPRed:SetROE(ENUMS.ROE.OpenFireWeaponFree)


--SEAD MISSION RED

local RedSeadTargetSET = SET_GROUP:New():FilterPrefixes("EWBLUE"):FilterStart()
local SEADtarget = TARGET:New(RedSeadTargetSET)

local SEADmission = AUFTRAG:NewSEAD(SEADtarget, 25000)
SEADmission:SetRequiredAssets(2, 4)
SEADmission:SetRepeatOnFailure(5)
SEADmission:SetROE(ENUMS.ROE.OpenFireWeaponFree)



---CHIEF---
--Border Zone
local ZoneBlueBorder=ZONE:New("RedChiefBorder"):DrawZone()--disable the drawzone after testing
--Agents
local Agents=SET_GROUP:New():FilterPrefixes({ "EWRED", "AWACSRED", "JTACRED", "FACRED" }):FilterOnce()
--Define the CHIEF.  
local REDChief=CHIEF:New(coalition.side.RED, Agents)
--Add border zone.
REDChief:AddBorderZone(ZoneBlueBorder)
--Enable tactical overview.
REDChief:SetTacticalOverviewOn()
--Response on targets
REDChief:SetResponseOnTarget(2, 4, 4, TARGET.Category.AIRCRAFT, AUFTRAG.Type.INTERCEPT)



REDChief:AddBrigade(brigadeRedOne)
REDChief:AddBrigade(brigadeRedTwo)
REDChief:AddBrigade(brigadeRedThree)
REDChief:AddBrigade(artilleryRedOne)
REDChief:AddBrigade(artilleryRedTwo)
REDChief:AddAirwing(RedAirwingGecitkale)
REDChief:AddAirwing(RedAirwingLarnaca)


-- Set strategy to DEFENSIVE: Only targets within the border of the chief's territory are attacked.
REDChief:SetStrategy(REDChief.Strategy.TOTALWAR)


--GIVE CHIEF MISSIONS
REDChief:AddMission(CAPRed)
REDChief:AddMission(missionRedGecitkale)
REDChief:AddMission(missionRedLarnaca)
REDChief:AddMission(SEADmission)



--CHIEF RESOURCE SECTION

local RedCAPOpsZone = OPSZONE:New("RedCAP")


-- Add strategic (OPS) zones.
local RedStratZone4 = REDChief:AddStrategicZone(Gecitkale, nil , 2)
local RedStratZone5 = REDChief:AddStrategicZone(Larnaca, nil , 2)

local Redcapzone1 = REDChief:AddStrategicZone(RedCAPOpsZone, nil, 2)




--RESOURCE SECTION
local RedCaptureZoneResource=REDChief:CreateResource(AUFTRAG.Type.CAPTUREZONE, 3, 6)
REDChief:AddToResource(RedCaptureZoneResource, AUFTRAG.Type.PATROLZONE, 2, 5)
REDChief:AddToResource(RedCaptureZoneResource, AUFTRAG.Type.GROUNDATTACK, 2, 5)
REDChief:AddToResource(RedCaptureZoneResource, AUFTRAG.Type.ONGUARD, 2, 5)
REDChief:AddToResource(RedCaptureZoneResource, AUFTRAG.Type.ARTY, 2, 5)

local RedCapResource=REDChief:CreateResource(AUFTRAG.Type.CAP, 1, 2)
--REDChief:AddToResource(Resource,MissionType,Nmin,Nmax,Attributes,Properties,Categories)
REDChief:AddToResource(RedCapResource, AUFTRAG.Type.SEAD, 2, 4)
REDChief:AddToResource(RedCapResource, AUFTRAG.Type.INTERCEPT, 2, 4)


local RedResourceEmpty=REDChief:CreateResource(AUFTRAG.Type.ONGUARD, 1, 5)
--REDChief:AddToResource(Resource,MissionType,Nmin,Nmax,Attributes,Properties,Categories)
REDChief:AddToResource(RedResourceEmpty, AUFTRAG.Type.NOTHING, 1, 3)
REDChief:AddToResource(RedResourceEmpty, AUFTRAG.Type.PATROLZONE, 2)


--Assign StratZones to resource lists


--StratZone4
REDChief:SetStrategicZoneResourceOccupied(RedStratZone4, RedCaptureZoneResource)
REDChief:SetStrategicZoneResourceEmpty(RedStratZone4, RedResourceEmpty)
--StratZone5
REDChief:SetStrategicZoneResourceOccupied(RedStratZone5, RedCaptureZoneResource)
REDChief:SetStrategicZoneResourceEmpty(RedStratZone5, RedResourceEmpty)
--CAPZone1
REDChief:SetStrategicZoneResourceOccupied(Redcapzone1, RedCapResource)
REDChief:SetStrategicZoneResourceEmpty(Redcapzone1, RedResourceEmpty)




--Start Chief
REDChief:__Start(1)


---COMMANDER---

--DEFINE RED COMMANDERS--
-- Create a commander.
local REDcommander=COMMANDER:New(coalition.side.RED)

-- Add legions to commander.
REDcommander:AddLegion(brigadeRedOne)
REDcommander:AddLegion(brigadeRedTwo)
REDcommander:AddLegion(brigadeRedThree)

REDcommander:AddLegion(artilleryRedOne)
REDcommander:AddLegion(artilleryRedTwo)
REDcommander:AddAirwing(RedAirwingGecitkale)
REDcommander:AddAirwing(RedAirwingLarnaca)


-- Start REDcommander. This also auto-starts all assigned legions.
REDcommander:__Start(3)


--- Function called each time and OPS group is send on a mission.
--function REDcommander:onafterOpsOnMission(From, Event, To, OpsGroup, Mission)
--  local opsgroup=OpsGroup --Ops.OpsGroup#OPSGROUP
--  local mission=Mission   --Ops.Auftrag#AUFTRAG
--  
--  -- Info message.
--  local text=string.format("Group %s is on %s mission %s", opsgroup:GetName(), mission:GetType(), mission:GetName())
--  MESSAGE:New(text, 360):ToAll()
--  env.info(text)
--end