def f(x,y): return x*x + 3*x + 2*x*y + y + y*y + 1358
def o(n): return bin(n)[2:].count('1')%2==0 # open

OPEN,WALL = 0,-1

def gen(r,c): return [[(WALL,OPEN)[o(f(x,y))] for x in range(c)] for y in range(r)]

def show(m,fm=None,to=None):
  r = len(m)
  c = len(m[0])
  print('    '+(' 0 1 2 3 4 5 6 7 8 9'*((c+9)//10))[:2*c])
  for y in range(r):
    print('%3d'%y,end=' ')
    for x in range(c):
      v = m[y][x]
      if v==OPEN: z = '  '
      elif v==WALL: z = '\u2588'*2
      else: z='%2d'%(v-1)
      if fm and (x,y)==fm: z='()'
      if to and (x,y)==to: z='[]'
      print(z,end='')
    print()

def directions( m, y, x ):
  d = []
  if y>0           and m[y-1][x]==OPEN: d.append((x,y-1))
  if y<len(m)-1    and m[y+1][x]==OPEN: d.append((x,y+1))
  if x>0           and m[y][x-1]==OPEN: d.append((x-1,y))
  if x<len(m[0])-1 and m[y][x+1]==OPEN: d.append((x+1,y))
  return d

r50 = 0 # reachable within len 50

def onestep( m, candidates, p, to ):
  global r50
  if p<52: # we start with 1, so it's 1 to 51
    r50 += len(candidates)
  for x,y in candidates: m[y][x] = p
  newcandidates = []
  for x,y in candidates:
    dirs = directions( m, y, x )
    for d in dirs:
      if d == to: return p # we finish as soon as we can
      if d not in newcandidates: newcandidates.append(d)
  return onestep( m, newcandidates, p+1, to )

def findpath( m, fm, to ): return onestep( m, [fm], 1, to )

m = gen(50,50)
print( findpath( m, (1,1), (31,39) ) )
print( r50 )
show( m, (1,1), (31,39) )
