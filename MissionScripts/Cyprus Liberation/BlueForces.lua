----BLUE AIR DETECTION--
---- Define a SET_GROUP object that builds a collection of groups that define the EWR network.
DetectionSetGroupBlueAir = SET_GROUP:New()
DetectionSetGroupBlueAir:FilterPrefixes( { "EWBLUE", "AWACSBLUE" } )
DetectionSetGroupBlueAir:FilterStart()
--
DetectionBlueAir = DETECTION_AREAS:New( DetectionSetGroupBlueAir, 30000 )

----BLUE A2G DETECTION--
DetectionSetGroupBlueGround = SET_GROUP:New()
DetectionSetGroupBlueGround:FilterPrefixes( { "JTACBLUE", "FACBLUE" } )
DetectionSetGroupBlueGround:FilterStart()
--
DetectionBlueGround = DETECTION_AREAS:New( DetectionSetGroupBlueGround, 10000)



----Get table of Detected Ground Targets
--local TargetUnits = DetectionBlueGround:GetDetectedItemSet()
--
--
--function DetectionBlueGround:OnAfterDetected(From, Event, To, Units)
--  BASE:T({"OnAfterDetected: ", Units})
--  for index, TargetUnits in pairs(Units) do
--    BASE:E("Detected Unit: " .. TargetUnits:GetTypeName())
--  end
--end



--- OnAfter Transition Handler for Event Detect.
-- @param Functional.Detection#DETECTION_UNITS self
-- @param #string From The From State string.
-- @param #string Event The Event string.
-- @param #string To The To State string.
--function DetectionBlueGround:OnAfterDetect(From,Event,To)
--
--  
--
--  HQ:MessageToAll( DetectionReport, 15, "Detection" )
--end



--BUILD INTEL HERE

local BlueIntelAir = INTEL:New(DetectionSetGroupBlueAir, "blue", "CIA")
BlueIntelAir:SetClusterAnalysis(true, true, true)--CHANGE THESE AFTER TESTING
BlueIntelAir:SetVerbosity(0)
BlueIntelAir:__Start(2)

local BlueIntelGround = INTEL:New(DetectionSetGroupBlueGround, "blue", "HOA")
BlueIntelGround:SetClusterAnalysis(true, true, true)--CHANGE THESE AFTER TESTING
BlueIntelGround:SetVerbosity(0)
BlueIntelGround:__Start(2)

--function BlueIntelAir:OnAfterNewContact(From, Event, To, Contact)
--  local text = string.format("NEW contact %s detected by %s", Contact.groupname, Contact.recce or "unknown")
--  MESSAGE:New(text, 15, "CIA"):ToAll()
--end
--
--function BlueIntelGround:OnAfterNewCluster(From, Event, To, Cluster)
--  local text = string.format("NEW cluster #%d of size %d", Cluster.index, Cluster.size)
--  MESSAGE:New(text,15,"HOA"):ToAll()
--end

---BUILD UNITS AND GROUPS HERE---

--CREATE PLATOONS FOR ARMOR AND INFANTRY
--ALPHA GROUP
local AlphaGroupTanks=PLATOON:New( "Alpha Group Tanks", 20, "187th Armor Platoon" )
AlphaGroupTanks:AddMissionCapability({AUFTRAG.Type.GROUNDATTACK}, 100)
AlphaGroupTanks:AddMissionCapability({AUFTRAG.Type.ONGUARD,AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE}, 50)

local AlphaGroupCalvary=PLATOON:New( "Alpha Group Calvary", 20, "33rd Calvary" )
AlphaGroupCalvary:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE, AUFTRAG.Type.ONGUARD}, 100)

local AlphaGroupMech=PLATOON:New( "Alpha Group Mechanized", 20, "104th Mechanized" )
AlphaGroupMech:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE, AUFTRAG.Type.ONGUARD}, 80)


--BRAVO GROUP
local BravoGroupTanks=PLATOON:New( "Bravo Group Tanks", 20, "245th Armor Platoon" )
BravoGroupTanks:AddMissionCapability({AUFTRAG.Type.GROUNDATTACK}, 100)
BravoGroupTanks:AddMissionCapability({AUFTRAG.Type.ONGUARD,AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE}, 50)

local BravoGroupCalvary=PLATOON:New( "Bravo Group Calvary", 20, "186th Calvary" )
BravoGroupCalvary:AddMissionCapability({AUFTRAG.Type.CAPTUREZONE, AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.ONGUARD}, 60)

local BravoGroupMech=PLATOON:New( "Bravo Group Mechanized", 20, "98th Mechanized" )
BravoGroupMech:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE, AUFTRAG.Type.ONGUARD}, 60)

--DELTA GROUP
local DeltaGroupTanks=PLATOON:New( "Delta Group Tanks", 20, "76th Armor Platoon" )
DeltaGroupTanks:AddMissionCapability({AUFTRAG.Type.GROUNDATTACK}, 100)
DeltaGroupTanks:AddMissionCapability({AUFTRAG.Type.ONGUARD,AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE}, 50)

local DeltaGroupCalvary=PLATOON:New( "Delta Group Calvary", 20, "35th Calvary" )
DeltaGroupCalvary:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE, AUFTRAG.Type.ONGUARD}, 60)

local DeltaGroupMech=PLATOON:New( "Delta Group Mechanized", 20, "83rd Mechanized" )
DeltaGroupMech:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.CAPTUREZONE, AUFTRAG.Type.ONGUARD}, 60)

--Platoon Echo
--Paladins
local platoonPaladinEcho=PLATOON:New("Echo Paladins", 15, "M109 Paladin")
platoonPaladinEcho:AddMissionCapability({AUFTRAG.Type.ARTY, AUFTRAG.Type.GROUNDATTACK}, 90)
platoonPaladinEcho:AddWeaponRange(UTILS.KiloMetersToNM(0.5), UTILS.KiloMetersToNM(20))
--MLRS
local platoonMlrsEcho=PLATOON:New("Echo MLRS", 15, "MLRS M270")
platoonMlrsEcho:AddMissionCapability({AUFTRAG.Type.ARTY, AUFTRAG.Type.GROUNDATTACK}, 80)
platoonMlrsEcho:AddWeaponRange(UTILS.KiloMetersToNM(10), UTILS.KiloMetersToNM(32))

--Platoon Golf
--Paladins
local platoonPaladinGolf=PLATOON:New("Golf Paladins", 15, "M109 Paladin")
platoonPaladinGolf:AddMissionCapability({AUFTRAG.Type.ARTY, AUFTRAG.Type.GROUNDATTACK}, 90)
platoonPaladinGolf:AddWeaponRange(UTILS.KiloMetersToNM(0.5), UTILS.KiloMetersToNM(20))

--MLRS
local platoonMlrsGolf=PLATOON:New("Golf MLRS", 15, "MLRS M270")
platoonMlrsGolf:AddMissionCapability({AUFTRAG.Type.ARTY, AUFTRAG.Type.GROUNDATTACK}, 80)
platoonMlrsGolf:AddWeaponRange(UTILS.KiloMetersToNM(10), UTILS.KiloMetersToNM(32))

----Rearming Platoon
--local platoonRearm=ARMYGROUP:New("Romeo Group Supply")
--platoonRearm:AddMission(AUFTRAG.Type.REARMING)




----Armor Brigades--DECLARE SPAWNZONES
--local zoneFOBWhiskey=ZONE:New("FOBWhiskey")
--local zoneFOBGolf = ZONE:New("FOBGolf")

--BUILD BRIGADES
--Alpha Brigade
local brigadeAlpha = BRIGADE:New("WarehouseEcho", "Brigade Alpha")
brigadeAlpha:AddPlatoon(AlphaGroupTanks)
brigadeAlpha:AddPlatoon(AlphaGroupCalvary)
brigadeAlpha:AddPlatoon(AlphaGroupMech)
brigadeAlpha:SetSpawnZone(zoneFOBWhiskey)
brigadeAlpha:Start()

--Bravo Brigade
local brigadeBravo = BRIGADE:New("WarehouseEcho", "Brigade Bravo")
brigadeBravo:AddPlatoon(BravoGroupTanks)
brigadeBravo:AddPlatoon(BravoGroupCalvary)
brigadeBravo:AddPlatoon(BravoGroupMech)
brigadeBravo:SetSpawnZone(zoneFOBWhiskey)
brigadeBravo:Start()

--Delta Brigade
local brigadeDelta = BRIGADE:New("WarehouseGolf", "Brigade Delta")
brigadeDelta:AddPlatoon(DeltaGroupTanks)
brigadeDelta:AddPlatoon(DeltaGroupCalvary)
brigadeDelta:AddPlatoon(DeltaGroupMech)
brigadeDelta:SetSpawnZone(zoneFOBGolf)
brigadeDelta:Start()

--EchoBrigade--Paladins and MLRS
local brigadeEcho=BRIGADE:New("WarehouseEcho", "Brigade Echo")
--SET SPAWN
brigadeEcho:SetSpawnZone(zoneFOBWhiskey)
--ASSIGN PLATOONS
brigadeEcho:AddPlatoon(platoonPaladinEcho)
brigadeEcho:AddPlatoon(platoonMlrsEcho)
--START
brigadeEcho:Start()

--GolfBrigade--Paladins and MLRS
local brigadeGolf=BRIGADE:New("WarehouseGolf", "Brigade Golf")
brigadeGolf:SetSpawnZone(zoneFOBGolf)
brigadeGolf:AddPlatoon(platoonPaladinGolf)
brigadeGolf:AddPlatoon(platoonMlrsGolf)

brigadeGolf:Start()

----Rearm Brigade Echo
--local brigadeRomeo=BRIGADE:New("WarehouseEcho", "Brigade Romeo")
--brigadeRomeo:SetSpawnZone(zoneFOBWhiskey)
--brigadeRomeo:AddPlatoon(platoonRearm)
--brigadeRomeo:Start()
--
--local brigadeJuliet=BRIGADE:New("WarehouseGolf", "Brigade Juliet")
--brigadeRomeo:SetSpawnZone(zoneFOBGolf)
--brigadeRomeo:AddPlatoon(platoonRearm)
--brigadeRomeo:Start()


----Brigade Functions
----Function called each time a group from the brigade is send on a mission.
--function brigadeAlpha:OnAfterArmyOnMission(From, Event, To, Armygroup, Mission)
--  local armygroup=Armygroup --Ops.ArmyGroup#ARMYGROUP
--  local mission=Mission --Ops.Auftrag#AUFTRAG
--  
--  -- Info text.
--  local text=string.format("Armygroup %s on Mission %s [%s]", armygroup:GetName(), mission:GetName(), mission:GetType())
--  MESSAGE:New(text, 60):ToAll()
--  env.info(text)
--end
--
--
--function brigadeBravo:OnAfterArmyOnMission(From, Event, To, Armygroup, Mission)
--  local armygroup=Armygroup --Ops.ArmyGroup#ARMYGROUP
--  local mission=Mission --Ops.Auftrag#AUFTRAG
--  
--  -- Info text.
--  local text=string.format("Armygroup %s on Mission %s [%s]", armygroup:GetName(), mission:GetName(), mission:GetType())
--  MESSAGE:New(text, 60):ToAll()
--  env.info(text)
--end
--
--
--function brigadeDelta:OnAfterArmyOnMission(From, Event, To, Armygroup, Mission)
--  local armygroup=Armygroup --Ops.ArmyGroup#ARMYGROUP
--  local mission=Mission --Ops.Auftrag#AUFTRAG
--  
--  -- Info text.
--  local text=string.format("Armygroup %s on Mission %s [%s]", armygroup:GetName(), mission:GetName(), mission:GetType())
--  MESSAGE:New(text, 60):ToAll()
--  env.info(text)
--end
--
--
--function brigadeEcho:OnAfterArmyOnMission(From, Event, To, Armygroup, Mission)
--  local armygroup=Armygroup --Ops.ArmyGroup#ARMYGROUP
--  local mission=Mission --Ops.Auftrag#AUFTRAG
--  
--  -- Info text.
--  local text=string.format("Armygroup %s on Mission %s [%s]", armygroup:GetName(), mission:GetName(), mission:GetType())
--  MESSAGE:New(text, 60):ToAll()
--  env.info(text)
--end
--
--function brigadeGolf:OnAfterArmyOnMission(From, Event, To, Armygroup, Mission)
--  local armygroup=Armygroup --Ops.ArmyGroup#ARMYGROUP
--  local mission=Mission --Ops.Auftrag#AUFTRAG
--  
--  -- Info text.
--  local text=string.format("Armygroup %s on Mission %s [%s]", armygroup:GetName(), mission:GetName(), mission:GetType())
--  MESSAGE:New(text, 60):ToAll()
--  env.info(text)
--end

--function brigadeRomeo:OnAfterArmyOnMission(From, Event, To, Armygroup, Mission)
--  local armygroup=Armygroup --Ops.ArmyGroup#ARMYGROUP
--  local mission=Mission --Ops.Auftrag#AUFTRAG
--  
--  -- Info text.
--  local text=string.format("Armygroup %s on Mission %s [%s]", armygroup:GetName(), mission:GetName(), mission:GetType())
--  MESSAGE:New(text, 60):ToAll()
--  env.info(text)
--end


---SQUADRONS---


--BUILD SQUADRONS HERE
-- F/A-18C squadron Akrotiri.
local BlueInterceptSqdOne=SQUADRON:New("F18CINTERCEPTTEMPLATE", 16, "23rd Fighter Squad") --Ops.Squadron#SQUADRON
BlueInterceptSqdOne:AddMissionCapability(AUFTRAG.Type.INTERCEPT)
BlueInterceptSqdOne:SetModex(100)
BlueInterceptSqdOne:SetCallsign(CALLSIGN.Aircraft.Chevy)
BlueInterceptSqdOne:SetSkill(AI.Skill.GOOD)

local BlueCapSqdOne=SQUADRON:New("F18CCAPTEMPLATE", 16, "24th Fighter Squad") --Ops.Squadron#SQUADRON
BlueCapSqdOne:AddMissionCapability(AUFTRAG.Type.CAP)
BlueCapSqdOne:SetModex(100)
BlueCapSqdOne:SetCallsign(CALLSIGN.Aircraft.Chevy)
BlueCapSqdOne:SetSkill(AI.Skill.GOOD)

local BlueSeadSqdOne=SQUADRON:New("F16CSEADTEMPLATE", 16, "27th Interdiction Squad") --Ops.Squadron#SQUADRON
BlueSeadSqdOne:AddMissionCapability(AUFTRAG.Type.SEAD)
BlueSeadSqdOne:SetModex(100)
BlueSeadSqdOne:SetCallsign(CALLSIGN.Aircraft.Chevy)
BlueSeadSqdOne:SetSkill(AI.Skill.GOOD)

local BlueBAISqdOne=SQUADRON:New("F15SEBAITEMPLATE", 16, "382nd Hellbringers")
BlueBAISqdOne:AddMissionCapability({AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.STRIKE}, 100)
BlueBAISqdOne:SetModex(100)
BlueBAISqdOne:SetCallsign(CALLSIGN.Aircraft.Chevy)
BlueBAISqdOne:SetSkill(AI.Skill.GOOD)

local BlueBAISqdTwo=SQUADRON:New("F15SEBAITEMPLATE2", 16, "381st Hellbringers")
BlueBAISqdTwo:AddMissionCapability({AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.STRIKE}, 100)
BlueBAISqdTwo:SetModex(100)
BlueBAISqdTwo:SetCallsign(CALLSIGN.Aircraft.Chevy)
BlueBAISqdTwo:SetSkill(AI.Skill.GOOD)

local BlueCASSqdOne=SQUADRON:New("A10CASTEMPLATE", 16, "163rd Brrrrrrrtt Squadron")
BlueCASSqdOne:AddMissionCapability({AUFTRAG.Type.CAS, AUFTRAG.Type.CASENHANCED}, 100)
BlueCASSqdOne:SetModex(100)
BlueCASSqdOne:SetCallsign(CALLSIGN.Aircraft.Colt)
BlueCASSqdOne:SetSkill(AI.Skill.GOOD)

local BlueGCISqdOne=SQUADRON:New("F18CGCITEMPLATE", 16, "33rd Killer Squad")
BlueGCISqdOne:AddMissionCapability(AUFTRAG.Type.GCICAP, 100)
BlueGCISqdOne:SetModex(100)
BlueGCISqdOne:SetCallsign(CALLSIGN.Aircraft.Colt)
BlueGCISqdOne:SetSkill(AI.Skill.GOOD)

local BlueCASSqdTwo=SQUADRON:New("AH64CASTEMPLATE", 16, "SomeNumbers Chopper Go Boom")
BlueCASSqdTwo:AddMissionCapability({AUFTRAG.Type.CAS, AUFTRAG.Type.CASENHANCED}, 100)
BlueCASSqdTwo:SetModex(100)
BlueCASSqdTwo:SetCallsign(CALLSIGN.Aircraft.Colt)
BlueCASSqdTwo:SetSkill(AI.Skill.GOOD)

local BlueCASSqdThree=SQUADRON:New("AH64CASTEMPLATE2", 16, "SomeNumbers Chopper Go Chop Chop")
BlueCASSqdThree:AddMissionCapability({AUFTRAG.Type.CAS, AUFTRAG.Type.CASENHANCED}, 100)
BlueCASSqdThree:SetModex(100)
BlueCASSqdThree:SetCallsign(CALLSIGN.Aircraft.Colt)
BlueCASSqdThree:SetSkill(AI.Skill.GOOD)

local BlueFACS=SQUADRON:New("FACBLUE", 6, "I see you!")
BlueFACS:AddMissionCapability({AUFTRAG.Type.FACA, AUFTRAG.Type.ORBIT}, 100)
BlueFACS:SetModex(100)
BlueFACS:SetCallsign(CALLSIGN.JTAC.Darknight)
BlueFACS:SetTakeoffAir()
BlueFACS:SetSkill(AI.Skill.GOOD)

--local BlueCASfg1=FLIGHTGROUP:New("A10CASTEMPLATE")
--BlueCASfg1:SetDetection(true)
--BlueCASfg1:SetEngageDetectedOn(10, {"Ground Units"}, CASSETzones)
--BlueCASfg1:Activate()
--BlueCASfg1:AddMission(AUFTRAG:NewCAS(casZoneNorth))
--
--
--local BlueCASfg2=FLIGHTGROUP:New("AH64CASTEMPLATE")
--BlueCASfg1:SetDetection(true)
--BlueCASfg1:SetEngageDetectedOn(10, {"Ground Units"}, CASSETzones)
--BlueCASfg1:Activate()
--BlueCASfg1:AddMission(AUFTRAG:NewCAS(casZoneSouth))
--
--function BlueCASfg1:onafterDestroyed(From,Event,To)
--BlueCASfg1:_Respawn(1, "A10CASTEMPLATE")
--end

--local BlueTransportHelos=SQUADRON:New("CH47 Transports", 10, "Heavy Lifters")
--BlueTransportHelos:AddMissionCapability(AUFTRAG.Type.CARGOTRANSPORT())



----Troop Transport Squadrons
--local cargoset=SET_OPSGROUP:New():FilterPrefixes("IA"):FilterStart()  --Core.Set#SET_OPSGROUP
--cargoset:Activate()
--
--
---- Transport assignment.
--local transport=OPSTRANSPORT:New(cargoset, BLUEzonePICKUP, BLUEzoneDROPOFFnorth)
--
--local TTChopper=FLIGHTGROUP:New("Troop Chopper")
--TTChopper:AddOpsTransport(transport)
--TTChopper:SetHomebase("FOBWhiskeyAIPad")
--TTChopper:Activate()
--
--
----This function may break
--function TTChopper:onafterDestroyed(From,Event,To)
--TTChopper:_Respawn(5)
--end






--AKROTIRI AIRWING
-- Create a new airwing.
local BlueAirWingAkrotiri=AIRWING:New("WarehouseAkrotiri", "187th Fighter Wing Akrotiri") --Ops.AirWing#AIRWING
  
-- Payload F/A-18C  
BlueAirWingAkrotiri:NewPayload("F18CINTERCEPTTEMPLATE", 2, AUFTRAG.Type.INTERCEPT, 100)
BlueAirWingAkrotiri:NewPayload("F18CCAPTEMPLATE", 2, AUFTRAG.Type.CAP, 100)
BlueAirWingAkrotiri:NewPayload("F16CSEADTEMPLATE", 2, AUFTRAG.Type.SEAD, 100)
BlueAirWingAkrotiri:NewPayload("F15SEBAITEMPLATE", 2, AUFTRAG.Type.BAI, 100)
BlueAirWingAkrotiri:NewPayload("F15SEBAITEMPLATE2", 2, {AUFTRAG.Type.BOMBING, AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.STRIKE}, 100)
BlueAirWingAkrotiri:NewPayload("A10CASTEMPLATE", 2, AUFTRAG.Type.CAS, 100)
BlueAirWingAkrotiri:NewPayload("AH64CASTEMPLATE", 2, AUFTRAG.Type.CAS, 100)
BlueAirWingAkrotiri:NewPayload("F18CGCITEMPLATE", 2, AUFTRAG.Type.GCICAP, 100)


-- Add squadrons to airwing.
BlueAirWingAkrotiri:AddSquadron(BlueInterceptSqdOne)
BlueAirWingAkrotiri:AddSquadron(BlueCapSqdOne)
BlueAirWingAkrotiri:AddSquadron(BlueSeadSqdOne)
BlueAirWingAkrotiri:AddSquadron(BlueBAISqdOne)
BlueAirWingAkrotiri:AddSquadron(BlueBAISqdTwo)
BlueAirWingAkrotiri:AddSquadron(BlueCASSqdOne)
BlueAirWingAkrotiri:AddSquadron(BlueGCISqdOne)
BlueAirWingAkrotiri:AddSquadron(BlueCASSqdTwo)
BlueAirWingAkrotiri:AddSquadron(BlueCASSqdThree)
--BlueAirWingAkrotiri:AddSquadron(BlueFACS)
--Use Flightgroup, if unable then uncomment this for Squadron

--BlueAirWingAkrotiri:AddSquadron(TTChopper)


BlueAirWingAkrotiri:SetNumberCAP(2)

BlueAirWingAkrotiri:Start()


--YOU STILL NEED A REARMING MISSION, UNITS ARE RUNNING OUT OF AMMO


--SRS for AWACS

local hereSRSPath = mySRSPath or "Z:\\DCS-SimpleRadio-Standalone"
local hereSRSPort = mySRSPort or 5002
--local hereSRSGoogle = mySRSGKey or "C:\\Program Files\DCS-SimpleRadio-Standalone\key.json"




--AWACS--
-- We need an AirWing
local AwacsBlue = AIRWING:New("WarehouseAkrotiri", "AWACSBLUE")
--AwacsAW:SetReportOn()
AwacsBlue:SetMarker(false)
AwacsBlue:SetAirbase(AIRBASE:FindByName(AIRBASE.Syria.Akrotiri))
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


local AwacsBlue = AWACS:New("Awacs-Blue", AwacsBlue, "blue", AIRBASE.Syria.Akrotiri, "AWACSBLUEORBIT", ZONE:FindByName("AWACSBLUEZONE"), "AWACSBLUECAPZONE", 264, radio.modulation.AM )

AwacsBlue:SetEscort(2)
AwacsBlue:SetAwacsDetails(CALLSIGN.AWACS.Darkstar,1,30,280,88,25)
AwacsBlue:SetTOS(4, 4)

AwacsBlue:__Start(5)

-- Set up SRS
--if hereSRSGoogle then
--  -- use Google
--  AwacsBlue:SetSRS(hereSRSPath,"female","en-US",hereSRSPort,"en-US-Wavenet-F",0.9,hereSRSGoogle)
--else
  -- use Windows
AwacsBlue:SetSRS(hereSRSPath,"male","en-US",hereSRSPort,nil,0.9)
--end


---BUILD MISSIONS HERE---
--REWORK THIS to remove the three mid zones, focus on holding and capturing of the airbases only.

--CAPTURE ZONES MISSION--
local missionBlueCaptureGecitkale=AUFTRAG:NewCAPTUREZONE(Gecitkale, coalition.side.BLUE)
missionBlueCaptureGecitkale:SetROE(ENUMS.ROE.OpenFire)
local missionBlueCaptureLarnaca=AUFTRAG:NewCAPTUREZONE(Larnaca, coalition.side.BLUE)
missionBlueCaptureLarnaca:SetROE(ENUMS.ROE.OpenFire)

--CAP MISSION NORTH--
local CAPmissionNorth = AUFTRAG:NewCAP(capZoneNorth, 15000, 350, nil, 90, 0, {"Air"})
CAPmissionNorth:SetRequiredAssets(2, 4)
CAPmissionNorth:SetRepeatOnFailure(5)
CAPmissionNorth:SetROE(ENUMS.ROE.OpenFire)

--CAP MISSION MID--
local CAPmissionMid = AUFTRAG:NewCAP(capZoneMid, 15000, 350, nil, 90, 0, {"Air"})
CAPmissionMid:SetRequiredAssets(2, 4)
CAPmissionMid:SetRepeatOnFailure(5)
CAPmissionMid:SetROE(ENUMS.ROE.OpenFire)

--CAP MISSION SOUTH--
local CAPmissionSouth = AUFTRAG:NewCAP(capZoneSouth, 15000, 350, nil, 90, 0, {"Air"})
CAPmissionSouth:SetRequiredAssets(2, 4)
CAPmissionSouth:SetRepeatOnFailure(5)
CAPmissionSouth:SetROE(ENUMS.ROE.OpenFire)

----FAC MISSIONS
--local FACmission = AUFTRAG:NewRECON(opszonesSET, 80, 5000, true, true)
--FACmission:SetRequiredAssets(1, 2)
--FACmission:SetRepeatOnFailure(6)
--FACmission:SetROE(ENUMS.ROE.ReturnFire)
--
--FACA MISSIONS
--local FACAmission = AUFTRAG:NewFACA()

--CAS MISSIONS
local CASmissionNorth = AUFTRAG:NewCAS(casZoneNorth, 10000, 250)
CASmissionNorth:SetRequiredAssets(2, 4)
CASmissionNorth:SetRepeatOnFailure(5)
CASmissionNorth:SetROE(ENUMS.ROE.OpenFire)

local CASmissionSouth = AUFTRAG:NewCAS(casZoneSouth, 10000, 250)
CASmissionSouth:SetRequiredAssets(2, 4)
CASmissionSouth:SetRepeatOnFailure(5)
CASmissionSouth:SetROE(ENUMS.ROE.OpenFire)

----AWACS MISSIONS
--local AWACSMission = AUFTRAG:NewAWACS(awacsZone:GetCoordinate(), 25000, 365, 270, 10)
--AWACSMission:SetRequiredAssets(1, 1)
--AWACSMission:SetRepeatOnFailure(5)
--AWACSMission:SetRadio(264) 
--
--local AWACSgroup=FLIGHTGROUP:New("AWACSBLUE")
--AWACSgroup:AddMission(AWACSMission)
--AWACSgroup:Activate()
--
--function AWACSgroup:onafterDestroyed(From,Event,To)
--AWACSgroup:_Respawn(1, "AWACSBLUE")
--end





--local AirbaseStrikeTargets = SET_AIRBASE:New():AddAirbasesByName({AIRBASE.Syria.Gecitkale, AIRBASE.Syria.Larnaca})

--Strike Mission





local StrikeTarget = ZONE:New("Zeta-1"):GetCoordinate()
--local StrikeTarget = StrikeTargetZone:GetVec2()


--local StrikeTarget = TARGET:New(AIRBASE.Syria.Gecitkale)

local StrikeMission = AUFTRAG:NewSTRIKE(StrikeTarget, 5000)
StrikeMission:SetRequiredAssets(2, 3)
StrikeMission:SetRepeatOnFailure(5)
StrikeMission:SetROE(ENUMS.ROE.OpenFireWeaponFree)

--Bombing Mission

local BombingMission = AUFTRAG:NewBOMBING(StrikeTarget, 10000)
BombingMission:SetRequiredAssets(2, 3)
BombingMission:SetRepeatOnFailure(5)
BombingMission:SetROE(ENUMS.ROE.OpenFireWeaponFree)








---
-- CHIEF OF STAFF
---

--Border Zone
local ZoneBlueBorder=ZONE:New("BlueChiefBorder")
--Agents
local Agents=SET_GROUP:New():FilterPrefixes({ "EWBLUE", "AWACSBLUE", "JTACBLUE", "FACBLUE" }):FilterStart()
--Define the CHIEF.  
local USChief=CHIEF:New(coalition.side.BLUE, Agents)
--Add border zone.
USChief:AddBorderZone(ZoneBlueBorder)
--Enable tactical overview.
--USChief:SetTacticalOverviewOn()
--Response on targets
--USChief:SetResponseOnTarget(NassetsMin,NassetsMax,ThreatLevel,TargetCategory,MissionType,Nunits,Defcon,Strategy)
USChief:SetResponseOnTarget(1, 4, 2, TARGET.Category.AIRCRAFT, AUFTRAG.Type.INTERCEPT)
USChief:SetResponseOnTarget(2, 4, 2, TARGET.Category.GROUND, AUFTRAG.Type.CAS)
USChief:SetResponseOnTarget(4, 8, 3, TARGET.Category.ZONE, AUFTRAG.Type.CAPTUREZONE)


---THIS SECTION REALLY REALLY NEEDS A REWORK---
--Build each task individually, wtf were you thinking here.
--during testing the commander is attempting to send units on tasks that they are incapable of completing.  STOP being lazzy you moron and do each mission individually so that you can find where the error is.

USChief:AddBrigade(brigadeAlpha)
USChief:AddBrigade(brigadeBravo)
USChief:AddBrigade(brigadeDelta)
USChief:AddBrigade(brigadeEcho)
USChief:AddBrigade(brigadeGolf)
USChief:AddAirwing(BlueAirWingAkrotiri)


-- Set strategy to DEFENSIVE: Only targets within the border of the chief's territory are attacked.
--TOTALWAR is working for a full onslaught.  Change this to defensive after Mission 3

USChief:SetStrategy(USChief.Strategy.TOTALWAR)


--GIVE CHIEF MISSIONS

--CAP MISSIONS
USChief:AddMission(CAPmissionNorth)
USChief:AddMission(CAPmissionMid)
USChief:AddMission(CAPmissionSouth)


USChief:AddMission(missionBlueCaptureGecitkale)
USChief:AddMission(missionBlueCaptureLarnaca)
--USChief:AddMission(FACmission)
USChief:AddMission(CASmissionNorth)
USChief:AddMission(CASmissionSouth)
USChief:AddMission(StrikeMission)
USChief:AddMission(BombingMission)
--USChief:AddMission(JTACblueDRONE)


--CHIEF RESOURCE SECTION

-- Add strategic (OPS) zones.
local BlueStratZone4 = USChief:AddStrategicZone(Gecitkale, 80, nil)
local BlueStratZone5 = USChief:AddStrategicZone(Larnaca, 80, nil)


local Bluecapzone1 = USChief:AddStrategicZone(CAPzoneNorthOPS, nil, 2)
local Bluecapzone2 = USChief:AddStrategicZone(CAPzoneMidOPS, nil, 2)
local Bluecapzone3 = USChief:AddStrategicZone(CAPzoneSouthOPS, nil, 2)
local Bluecaszone1 = USChief:AddStrategicZone(CASzoneNorthOPS, nil, 2)
local Bluecaszone2 = USChief:AddStrategicZone(CASzoneSouthOPS, nil, 2)

--ResourceAssignment

--ZONE CAPTURE RESOURCES
local BlueCAPTUREResourceOccupied=USChief:CreateResource(AUFTRAG.Type.CAPTUREZONE, 5, 10, nil, nil)
USChief:AddToResource(BlueCAPTUREResourceOccupied, AUFTRAG.Type.ARTY, 2, 4, nil)
USChief:AddToResource(BlueCAPTUREResourceOccupied, AUFTRAG.Type.BARRAGE, 2, 4, nil, nil)
USChief:AddToResource(BlueCAPTUREResourceOccupied, AUFTRAG.Type.SEAD, 2, 4)
USChief:AddToResource(BlueCAPTUREResourceOccupied, AUFTRAG.Type.GROUNDATTACK, 3, 5)
--USChief:AddToResource(BlueResourceOccupied, AUFTRAG.Type.RECON, 2, 4)
USChief:AddToResource(BlueCAPTUREResourceOccupied, AUFTRAG.Type.CAS, 2, 4)
USChief:AddToResource(BlueCAPTUREResourceOccupied, AUFTRAG.Type.BAI, 2, 4)
USChief:AddToResource(BlueCAPTUREResourceOccupied, AUFTRAG.Type.STRIKE, 2, 4)
USChief:AddToResource(BlueCAPTUREResourceOccupied, AUFTRAG.Type.BOMBING, 2, 4)
USChief:AddToResource(BlueCAPTUREResourceOccupied, AUFTRAG.Type.RECON, 1, 2)

--CAS AND BAI SPECIFIC
local BlueCASResource = USChief:CreateResource(AUFTRAG.Type.CAS, 2, 4)
USChief:AddToResource(BlueCASResource, AUFTRAG.Type.BAI, 2, 4)

--Standard Empty ON GUARD and PATROL

local BlueResourceEmpty=USChief:CreateResource(AUFTRAG.Type.ONGUARD, 1, 5)
--USChief:AddToResource(Resource,MissionType,Nmin,Nmax,Attributes,Properties,Categories)
USChief:AddToResource(BlueResourceEmpty, AUFTRAG.Type.ONGUARD, 1, 3)
USChief:AddToResource(BlueResourceEmpty, AUFTRAG.Type.PATROLZONE, 2)
USChief:AddToResource(BlueResourceEmpty, AUFTRAG.Type.RECON, 1, 2)

--CAPResources
local BlueCAPResourceListOccupied=USChief:CreateResource(AUFTRAG.Type.CAP, 2, 4)
local BlueCAPResourceListEmpty=USChief:CreateResource(AUFTRAG.Type.PATROLZONE, 1, 2)

--Assign StratZones to resource lists


--StratZone4
USChief:SetStrategicZoneResourceOccupied(BlueStratZone4, BlueCAPTUREResourceOccupied)
USChief:SetStrategicZoneResourceEmpty(BlueStratZone4, BlueResourceEmpty)
--StratZone5
USChief:SetStrategicZoneResourceOccupied(BlueStratZone5, BlueCAPTUREResourceOccupied)
USChief:SetStrategicZoneResourceEmpty(BlueStratZone5, BlueResourceEmpty)

--CAPZone1
USChief:SetStrategicZoneResourceOccupied(Bluecapzone1, BlueCAPResourceListOccupied)
USChief:SetStrategicZoneResourceEmpty(Bluecapzone1, BlueCAPResourceListEmpty)
--CAPZone2
USChief:SetStrategicZoneResourceOccupied(Bluecapzone2, BlueCAPResourceListOccupied)
USChief:SetStrategicZoneResourceEmpty(Bluecapzone2, BlueCAPResourceListEmpty)
--CAPZone3
USChief:SetStrategicZoneResourceOccupied(Bluecapzone3, BlueCAPResourceListOccupied)
USChief:SetStrategicZoneResourceEmpty(Bluecapzone3, BlueCAPResourceListEmpty)  
--CASZoneNorth
USChief:SetStrategicZoneResourceOccupied(Bluecaszone1, BlueCASResource)
USChief:SetStrategicZoneResourceEmpty(Bluecaszone1, BlueResourceEmpty)  
--CASZoneSouth
USChief:SetStrategicZoneResourceOccupied(Bluecaszone2, BlueCASResource)
USChief:SetStrategicZoneResourceEmpty(Bluecaszone2, BlueResourceEmpty) 



--Start Chief
USChief:__Start(1)


-- Function called each time Chief Agents detect a new contact.
--function USChief:OnAfterNewContact(From, Event, To, Contact)
--
--  -- Gather info of contact.
--  local ContactName=USChief:GetContactName(Contact)
--  local ContactType=USChief:GetContactTypeName(Contact)
--  local ContactThreat=USChief:GetContactThreatlevel(Contact)
--  
--  -- Text message.
--  local text=string.format("Detected NEW contact: Name=%s, Type=%s, Threat Level=%d", ContactName, ContactType, ContactThreat)
--  
--  -- Show message in log file.
--  env.info(text)
--  
--end





---COMMANDERS---


--DEFINE BLUE COMMANDERS--
-- Create a commander.
local UScommander=COMMANDER:New(coalition.side.BLUE)

-- Add legions to commander.
UScommander:AddLegion(brigadeAlpha)
UScommander:AddLegion(brigadeBravo)
UScommander:AddLegion(brigadeDelta)
UScommander:AddLegion(brigadeEcho)
UScommander:AddLegion(brigadeGolf)
UScommander:AddAirwing(BlueAirWingAkrotiri)


-- Start UScommander. This also auto-starts all assigned legions.
UScommander:__Start(3)


--- Function called each time and OPS group is send on a mission.
--function UScommander:onafterOpsOnMission(From, Event, To, OpsGroup, Mission)
--  local opsgroup=OpsGroup --Ops.OpsGroup#OPSGROUP
--  local mission=Mission   --Ops.Auftrag#AUFTRAG
--  
--  -- Info message.
--  local text=string.format("Group %s is on %s mission %s", opsgroup:GetName(), mission:GetType(), mission:GetName())
--  MESSAGE:New(text, 360):ToAll()
--  env.info(text)
--end