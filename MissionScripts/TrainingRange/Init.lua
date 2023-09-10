--dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/Moose DEVELOPMENT - UPDATED/MOOSE-develop/MOOSE_INCLUDE/Moose_Include_Static/Moose.lua')
--env.info("Moose Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/Moose.lua')
env.info("Moose Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/MissionScripts/TrainingRange/Range_Full.lua')
env.info("Range Script Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/MissionScripts/TrainingRange/Splash_Damage_2_0.lua')
env.info("Splash Damage Loaded")




--Put this line in the trigger in Mission Editor
--dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/MissionScripts/TrainingRange/Init.lua')