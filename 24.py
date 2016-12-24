s = open('24.dat').read().strip().split('\n')

m = [[(0,-1)[c=='#'] for c in r] for r in s] # maze; free space - zeros
d = {} # temporary dictionary of marked points
for i,r in enumerate(s):
  for j,c in enumerate(r):
    if '0'<=c<='9': # we have no more than 10 marked points
      d[int(c)]=(i,j)
t = [d[i] for i in sorted(d.keys())]

def show(m,t):
  for i,r in enumerate(m):
    for j,c in enumerate(r):
      if (i,j) in t: print(t.index((i,j)),end='')
      else: print(' \u2588'[c!=0],end='')
    print()

def step( m, ends, p, to ):
  next = []
  for x,y in ends:
    m[x][y] = p
    for (nx,ny) in (x-1,y),(x+1,y),(x,y-1),(x,y+1):
      if (nx,ny) == to: return p # we finish as soon as we can
      if m[nx][ny] != 0: continue # not free space
      if (nx,ny) not in next: next.append((nx,ny))
  return step( m, next, p+1, to )

def findpath( m, fm, to ): return step( m, [fm], 1, to )

d = {} # distances between marked points; we assume they are all connected
for i in range(len(t)-1):
  for j in range(i+1,len(t)):
    d[(i,j)] = d[(j,i)] = findpath( [r[:] for r in m], t[i], t[j] )

import itertools
def minsum( n, d, and_back=False ):
  ms = 0
  for p in itertools.permutations( range(1,n) ):
    q = and_back and p+(0,) or p
    s = sum(d[(x,y)] for (x,y) in zip((0,)+p,q))
    if ms==0 or s<ms: ms = s
  return ms
print( minsum( len(t), d ) )
print( minsum( len(t), d, and_back=True ) )
