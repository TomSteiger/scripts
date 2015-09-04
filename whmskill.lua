--Basic WHM skill up script for healing and enhancing
--This does some very basic checking to make sure that we are on the right job
--and gets MaxMP and such. Needs to be invoked from the console.

-- Author: Etamame
-- Version: 0.5
-- Name: WHM Healing and Enhancing Skill Script

--LUA requires (thats like imports)
res = require('resources')
require('tables')

--Sleep function so that we can pause between casts...
function sleep(lcli)
  os.execute('timeout '..tonumber(lcli))
end

--The main WHM skill up function
function WHMSkillUp()
  
  --Check if we are healing and if so stop healing
  if sPlyrStatus == 33 then
    windower.send_command('input /heal')
  end
  
  if sPlyrJob == 'WHM' then
  
    --Get Cure spell IDs
    tblCures[1] = res.spells:with('name', 'Cure')['id']
    tblCures[2] = res.spells:with('name','Cure II')['id']
    tblCures[3] = res.spells:with('name','Cure III')['id']
    tblCures[4] = res.spells:with('name','Cure IV')['id']
    tblCures[5] = res.spells:with('name','Cure V')['id']
    
    --Get Bar spell IDs
    tblEnhance[1] = res.spells:with('name', 'Barstonra')['id']
    tblEnhance[2] = res.spells:with('name', 'Barsleepra')['id']
    tblEnhance[3] = res.spells:with('name', 'Barwatera')['id']
    tblEnhance[4] = res.spells:with('name', 'Barpoisonra')['id']
    tblEnhance[5] = res.spells:with('name', 'Barparalyzra')['id']
    tblEnhance[6] = res.spells:with('name', 'Baraera')['id']
    tblEnhance[7] = res.spells:with('name', 'Barfira')['id']
    tblEnhance[8] = res.spells:with('name', 'Barblindra')['id']
    tblEnhance[9] = res.spells:with('name', 'Barblizzara')['id']
    tblEnhance[10] = res.spells:with('name', 'Barsilencera')['id']
    tblEnhance[11] = res.spells:with('name', 'Barthundra')['id']
    tblEnhance[12] = res.spells:with('name', 'Barpetra')['id']  
    
    
    --Start a loop for capping healing...
    while ((tonumber(windower.ffxi.get_player()['skills']['healing_magic']) < tonumber(tblHealingCap[iPlyrLevel])) and bRun = true) do
      if bHealing == true then
        if windower.ffxi.get_player()['vitals']['mp'] == iPlyMPMax and windower.ffxi.get_player()['status'] == '33' then
          windower.send_command('/heal')
          bHealing = false
        end
      else
      
        --Loop over the cure spells and start casting
        for k, v in pairs(tblCures) do
          if windower.ffxi.get_player()['vitals']['mp'] < 8 and windower.ffxi.get_player()['status'] ~= '33' then
            bHealing = true
            windower.send_command('/heal')
          else
            --Check if the player has the spells
            if windower.ffxi.get_spells()[v] == true then
              --Player knows the spell so now we do the actual casting
              windower.send_command('input /ma "'.. res.spells:with('id',k)['name']..'" <me>')
              --Sleep the script for the time being
              iDelay = tonumber(res.spells:with('id',k)['cast_time']) + 2
              sleep(iDelay)
            end             
          end
        end
      end
    end
    
    --Same loop logic for enhancing... I can refactor to clean this up at some point...
  else
    windower.add_to_chat(121,'Please change to WHM as your main Job!!!')
  end
end

--Register a handler to stop and start the 
windower.register_event('chat message', function(message)
  if message = 'Start Skill Up' then
    bRun = true
    coroutine.yield()
    WHMSkillup()
  elseif message = 'Stop Skill Up' then
    bRun = false
    coroutine.yield()
  end
end)


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
tblCures={0,0,0,0,0}
tblEnhance={0,0,0,0,0,0,0,0,0,0,0,0}
bHealing=false

--Get initial character information...
tblPlayer = windower.ffxi.get_player()

iPlyrMPMax=tblPlayer.vitals.max_mp
sPlyrJob=tblPlayer.main_job
sPlyrStatus=tblPlayer.status
iPlyrLevel=tblPlayer.main_job_level
tblPlyrSkills=tblPlayer.skills
tblPlyrSpells=windower.ffxi.get_spells()

--print player info
windower.add_to_chat(121,'Inital Information for the WHM Skill Script')
windower.add_to_chat(121,'Player Job: '..sPlyrJob..' - '..iPlyrLevel)
windower.add_to_chat(121,'Player Status: '..sPlyrStatus)
windower.add_to_chat(121,'Player MP: '..windower.ffxi.get_player()['vitals']['mp'])
windower.add_to_chat(121,'Player Max MP: '..iPlyrMPMax)
--Print the  WHM skills for the player
for k, v in pairs( tblPlyrSkills ) do
  if k == 'healing_magic' then 
    windower.add_to_chat(121,'Current Healing Skill: ' .. v)  
  end
  if k == 'enhancing_magic' then
    windower.add_to_chat(121,'Current Enhancing Skill: ' .. v)
  end
end

--Print the skill cap for the current level...
windower.add_to_chat(121,'Healing Skill Cap for current level: '..tblHealingCap[iPlyrLevel])
windower.add_to_chat(121,'Enhancing Skill Cap for current level: '..tblEnhancingCap[iPlyrLevel])

