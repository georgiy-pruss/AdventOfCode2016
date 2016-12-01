# day 01 http://adventofcode.com/2016/day/1

cx,cy = 0,0  # we walk on x,y plane
curdir = 0   # north, 1=east, 2=south, 3=west
task2 = -1   # will be >=0 when done
visited = {} # for task2
for e in open("01.dat","rt").read().strip().replace(',','').split():
  curdir = (curdir+(e[0]=='R' and 1 or 3)) % 4
  dx = (0,1,0,-1)[curdir]; dy = (1,0,-1,0)[curdir]
  dst = int(e[1:])
  if task2<0:
    for p in range(1,dst+1):
      nx,ny = cx+dx*p,cy+dy*p
      if (nx,ny) in visited:
        task2 = abs(nx)+abs(ny)
        break
      visited[ (nx,ny) ] = True
  cx,cy = cx+dx*dst,cy+dy*dst
print( abs(cx)+abs(cy) )
print( task2 )
