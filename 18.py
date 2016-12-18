def f(a,b,c): return (a,b,c) in ((1,1,0),(0,1,1),(1,0,0),(0,0,1))
def a(o): w = [0]+o+[0]; return [int(f(w[i],w[i+1],w[i+2])) for i in range(len(o))]
# better rule:
def a(o): w = o+[0]; return [w[i-1]!=w[i+1] for i in range(len(o))]
def c(o): return len(o)-sum(o)

def s(v,n):
  m = c(v)
  for i in range(n-1):
    v = a(v)
    m += c(v)
  return m

assert a([0,0,1,1,0]) == [0,1,1,1,1]
assert a(a([0,0,1,1,0])) == [1,1,0,0,1]
assert s([0,1,1,0,1,0,1,1,1,1],10) == 38

v = [x=='^' for x in open('18.dat','rt').read().strip()]
print(s(v,40))
print(s(v,400000))
