def f(x,y): return x*x + 3*x + 2*x*y + y + y*y + 1358
def o(n): return bin(n)[2:].count('1')%2==0 # open

OPEN,WALL = 0,-1

def gen(r,c): return [[(WALL,OPEN)[o(f(x,y))] for x in range(c)] for y in range(r)]

def directions( m, y, x ):
  d = []
  if y>0           and m[y-1][x]==OPEN: d.append((x,y-1))
  if y<len(m)-1    and m[y+1][x]==OPEN: d.append((x,y+1))
  if x>0           and m[y][x-1]==OPEN: d.append((x-1,y))
  if x<len(m[0])-1 and m[y][x+1]==OPEN: d.append((x+1,y))
  return d

def step( m, ends, p, to, cnt, maxp ):
  if p<=maxp: cnt += len(ends)
  next = []
  for x,y in ends:
    m[y][x] = p
    dirs = directions( m, y, x )
    for d in dirs:
      if d == to: return p, cnt # we finish as soon as we can
      if d not in next: next.append(d)
  return step( m, next, p+1, to, cnt, maxp )

def findpath( m, fm, to ): return step( m, [fm], 1, to, 0, 50+1 )

print( "%d %d" % findpath( gen(50,50), (1,1), (31,39) ) )
