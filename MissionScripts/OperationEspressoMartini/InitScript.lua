dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/Moose DEVELOPMENT - UPDATED/MOOSE-develop/MOOSE_INCLUDE/Moose_Include_Static/Moose.lua')
env.info("Moose Loaded")

--dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/Moose.lua')
--env.info("Mission Script Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/OperationEspressoMartini/mist_4_5_107.lua')
env.info("Mist Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/OperationEspressoMartini/OperationEspressoMartini.lua')
env.info("Mission Script Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/OperationEspressoMartini/CTLD(OEM).lua')
env.info("CTLD Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/OperationEspressoMartini/SplashDamage.lua')
env.info("Splash Damage Loaded")

dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/OperationEspressoMartini/Hercules_Cargo_CTLD.lua')
env.info("Herc CTLD Loaded")

--Put this line in the trigger in Mission Editor
--dofile(lfs.writedir()..'/Missions/DCS Scripts/MY_MISSIONS/OperationEspressoMartini/InitScript.lua')