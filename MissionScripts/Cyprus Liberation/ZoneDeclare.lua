--Create OPS zones
--These will work for both blue and red side

Gecitkale=OPSZONE:New("Zeta-1")
Larnaca=OPSZONE:New("Zeta-2")

--CREATE OPSZONES SET for Capture function
opszonesSET=SET_OPSZONE:New():FilterPrefixes("Zeta"):FilterOnce()

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


--Add CAPZONES as OPSZONES
--blue side only
CAPzoneNorthOPS = OPSZONE:New("CAPzoneNorth")
CAPzoneMidOPS = OPSZONE:New("CAPzoneMID")
CAPzoneSouthOPS = OPSZONE:New("CAPzoneSouth")

--Define CAP ZONES
capZoneNorth=ZONE:New("CAPzoneNorth")
capZoneMid=ZONE:New("CAPzoneMID")
capZoneSouth=ZONE:New("CAPzoneSouth")

--Define CAS ZONES
casZoneNorth=ZONE:New("CASzone1")
casZoneSouth=ZONE:New("CASzone2")

--ADD CAS ZONES AS OPSZONES
 CASzoneNorthOPS = OPSZONE:New("CASzone1")
 CASzoneSouthOPS = OPSZONE:New("CASzone2")

--ADD CAS SETZONE for use later
CASSETzones = SET_ZONE:New():FilterPrefixes("Zeta"):FilterStart()

--Define AWACS ZONES
awacsZone=ZONE:New("AWACSZONE")

--TARGETZONES

ZONEGecitkale=ZONE:New("Zeta-1")
ZONELarnaca=ZONE:New("Zeta-2")


--MAKE SURE TO SET THESE ZONES IN ME
--Chopper Transport Zones
BLUEzonePICKUP=ZONE_AIRBASE:New("FOBWhiskeyAIPad")
BLUEzoneDROPOFFnorth=ZONE:New("TroopDropZone1")
BLUEzoneDROPOFFsouth=ZONE:New("TroopDropZone2")



--Armor Brigades--DECLARE SPAWNZONES
zoneFOBWhiskey=ZONE:New("FOBWhiskey")
zoneFOBGolf = ZONE:New("FOBGolf")

ammoDropZone1 = ZONE:New("AmmoDropZone1")




