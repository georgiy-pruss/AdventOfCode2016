def test( l ): # test line; line is one of s
  if len(l)==0:
    return True
  for x in l:
    if x<0:
      p = -x
      if p in l:
        pass
      else:
        for y in w: # 1 to 5 or 1 to 7
          if y!=p and y in l:
            return False
  return True

def testend( s ):
  return 0==len(s[1])==len(s[2])==len(s[3]) # all at s[4] and s[0]==4

def validmoves( s ):
  c = [] # candidates
  e = s[0][0]
  l = s[e] # current line, moves are only for it
  if e+1<len(s): # can go up
    ln = s[e+1] # next line
    for i,x in enumerate(l):
      lx = l[:]; lx.remove(x)
      if test(lx):
        lu = ln[:]; lu.append(x)
        if test(lu):
          c.append( (x,0,1) ) # only x, no second, up
      # now try x and some second item
      for j in range(i+1,len(l)):
        y = l[j]
        lxy = lx[:]; lxy.remove(y)
        if test(lxy):
          lu = ln[:]; lu.append(x); lu.append(y)
          if test(lu):
            c.append( (x,y,1) )
  if e>1: # can go down; we numerate them from 1
    ln = s[e-1]
    for i,x in enumerate(l):
      lx = l[:]; lx.remove(x)
      if test(lx):
        ld = ln[:]; ld.append(x)
        if test(ld):
          c.append( (x,0,-1) ) # only x, no second, down
      # now try x and some second item
      for j in range(i+1,len(l)):
        y = l[j]
        lxy = lx[:]; lxy.remove(y)
        if test(lxy):
          ld = ln[:]; ld.append(x); ld.append(y)
          if test(ld):
            c.append( (x,y,-1) )
  return c

def normalize( s ):
  return ';'.join(' '.join(str(x) for x in sorted(l)) for l in s)

def restore( norm_s ):
  return [[int(x) for x in l.split()] for l in norm_s.split(';')]

def findline( c, s ):
  for i in range(1,5): # lines 1..4
    if c in s[i]: return i
  return -1

def prune( s, clist ):
  clistnew = []
  for c in clist:
    if c[1]==0: # only one
      cxl = findline( -c[0], s )
      for co in r: # if there's already such move with smaller number
        if abs(co)>=abs(c[0]): continue
        if co not in s[s[0][0]]: continue
        if (co,0,c[2]) in clist and -co in s[cxl]:
          break
      else:
        clistnew.append(c)
    else:
      # to hell with that! we'll bruteforce!
      clistnew.append(c)
  return clistnew

def analyze( k, s, prev_s_c=() ): # analyze new state
  norm_s = normalize( s ) # for dictionary key
  if norm_s in d:
    return 0,'ALREADY TRIED'
  if testend(s):
    d[ norm_s ] = ([],prev_s_c)
    return -1,'SUCCESS'

  # make list on candidates and validate them
  clist = validmoves( s )
  if len(clist)==0:
    return 0,'NO MOVES'

  # prune clist -- remove 'structurally' identical moves
  # it doesn't help much actually
  clist = prune( s, clist )

  # we're going to try candidates, but first remember the state
  d[ norm_s ] = (clist,prev_s_c) # list of candidates and where from

  # and save it in breadth dictionary
  if k not in b: b[k] = [] # k-th level
  if norm_s not in b[k]:
    b[k].append( norm_s )

  return len(clist),'candidates to try'

def nextstate( s, c ):
  ns = [[x for x in l] for l in s] # make copy
  x,y,mv = c
  e = ns[0][0]
  ns[e].remove(x)
  if y: ns[e].remove(y)
  e += mv
  ns[e].append(x)
  if y: ns[e].append(y)
  ns[0][0] = e
  return ns

def draw( s ):
  dd = {-1:'a',-2:'b',-3:'c',-4:'d',-5:'e',-6:'f',-7:'g',1:'A',2:'B',3:'C',4:'D',5:'E',6:'F',7:'G'}
  s = restore(s)
  for i in (4,3,2,1):
    o = ''
    if s[0][0]==i: o += '* '
    else: o += '  '
    for p in v:
      if p in s[i]:
        o += dd[p]+' '
      else:
        o += '- '
    print( o )
  print()

def success( s,  ):
  k = 0
  print( 'end:', s )
  norm_s = normalize( s )
  draw( norm_s )
  while 42:
    prev_s_c = d[ norm_s ][1]
    if not prev_s_c: break
    norm_s,c = prev_s_c # normalized state there
    k += 1
    print( 'prev', norm_s, c )
    draw(norm_s)
  print( k ) # <-- the answer!

def domoves( k ): # do all the moves at step k
  for norm_s in b[k]:
    # restore state
    s = restore( norm_s )
    clist = d[ norm_s ][0] # clist from state norm_s
    for c in clist: # and advance k!
      ns = nextstate( s, c )
      n,msg = analyze( k+1, ns, (norm_s,c) )
      if n<0:
        success( ns )
        return True
  print( 'domoves',k,'next',len(b[k+1]) )
  return False


d = {} # done -- dict of passed states; (e,s)->[c]
b = {} # breadth-wise dist for BFS: move k ->[(e,s),...]
v = (-1,1,-2,2,-3,3,-4,4,-5,5)
r = range(-5,5+1)
w = (1,2,3,4,5)
s = [[1], [-1,1],[2,3,4,5],[-2,-3,-4,-5],[]]

analyze( 0, s )
for k in range(35): # 35 will be enough
  if domoves( k ): # do all the moves at level k
    break

d = {} # done -- dict of passed states; (e,s)->[c]
b = {} # breadth-wise dist for BFS: move k ->[(e,s),...]
v = (-1,1,-2,2,-3,3,-4,4,-5,5,-6,6,-7,7)
r = range(-7,7+1)
w = (1,2,3,4,5,6,7)
s = [[1], [-1,1,-6,6,-7,7],[2,3,4,5],[-2,-3,-4,-5],[]]

analyze( 0, s )
for k in range(99):
  if domoves( k ): # do all the moves at level k
    break
