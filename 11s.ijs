E=:|.,4#.(2&*+"1 1/])0 0 0 1|.~"1 0 i.4
Z=:16#.[,((i.16)E}256#0){~4#.]
U=:[:({.;4 4 4 4#:E{~}.)(16$~[)#:]
A=:(1 e.])*.[:+./1<]
B=:A@({:@]{"1[)`1:@.(A@({.@]{"1[))
M=:4 :'(((_1 1*>{.y)+"1(<}.y){x)(<}.y)}x)({:@](Z\:~)[)`(_1"_)@.B>{:y'
O=:4 :0
 r=.,:'m i p'=.y[t=.0 4$0
 for_j.i+1+(i.(#x)-i+1)do.if.-.t e.~h=.j{x do.t=.t,h
  if.(3,m)e.~({.p){h do.r=.r,m;(i,j);p end.end.end.r
)
F=:4 :0
 r=.0 3$0[d=.~:y
 for_i.i.#y do.if.0=i{d do.continue.end.if.0=c=.x{e=.i{y do.continue.end.
  for_g.x+1 _1#~(x<3),x>0 do.
   if.3=c do.r=.r,3;i;x,g for_m.2 1 do.r=.r,y O m;i;x,g end.
   else.r=.r,y O c;i;x,g end.end.end.r
)
S=:4 :0
 p=.v=.,z=.f Z\:~s[l=.>:#s['f s'=.y
 for_k.i.99 do.q=.0$0
  for_z.p do.'f s'=.l U z
   for_m.f F s do.if.0<:n=.s M m do.if.n=x do.>:k return.end.
    if.-.n e.v do.v=.v,n[q=.q,n end.end.end.end.
  if.0=#q do.''return.end.
  p=.q end.
)
echo(3 Z 5 4$0 0 0 3)S 0;5 4$o=:3 0 0 0,16$0 2 1 0
echo(3 Z 7 4$0 0 0 3)S 0;7 4$o,3 0 0 0
exit 0
