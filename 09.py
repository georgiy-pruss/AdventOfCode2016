t = open('09.dat','rt').read().strip()

p = 0
o = 0
while True:
  b = t.find( '(', p )
  if b<0: o += len(t[p:]); break
  e = t.find( ')', b+1 )
  if e<0: o += len(t[p:]); break
  o += b-p
  r,n = map(int,t[b+1:e].split('x'))
  o += r*n
  p = e+1+r
print(o)

import time
o = 0 # output length
##k = 0 # counter, just for showing progress
##m = len(t) # min len of text, just for showing
##started = time.time()
while True:
  b = t.find( '(' )
  if b<0: o += len(t); break
  e = t.find( ')', b+1 )
  if e<0: o += len(t); break
  o += b
  r,n = map(int,t[b+1:e].split('x'))
  t = t[e+1:e+1+r]*n + t[e+1+r:]
  ##if len(t)<m: m=len(t)
  ##k += 1
  ##if k%1000000==0: print(k//1000000,'t',len(t),'m',m,'o',o)
print(o)
##print(time.time()-started)
