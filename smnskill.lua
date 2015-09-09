function sleep(lcli)
  os.execute('timeout '..tonumber(lcli))
end

i = 1

while i < 100   