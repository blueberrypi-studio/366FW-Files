--[[

--GROUND CREW SCRIPT REWORK


--To use this script you must setup late activated templates in ME.  The names MUST MATCH the following

if you do not have Massuns mod pack the salutes will not work

--Infantry Groups
these need to be ground units

M92 Saluter x2
Group Name: GC1, GC2

M92 Crounch Worker
Group Name: GC3

Fuel Truck
Group Name: FT


--Statics
--STATICS USE UNIT NAME NOT GROUP NAME, MAKE BOTH NAMES THE SAME FOR GOOD MEASURE
static, airfield equipment

M92 Generator Human
Unit Name: Generator

under structures
M92 Fire Extinguisher
Unit Name: FireExt



]]

--AIRPLANES


local planeClientSet = SET_CLIENT:New():FilterCategories("plane"):FilterStart()

planeClientSet:ForEachClient(function(_client)

  _client:Alive(function()


-- Calculate spawn locations for airplanes
-- you must find a way to differentiate between terminal types, or you will have to ensure that all spawns are openair

--ONLY CAUCASUS HAS BUNKER HANGARS.  FUCK CAUCASUS. USE CAUCASUS FRIENDLY VERSION SPACING if CAUCASUS MAP

--GC (GroundCrew) GS (GroundStatic)
--Define GroundCrew Objects
  local planeGC1 = nil
  local planeGC2 = nil
  local planeGS1 = nil
  local planeGS2 = nil
  local planeFT = nil
  
--get client information
--client information can be reused  
  local unitClient = _client:GetClientGroupUnit()
  local unitName = _client:Name()
  local coalitionClient = _client:GetCountry()
  local rampCoordinate = _client:GetCoordinate()
  
  local nearestAirfield = rampCoordinate:GetClosestAirbase()
  local airfieldType = nearestAirfield:GetAirbaseCategory()
 
 --[[
 
 UNCOMMENT THIS SECTION IF YOU ARE USING CAUCASUS MAP,  THIS SPACING WILL FIX THE MEN ON THE ROOF OF THE ARMORED BUNKERS
  
--plane static headings, facingdirection, position
--GroundCrew 1--left hand Saluter
  local planeGC1Heading = _client:GetHeading() + 340
  local planeGC1Facing = math.fmod( _client:GetHeading() + 90, 360 )
  local planeGC1Position = rampCoordinate:Translate( 24.5, planeGC1Heading )
--GroundCrew 2--right hand saluter
  local planeGC2Heading = _client:GetHeading() + 20
  local planeGC2Facing = math.fmod( _client:GetHeading() + 270, 360 )
  local planeGC2Position = rampCoordinate:Translate( 24.5, planeGC2Heading )
--GroundStatic 1--generator
  local planeGS1Heading = _client:GetHeading() + 90
  local planeGS1Facing = math.fmod( _client:GetHeading(), 360 )
  local planeGS1Position = rampCoordinate:Translate( 7, planeGS1Heading )
--GroundStatic 2--fire extinguisher
  local planeGS2Heading = _client:GetHeading() + 320
  local planeGS2Facing = math.fmod( _client:GetHeading(), 360)
  local planeGS2Position = rampCoordinate:Translate( 8, planeGS2Heading)
  
  --]]
  
  
  --OPEN AIR SPACING
  
  --plane static headings, facingdirection, position
--GroundCrew 1--left hand Saluter
  local planeGC1Heading = _client:GetHeading() + 320
  local planeGC1Facing = math.fmod( _client:GetHeading() + 90, 360 )
  local planeGC1Position = rampCoordinate:Translate( 17, planeGC1Heading )
--GroundCrew 2--right hand saluter
  local planeGC2Heading = _client:GetHeading() + 40
  local planeGC2Facing = math.fmod( _client:GetHeading() + 270, 360 )
  local planeGC2Position = rampCoordinate:Translate( 17, planeGC2Heading )
--GroundStatic 1--generator
  local planeGS1Heading = _client:GetHeading() + 90
  local planeGS1Facing = math.fmod( _client:GetHeading(), 360 )
  local planeGS1Position = rampCoordinate:Translate( 7, planeGS1Heading )
--GroundStatic 2--fire extinguisher
  local planeGS2Heading = _client:GetHeading() + 320
  local planeGS2Facing = math.fmod( _client:GetHeading(), 360)
  local planeGS2Position = rampCoordinate:Translate( 10, planeGS2Heading)
--FuelTruck
  local planeFTHeading = _client:GetHeading() + 70
  local planeFTFacing = math.fmod( _client:GetHeading() + 310, 360)
  local planeFTPosition = rampCoordinate:Translate( 19, planeFTHeading)
  
  
--event handlers
  unitClient:HandleEvent( EVENTS.PlayerLeaveUnit )
  unitClient:HandleEvent( EVENTS.Crash )
  unitClient:HandleEvent( EVENTS.PilotDead )  
  

  if airfieldType == 0 then
  
  local CrewChiefLivery = { "variation 1", "variation 2", "variation 3", "variation 4", "variation 5" }
--spawn GC1  
  local spawnPlaneGC1 = SPAWN:NewWithAlias("GC1", "CrewChief" )
  
    spawnPlaneGC1:OnSpawnGroup(
      function( SpawnGroup )
        planeGC1 = SpawnGroup --groupdeclare for further use
      end)
    
    spawnPlaneGC1:InitHeading( planeGC1Facing )
    spawnPlaneGC1:InitLivery( CrewChiefLivery[ math.random( #CrewChiefLivery ) ] )
    spawnPlaneGC1:InitCountry( coalitionClient )
    spawnPlaneGC1:SpawnFromCoordinate( planeGC1Position )

  
--spawn GC2
  local spawnPlaneGC2 = SPAWN:NewWithAlias("GC2", "GroundChief" )
  
    spawnPlaneGC2:OnSpawnGroup(
      function( SpawnGroup )
        planeGC2 = SpawnGroup
      end)
  
    spawnPlaneGC2:InitHeading( planeGC2Facing )
    spawnPlaneGC2:InitLivery( CrewChiefLivery[ math.random( #CrewChiefLivery ) ] )
    spawnPlaneGC2:InitCountry( coalitionClient )
    spawnPlaneGC2:SpawnFromCoordinate( planeGC2Position )

--Fuel Truck
  local spawnFT = SPAWN:NewWithAlias( "FT", "Fuel" )
    spawnFT:InitHeading(planeFTFacing)
    spawnFT:InitCountry(coalitionClient)
    spawnFT:SpawnFromCoordinate(planeFTPosition)

--salute scheduler for salutes
  local planeSalute = SCHEDULER:New( nil,
    function()
      local clientCoordinate = unitClient:GetCoordinate()
--      local distance = clientCoordinate:Get3dDistance(rampCoordinate)
      local airspeed = unitClient:GetVelocityKNOTS()
--        if distance < 15 and airspeed >= 2 then
        if airspeed >= 2 and airspeed <= 10 then
          planeGC1:OptionAlarmStateRed()
          planeGC2:OptionAlarmStateRed()
        else
          planeGC1:OptionAlarmStateGreen()
          planeGC2:OptionAlarmStateGreen()
        end
    end, {}, 1, 1 )


--Ground Statics

  local spawnGS1 = SPAWNSTATIC:NewFromStatic( "Generator", coalitionClient)
    spawnGS1:InitHeading(planeGS1Heading)
    spawnGS1:InitCountry(coalitionClient)  
    spawnGS1:SpawnFromCoordinate(planeGS1Position)
    
  local spawnGS2 = SPAWNSTATIC:NewFromStatic( "FireExt", coalitionClient)
    spawnGS2:InitHeading(planeGS2Heading)
    spawnGS2:InitCountry(coalitionClient)
    spawnGS2:SpawnFromCoordinate(planeGS2Position)
    
  
  
  
  local function funcLeaveAircraft()
  
    planeGC1:Destroy(nil,0)
    planeGC2:Destroy(nil,0)
    planeGS1:Destroy(nil,0)
    planeGS2:Destroy(nil,0)
    planeFT:Destroy(nil,0)
    
    unitClient:UnhandleEvent( EVENTS.PlayerLeaveUnit )
    unitClient:UnhandleEvent( EVENTS.Crash )
    unitClient:UnhandleEvent( EVENTS.PilotDead )
    
  end
  
  
  function unitClient:OnEventPlayerLeaveUnit(EventData)
    funcLeaveAircraft()
  end
  
  function unitClient:OnEventCrash(EventData)
    funcLeaveAircraft()
  end
  
  function unitClient:OnEventPilotDead(EventData)
    funcLeaveAircraft()
  end
  
  
  
  end
  end)
end)



local heloClientSet = SET_CLIENT:New():FilterCategories("helicopter"):FilterStart()

heloClientSet:ForEachClient(function(_client)

  _client:Alive(function()


-- Calculate spawn locations for airplanes
-- you must find a way to differentiate between terminal types, or you will have to ensure that all spawns are openair

--ONLY CAUCASUS HAS BUNKER HANGARS.  FUCK CAUCASUS. USE CAUCASUS FRIENDLY VERSION SPACING if CAUCASUS MAP

--GC (GroundCrew) GS (GroundStatic)
--Define GroundCrew Objects
  local heloGC1 = nil
  local heloGC2 = nil
  local heloGC3 = nil
  local heloGS1 = nil
  local heloGS2 = nil
  local heloFT = nil
  
--get client information
--client information can be reused  
  local unitClient = _client:GetClientGroupUnit()
  local unitName = _client:Name()
  local coalitionClient = _client:GetCountry()
  local rampCoordinate = _client:GetCoordinate()
  
  local nearestAirfield = rampCoordinate:GetClosestAirbase()
  local airfieldType = nearestAirfield:GetAirbaseCategory()
  
   
 --[[
 
 UNCOMMENT THIS SECTION IF YOU ARE USING CAUCASUS MAP,  THIS SPACING WILL FIX THE MEN ON THE ROOF OF THE ARMORED BUNKERS
  
--plane static headings, facingdirection, position
--GroundCrew 1--left hand Saluter
  local planeGC1Heading = _client:GetHeading() + 340
  local planeGC1Facing = math.fmod( _client:GetHeading() + 90, 360 )
  local planeGC1Position = rampCoordinate:Translate( 24.5, planeGC1Heading )
--GroundCrew 2--right hand saluter
  local planeGC2Heading = _client:GetHeading() + 20
  local planeGC2Facing = math.fmod( _client:GetHeading() + 270, 360 )
  local planeGC2Position = rampCoordinate:Translate( 24.5, planeGC2Heading )
--GroundStatic 1--generator
  local planeGS1Heading = _client:GetHeading() + 90
  local planeGS1Facing = math.fmod( _client:GetHeading(), 360 )
  local planeGS1Position = rampCoordinate:Translate( 7, planeGS1Heading )
--GroundStatic 2--fire extinguisher
  local planeGS2Heading = _client:GetHeading() + 320
  local planeGS2Facing = math.fmod( _client:GetHeading(), 360)
  local planeGS2Position = rampCoordinate:Translate( 8, planeGS2Heading)
  
  --]]
  

  --OPEN AIR SPACING
  
  --plane static headings, facingdirection, position
--GroundCrew 1--left hand Saluter
  local heloGC1Heading = _client:GetHeading() + 280
  local heloGC1Facing = math.fmod( _client:GetHeading() + 90, 360 )
  local heloGC1Position = rampCoordinate:Translate( 10, heloGC1Heading )
--GroundCrew 2--right hand saluter
  local heloGC2Heading = _client:GetHeading() + 50
  local heloGC2Facing = math.fmod( _client:GetHeading() + 270, 360 )
  local heloGC2Position = rampCoordinate:Translate( 10, heloGC2Heading )
--GroundCrew 3--fireext guy
  local heloGC3Heading = _client:GetHeading() + 315
  local heloGC3Facing = math.fmod( _client:GetHeading() + 90, 360 )
  local heloGC3Position = rampCoordinate:Translate( 10, heloGC3Heading )  
--GroundStatic 1--generator
  local heloGS1Heading = _client:GetHeading() + 90
  local heloGS1Facing = math.fmod( _client:GetHeading(), 360 )
  local heloGS1Position = rampCoordinate:Translate( 12, heloGS1Heading )
--GroundStatic 2--fire extinguisher
  local heloGS2Heading = _client:GetHeading() + 320
  local heloGS2Facing = math.fmod( _client:GetHeading(), 360)
  local heloGS2Position = rampCoordinate:Translate( 10, heloGS2Heading)
--FuelTruck
  local heloFTHeading = _client:GetHeading() + 70
  local heloFTFacing = math.fmod( _client:GetHeading() + 310, 360)
  local heloFTPosition = rampCoordinate:Translate( 19, heloFTHeading)
  
  
--event handlers
  unitClient:HandleEvent( EVENTS.PlayerLeaveUnit )
  unitClient:HandleEvent( EVENTS.Crash )
  unitClient:HandleEvent( EVENTS.PilotDead )  
  

  if airfieldType == 0 then
  
  local CrewChiefLivery = { "variation 1", "variation 2", "variation 3", "variation 4", "variation 5" }
--spawn GC1  
  local spawnHeloGC1 = SPAWN:NewWithAlias("GC1", "CrewChief" )
  
    spawnHeloGC1:OnSpawnGroup(
      function( SpawnGroup )
        heloGC1 = SpawnGroup --groupdeclare for further use
      end)
    
    spawnHeloGC1:InitHeading( heloGC1Facing )
    spawnHeloGC1:InitLivery( CrewChiefLivery[ math.random( #CrewChiefLivery ) ] )
    spawnHeloGC1:InitCountry( coalitionClient )
    spawnHeloGC1:SpawnFromCoordinate( heloGC1Position )

  
--spawn GC2
  local spawnHeloGC2 = SPAWN:NewWithAlias("GC2", "GroundChief" )
  
    spawnHeloGC2:OnSpawnGroup(
      function( SpawnGroup )
        heloGC2 = SpawnGroup
    end)
  
    spawnHeloGC2:InitHeading( heloGC2Facing )
    spawnHeloGC2:InitLivery( CrewChiefLivery[ math.random( #CrewChiefLivery ) ] )
    spawnHeloGC2:InitCountry( coalitionClient )
    spawnHeloGC2:SpawnFromCoordinate( heloGC2Position )

--spawn GC3
  local spawnHeloGC3 = SPAWN:NewWithAlias("GC3", "Fireman" )
  
    spawnHeloGC3:OnSpawnGroup(
      function( SpawnGroup )
        heloGC3 = SpawnGroup
    end)
  
    spawnHeloGC3:InitHeading( heloGC3Facing )
    spawnHeloGC3:InitLivery( CrewChiefLivery[ math.random( #CrewChiefLivery ) ] )
    spawnHeloGC3:InitCountry( coalitionClient )
    spawnHeloGC3:SpawnFromCoordinate( heloGC3Position )

--Fuel Truck
  local spawnFT = SPAWN:NewWithAlias( "FT", "Fuel" )
    spawnFT:InitHeading(heloFTFacing)
    spawnFT:InitCountry(coalitionClient)  
    spawnFT:SpawnFromCoordinate(heloFTPosition) 
    
    spawnFT:OnSpawnGroup(
      function(SpawnGroup)
        heloFT = SpawnGroup
      end)
        
    
--salute scheduler for salutes
  local heloSalute = SCHEDULER:New( nil,
    function()
      local clientCoordinate = unitClient:GetCoordinate()
--      local distance = clientCoordinate:Get3dDistance(rampCoordinate)--for some reason this is now breaking.  could be due to a bug in moose?  moose version on target range does not break.  but we need this version for mission.
      local airspeed = unitClient:GetVelocityKNOTS()
--        if distance < 15 and airspeed >= 2 then  --potentially look for another way to do this.
        if airspeed >= 2 and airspeed <= 10 then --for now this will salute if client is moving more than 2 knots
          heloGC1:OptionAlarmStateRed()
          heloGC2:OptionAlarmStateRed()
        else
          heloGC1:OptionAlarmStateGreen()
          heloGC2:OptionAlarmStateGreen()
        end
    end, {}, 1, 1 )


--Ground Statics

  local spawnGS1 = SPAWNSTATIC:NewFromStatic( "Generator", coalitionClient)
    spawnGS1:InitHeading(heloGS1Facing)
    spawnGS1:InitCountry(coalitionClient)  
    spawnGS1:SpawnFromCoordinate(heloGS1Position)

    
  local spawnGS2 = SPAWNSTATIC:NewFromStatic( "FireExt", coalitionClient)
    spawnGS2:InitHeading(heloGS2Facing)
    spawnGS2:InitCountry(coalitionClient)  
    spawnGS2:SpawnFromCoordinate(heloGS2Position)
    
  
  
  
  
  local function funcLeaveAircraft()
  
    heloGC1:Destroy(nil,0)
    heloGC2:Destroy(nil,0)
    heloGC3:Destroy(nil,0)
    spawnGS1:Destroy(nil,0)
    spawnGS2:Destroy(nil,0)
    heloFT:Destroy(nil,0)
    
    unitClient:UnhandleEvent( EVENTS.PlayerLeaveUnit )
    unitClient:UnhandleEvent( EVENTS.Crash )
    unitClient:UnhandleEvent( EVENTS.PilotDead )
    
  end
  
  
  function unitClient:OnEventPlayerLeaveUnit(EventData)
    funcLeaveAircraft()
  end
  
  function unitClient:OnEventCrash(EventData)
    funcLeaveAircraft()
  end
  
  function unitClient:OnEventPilotDead(EventData)
    funcLeaveAircraft()
  end
  
  
  
  
  end
  end)
end)

