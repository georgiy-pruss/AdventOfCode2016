# http://adventofcode.com/2016/day/2
def gc( t, d ):
  n = '5'
  o = ''
  for l in t:
    if len(l)==0: continue
    for c in l:
      n = d[c][int(n,16)]
    o += n
  return o
t = open('02.dat','rt').read().split('\n')
d1 = {'U':'-123123456', 'D':'-456789789', 'L':'-112445778', 'R':'-233566899'}
s = ['ULL','RRDDD','LURDL','UUUUD']
assert gc( s, d1 ) == '1985'
print( gc( t, d1 ) )
d2 = {'U':'-121452349678B','D':'-36785ABC9ADCD','L':'-122355678AABD','R':'-134467899BCCD'}
assert gc( s, d2 ) == '5DB3'
print( gc( t, d2 ) )
