def disk(t,k,n,startpos):
  tm = t+k
  pos = (startpos + tm) % n
  return pos==0

assert disk(0, 1,5,4) and not disk(0, 2,2,1)
assert disk(5, 1,5,4) and disk(5, 2,2,1)

'''
Disc #1 has 17 positions; at time=0, it is at position 1.
Disc #2 has 7 positions; at time=0, it is at position 0.
Disc #3 has 19 positions; at time=0, it is at position 2.
Disc #4 has 5 positions; at time=0, it is at position 0.
Disc #5 has 3 positions; at time=0, it is at position 0.
Disc #6 has 13 positions; at time=0, it is at position 5.
'''

period = 17*7*19*5*3*13
for t in range(period):
  if disk(t, 1,17,1) and disk(t, 2,7,0) and disk(t, 3,19,2):
    if disk(t, 4,5,0) and disk(t, 5,3,0) and disk(t, 6,13,5):
      print( t )
      break
for t in range(period*11):
  if disk(t, 1,17,1) and disk(t, 2,7,0) and disk(t, 3,19,2):
    if disk(t, 4,5,0) and disk(t, 5,3,0) and disk(t, 6,13,5):
      if disk(t, 7,11,0):
        print( t )
        break

# You got rank 763 on this star's leaderboard.
