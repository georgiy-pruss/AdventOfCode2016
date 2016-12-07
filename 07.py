t = open('07.dat','rt').read().strip().split('\n')

def hasabba( s ):
  for i in range(len(s)-3):
    if s[i]==s[i+3] and s[i+1]==s[i+2] and s[i]!=s[i+1]: return True
  return False

def testabba( l ):
  ok = False
  for p in l.split(']'):
    d = p.split('[')
    if len(d) == 2:
      if hasabba(d[1]): return False
      if hasabba(d[0]): ok = True
    else:
      if hasabba(p): ok = True
  return ok

def abalist( s ):
  return [s[i:i+3] for i in range(len(s)-2) if s[i]==s[i+2] and s[i]!=s[i+1]]

def aba_bab( l ):
  aba = []
  bab = []
  for ps in l.split(']'):
    d = ps.split('[')
    if len(d) == 2:
      aba += abalist(d[0])
      bab += abalist(d[1])
    else:
      aba += abalist(ps)
  return aba, bab

def testababab( l ):
  aba,bab = aba_bab( l )
  if len(aba)==0 or len(bab) == 0: return False
  for a in aba:
    if a[1]+a[0]+a[1] in bab:
      return True
  return False

assert testabba( 'abba[mnop]qrst' )
assert not testabba( 'abcd[bddb]xyyx' )
assert not testabba( 'aaaa[qwer]tyui' )
assert testabba( 'ioxxoj[asdfgh]zxcvbn' )

assert testababab( 'aba[bab]xyz' )
assert not testababab( 'xyx[xyx]xyx' )
assert testababab( 'aaa[kek]eke' )
assert testababab( 'zazbz[bzb]cdb' )

print( sum(testabba(l) for l in t) )
print( sum(testababab(l) for l in t) )
