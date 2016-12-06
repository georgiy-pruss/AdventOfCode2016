t = open('06.dat','rt').read().strip().split('\n')
n = len(t[0]); d = [{} for i in range(n)]
for i in range(n): assert len(t[i])==n
for l in t: # can't have two for's in one line
  for i,c in enumerate(l): d[i][c] = d[i].get(c,0)+1
sd = [sorted([(d[i][c],c) for c in d[i]]) for i in range(n)]
print( ''.join( sd[i][-1][1] for i in range(n)) )
print( ''.join( sd[i][0][1] for i in range(n)) )
