--Basic WHM skill up script for healing and enhancing
--This does some very basic checking to make sure that we are on the right job
--and gets MaxMP and such. Needs to be invoked from the console.

-- Author: Etamame
-- Version: 0.5
-- Name: WHM Healing and Enhancing Skill Script

--LUA requires (thats like imports)
res = require('resources')

--Table for skill caps for healing magic
tblHealingCap={6;9;12;15;18;21;24;27;30;33;36;39;42;45;48;51;54;57;60;63;66;69;72;75;78;81;84;87;90;93;96;99;102;105;108;111;114;117;120;123;126;129;132;135;138;141;144;147;150;153;158;163;168;173;178;183;188;193;198;203;207;212;217;222;227;232;236;241;246;251;256;261;266;271;276}

--Table for skill caps for enhancing magic
tblEnhancingCap={5;7;10;13;16;19;21;24;27;30;33;35;38;41;44;47;49;52;55;58;61;63;66;69;72;75;77;80;83;86;89;91;94;97;100;103;105;108;111;114;117;119;122;125;128;131;133;136;139;142;146;151;156;161;166;170;175;180;185;190;192;195;197;200;202;205;207;210;212;215;218;221;224;227;230}

-- Initial usage message...
windower.add_to_chat(121,'This script skills healing and then enhancing to cap both.')
windower.add_to_chat(121,'Will cap to the appropriate skill for your current level')
windower.add_to_chat(121,'Assumes that your job is WHM and you are in a place you can cast')

--Initialize variables for the script...
sPlyrJob='None'
sPlyrStatus='None'
iPlyrMPMax='0'
iPlyrMP='0'
iPlyrLevel='0'
tblPlyrSkills={}
tblCures{0,0,0,0,0}

--Get initial character information...
tblPlayer = windower.ffxi.get_player()

iPlyrMPMax=tblPlayer.vitals.max_mp
sPlyrJob=tblPlayer.main_job
sPlyrStatus=tblPlayer.status
iPlyrLevel=tblPlayer.main_job_level
tblPlyrSkills=tblPlayer.skills

--print player info
windower.add_to_chat(121,'Inital Information for the WHM Skill Script')
windower.add_to_chat(121,'Player Max MP: '..iPlyrMPMax)
windower.add_to_chat(121,'Player Job: '..sPlyrJob)
windower.add_to_chat(121,'Player Status: '..sPlyrStatus)
windower.add_to_chat(121,'Player Job Level: '..iPlyrLevel)
windower.add_to_chat(121,'Player MP: '..windower.ffxi.get_player()['vitals']['mp'])

--print all of the skills for the player
for k, v in pairs( tblPlyrSkills ) do
  if (k == 'healing_magic' or k == 'enhancing_magic') then
    --windower.add_to_chat(121,k .. ' - ' .. v)
  end
end

windower.add_to_chat(121,'Healing Skill Cap for current level: '..tblHealingCap[iPlyrLevel])
windower.add_to_chat(121,'Enhancing Skill Cap for current level: '..tblEnhancingCap[iPlyrLevel])

Need to determine what cure levels we have...
tblSpells = windower.ffxi.get_spells()

--Get Cure spell IDs
tblCures[1] = res.spells:with('name', 'Cure')

windower.add_to_chat(121,tblCures[1])
--windower.add_to_chat(121,tblSpells[tblCures[1]])

--for k,v in pairs(tblSpells) do
--  windower.add_to_chat(121,k..' - '..v)
--while 
