def g(a): return a+'0'+''.join(c=='0'and'1'or'0' for c in reversed(a))
def gg(a,n): return len(a)>=n and a[:n] or gg(g(a),n)
def h(a): return ''.join('01'[a[i]==a[i+1]] for i in range(0,len(a),2))
def hh(a): return len(a)%2==1 and a or hh(h(a))

#assert g('0') == '001'
#assert g('1') == '100'
#assert g('11111') == '11111000000'
#assert g('111100001010') == '1111000010100101011110000'
#print( gg('10000',20) )
#assert hh( gg('10000',20) ) == '01100'

print( hh( gg('01110110101001000',272) ) )      # 11100111011101111
print( hh( gg('01110110101001000',35651584) ) ) # 10001110010000110
