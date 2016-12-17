import hashlib
def md5(s): return hashlib.md5(s).hexdigest()

# grid is 1 2 3 4, 5 6 ... to 16; next state is...
door_u = [0,  0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12]
door_d = [0,  5, 6, 7, 8, 9,10,11,12,13,14,15,16, 0, 0, 0, 0]
door_l = [0,  0, 1, 2, 3, 0, 5, 6, 7, 0, 9,10,11, 0,13,14,15]
door_r = [0,  2, 3, 4, 0, 6, 7, 8, 0,10,11,12, 0,14,15,16, 0]

def whatdoorsopen( path, salt ): # u d l r
  s = md5( salt + path )
  return s[0] in 'bcdef', s[1] in 'bcdef', s[2] in 'bcdef',  s[3] in 'bcdef'

def moves( st, path, salt ):
  u,d,l,r = whatdoorsopen( path, salt )
  st_path = [] # new
  if u and door_u[st]: st_path.append( (door_u[st], b'U') )
  if d and door_d[st]: st_path.append( (door_d[st], b'D') )
  if l and door_l[st]: st_path.append( (door_l[st], b'L') )
  if r and door_r[st]: st_path.append( (door_r[st], b'R') )
  return st_path

def play( state, final, salt, maxsteps=1000 ):
  shortest = ''
  longest = ''
  path = b''
  b = [ [(state,path)] ] # b will save all states at all levels
  for k in range(maxsteps):
    bk = b[k]
    b.append( [] )
    for state,path in bk:
      st_path = moves( state, path, salt )
      for s,p in st_path:
        if s==final:
          if not shortest: shortest = path+p
          longest = path+p
        else:
          b[k+1].append( (s,path+p) )
    if len(b[k+1])==0: # no more moves
      return ( shortest, len(longest) )
  return (b'',0) # not finished in given number of steps

#assert play( 1, 16, b'ihgpwlah' ) == ( b'DDRRRD', 370 )
#assert play( 1, 16, b'kglvqrro' ) == ( b'DDUDRLRRUDRD', 492 )
#assert play( 1, 16, b'ulqzkmiv' ) == ( b'DRURDRUDDLLDLUURRDULRLDUUDDDRR', 830 )

print( (b"%s %d" % play( 1, 16, b'bwnlcvfs' )).decode('ascii') )
