t = open('09.dat','rt').read().strip()

def v( t, k ):
  p = 0 # current position in string
  o = 0 # counted length
  while True:
    b = t.find( '(', p )
    if b<0: o += len(t)-p; return o
    e = t.index( ')', b+1 ) # fail if not found
    o += b-p
    r,n = map(int,t[b+1:e].split('x'))
    if k==1: o += r*n # part 1
    else: o += n * v( t[e+1:e+1+r], 2 ) # part 2
    p = e+1+r # could be recursion on t[e+1+r:] but we'd better loop

print(v(t,1))
print(v(t,2))
