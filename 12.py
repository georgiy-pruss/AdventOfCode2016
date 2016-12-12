def xlate(l): # returns (OPCODE(0-6), NUM/R#, NUM/R#)
  A = ord('a')
  s = l.split()
  if s[0]=='cpy':
    if s[1] in 'abcd': return (1,ord(s[1])-A,ord(s[2])-A) # 1: cpy r1 r2
    else: return (2,int(s[1]),ord(s[2])-A)                # 2: cpi n1 r2
  if s[0]=='inc': return (3,ord(s[1])-A,0)                # 3: inc r _
  if s[0]=='dec': return (4,ord(s[1])-A,0)                # 4: dec r _
  if s[0]=='jnz':
    if s[1] in 'abcd': return (5,ord(s[1])-A,int(s[2]))   # 5: jnz r1 n2
    if int(s[1])!=0: return (6,int(s[2]),0)               # 6: jmp n _
    return (0,int(s[2]),0)                                # 0: nop n _
  print( 'unrecognized instr.', l )

# r is IN/OUT
def cpy_x_y(r,x,y): r[y] = r[x]
def cpi_x_y(r,x,y): r[y] = x
def inc_x(r,x,_): r[x]+=1;
def dec_x(r,x,_): r[x]-=1;
def jnz_x_y(r,x,y):
  if r[x]!=0: r[-1] = r[-1]-1+y # everywhere r[-1]->r[4] => 9.31s->8.96s
def jmp_x(r,x,_): r[-1] = r[-1]-1+x
def nop_x(r,x,_): pass

def exec(regs,t): # get regs (a,b,c,d,pc), return other regs
  it = (nop_x,cpy_x_y,cpi_x_y,inc_x,dec_x,jnz_x_y,jmp_x)
  r = list(regs) # make copy/cvt to list
  lt = len(t)
  pc = r[-1] # faster if it's in a var
  while 0<=pc<lt:
    c,x,y = t[pc]
    r[-1]+=1
    it[c](r,x,y) # r is IN/OUT
    pc=r[-1]
  return r

sample = ('cpy 41 a','inc a','inc a','dec a','jnz a 2','dec a')
assert exec( (0,0,0,0,0), [xlate(l) for l in sample] )[0]==42

t = [xlate(l) for l in open('12.dat','rt').read().strip().split('\n')]
print( exec( (0,0,0,0,0), t )[0] ) # 954395 instr
print( exec( (0,0,1,0,0), t )[0] ) # 27683406 instr; 9.31 s; 2.97 Mops
