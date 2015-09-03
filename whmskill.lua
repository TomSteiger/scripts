--Basic WHM skill up script for healing and enhancing
--This does some very basic checking to make sure that we are on the right job
--and gets MaxMP and such. Needs to be invoked from the console.

-- Initial usage message...
windower.add_to_chat('This script cycles between healing and enhancing for a full set of MP.')

--Initialize variables for the script...
sPlyrJob='None'
sPlyrStatus='None'
iPlyrMPMax='0'
iPlyrMP='0'
iPlyrLevel='0'
tblPlyrSkills={}

--Get initial character information...
tblPlayer = windower.ffxi.get_player()

iPlyrMPMax=tblPlayer.vitals.max_mp
sPlyrJob=tblPlayer.main_job
sPlyrStatus=tblPlayer.status
iPlyrLevel=tblPlayer.main_job_level
tblPlyrSkills=tblPlayer.skills

--print player info
windower.add_to_chat(121,'Player Max MP: '..iPlyrMPMax)
windower.add_to_chat(121,'Player Job: '..sPlyrJob)
windower.add_to_chat(121,'Player Status: '..sPlyrStatus)
windower.add_to_chat(121,'Player Job Level: '..iPlyrLevel)
windower.add_to_chat(121,'Player MP: '..windower.ffxi.get_player()['vitals']['mp'])

--print all of the skills for the player
for k, v in pairs( tblPlyrSkills ) do
  --if (k == 'healing' or k == 'enhancing') then
    windower.add_to_chat(121,k .. ' - ' .. v)
  --end
end
