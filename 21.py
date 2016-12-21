def scramble(a,d):
  for s in d:
    s1=s[1]
    if s1=='letter': # 'swap letter X with letter Y'
      x=a.index(s[2]); y=a.index(s[5])
      if x>y: x,y=y,x
      if x!=y: a = a[:x]+a[y]+a[x+1:y]+a[x]+a[y+1:]
    elif s1=='left': # 'rotate left X steps'
      n = int(s[2])
      if n!=0: a=a[n:]+a[:n]
    elif s1=='right': # 'rotate right X steps'
      n = int(s[2])
      if n!=0: a=a[-n:]+a[:-n]
    elif s1=='based': # 'rotate based on position of letter X'
      n = a.index(s[6])
      a=a[-1:]+a[:-1]
      a=a[-n:]+a[:-n]
      if n>=4: a=a[-1:]+a[:-1]
    elif s1=='positions': # 'reverse positions X through Y'
      x=int(s[2]); y=int(s[4])
      if x>y: x,y=y,x
      a=a[:x]+a[x:y+1][::-1]+a[y+1:]
    elif s[0]=='swap': # 'swap position X with position Y'
      x=int(s[2]); y=int(s[5])
      if x>y: x,y=y,x
      if x!=y: a=a[:x]+a[y]+a[x+1:y]+a[x]+a[y+1:]
    else: # move position X to position Y'
      x=int(s[2]); y=int(s[5])
      if x<y: a=a[:x]+a[x+1:y+1]+a[x]+a[y+1:]
      else:   a=a[:y]+a[x]+a[y:x]+a[x+1:]
  return a

def unscramble(a,d):
  for s in d[::-1]:
    s1=s[1]
    if s1=='letter': # 'swap letter X with letter Y'
      x=a.index(s[2]); y=a.index(s[5])
      if x>y: x,y=y,x
      if x!=y: a = a[:x]+a[y]+a[x+1:y]+a[x]+a[y+1:]
    elif s1=='left': # 'rotate left X steps'
      n = int(s[2])
      if n!=0: a=a[-n:]+a[:-n]
    elif s1=='right': # 'rotate right X steps'
      n = int(s[2])
      if n!=0: a=a[n:]+a[:n]
    elif s1=='based': # 'rotate based on position of letter X'
      n = a.index(s[6])
      n = {1:1,3:2,5:3,7:4, 2:-2,4:-1,6:0,0:1}[n]
      a=a[n:]+a[:n]
    elif s1=='positions': # 'reverse positions X through Y'
      x=int(s[2]); y=int(s[4])
      if x>y: x,y=y,x
      a=a[:x]+a[x:y+1][::-1]+a[y+1:]
    elif s[0]=='swap': # 'swap position X with position Y'
      assert s1=='position'
      x=int(s[2]); y=int(s[5])
      if x>y: x,y=y,x
      if x!=y: a=a[:x]+a[y]+a[x+1:y]+a[x]+a[y+1:]
    else: # move position X to position Y'
      y=int(s[2]); x=int(s[5])
      if x<y: a=a[:x]+a[x+1:y+1]+a[x]+a[y+1:]
      else:   a=a[:y]+a[x]+a[y:x]+a[x+1:]
  return a

d = [x.split() for x in open('21.dat','rt').read().strip().split('\n')]
print(scramble('abcdefgh',d))
assert unscramble(scramble('abcdefgh',d),d)=='abcdefgh'
print(unscramble('fbgdceah',d))
