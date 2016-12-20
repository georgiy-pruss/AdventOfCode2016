def u(r,q):
  if q[0]<r[0]: r,q = q,r
  if r[0]<=q[0]<=r[1]:
    if q[1]<=r[1]: return 1,r[0],r[1]
    return 1,r[0],q[1]
  if r[1]+1==q[0]:
    return 1,r[0],q[1]
  return 2,(r[0],r[1]),(q[0],q[1])

rr = [] # [(a,b),(c,d),...]
for l in open('20.dat','rt').read().strip().split('\n'):
  p,q = l.split('-')
  a,b = int(p),int(q)
  if a>b: a,b = b,a
  if len(rr)==0: rr = [(a,b)]; continue
  nr = []
  for i,r in enumerate(rr):
    k,x,y = u(r,(a,b))
    if k==1:
      a,b = x,y
    else:
      nr.append(x); a,b = y
  nr.append( (a,b) )
  rr = nr

if rr[0][0]==0:
  print(rr[0][1]+1)
else:
  print(rr[0][0]-1)

c = 2**32
for (x,y) in rr:
  c -= y-x+1
print(c)
