t = open('06.dat','rt').read().strip().split('\n')

print( ''.join(max((clmn.count(c),c) for c in clmn)[1] for clmn in zip(*t)) )
print( ''.join(min((clmn.count(c),c) for c in clmn)[1] for clmn in zip(*t)) )

#for m in max,min: print( ''.join(m((clmn.count(c),c) for c in clmn)[1] for clmn in zip(*t)) )

#submited by _2bt, added 'rt' and strip() by me
#for m in max, min: print( "".join(m(l, key=l.count) for l in zip(*open("06.dat","rt"))).strip() )

if 0: # the above is shorter :)
  n = len(t[0]); d = [{} for i in range(n)]
  for i in range(n): assert len(t[i])==n
  for l in t: # can't have two for's in one line
    for i,c in enumerate(l): d[i][c] = d[i].get(c,0)+1
  sd = [sorted([(d[i][c],c) for c in d[i]]) for i in range(n)]
  print( ''.join( sd[i][-1][1] for i in range(n)) )
  print( ''.join( sd[i][0][1] for i in range(n)) )
