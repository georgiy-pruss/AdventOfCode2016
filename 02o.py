h=lambda t,d,r=__import__('functools').reduce:r(lambda s,l,f=lambda n,c:d[c][int(n,16)]:(r(f,l,s[0]),s[1]+r(f,l,s[0])),t,('5',''))[1]

# keypad descriptions
d1={'U':'x123123456','D':'x456789789','L':'x112445778','R':'x233566899'}
d2={'U':'x121452349678B','D':'x36785ABC9ADCD','L':'x122355678AABD','R':'x134467899BCCD'}
# tests
s = ['ULL','RRDDD','LURDL','UUUUD']
assert h( s, d1 ) == '1985'
assert h( s, d2 ) == '5DB3'
# solutions
t = open('02.dat','rt').read().strip().split('\n')
print( h( t, d1 ) )
print( h( t, d2 ) )

# h=... is 132 chars and full solutions below: 258 and 274 chars
print((lambda t,d,r=__import__('functools').reduce:r(lambda s,l,f=lambda n,c:d[c][int(n,16)]:(r(f,l,s[0]),s[1]+r(f,l,s[0])),t,('5',''))[1])(open('02.dat','rt').read().strip().split('\n'),{'U':'x123123456','D':'x456789789','L':'x112445778','R':'x233566899'}))
print((lambda t,d,r=__import__('functools').reduce:r(lambda s,l,f=lambda n,c:d[c][int(n,16)]:(r(f,l,s[0]),s[1]+r(f,l,s[0])),t,('5',''))[1])(open('02.dat','rt').read().strip().split('\n'),{'U':'x121452349678B','D':'x36785ABC9ADCD','L':'x122355678AABD','R':'x134467899BCCD'}))
