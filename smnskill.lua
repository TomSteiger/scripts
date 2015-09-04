function snooze(lcli)
  coroutine.sleep(i)
  bKeepGoing = true
end

bKeepGoing = false

print(1)
snooze(3)
while bKeepGoing = false
   print 'Keep waiting: '..bKeepGoing 
end
print (2)