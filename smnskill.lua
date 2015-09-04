bRun = true

while bRun == true do
  print(windower.ffxi.get_player()['status'])
  if windower.ffxi.get_player()['status'] == '33' then
    bRun = false
  end
end