t = open('10.dat','rt').read().strip().split('\n')

E,O,B = 0,0,1 # empty value; what:Output, what:Bot
bot = {} # i-th bot: [lo-what lo-# hi-what hi-# v1 v2]
out = {}

# first we build the bot net
for l in t:
  l = l.split()
  if l[0]=='bot':
    k = int(l[1])
    assert l[3]=='low' and l[8]=='high'
    if l[5]=='bot': lo=B
    else: assert l[5]=='output'; lo=O
    lk = int(l[6])
    if l[10]=='bot': hi=B
    else: assert l[10]=='output'; hi=O
    hk = int(l[11])
    bot[k] = [lo,lk,hi,hk,E,E]

def pv( v, w, k ): # pass value
  if w==B:
    if k not in bot: print( 'no such bot', k )
    bk = bot[k]
    if bk[4]==E: bk[4]=v
    else:
      if bk[5]!=E: print( 'change bot',k,'to',v,'it had',bk[4],bk[5] )
      bk[5]=v
      lv = min(bk[4],bk[5])
      hv = max(bk[4],bk[5])
      if lv==17 and hv==61: # part 1: catch what was asked!
        print( k )
      pv( lv, bk[0], bk[1] )
      pv( hv, bk[2], bk[3] )
  else: # w==O
    if k in out: print( 'change output',k,'to',v,'it had',out[k] )
    out[k] = v

# then we spread values
for l in t:
  l = l.split()
  if l[0]=='value':
    v = int(l[1])
    k = int(l[5])
    pv( v, B, k )

print( out[0]*out[1]*out[2] ) # part 2: multiply outputs

# for bk in sorted(bot.keys()): print( bk, bot[bk] )
# for ok in sorted(out.keys()): print( ok, out[ok] )
