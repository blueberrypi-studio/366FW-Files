--dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/Moose DEVELOPMENT - UPDATED/MOOSE-develop/MOOSE_INCLUDE/Moose_Include_Static/Moose.lua')
--env.info("Moose Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/Moose.lua')
env.info("Mission Script Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/MissionScripts/OperationEspressoMartini/mist_4_5_107.lua')
env.info("Mist Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/MissionScripts/OperationEspressoMartini/GroundCrew_OEM.lua')
env.info("Ground Crew")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/MissionScripts/OperationEspressoMartini/CTLD_OEM.lua')
env.info("CTLD Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/MissionScripts/OperationEspressoMartini/Hercules_Cargo_CTLD.lua')
env.info("Herc CTLD Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/MissionScripts/OperationEspressoMartini/SplashDamage.lua')
env.info("Splash Damage Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/MissionScripts/OperationEspressoMartini/OperationEspressoMartini.lua')
env.info("Mission Script Loaded")

--dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/MissionScripts/OperationEspressoMartini/Its Over 9000 script by Mith.lua')
--env.info("Its over 9000")



--Put this line in the trigger in Mission Editor
--dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/OperationEspressoMartini/InitScript.lua')