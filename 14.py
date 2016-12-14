import hashlib

t = b'jlmsuwbz'

def md5(s): return hashlib.md5(s).hexdigest()

# https://en.wikipedia.org/wiki/MD5
assert '9e107d9d372bb6826bd81d3542a419d6' == md5(b'The quick brown fox jumps over the lazy dog')

hashes = [] # plain md5 hashes
shs = [] # stretched hashes

def getmd5( i ):
  if i<len(hashes):
    return hashes[i]
  assert i==len(hashes) # they increase
  h = md5( t+b'%d'%i )
  hashes.append( h )
  return h

def getsh( i ):
  if i<len(shs):
    return shs[i]
  assert i==len(shs) # they increase
  h = getmd5( i )
  for l in range(2016):
    h = md5( h.encode('ascii') )
  shs.append(h)
  return h

def findin1000( k, m, part ):
  for j in range(k+1,k+1+1000):
    h = part==1 and getmd5(j) or getsh(j)
    if m in h:
      return j
  return 0

def hasXXX(s): # return 5-X pattern or None
  for i in range(len(s)-2):
    if s[i]==s[i+1]==s[i+2]:
      return s[i]*5
  return None

def solve( part ):
  k = 0
  for i in range(64):
    while 1:
      h = part==1 and getmd5(k) or getsh(k)
      m = hasXXX(h)
      if m is not None:
        if findin1000( k, m, part ):
          break
      k += 1
    k += 1
  return k-1

# test:
# t = b'abc'
# for i in range(10000): getmd5(i)
# assert '888' in getmd5(18)
# assert 'eee' in getmd5(39) and 'eeeee' in getmd5(816)
# assert getsh(0) == 'a107ff634856bb300138cac6568c0f24'
# solve for 'abc' --> 22728 22551

k1 = (1139, 1180, 1190, 1304, 1340, 1462, 1615, 1806, 1820, 1891, 2771, 2810, 2922, 3042, 3392,
      3581, 3673, 3700, 7958, 8101, 8318, 8529, 8694, 15969, 16398, 16853, 17083, 17236, 17617,
      17721, 20769, 20885, 21009, 21277, 21378, 21557, 21684, 23191, 23237, 23274, 23289,
      23340, 23421, 23486, 23506, 23608, 23653, 23691, 23700, 23803, 23916, 24007, 24053,
      24167, 24169, 34300, 34463, 34487, 34638, 34769, 35162, 35170, 35171, 35186)
k2 = (41, 108, 151, 311, 312, 375, 501, 531, 595, 3794, 3810, 3858, 4006, 4083, 4272, 4665,
      4738, 5721, 5938, 6136, 6165, 6233, 6253, 6271, 6326, 7504, 7619, 7654, 7870, 8108,
      8142, 8356, 8394, 8739, 12382, 12596, 12662, 12822, 13194, 13210, 13413, 14536, 14597,
      14917, 14927, 14948, 15001, 15063, 15150, 15271, 15324, 15431, 19351, 19480, 19481,
      19657, 19724, 20049, 20257, 22196, 22381, 22382, 22417, 22429)

print( solve(1) ) # 35186 - 1.2s
print( solve(2) ) # 22429 - 42s
