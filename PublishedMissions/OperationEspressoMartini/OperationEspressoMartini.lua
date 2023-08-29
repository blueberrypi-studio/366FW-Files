--[[


OPERATION ESPRESSO MARTINI

by: TheDude

TODO

Armor Spawns Balanced
CTLD Tested
Waypoints for CTLD implemented (Make a mission specific Copy of CTLD Script)
Client Slots

Blue support forces: CAP, and Helo Escorts





]]--



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local DEBUG = true
local DEBUG_PARKING = false



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

local redAirCapEasyTemplates = {"MIG29A", "MIG31", "SU30"}
local redAirCapHardTemplates = {"M2000", "M2000C"}

local redCapZoneTable = { ZONE:New("RCAP1"), ZONE:New("RCAP2"), ZONE:New("RCAP3"), ZONE:New("RCAP4") }

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

--blueHQ = STATIC:FindByName("BLUEHQ")
redHQ = STATIC:FindByName("REDHQ")

---COMMANDCENTERS

--RED

RU_CC = COMMANDCENTER:New( GROUP:FindByName( "REDCC" ), "Russian Command" )
--US_CC = COMMANDCENTER:New( GROUP:FindByName( "BLUECC" ), "Allied Command")



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO DETECTION
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--BLUE

--DetectionSetGroupBlue = SET_GROUP:New()
--DetectionSetGroupBlue:FilterPrefixes( { "EWRBLUE", "AWACSBLUE", "FACBLUE", "JTACBLUE", "366th" } )
--DetectionSetGroupBlue:FilterStart()
--
--DetectionBlue = DETECTION_AREAS:New( DetectionSetGroupBlue, 30000 )

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


--Add Scoring Groups



--Add Static Scoring
--Scoring:AddStaticScore(STATIC:FindByName("WarehouseRedAlphaBrigade"), 200)
--Scoring:AddStaticScore(STATIC:FindByName("WarehouseRedBravoBrigade"), 200)
--Scoring:AddStaticScore(STATIC:FindByName("WarehouseRedAlphaAirBrigade"), 200)
--Scoring:AddStaticScore(STATIC:FindByName("WarehouseRedBravoAirBrigade"), 200)



Scoring:SetMessagesHit(false)
Scoring:SetMessagesDestroy(true)
Scoring:SetMessagesScore(true)


--Add Zone Scoring

--Set the Zone scoring multiplier to award a higher score for kills inside the engagement zone of the air defenses.

--ScoringMultiplierZone = ZONE:New( "DoubleScoreZone" )
--Scoring:AddZoneScore( ScoringMultiplierZone, 100 )


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


--BLUE SHORAD
--local samblueSET = SET_GROUP:New():FilterPrefixes("SAMBLUE"):FilterCoalitions("blue"):FilterStart()
-- usage: SHORAD:New(name, prefix, samset, radius, time, coalition)
--blueShorad = SHORAD:New("BlueShorad", "Blue SHORAD", samblueSET, 22000, 600, "blue")

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
--blueMantis = MANTIS:New( "Blue MANTIS", "SAMBLUE", "EWRBLUE", "BLUEHQ", "blue", true, "AWACSBLUE" )
--blueMantis:AddShorad(blueShorad, 720)

--if DEBUG then
--blueMantis:Debug(on)
--end

--blueMantis:Start()


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO BLUE REAPER DRONE
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


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










--AI TROOP TRANSPORT





--[[

    RED TROOP TRANSPORT SPAWN

]]--


--local cargoInfantryTemplates = {"RedInfantry", "RedInfantryManpad"}
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

--[[
--AMPHIBIOUS LANDING RED

local redCommandShip = GROUP:FindByName("RedCommandShip")

-- Zones.
local zoneRedSupplyShip=ZONE_GROUP:New("RedFor Supply Ship", GROUP:FindByName("RedSupplyShip"), 1000)
local zoneDeploy=ZONE:New("RedZoneSurf"):DrawZone()
local zoneBravo=ZONE:New("RedPatrolZone"):DrawZone()

-- USS Tarawa carrier.
local redSupplyShip=NAVYGROUP:New("RedSupplyShip")
redSupplyShip:SetPatrolAdInfinitum(false)
redSupplyShip:SetCarrierUnloaderBack(50, 40)
redSupplyShip:Activate()

-- Tansport assignment. The cargo groups are added later when we spawn them.
local transport=OPSTRANSPORT:New(nil, zoneRedSupplyShip, zoneDeploy)

-- Assign transport to Tarawa.
redSupplyShip:AddOpsTransport(transport)

-- Create a SPAWN object that will spawn late activated AAV-7, which are amphibious.
local spawnAPC=SPAWN:New("APC AAV-7 REDFOR"):InitLateActivated(true)

-- Create a SPAWN object that will spawn late activated Infantry.
local spawnInf=SPAWN:New("RIAPC"):InitLateActivated(true)


if redCommandShip:IsAlive() then

local shipTransportScheduler = SCHEDULER:New( nil,

  function()

  
  -- Spawn 5 APCs, create ARMYGROUPs, add each as cargo and load directly into the Tarawa.
    for i=1,5 do

    -- Create ARMYGROUP from spawned APC, add as cargo and load directly into the Tarawa.
    local apc=ARMYGROUP:New(spawnAPC:Spawn())
    transport:AddCargoGroups(apc)
    redSupplyShip:Load(apc)
  
    -- Create ARMYGROUP from spawned APC and load directly into the APC.
    local infgroup=ARMYGROUP:New(spawnInf:Spawn())
    apc:Load(infgroup)
    end



  end,{}, 10, 300, 0)
else 
return
end


    -- Mission to patrol zone bravo.
    local mission=AUFTRAG:NewPATROLZONE(zoneBravo)

    --- Function called when a cargo group is unloaded from a carrier.
function transport:OnAfterUnloaded(From, Event, To, OpsGroupCargo, OpsGroupCarrier)
  local apc=OpsGroupCargo --Ops.ArmyGroup#ARMYGROUP
  
  -- Add random waypoint in zone Bravo.
  local wp1=apc:AddWaypoint(zoneBravo:GetRandomCoordinate())
  
  -- Give cruise command.
  apc:__Cruise(5)
  
  --- Function called when the group passed a waypoint.
  function apc:OnAfterPassingWaypoint(From, Event, To, Waypoint)
    local waypoint=Waypoint --Ops.OpsGroup#OPSGROUP.Waypoint
    
    if waypoint.uid==wp1.uid then
    
      -- Get all cargo groups.
      local cargos=apc:GetCargoOpsGroups()
      
      for _,_infantrygroup in pairs(cargos) do
        local infantrygroup=_infantrygroup --Ops.ArmyGroup#ARMYGROUP
        
        -- Unload infantry near the carrier
        local Coordinate=apc:GetCoordinate():Translate(math.random(50, 100), math.random(0,360))          
        apc:Unload(infantrygroup, Coordinate, true)
        
        -- Assign patrol mission to infantry group.
        infantrygroup:AddMission(mission)
      end
      
    end
  end
  
end
]]

--Amphibious Rework

local redSupplyShip = GROUP:FindByName("RedSupplyShip")

local redArmorZones = { ZONE:New("RA1"), ZONE:New("RA2")}
local redArmorTemplates = { "REDFOR APC", "REDFOR BMP", "REDFOR T80", "REDFOR SHILKA"}

local redArmorGroupAlpha = ARMYGROUP:New("Red Armor Group Alpha")
local redArmorGroupBravo = ARMYGROUP:New("Red Armor Group Bravo")
local redArmorGroupCharlie = ARMYGROUP:New("Red Armor Group Charlie")


--[[


YOU HAVE ALOT OF SHIT TO DO HERE.  FIX THIS.


local redArmorMission = AUFTRAG:NewCAPTUREZONE()




]]

--RED FLIGHTGROUPS

--✈
--Red Squadrons

--CAP
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

--RED AIRWING

local redAirwingOne = AIRWING:New("WarehouseQeshm", "Mocha Frappe")


redAirwingOne:NewPayload("✈ MIG29S", 99, AUFTRAG.Type.CAP, 100)
redAirwingOne:NewPayload("✈ SU33", 99, AUFTRAG.Type.CAP, 100)
redAirwingOne:NewPayload("✈ MIRAGE2000", 99, AUFTRAG.Type.CAP, 100)

redAirwingOne:AddPatrolPointCAP(ZONE:New("REDCAPZONE"):GetCoordinate(),math.random(15000, 25000),math.random(300, 450),math.random(1,360),math.random(20, 50))
--redAirwing:SetAirbase(AIRBASE.Caucasus.Novorossiysk)

redAirwingOne:AddSquadron(redCapOne)
redAirwingOne:AddSquadron(redCapTwo)
redAirwingOne:AddSquadron(redCapThree)

redAirwingOne:Start()

redAirwingOne:SetTakeoffAir()
redAirwingOne:SetNumberCAP(2)


local missionRedCAPzone = AUFTRAG:NewCAP(redCAPzone, 15000, 350, nil, 90, 20, {"Air"})
missionRedCAPzone:SetRequiredAssets(2)
missionRedCAPzone:SetRepeatOnFailure(16)
missionRedCAPzone:SetROE(ENUMS.ROE.OpenFire)

redAirwingOne:AddMission(missionRedCAPzone)
