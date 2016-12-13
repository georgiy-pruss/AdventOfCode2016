f=: 1358+([*[+3+2*])+]*1+]
o=: [:-2|[:+/#:
gen =: [:|:([:i.[)(o@f)"0 0/[:i.]

directions =: 4 : 0 NB. grrrrrhhh such long function!!!
  d =. 0 2$0
  if. 0<{:y        do. if. 0=(<0 _1+y){x do. d=.d,0 _1+y end.end.
  if. (<:#x)>{:y   do. if. 0=(<0  1+y){x do. d=.d,0  1+y end.end.
  if. 0<{.y        do. if. 0=(<_1 0+y){x do. d=.d,_1 0+y end.end.
  if. (<:#{.x)>{.y do. if. 0=(<1  0+y){x do. d=.d,1  0+y end.end.
  d
)

go =: 4 : 0 NB. uses x show tgt to display the maze at the end
  next =. 0 2$0 [ 'ends tgt cnt p maxp' =. y
  if. p<:maxp do. cnt =. cnt + #ends end.
  for_xy. ends do. x=.p (<xy)}x NB. mark cells in ends first
    for_d. x directions xy do. NB. for all possible directions at xy
      if. d -: tgt do. p, cnt [ x show tgt return. end. NB. got it! finish!
      if. -.d e. next do. next=.next,d end. end. end.
  x go next;tgt;cnt;(p+1);maxp
)

cell =: 3 : 'if. y<:0 do. a.{~(-y){3 2$32 32 219 219 60 62 else. 2":<:y end.'
show =: 4 : 'for_row. _2(<y)}x do. echo ,cell"0 row end.'
show =: 0: NB. to not show anything. otherwise make prev. definition visible

echo (50 gen 50) go (,:1 1);39 31;0;1;50+1
exit 0
