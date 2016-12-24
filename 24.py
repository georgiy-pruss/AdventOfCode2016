s = open('24.dat').read().strip().split('\n')

g = {}
for i,r in enumerate(s):
  for j,c in enumerate(r):
    if '0'<=c<='9':
      g[int(c)]=(i,j)
t = [g[k] for k in sorted(g.keys())] # targets, points marked 0,1,2,...
m = [[(0,-1)[c=='#'] for c in r] for r in s] # maze; free space - zeros

def show(m,t):
  for i,r in enumerate(m):
    for j,c in enumerate(r):
      if (i,j) in t: print(t.index((i,j)),end='')
      else: print(' \u2588'[c!=0],end='')
    print()

def directions( m, x, y ):
  d = []
  if m[x-1][y]==0: d.append((x-1,y))
  if m[x+1][y]==0: d.append((x+1,y))
  if m[x][y-1]==0: d.append((x,y-1))
  if m[x][y+1]==0: d.append((x,y+1))
  return d

def step( m, ends, p, to ):
  next = []
  for x,y in ends:
    m[x][y] = p
    dirs = directions( m, x, y )
    for d in dirs:
      if d == to: return p # we finish as soon as we can
      if d not in next: next.append(d)
  return step( m, next, p+1, to )

def findpath( m, fm, to ): return step( m, [fm], 1, to )

d = {}
for i in range(len(t)-1):
  for j in range(i+1,len(t)):
    l = findpath( [r[:] for r in m], t[i], t[j] )
    d[(i,j)]=d[(j,i)]=l

import itertools

ms = 0
for p in itertools.permutations( list(range(1,len(t))) ):
  s = 0
  for (x,y) in zip((0,)+p,p): s += d[(x,y)]
  if ms==0 or s<ms: ms = s
print( ms )

ms = 0
for p in itertools.permutations( list(range(1,len(t))) ):
  s = 0
  for (x,y) in zip((0,)+p,p+(0,)): s += d[(x,y)]
  if ms==0 or s<ms: ms = s
print( ms )
