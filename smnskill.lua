function snooze(lcli)
  local nTime = os.time() + lcli
  repeat until os.time() > ntime
end

windower.register_event('incoming text'function(original)
  print(original)
end)
bRun = true
i = 1

while bRun == true do
  print(i)
  snooze(5)
end