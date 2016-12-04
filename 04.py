t = open('04.dat','rt').read().strip().split('\n')

def maxindex(a):
  maxi = -1; maxe = -1
  for i,e in enumerate(a):
    if e>maxe: maxi,maxe = i,e
  return maxi

def shiftcrypt( t, n ):
  o = ''
  for c in t:
    if c=='-': o += ' '
    else: o += chr((ord(c)-ord('a')+n) % 26 + ord('a'))
  return o

assert shiftcrypt( 'qzmt-zixmtkozy-ivhz', 343 ) == 'very encrypted name'

nsum = 0
for r in t:
  c = [0]*26 # counter for letters
  n = 0 # id
  s = 0 # checksum
  w = '' # save word here
  for i,e in enumerate(r):
    if 'a'<=e<='z':
      c[ord(e)-ord('a')] += 1
    elif '0'<=e<='9':
      if w=='': w = r[:i-1]
      n = 10*n + ord(e)-ord('0')
    elif e=='[':
      cs = r[i+1:-1]; break
  a = ''
  for i in range(5):
    k = maxindex(c)
    a += chr(ord('a')+k)
    c[k] = -1
  if a == cs:
    nsum += n
  rs = shiftcrypt( w, n )
  if 'north' in rs: # actually it's 'northpole object storage'
    task2 = n

print( nsum )
print( task2 )
