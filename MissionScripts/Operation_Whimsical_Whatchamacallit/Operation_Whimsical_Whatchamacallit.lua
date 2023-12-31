--[[

  Operation Whimsical Whatchamacallit
  
TODO

1.  Add air defense platoons to the brigades--done
2.  Thin out me templates
3.  Rebuild battlezone --nearly done
4.  Build Target List--done
5.  Build commander interface --done
6.  Build reaper set--not using more than likely
7.  Build ctld setup --done
8.  Build csar setup --NA
9.  Rebuild zone structure - check from zone list --zone structure tested in aitest1--done
10.  Add sounds to miz
11.  Build Script Load Triggers
12.  Fix awacs breaking srs/ to do this more than likely just establish an Orbit AUFTRAG using the persistent AWACS build, and just scratch the voice coms from awacs --done was Red side
13.  Shorad--done
14.  Mantis--done
15.  ADD RAT -- Needs more testing


Ideas-
For Balance purposes, give Red Chief more air assets than blue chief, or restrict the number of intercept and cap missions for blue with a higher number for red.
Possibly add Air defense brigades at spawn to SHORAD defense of the factory area


Balance Tests

AI Test1

Blue destroyed red.  Insane amount of abrams, balance this.
Very few red units.  Make more
Apparently Warehouses are now captureable based on zone coalition.  Blue captured reds warehouse, therefore leading to a shutdown of the red armor.  Interesting

Too many blue air units, limit auftrags, and limit grouping

AI Test2

AirDefence Auftrag is having issues --fixed needs balancing 

potential balancing issue is that there is no intel coming in, besides the awacs


Map statics is complete garbage.  Assign the bridges in briefing as TOO's as to limit reds ability to move more armor into zone.
There will not be score for bridges.  Not possible to do as the bridges are literally comprised of 100s of individual concrete walls....wtf ed pro "map making"

Assign static factories as targets
remove map scenery factory

remove scoring addition of scenery objects, this is going to cause a massive performance problem due to ED's lunacy.

red air needs restructuring, we pretty much went unimpeeded with very little risk.  hopefully some beautiful little manpads will do the trick.

AI Test3
1 hour test
No errors.
Blue started strong unfortunately this is the point where red is losing ALL initial air defenses.  You need a way to counter this, either by delaying the auftrags to the chief or delaying inital activation of chief the latter part is dirty
Red came back to win, took blues warehouse and therefore cutting chiefs assets to what was left alive.  initial suggestion is to change this, however after thinking about it this occured 40 minutes into the test.  By this point players
should have already completed set tasks.  Use this as a mission failure.
the main battle was fucking awesome to watch, if my machine can run it without stutters the server will be fine


FlightTest One

timing of sounds in the beginning of mission needs adjustment
static scores are working, check the factories, they may be made of multiple pieces.
set waypoints for all jets

TODO
reduce the number of blue cas in air, also move their spawns to a dedicated tarawa
address the brigades and specialize the units as to see a more diverse battlefield --done needs testing

change names of chief zones, as they are displayed in messages



Possible Future Changes,

It may be possible to make multiple target lists, this would allow for creating a strike package tailored to airframes.

Create sets of clients, use either a strike target name ie. ECHO, FOXTROT some shit.  Then for each of those clients run the sequencing of targets.

FOr this type of mission it would allow for sequential completion.  The cas guys would have their role and their targets, and the sead and strike guys would have their and so on.
For future missions.  DO THIS!

]]  




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SETUP
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

_SETTINGS:SetPlayerMenuOff()
_SETTINGS:SetImperial()
_SETTINGS:SetA2G_BR()
_SETTINGS:SetA2A_BRAA()


local DEBUG = false
local DEBUG_CHIEF = false
local DEBUG_COMMANDERS = false
local DEBUG_PARKING = false
local DEBUG_SHORAD = false
local DEBUG_SCORING = false

if DEBUG_CHIEF then
  BASE:TraceClass("CHIEF")
  BASE:TraceOn()
end

if DEBUG_COMMANDERS then
  BASE:TraceClass("COMMANDER")
  BASE:TraceOn()
end

if DEBUG_SCORING then
  BASE:TraceClass("SCORING")
  BASE:TraceOn()
end


if DEBUG_PARKING then
  AIRBASE:FindByName(AIRBASE.Caucasus.Sochi_Adler):MarkParkingSpots()
end

--Sochi
local Parking = ({63, 66, 69, 65, 62, 68, 64, 67, 61})

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SETUP SRS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local hereSRSPath = "C:\Program Files\DCS-SimpleRadio-Standalone"
--local hereSRSPath = "Z:\DCS-SimpleRadio-Standalone"
local hereSRSPort = 5002


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO ZONES
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local zone1 = ZONE:New("BLUECHIEF")
local zone2 = ZONE:New("REDCHIEF")
local zone3 = ZONE:New("BLUECAP")
local zone4 = ZONE:New("REDCAP")
local zone5 = ZONE:New("REDARMORSPAWN")
local zone6 = ZONE:New("BLUEARMORSPAWN")
local zone7 = ZONE:New("DRONEORBIT")


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

local noDamageStaticSet = SET_STATIC:New():FilterPrefixes("ND"):FilterStart()



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO EVENT HANDLERS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

clientSet:HandleEvent(EVENTS.Hit)
clientSet:HandleEvent(EVENTS.Dead)
clientSet:HandleEvent(EVENTS.Land)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SOUNDS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local smokeSound = "Target Smoke.ogg"
local startSound = "Korean War 3.ogg"
local taskQueueSound = "That Is Our Target.ogg"
local victorySound = "Campaign Victory 1.ogg"



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO MESSAGES
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local opStartMessage = MESSAGE:New("Welcome to Operation Whimsical Whatchamacallit",10)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO ATIS Sochi on 131.1 MHz AM
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--this is completely unneccessary and noone will use it.  consider pulling 
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

local CleanUpAirports = CLEANUP_AIRBASE:New( { AIRBASE.Caucasus.Sochi_Adler, AIRBASE.Caucasus.Novorossiysk } )


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO HEADQUARTERS/COMMANDCENTERS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local blueHQ = STATIC:FindByName("BLUEHQ")
local redHQ = STATIC:FindByName("REDHQ")

---COMMANDCENTERS

--RED

local RU_CC = COMMANDCENTER:New( GROUP:FindByName( "REDCC" ), "Russian Command" )
local US_CC = COMMANDCENTER:New( GROUP:FindByName( "BLUECC" ), "Allied Command")


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO DETECTION
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--BLUE

local DetectionSetGroupBlue = SET_GROUP:New()
  DetectionSetGroupBlue:FilterPrefixes( { "EWRBLUE", "AWACSBLUE", "FACBLUE", "JTACBLUE", "366th" } )
  DetectionSetGroupBlue:FilterStart()
  

  

local DetectionBlue = DETECTION_AREAS:New( DetectionSetGroupBlue, 30000 )

--RED
local DetectionSetGroupRed = SET_GROUP:New()
  DetectionSetGroupRed:FilterPrefixes({ "EWRRED", "AWACSRED", "FACRED", "JTACRED" })
  DetectionSetGroupRed:FilterStart()

local DetectionRed = DETECTION_AREAS:New( DetectionSetGroupRed, 30000 )

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO PLAYER TASK CONTROLLER
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Set up A2G task controller for the blue side named "82nd Airborne"
local taskmanager = PLAYERTASKCONTROLLER:New("366th Airwing",coalition.side.BLUE,PLAYERTASKCONTROLLER.Type.A2G)
  taskmanager:DisableTaskInfoMenu()
  taskmanager:EnableTaskInfoMenu()
  taskmanager:SetAllowFlashDirection(true)
  taskmanager:SetCallSignOptions(true,true,{Ford="Yankee"})
  taskmanager:SetLocale("en")
  taskmanager:SetMenuName("Inspector Gadget")
--  taskmanager:SetupIntel("JTACBLUE")


-- Set up using SRS

--HOW LONG ARE YOU GOING TO LET THIS SRS BULLSHIT BEAT YOU??

--taskmanager:SetSRS({130,255},{radio.modulation.AM,radio.modulation.AM},hereSRSPath,"female","en-US",hereSRSPort,"Microsoft Hazel Desktop",0.7,hereSRSGoogle)

--taskmanager:SetSRSBroadcast({127.5,305},{radio.modulation.AM,radio.modulation.AM})

  taskmanager:SetTargetRadius(5000)
  --add detection to inspectorgadget



function taskmanager:OnAfterTaskTargetSmoked(From,Event,To,Task)
  local radio = USERSOUND:New(smokeSound):ToCoalition(coalition.side.BLUE)
end

function taskmanager:OnAfterTaskTargetFlared(From,Event,To,Task)
  local radio = USERSOUND:New(smokeSound):ToCoalition(coalition.side.BLUE)
end

function taskmanager:OnAfterTaskTargetIlluminated(From,Event,To,Task)
  local radio = USERSOUND:New(smokeSound):ToCoalition(coalition.side.BLUE)
end


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO SCORING
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local missionScoring = SCORING:New("Operation Whimsical Whatchamacallit")

  missionScoring:SetScaleDestroyScore( 10 )
  missionScoring:SetScaleDestroyPenalty( 40 )

  missionScoring:SetMessagesHit(false)
  missionScoring:SetMessagesDestroy(false)
  missionScoring:SetMessagesScore(false)
  
  

--remember to assign targets after declaration

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SETUP SHORAD
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--RED

local redSamSet = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes("Red AAA", "Red SA8", "Red SA15", "EWRRED"):FilterStart()

local redShorad = SHORAD:New("Fun Factory SHORAD", "Red Shorad", redSamSet, 12000, 600, "red", false)
  
  redShorad:SetDefenseLimits(80, 95)
  

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SETUP MANTIS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local redMantis = MANTIS:New("Fun Factory AAA", "Red AAA", "EWRRED", nil, "red", true, "AWACSRED", false)

  redMantis:SetSAMRadius(UTILS.NMToMeters(40))
  redMantis:SetSAMRange(85)
  redMantis:SetDetectInterval(20)
  redMantis:SetAutoRelocate(true, true)
  
  redMantis:Start()
  
  
local redSA10 = MANTIS:New("Fun Factory SA10", "Red SA10", "EWRRED", nil, "red", true, "AWACSRED", false)

  redSA10:SetSAMRadius(UTILS.NMToMeters(40))
  redSA10:SetSAMRange(90)
  redSA10:SetDetectInterval(20)
  redSA10:AddShorad(redShorad,720)
--  redSA10:SetAdvancedMode(true,90)
  redSA10:SetAutoRelocate(false,false)


  redSA10:Start()

local redSA12 = MANTIS:New("Fun Factory SA12", "Red SA12", "EWRRED", nil, "red", true, "AWACSRED", false)

  redSA12:SetSAMRadius(UTILS.NMToMeters(40))
  redSA12:SetSAMRange(90)
  redSA12:SetDetectInterval(20)
  redSA12:AddShorad(redShorad,720)
--  redSA12:SetAdvancedMode(true,90)
  redSA12:SetAutoRelocate(false,false)

  redSA12:Start()

local redSA2 = MANTIS:New("Fun Factory SA2", "Red SA2", "EWRRED", nil, "red", true, "AWACSRED", false)

  redSA2:SetSAMRadius(UTILS.NMToMeters(40))
  redSA2:SetSAMRange(90)
  redSA2:SetDetectInterval(20)
  redSA2:AddShorad(redShorad,720)
--  redSA2:SetAdvancedMode(true,90)
  redSA2:SetAutoRelocate(false,false)

  redSA2:Start()


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SHORAD DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if DEBUG_SHORAD then

  redMantis:Debug(true)
  redSA10:Debug(true)
  redSA12:Debug(true)
  redSA2:Debug(true)

--SA10 DEBUG
function redSA10:OnAfterShoradActivated(From, Event, To, Name, Radius, Ontime)
  -- show some info
  local m = MESSAGE:New(string.format("Mantis switched on Shorad for %s | Radius %d | OnTime %d", Name, Radius, Ontime),10,"Info"):ToAll()
end

function redSA10:OnAfterAdvStateChange(From, Event, To, Oldstate, Newstate, Interval)
    -- show some info
  local state = { [1] = "GREEN", [2] = "AMBER", [3] = "RED" }
  local oldstate = state[Oldstate+1]
  local newstate = state[Newstate+1]
  local m = MESSAGE:New(string.format("Mantis switched Advanced from from %s to %s interval %dsec", oldstate, newstate, Interval),10,"Info"):ToAll()
end

function redSA10:OnAfterRedState(From, Event, To, Group)
   -- show some info
  local SamName = Group:GetName()
  local m = MESSAGE:New(string.format("Mantis switched %s to RED state!", SamName),10,"Info"):ToAll()
end

function redSA10:OnAfterGreenState(From, Event, To, Group)
   -- show some info
  local SamName = Group:GetName()
  local m = MESSAGE:New(string.format("Mantis switched %s to GREEN state!", SamName),10,"Info"):ToAll()
end

--SA12 DEBUG

function redSA12:OnAfterShoradActivated(From, Event, To, Name, Radius, Ontime)
  -- show some info
  local m = MESSAGE:New(string.format("Mantis switched on Shorad for %s | Radius %d | OnTime %d", Name, Radius, Ontime),10,"Info"):ToAll()
end

function redSA12:OnAfterAdvStateChange(From, Event, To, Oldstate, Newstate, Interval)
    -- show some info
  local state = { [1] = "GREEN", [2] = "AMBER", [3] = "RED" }
  local oldstate = state[Oldstate+1]
  local newstate = state[Newstate+1]
  local m = MESSAGE:New(string.format("Mantis switched Advanced from from %s to %s interval %dsec", oldstate, newstate, Interval),10,"Info"):ToAll()
end

function redSA12:OnAfterRedState(From, Event, To, Group)
   -- show some info
  local SamName = Group:GetName()
  local m = MESSAGE:New(string.format("Mantis switched %s to RED state!", SamName),10,"Info"):ToAll()
end

function redSA12:OnAfterGreenState(From, Event, To, Group)
   -- show some info
  local SamName = Group:GetName()
  local m = MESSAGE:New(string.format("Mantis switched %s to GREEN state!", SamName),10,"Info"):ToAll()
end

--SA2 DEBUG

function redSA2:OnAfterShoradActivated(From, Event, To, Name, Radius, Ontime)
  -- show some info
  local m = MESSAGE:New(string.format("Mantis switched on Shorad for %s | Radius %d | OnTime %d", Name, Radius, Ontime),10,"Info"):ToAll()
end

function redSA2:OnAfterAdvStateChange(From, Event, To, Oldstate, Newstate, Interval)
    -- show some info
  local state = { [1] = "GREEN", [2] = "AMBER", [3] = "RED" }
  local oldstate = state[Oldstate+1]
  local newstate = state[Newstate+1]
  local m = MESSAGE:New(string.format("Mantis switched Advanced from from %s to %s interval %dsec", oldstate, newstate, Interval),10,"Info"):ToAll()
end

function redSA2:OnAfterRedState(From, Event, To, Group)
   -- show some info
  local SamName = Group:GetName()
  local m = MESSAGE:New(string.format("Mantis switched %s to RED state!", SamName),10,"Info"):ToAll()
end

function redSA2:OnAfterGreenState(From, Event, To, Group)
   -- show some info
  local SamName = Group:GetName()
  local m = MESSAGE:New(string.format("Mantis switched %s to GREEN state!", SamName),10,"Info"):ToAll()
end


end


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO SCENERY OBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

local bridge1 = SCENERY:FindByNameInZone("74252386",ZONE:FindByName("roadbridge1"))
local bridge2 = SCENERY:FindByNameInZone("74252524",ZONE:FindByName("roadbridge2"))
local bridge3 = SCENERY:FindByNameInZone("74252567",ZONE:FindByName("roadbridge3"))
local bridge4 = SCENERY:FindByNameInZone("74252628",ZONE:FindByName("roadbridge4"))
local bridge5 = SCENERY:FindByNameInZone("74252797",ZONE:FindByName("roadbridge5"))
local bridge6 = SCENERY:FindByNameInZone("74252804",ZONE:FindByName("roadbridge6"))
local bridge7 = SCENERY:FindByNameInZone("74252817",ZONE:FindByName("roadbridge7"))
local bridge8 = SCENERY:FindByNameInZone("74252923",ZONE:FindByName("roadbridge8"))

local railBridge1 = SCENERY:FindByNameInZone("74810038",ZONE:FindByName("railbridge1"))
local railBridge2 = SCENERY:FindByNameInZone("74252420",ZONE:FindByName("railbridge2"))

--these are cooling towers you idiot not chemtanks
local chemTank1 = SCENERY:FindByNameInZone('102269512',ZONE:FindByName("chemtank1"))
local chemTank2 = SCENERY:FindByNameInZone('102269448',ZONE:FindByName("chemtank2"))

local factory1 = SCENERY:FindByNameInZone('80152029',ZONE:FindByName("factory1"))
local factory2 = SCENERY:FindByNameInZone('80152028',ZONE:FindByName("factory2"))
local factory3 = SCENERY:FindByNameInZone('80152030',ZONE:FindByName("factory3"))
local factory4 = SCENERY:FindByNameInZone('80152031',ZONE:FindByName("factory4"))



local sceneryTable = {bridge1, bridge2, bridge3, bridge4, bridge5, bridge6, bridge7, bridge8, railBridge1, railBridge2, chemTank1, chemTank2, factory1, factory2, factory3, factory4}

  for i, scenery in ipairs(sceneryTable) do
    local scenery = scenery
      missionScoring:AddStaticScore(scenery,250)
      scenery:SmokeRed()    
  end

]]

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO HVT's for SCORING
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--local smokeZONE = ZONE:New("SMOKEZONE")
--  
--  smokeZONE:Scan(Object.Category.UNIT, Unit.Category.GROUND_UNIT)
--  
--local clientInZone = smokeZONE:IsSomeInZoneOfCoalition(1)




--static zoneset
local staticZONE = SET_ZONE:New():FilterPrefixes("CAPTUREZONE"):FilterOnce()
--static set filtered by zone
local HVTstatics = SET_STATIC:New():FilterZones(staticZONE):FilterCoalitions("red"):FilterOnce()


--function called for each red static in zone
HVTstatics:ForEachStatic(

  function(SpawnStatic)
    local target = SpawnStatic
    local name = target:GetName()
    
    if DEBUG_SCORING then
    local message = MESSAGE:New(string.format(name),10,"DEBUGINFO")
          message:ToAll()
    end
    
    local staticObj = STATIC:FindByName(string.format(name))
    
      missionScoring:AddStaticScore(staticObj, 250 )
      

  end)
  
  
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO CIV BUILDINGS for SCORING
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local civBuild = SET_STATIC:New():FilterZones(staticZONE):FilterCoalitions("neutral"):FilterOnce()



  civBuild:ForEachStatic(
    
    function(SpawnStatic)
      

      local static = SpawnStatic
      local name = static:GetName()
      
      if DEBUG_SCORING then
      local message = MESSAGE:New(string.format(name),10,"DEBUGINFO")
        message:ToAll()
        
      end
    
      local staticObj = STATIC:FindByName(string.format(name))
      
        missionScoring:AddStaticScore(staticObj, -500)
        

    end)



  

  
 





-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO TARGET TABLE
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Define Operation Targets

local operationTargets = { 
  [1] = {       
    TargetName = "EWRRED GIZMO",
    TargetStatic = false,
    TargetBriefing = "Destroy the Early Warning Radar",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [2] = {       
    TargetName = "EWRRED GADGET",
    TargetStatic = false,
    TargetBriefing = "Destroy the Early Warning Radar",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [3] = {       
    TargetName = "RU Supply Train Thingie",
    TargetStatic = false,
    TargetBriefing = "Destroy the Train",
    TargetAuftrag = AUFTRAG.Type.GROUNDATTACK,
  },
  [4] = {       
    TargetName = "RU Supply Train Thangie",
    TargetStatic = false,
    TargetBriefing = "Destroy the Train",
    TargetAuftrag = AUFTRAG.Type.GROUNDATTACK,
  },
  [5] = {       
    TargetName = "WarehouseRedAlphaBrigade",
    TargetStatic = true,
    TargetBriefing = "Destroy the Warehouse",
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

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO OPERATION PHASES
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




--Setup Operation
local operation = OPERATION:New("Operation Whimsical Whatchamacallit")


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
operation:__Start(20)


--Operation Start Sound
function InitialSound()
  local radio = USERSOUND:New(startSound):ToCoalition(coalition.side.BLUE)
end

local Stimer = TIMER:New(InitialSound)
Stimer:Start(60)

  

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
  local radio = USERSOUND:New(taskQueueSound):ToCoalition(coalition.side.BLUE)
end 
  
  
-- Operation finished
function operation:OnAfterOver(From,Event,To,Phase)
  MESSAGE:New("Operation Whimsical Whatchamacallit Victory!!",15):ToBlue()
  local radio = USERSOUND:New(victorySound):ToCoalition(coalition.side.BLUE)
end







-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO REDFOR
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Red Platoons

--Red Alpha Air Defense
local strelaPlatoonAlpha = PLATOON:New( "Strela", 15, "Strela Alpha" )
  strelaPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE, 100 )
  strelaPlatoonAlpha:SetSkill(AI.Skill.EXCELLENT)
  strelaPlatoonAlpha:SetMissionRange(4)


local geckoPlatoonAlpha = PLATOON:New( "SA8 Gecko", 15, "SA8 Gecko Alpha" )
  geckoPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE, 100 )
  geckoPlatoonAlpha:SetSkill(AI.Skill.EXCELLENT)
  geckoPlatoonAlpha:SetMissionRange(4)

local shilkaPlatoonAlpha = PLATOON:New( "ZSU-23 Shilka", 15, "ZSU-23 Shilka Alpha" )
  shilkaPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE, 100 )
  shilkaPlatoonAlpha:SetSkill(AI.Skill.EXCELLENT)
  shilkaPlatoonAlpha:SetMissionRange(4)

--Red Tanks

local t80uPlatoonAlpha = PLATOON:New( "T80U", 35, "T80U Alpha")
  t80uPlatoonAlpha:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.CAPTUREZONE }, 100)
  t80uPlatoonAlpha:SetSkill(AI.Skill.EXCELLENT)
  t80uPlatoonAlpha:SetMissionRange(4)



local t90PlatoonAlpha = PLATOON:New( "T90", 35, "T90 Alpha")
  t90PlatoonAlpha:AddMissionCapability({AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.CAPTUREZONE}, 95)
  t90PlatoonAlpha:SetSkill(AI.Skill.EXCELLENT)
  t90PlatoonAlpha:SetMissionRange(4)


local t72PlatoonAlpha = PLATOON:New( "T72B3", 35, "T72B3 Alpha")
  t72PlatoonAlpha:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.ONGUARD}, 100)
  t72PlatoonAlpha:SetSkill(AI.Skill.EXCELLENT)
  t72PlatoonAlpha:SetMissionRange(4)
  
  

--RED ARMOR BRIGADES
local redBrigadeArmorAlpha = BRIGADE:New( "WarehouseRedAlphaBrigade", "Jelly Rolls")

  redBrigadeArmorAlpha:AddPlatoon(strelaPlatoonAlpha)
  redBrigadeArmorAlpha:AddPlatoon(geckoPlatoonAlpha)
  redBrigadeArmorAlpha:AddPlatoon(shilkaPlatoonAlpha)
  redBrigadeArmorAlpha:AddPlatoon(t80uPlatoonAlpha)
  redBrigadeArmorAlpha:AddPlatoon(t90PlatoonAlpha)
  redBrigadeArmorAlpha:AddPlatoon(t72PlatoonAlpha)
  redBrigadeArmorAlpha:SetSpawnZone(zone5)
  redBrigadeArmorAlpha:Start()
  
--REDFOR SQUADRONS

--CAP
local redCapOne=SQUADRON:New("MIG29S", 16, "MIG29S") --Ops.Squadron#SQUADRON
  redCapOne:AddMissionCapability({AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5, AUFTRAG.Type.INTERCEPT}, 90)
  redCapOne:SetModex(100)--you can also set a prefix here
  redCapOne:SetSkill(AI.Skill.ACE)
  redCapOne:SetTakeoffHot()
  redCapOne:SetDespawnAfterHolding(true)

--INTERCEPT
local redIntOne=SQUADRON:New("MIG31", 16, "MIG31") --Ops.Squadron#SQUADRON
  redIntOne:AddMissionCapability({AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.ALERT5}, 90)
  redIntOne:SetModex(100)
  redIntOne:SetSkill(AI.Skill.ACE)
  redIntOne:SetTakeoffHot()
  redIntOne:SetDespawnAfterHolding(true)

--CAS
local redCasOne=SQUADRON:New("KA50", 16, "KA50")
  redCasOne:AddMissionCapability(AUFTRAG.Type.CAS, 80)
  redCasOne:SetTakeoffAir()
  redCasOne:SetModex(100)
  redCasOne:SetSkill(AI.Skill.ACE)
  redCasOne:SetDespawnAfterHolding(true)



--Awacs
local AwacsRedSquadron = SQUADRON:New("AWACSRED", 2, "AWACSRED")
  AwacsRedSquadron:AddMissionCapability({AUFTRAG.Type.ORBIT},100)
  AwacsRedSquadron:SetFuelLowRefuel(true)
  AwacsRedSquadron:SetFuelLowThreshold(0.2)
  AwacsRedSquadron:SetTurnoverTime(10,20)
  AwacsRedSquadron:SetTakeoffAir()

  
  
--RED AIRWING

local redAirwing = AIRWING:New("WarehouseNovoAirwing", "Jelly Smashers")


  redAirwing:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Novorossiysk))
  redAirwing:SetMarker(false)
  redAirwing:SetReportOff()

  redAirwing:NewPayload("MIG31", 99, AUFTRAG.Type.INTERCEPT, 100)
  redAirwing:NewPayload("MIG29S", 99, AUFTRAG.Type.CAP, 100)
  redAirwing:NewPayload("KA50", 99, AUFTRAG.Type.CAS, 100)
  redAirwing:NewPayload("AWACSRED",-1,{AUFTRAG.Type.ORBIT},100)
  
  
  redAirwing:AddSquadron(redCapOne)
  redAirwing:AddSquadron(redIntOne)
  redAirwing:AddSquadron(redCasOne)
  redAirwing:AddSquadron(AwacsRedSquadron)
  
  redAirwing:SetNumberAWACS(1)
    
  redAirwing:Start()


  
--MISSIONS

--Awacs Orbit
local missionRedAwacsOrbit = AUFTRAG:NewORBIT(ZONE:FindByName("REDAWACSORBIT"):GetCoordinate(), 35000, 350, 90, 40)
  missionRedAwacsOrbit:SetRequiredAssets(1)
  missionRedAwacsOrbit:SetRepeatOnFailure(99)
  
--Red Capture Mission
local missionRedCaptureZone1=AUFTRAG:NewCAPTUREZONE(opzone1, coalition.side.RED)
  missionRedCaptureZone1:SetRequiredAssets(12)
  missionRedCaptureZone1:SetRepeatOnFailure(99)
  missionRedCaptureZone1:SetROE(ENUMS.ROE.OpenFire)

--Red CAP Mission for MainClashZone
local missionRedCAPzone2 = AUFTRAG:NewCAP(zone4, 15000, 350, nil, 90, 20, {"Air"})
  missionRedCAPzone2:SetRequiredAssets(2)
  missionRedCAPzone2:SetRepeatOnFailure(5)
  missionRedCAPzone2:SetROE(ENUMS.ROE.OpenFire)

--Red CAS Mission for MainClashZone
local missionRedCASzone2 = AUFTRAG:NewCAS(zone10, 8000, 250)
  missionRedCASzone2:SetRequiredAssets(2)
  missionRedCASzone2:SetRepeatOnFailure(5)
  missionRedCASzone2:SetROE(ENUMS.ROE.OpenFire)

--Air Defense Missions -- 
local missionRedAirDefenseOne = AUFTRAG:NewAIRDEFENSE(zone10)
  missionRedAirDefenseOne:SetRequiredAssets(5)
  missionRedAirDefenseOne:SetRepeatOnFailure(99)
  missionRedAirDefenseOne:SetROE(ENUMS.ROE.OpenFireWeaponFree)





--RED CHIEF

--Agents
local RedAgents = DetectionSetGroupRed

--Define the CHIEF.  
local RUChief=CHIEF:New(coalition.side.RED, RedAgents)

--Add border zone.
  RUChief:AddBorderZone(zone2)

--Enable tactical overview.
--RUChief:SetTacticalOverviewOn()

--Response on targets
  RUChief:SetResponseOnTarget(1, 2, 1, TARGET.Category.AIRCRAFT, AUFTRAG.Type.INTERCEPT)
  RUChief:SetResponseOnTarget(8, 10, 0, TARGET.Category.ZONE, AUFTRAG.Type.CAPTUREZONE)


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
  RUChief:AddMission(missionRedAwacsOrbit)

  RUChief:SetLimitMission(2, AUFTRAG.Type.CAS)
  RUChief:SetLimitMission(2, AUFTRAG.Type.CAP)
  RUChief:SetLimitMission(6, AUFTRAG.Type.CAPTUREZONE)
  RUChief:SetLimitMission(2, AUFTRAG.Type.INTERCEPT)
  RUChief:SetLimitMission(6, AUFTRAG.Type.AIRDEFENSE)
  RUChief:SetLimitMission(1, AUFTRAG.Type.ORBIT)

--RED RESOURCES
-- Add strategic (OPS) zones.
local RedStratZone1 =RUChief:AddStrategicZone(opzone1, 100, 100)

--Red Chief Resources

local RedCAPTUREResourceOccupied = RUChief:CreateResource(AUFTRAG.Type.CAPTUREZONE, 10, 16, nil, nil)
--RUChief:AddToResource(RedCAPTUREResourceOccupied, AUFTRAG.Type.PATROLZONE, 10, 16, nil, nil)
--RUChief:AddToResource(RedCAPTUREResourceOccupied, AUFTRAG.Type.AIRDEFENSE, 6, 8, nil, nil)

local RedCAPTUREResourceEmpty = RUChief:CreateResource(AUFTRAG.Type.ONGUARD, 10, 16)
--RUChief:AddToResource(RedCAPTUREResourceEmpty, AUFTRAG.Type.PATROLZONE, 10, 13)
--RUChief:AddToResource(RedCAPTUREResourceEmpty, AUFTRAG.Type.AIRDEFENSE, 6, 8, nil, nil)

--Assign StratZones to resource lists

--StratZone1 - CAPTUREZONE
  RUChief:SetStrategicZoneResourceOccupied(RedStratZone1, RedCAPTUREResourceOccupied)
  RUChief:SetStrategicZoneResourceEmpty(RedStratZone1, RedCAPTUREResourceEmpty)


--Start Chief
  RUChief:Start(10)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO BLUEFOR
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--BLUE PLATOONS

--Blue Mobile Air Defense
--Alpha Platoon
local rolandPlatoonAlpha = PLATOON:New( "Roland", 15, "Roland Alpha" )
rolandPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE, 100 )
rolandPlatoonAlpha:SetSkill(AI.Skill.EXCELLENT)

local chaparralPlatoonAlpha = PLATOON:New( "Chaparral", 15, "Chaparral Alpha" )
chaparralPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE, 100 )
chaparralPlatoonAlpha:SetSkill(AI.Skill.EXCELLENT)


local avengerPlatoonAlpha = PLATOON:New( "Avenger", 15, "Avenger Alpha" )
avengerPlatoonAlpha:AddMissionCapability( AUFTRAG.Type.AIRDEFENSE, 100 )
avengerPlatoonAlpha:SetSkill(AI.Skill.EXCELLENT)

--Blue Tanks

--☮
--Alpha Platoons

local abramsPlatoonAlpha = PLATOON:New( "M1A2 Abrams", 15, "M1A2 Abrams Alpha")
  abramsPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
  abramsPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
  abramsPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.ONGUARD, 70)
  abramsPlatoonAlpha:SetSkill(AI.Skill.EXCELLENT)

local strykermgsPlatoonAlpha = PLATOON:New( "Stryker MGS", 15, "Stryker MGS Alpha")
  strykermgsPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
  strykermgsPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.CAPTUREZONE, 80)
  strykermgsPlatoonAlpha:SetSkill(AI.Skill.EXCELLENT)

local strykeratgmPlatoonAlpha = PLATOON:New( "ATGM Stryker", 15, "ATGM Stryker Alpha")
  strykeratgmPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.GROUNDATTACK, 80)
  strykeratgmPlatoonAlpha:AddMissionCapability(AUFTRAG.Type.ONGUARD, 70)
  strykeratgmPlatoonAlpha:SetSkill(AI.Skill.EXCELLENT)
  
  
local jtacPlatoon = PLATOON:New("JTACBLUE",25,"JTACBLUE")
  jtacPlatoon:AddMissionCapability(AUFTRAG.Type.RECON,100)
  jtacPlatoon:SetSkill(AI.Skill.EXCELLENT)

--Blue Armor Brigades

local blueBrigadeArmorAlpha = BRIGADE:New( "WarehouseBlueAlphaBrigade", "Crunchy Peanutbutter")
  blueBrigadeArmorAlpha:AddPlatoon(rolandPlatoonAlpha)
  blueBrigadeArmorAlpha:AddPlatoon(chaparralPlatoonAlpha)
  blueBrigadeArmorAlpha:AddPlatoon(avengerPlatoonAlpha)
  blueBrigadeArmorAlpha:AddPlatoon(abramsPlatoonAlpha)
  blueBrigadeArmorAlpha:AddPlatoon(strykermgsPlatoonAlpha)
  blueBrigadeArmorAlpha:AddPlatoon(strykeratgmPlatoonAlpha)
  blueBrigadeArmorAlpha:AddPlatoon(jtacPlatoon)
  blueBrigadeArmorAlpha:SetSpawnZone(zone6)
  blueBrigadeArmorAlpha:Start()

--BLUE SQUADRONS

--CAP
local blueCapOne=SQUADRON:New("F18C", 8, "F18C") --Ops.Squadron#SQUADRON
  blueCapOne:AddMissionCapability(AUFTRAG.Type.CAP)
  blueCapOne:SetModex(100)
  blueCapOne:SetCallsign(CALLSIGN.Aircraft.Ford)
  blueCapOne:SetParkingIDs(Parking)
  blueCapOne:SetTakeoffHot()
  blueCapOne:SetDespawnAfterHolding(true)
  blueCapOne:SetSkill(AI.Skill.ACE)

--INTERCEPT
local blueIntOne=SQUADRON:New("F14B", 8, "F14B") --Ops.Squadron#SQUADRON
  blueIntOne:AddMissionCapability(AUFTRAG.Type.INTERCEPT)
  blueIntOne:SetModex(100)
  blueIntOne:SetCallsign(CALLSIGN.Aircraft.Pontiac)
  blueIntOne:SetParkingIDs(Parking)
  blueIntOne:SetTakeoffHot()
  blueIntOne:SetDespawnAfterHolding(true)
  blueIntOne:SetSkill(AI.Skill.ACE)

--CAS
local blueCasOne=SQUADRON:New("AH64DCAS", 16, "AH64DCAS")
  blueCasOne:AddMissionCapability(AUFTRAG.Type.CAS, 100)
  blueCasOne:SetModex(100)
  blueCasOne:SetSkill(AI.Skill.ACE)
  blueCasOne:SetTakeoffAir()


--RECON
local blueRecon=SQUADRON:New("JTACBLUE Reaper", 8, "JTACBLUE Reaper")
  blueRecon:AddMissionCapability(AUFTRAG.Type.ORBIT, 100)
  blueRecon:SetCallsign(CALLSIGN.JTAC.Deathstar)
  blueRecon:SetSkill(AI.Skill.ACE)
  blueRecon:SetTakeoffAir()
  blueRecon:SetModex(100)


--BLUE AIRWING

local blueAirwing = AIRWING:New("WarehouseSochiAirwing", "Peanut Butter Crackers")

  blueAirwing:NewPayload("F14B", 99, AUFTRAG.Type.INTERCEPT, 100)
  blueAirwing:NewPayload("F18C", 99, AUFTRAG.Type.CAP, 100)
  blueAirwing:NewPayload("JTACBLUE Reaper", 99, AUFTRAG.Type.ORBIT, 100)

  blueAirwing:AddSquadron(blueCapOne)
  blueAirwing:AddSquadron(blueIntOne)
--  blueAirwing:AddSquadron(blueRecon)
  blueAirwing:Start()

--Tarawa Airwing

local blueCasAirwing = AIRWING:New("APACHEWAREHOUSE", "Jolly Ranchers")

  blueCasAirwing:NewPayload("AH64DCAS", 99, AUFTRAG.Type.CAS, 100)
  blueCasAirwing:AddSquadron(blueCasOne)

  
  blueCasAirwing:Start()

--BLUE AWACS
-- We need an AirWing
local AwacsBlue = AIRWING:New("WarehouseSochiAwacsAirwing", "AWACSBLUE")
--  AwacsBlue:SetReportOn()
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
local AwacsEscortsBlue = SQUADRON:New("F14BESCORT",4,"F14BESCORT")
  AwacsEscortsBlue:AddMissionCapability({AUFTRAG.Type.ESCORT})
  AwacsEscortsBlue:SetFuelLowRefuel(true)
  AwacsEscortsBlue:SetFuelLowThreshold(0.3)
  AwacsEscortsBlue:SetTurnoverTime(10,20)
  AwacsEscortsBlue:SetTakeoffAir()
  AwacsEscortsBlue:SetRadio(275,radio.modulation.AM)
  AwacsBlue:AddSquadron(AwacsEscortsBlue)
  AwacsBlue:NewPayload("F14BESCORT",-1,{AUFTRAG.Type.ESCORT},100)


local AwacsBlue = AWACS:New("Awacs-Blue", AwacsBlue, "blue", AIRBASE.Caucasus.Sochi_Adler, "BLUEAWACSORBIT", ZONE:FindByName("BLUECHIEF"), "BLUECAP", 264, radio.modulation.AM )

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





--MISSIONS
--Blue Capture Mission to Take Main Clash Zone
local missionBlueCaptureZone6 = AUFTRAG:NewCAPTUREZONE(opzone1, coalition.side.BLUE)
  missionBlueCaptureZone6:SetROE(ENUMS.ROE.OpenFireWeaponFree)
  missionBlueCaptureZone6:SetRequiredAssets(6)
  missionBlueCaptureZone6:SetRepeatOnFailure(10)

--Blue CAP Mission for MainClashZone
local missionBlueCAPzone2 = AUFTRAG:NewCAP(zone3, 15000, 350, nil, 90, 20, {"Air"})
  missionBlueCAPzone2:SetRequiredAssets(2)
  missionBlueCAPzone2:SetRepeatOnFailure(20)
  missionBlueCAPzone2:SetROE(ENUMS.ROE.OpenFireWeaponFree)

--Blue CAS Mission for MainClashZone
local missionBlueCASzone2 = AUFTRAG:NewCAS(zone10, 5000, 250, nil, 90, 5, {"Ground Units"})
  missionBlueCASzone2:SetRequiredAssets(2)
  missionBlueCASzone2:SetRepeatOnFailure(15)
  missionBlueCASzone2:SetROE(ENUMS.ROE.OpenFireWeaponFree)

--Air Defense Missions -- use Capzones Zone7 Zone8 Zone9
local missionBlueAirDefenseOne = AUFTRAG:NewAIRDEFENSE( ZONE:FindByName("adZone1") )
  missionBlueAirDefenseOne:SetRequiredAssets(2)
  missionBlueAirDefenseOne:SetRepeatOnFailure(15)
  missionBlueAirDefenseOne:SetROE(ENUMS.ROE.OpenFireWeaponFree)
  
local missionBlueAirDefenseTwo = AUFTRAG:NewAIRDEFENSE( ZONE:FindByName("adZone2") )
  missionBlueAirDefenseTwo:SetRequiredAssets(2)
  missionBlueAirDefenseTwo:SetRepeatOnFailure(15)
  missionBlueAirDefenseTwo:SetROE(ENUMS.ROE.OpenFireWeaponFree)
  
local missionBlueAirDefenseThree = AUFTRAG:NewAIRDEFENSE( ZONE:FindByName("adZone3") )
  missionBlueAirDefenseThree:SetRequiredAssets(2)
  missionBlueAirDefenseThree:SetRepeatOnFailure(15)
  missionBlueAirDefenseThree:SetROE(ENUMS.ROE.OpenFireWeaponFree) 

--Blue RECON Mission for Drone
local missionBlueRecon = AUFTRAG:NewORBIT(zone7:GetCoordinate(), 45000, 300, 90, 30)
  missionBlueRecon:SetRequiredAssets(1)
  missionBlueRecon:SetRepeatOnFailure(99)
  missionBlueRecon:SetROE(ENUMS.ROE.OpenFireWeaponFree)
  
--Blue Recon Mission for JTAC

--create zoneset for recon
local reconZoneSet = SET_ZONE:New():FilterPrefixes("wpzone"):FilterOnce()

local missionBlueJtac = AUFTRAG:NewRECON(reconZoneSet, 6, nil, true, true, nil)
  missionBlueJtac:SetRequiredAssets(1)
  missionBlueJtac:SetRepeatOnFailure(99)
  missionBlueJtac:SetROE(ENUMS.ROE.ReturnFire)

--Apache Commander for testing

--local ApCommander = COMMANDER:New(coalition.side.BLUE, "Apache Command")
--
--
--  ApCommander:AddAirwing(blueCasAirwing)
--  
--  ApCommander:AddMission(missionBlueCASzone2)
--  
--  
--  ApCommander:Start()









--BLUE
--Agents
local BlueAgents = DetectionSetGroupBlue
--Define the CHIEF.  
local USChief=CHIEF:New(coalition.side.BLUE, BlueAgents)
--Add border zone.
USChief:AddBorderZone(zone1)
--Enable tactical overview.

if DEBUG then
USChief:SetTacticalOverviewOn()
end

--Response on targets

USChief:SetResponseOnTarget(2, 2, 2, TARGET.Category.AIRCRAFT, AUFTRAG.Type.INTERCEPT)
--USChief:SetResponseOnTarget(2, 4, 2, TARGET.Category.GROUND, AUFTRAG.Type.CAS)
USChief:SetResponseOnTarget(2, 4, 3, TARGET.Category.ZONE, AUFTRAG.Type.CAPTUREZONE)

--Strategy--  ADJUST THIS IF TOO MUCH

USChief:SetStrategy(USChief.Strategy.AGGRESSIVE)

--ADD BRIGADES

USChief:AddBrigade(blueBrigadeArmorAlpha)

--ADD AIRWINGS

USChief:AddAirwing(blueAirwing)
--USChief:AddAirwing(blueCasAirwing)

--ADD MISSIONS

USChief:AddMission(missionBlueCaptureZone6)
USChief:AddMission(missionBlueCAPzone2)
--USChief:AddMission(missionBlueCASzone2)
USChief:AddMission(missionBlueRecon)
USChief:AddMission(missionBlueAirDefenseOne)
USChief:AddMission(missionBlueAirDefenseTwo)
USChief:AddMission(missionBlueAirDefenseThree)



USChief:AddMission(missionBlueJtac)


--USChief:SetLimitMission(5)
--USChief:SetLimitMission(2, AUFTRAG.Type.CAS)
USChief:SetLimitMission(2, AUFTRAG.Type.CAP)
USChief:SetLimitMission(2, AUFTRAG.Type.INTERCEPT)
USChief:SetLimitMission(3, AUFTRAG.Type.AIRDEFENSE)
USChief:SetLimitMission(4, AUFTRAG.Type.CAPTUREZONE)
USChief:SetLimitMission(4, AUFTRAG.Type.GROUNDATTACK)
USChief:SetLimitMission(5, AUFTRAG.Type.PATROLZONE)
USChief:SetLimitMission(1, AUFTRAG.Type.ORBIT)
USChief:SetLimitMission(2, AUFTRAG.Type.RECON)



--Blue Chief Resources
-- Add strategic (OPS) zones.
local BlueStratZone1 = USChief:AddStrategicZone(opzone1, 100, 100)

--Blue Chief Resources

local BlueCAPTUREResourceOccupied = USChief:CreateResource(AUFTRAG.Type.CAPTUREZONE, 3, 6, nil, nil)
--USChief:AddToResource(BlueCAPTUREResourceOccupied, AUFTRAG.Type.PATROLZONE, 3, 6, nil, nil)

local BlueCAPTUREResourceEmpty = USChief:CreateResource(AUFTRAG.Type.ONGUARD, 3, 5)
--USChief:AddToResource(BlueCAPTUREResourceEmpty, AUFTRAG.Type.PATROLZONE, 2, 4)


--Assign StratZones to resource lists
--StratZone1 - CAPTUREZONE
USChief:SetStrategicZoneResourceOccupied(BlueStratZone1, BlueCAPTUREResourceOccupied)
USChief:SetStrategicZoneResourceEmpty(BlueStratZone1, BlueCAPTUREResourceEmpty)



USChief:Start(15)


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
  
ZoneCaptureCoalitionOne:Start( 60, 120 )

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO EXTRAS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


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


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---TODO RAT
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--random air traffic [rat]

--red civs

local redRatTemplateSet = SET_GROUP:New():FilterPrefixes("RR"):FilterStart()

local redRat = RAT:New("Red737Civ", "737 Civilian Russian")

  redRat:SetCoalition()
  redRat:InitRandomizeTemplateSet(redRatTemplateSet)
  redRat:Commute(true)
  redRat:ContinueJourney()
  redRat:Spawn(3)


local blueRatTemplateSet = SET_GROUP:New():FilterPrefixes("BR"):FilterStart()

local blueRat = RAT:New("Blue737Civ", "737 Civilian US")

  blueRat:SetCoalition()
  blueRat:InitRandomizeTemplateSet(blueRatTemplateSet)
  blueRat:Commute(true)
  blueRat:ContinueJourney()
  blueRat:Spawn(3)
  blueRat:Invisible()


--need to add score reduction and penalty for kill







