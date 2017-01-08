E=:|.,4#.(2&*+"1 1/])0 0 0 1|.~"1 0 i.4
Z=:16#.[,((i.16)E}256#0){~4#.]
U=:[:({.;4 4 4 4#:E{~}.)(16$~[)#:]
A=:(1 e.])*.[:+./1<]
B=:A@({:@]{"1[)`1:@.(A@({.@]{"1[))
M=:4 :'(((_1 1*>{.y)+"1(<}.y){x)(<}.y)}x)({:@](Z\:~)[)`(_1"_)@.B>{:y'
D=:4 :'r,m;"1(i,"0(g*.~:h)#j);"1 p[g=.(3,m)e.~/({.p){"1 h=.x{~j=.>:i+i.->:i-#x[r=.,:''m i p''=.y'
F=:4 :0
 r=.0 3$0
 for_i.(~:#i.@#)y do.if.c=.x{e=.i{y do.
  for_g.x+1 _1#~(x<3),x>0 do.t=.i;x,g
   if.3=c do.r=.((r,3;t),y D 2;t),y D 1;t else.r=.r,y D c;t end.end.end.end.r
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
