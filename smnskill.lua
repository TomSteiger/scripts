i = 0

while i < 20 do
  print('The value of i is: '..i)
  coroutine.sleep(2)
  print('Next i is - '..(i+1))
  i = i+1
end