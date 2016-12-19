def s1( n ):
  g = [1]*n
  o = n
  l = -1 # last one
  while o>1:
    for i in range(n): # i-th acts
      if g[i]==0: continue
      for j in range(n): # find pray
        j=(j+i+1)%n
        if g[j]!=0:
          g[j]=0
          o -= 1
          l = i
          break
  return l

# print( s1(3018458)+1 ) -- very slow... but has answer
# run s1 for first several n, then ask this sequence at oeis.org:
# Josephus problem http://oeis.org/A006257 a(n)=ROL(n,1)
# so it's just binary rotate left 1 bit!

def s1fast( n ): return int(bin(n)[3:]+'1',2)
print( s1fast(3018458) )

def s2( n ):
  g = [1]*n
  o = n
  i = 0 # current one
  l = -1 # last one
  while o>1:
    if g[i]==0: i=(i+1)%n; continue
    # find "half" from us, n//2-1 th
    j = (i+1)%n
    k = 0
    while True:
      if g[j]: k+=1
      if k==o//2: break
      j = (j+1)%n
    l = i
    g[j]=0
    o -= 1
    if o==1: break
    i=(i+1)%n
  return l

if 0:
  # run for some few members
  p = 0
  for i in range(88):
    n = s2( i+2 )+1
    if n<p: print()
    p = n
    print( n, end=' ' )
  print()
  # this sequence:
  # 1-3: 1 1 3
  # 4-9: 1-3 5--9
  # 10-27: 1-9 11--27
  # 28-81: 1-27 29--81
  # 82-...: 1-81 83--243

# so it's better to 1) find range between powers of 3
# 2) find in which half the number is, first is with increments 1 (1...3^x),
# the second is odd numbers 3^x+2...3^(x+1)
def s2fast( n ):
  k=1
  while 3*k<n: k*=3 # log(3,n)
  if n<=2*k: return n-k
  return (n-2*k)*2+k

print( s2fast(3018458) )
