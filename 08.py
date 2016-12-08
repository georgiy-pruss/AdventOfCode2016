t = open('08.dat','rt').read().strip().split('\n')

m = 6*[50*[0]]

for s in t:
  a = s.replace('=',' ').replace('x',' ').split()
  if a[0]=='rect': # ['rect', '...', '...']
    x = int( a[1] ); y = int( a[2] )
    for i in range(y): m[i] = [1]*x + m[i][x:]
  elif a[1]=='row': # ['rotate', 'row', 'y', '...', 'by', '...']
    y = int( a[3] ); x = int( a[5] )
    m[y] = m[y][-x:]+m[y][:-x]
  elif a[1]=='column': # ['rotate', 'column', '...', 'by', '...']
    x = int( a[2] ); y = int( a[4] )
    w = [list(o) for o in zip(*m)]
    w[x] = w[x][-y:]+w[x][:-y]
    m = [list(o) for o in zip(*w)]

print( sum(sum(w) for w in m) )
for l in m: print( ''.join(' \u2588'[e] for e in l) )
