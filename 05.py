import hashlib

t = b'uqwqemis'

def md5(s): return hashlib.md5(s).hexdigest()

# https://en.wikipedia.org/wiki/MD5
assert '9e107d9d372bb6826bd81d3542a419d6' == md5(b'The quick brown fox jumps over the lazy dog')

assert '000001' == md5(b'abc3231929')[:6]
assert '000008' == md5(b'abc5017308')[:6]
assert '00000f' == md5(b'abc5278568')[:6]

def f(s):
  B = '_' # blank char
  o1 = ''
  o2 = 8*B
  d = 0   # digits done
  i = 0
  while True:
    m = md5( s+b'%d'%i )
    if m[:5] == '00000':
      if len(o1)<8: o1 += m[5]
      if '0'<=m[5]<='7':
        p = int(m[5])
        if o2[p] == B:
          o2 = o2[:p]+m[6]+o2[p+1:] # print( i ); print( o2 )
          d += 1
          if d==8: break
    i += 1
  return o1,o2

# o1,o2 = f( b'abc' )
# assert o1 == '18f47a30' # 9.7 s, 8605828 iterations
# assert o2 == '05ace8e3' # 15.6 s, 13753421 iterations

o1,o2 = f(t)
print( o1 ) # 1a3099aa, 19 s, 16734551 iterations
print( o2 ) # 694190cd, 30 s, 26326685 iterations
