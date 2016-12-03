t = open('03.dat','rt').read().strip().split('\n')
m = 0
n = 0
k = 0
for l in t:
  x,y,z = l.split(); x=int(x); y=int(y); z=int(z)
  if x+y>z and x+z>y and y+z>x: m += 1
  k += 1
  if k%3 == 1: x1,y1,z1 = x,y,z
  if k%3 == 2: x2,y2,z2 = x,y,z
  if k%3 == 0:
    if x+x1>x2 and x+x2>x1 and x1+x2>x: n += 1
    if y+y1>y2 and y+y2>y1 and y1+y2>y: n += 1
    if z+z1>z2 and z+z2>z1 and z1+z2>z: n += 1
print(m)
print(n)
