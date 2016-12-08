t = open('08.dat','rt').read().strip().split('\n')

r,c = 6,50
m = r * [c*['.']]

for s in t:
  if s.startswith('rect'):
    x = int( s[s.find(' ')+1:s.find('x')] )
    y = int( s[s.find('x')+1:] )
    for i in range(y): m[i] = ['#']*x + m[i][x:]
  elif s.startswith('rotate row y='):
    y = int( s[s.find('=')+1:s.find('by')-1] )
    x = int( s[s.find('by')+2:] )
    m[y] = m[y][-x:]+m[y][:-x]
  elif s.startswith('rotate column x='):
    x = int( s[s.find('=')+1:s.find('by')-1] )
    y = int( s[s.find('by')+2:] )
    w = [list(o) for o in zip(*m)]
    w[x] = w[x][-y:]+w[x][:-y]
    m = [list(o) for o in zip(*w)]

print( sum(sum(e=='#' for e in m[i]) for i in range(r)) )
for l in m: print( ''.join(e for e in l) )
