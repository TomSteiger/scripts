function snooze(lcli)
  print(os.time())
  local nTime = os.time() + lcli
  repeat until os.time() > nTime
end



bRun = true
i = 1

while bRun == true do
  if windower.ffxi.get_player()['status'] == 1 then
    bRun = false
  end
  print(i)
  snooze(5)
  i = i + 1
end