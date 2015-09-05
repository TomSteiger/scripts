function snooze(lcli)
  os.execute('timeout '..tonumber(lcli))
  print('In the snooze function')
end

print(1)
snooze(3)
print(2)