t = open('04.dat','rt').read().strip().split('\n')

def maxindex(a):
  m = -1
  x = -1
  for i,e in enumerate(a):
    if e>m:
      x,m = i,e
  return x,m

def shift( t, n ):
  o = ''
  for c in t:
    if c=='-':
      o += ' '
    else:
      o += chr((ord(c)-ord('a')+n) % 26 + ord('a'))
  return o

assert shift( 'qzmt-zixmtkozy-ivhz', 343 ) == 'very encrypted name'

nsum = 0
for r in t:
  c = [0]*26 # counter for letters
  n = 0 # id
  j = 0 # begin of id = end of name
  s = 0 # checksum
  for i,e in enumerate(r):
    if 'a'<=e<='z':
      c[ord(e)-ord('a')] += 1
    elif '0'<=e<='9':
      if j==0: j = i
      n = 10*n + ord(e)-ord('0')
    elif e=='[':
      cs = r[i+1:-1]
      break
  a = ''
  for i in range(5):
    k,m = maxindex(c)
    a += chr(ord('a')+k)
    c[k] = -1
  if a==cs:
    nsum += n
  rs = shift( r[0:j-1], n )
  if 'north' in rs or 'pole' in rs:  # actually it's 'northpole object storage'
    t2 = n

print( nsum )
print( t2 )
