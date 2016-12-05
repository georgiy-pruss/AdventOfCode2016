import hashlib

t = b'uqwqemis'

def md5(s): return hashlib.md5(s).hexdigest()

# https://en.wikipedia.org/wiki/MD5
assert '9e107d9d372bb6826bd81d3542a419d6' == md5(b'The quick brown fox jumps over the lazy dog')

assert '1' == md5(b'abc3231929')[5]
assert '8' == md5(b'abc5017308')[5]
assert 'f' == md5(b'abc5278568')[5]

def f(s): # part 1
  i = 0
  o = ''
  while True:
    m = md5( s+b'%d'%i )
    if m[:5] == '00000':
      o += m[5]
      if len(o)==8: break
    i += 1
  # print(i)
  return o

def g(s): # part 2
  i = 0
  B = '_' # blank char
  o = 8*B
  d = 0   # digits done
  while True:
    m = md5( s+b'%d'%i )
    if m[:5] == '00000':
      if '0'<=m[5]<='7':
        p = int(m[5])
        if o[p] == B:
          o = o[:p]+m[6]+o[p+1:]
          d += 1
          # print( i )
          # print( o )
          if d==8: break
    i += 1
  return o

# assert f( b'abc' ) == '18f47a30' # 9.7 s, 8605828 iterations
# assert g( b'abc' ) == '05ace8e3' # 15.6 s, 13753421 iterations

print( f( t ) ) # 1a3099aa, 19 s, 16734551 iterations
print( g( t ) ) # 694190cd, 30 s, 26326685 iterations
