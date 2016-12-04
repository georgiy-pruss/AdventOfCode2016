t = open('03.dat','rt').read().strip().split('\n')
def tr(x,y,z): return x+y>z and x+z>y and y+z>x
m = 0 # horizontal triangles
n = 0 # vertical triangles
k = 0 # for counting by 3
for l in t:
  x,y,z = l.split(); x=int(x); y=int(y); z=int(z)
  if tr(x,y,z): m += 1
  k += 1
  if k%3 == 1: x1,y1,z1 = x,y,z
  if k%3 == 2: x2,y2,z2 = x,y,z
  if k%3 == 0:
    if tr(x,x1,x2): n += 1
    if tr(y,y1,y2): n += 1
    if tr(z,z1,z2): n += 1
print(m)
print(n)
