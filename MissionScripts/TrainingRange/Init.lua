--dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/Moose DEVELOPMENT - UPDATED/MOOSE-develop/MOOSE_INCLUDE/Moose_Include_Static/Moose.lua')
--env.info("Moose Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/Moose.lua')
env.info("Moose Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/MissionScripts/TrainingRange/Range_Full.lua')
env.info("Range Script Loaded")




--Put this line in the trigger in Mission Editor
--dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/MissionScripts/TrainingRange/Init.lua')