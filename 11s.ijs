b=:(1 e.])*.[:+./1<]
B=:b@({:@]{"1[)`1:@.(b@({.@]{"1[))
E=:|.,4#.(2&*+"1 1/])0 0 0 1|.~"1 0 i.4
Z=:16#.[,((i.16)E}256#0){~4#.]
U=:[:({.;4 4 4 4#:E{~}.)(16$~[)#:]
M=:(((_1 1*>@{.@])+"1<@}.@]{[)`(<@}.@])`[})({:@](Z\:~)[)`(_1"_)@.B(>@{:@])
M=:4 :'(((_1 1*>{.y)+"1(<}.y){x)(<}.y)}x)({:@](Z\:~)[)`(_1"_)@.B>{:y'
NB. ^^ tacit is not shorter but 12-17% faster -- t: 0.321 1.987 e: 0.376 2.240
solve=:4 :0
 r=.v=.,z=.f Z\:~s[l=.>:#s['f s'=.y
 for_k.i.99 do.p=.0$0
  for_z.r do.ms=.0 3$0[d=.~:s['f s'=.l U z
   for_i.i.#s do.if.0=i{d do.continue.end.
    if.0=c=.f{e=.i{s do.continue.end.
    for_g.((f<3),f>0)#f+1 _1 do.
     if.3=c do.ms=.ms,3;i;f,g
      for_m.2 1 do.ms=.ms,m;i;f,g[t=.0 4$0
       for_j.(i+1)+(i.(#s)-(i+1))do.
        if.-.t e.~h=.j{s do.t=.t,h
         if.(3,m)e.~f{h do.ms=.ms,m;(i,j);f,g end.end.end.end.
     else.ms=.ms,c;i;f,g[t=.0 4$0
      for_j.(i+1)+(i.(#s)-(i+1))do.
       if.-.t e.~h=.j{s do.t=.t,h
        if.(3,c)e.~f{h do.ms=.ms,c;(i,j);f,g end.end.end.end.end.end.
   for_m.ms do.if.0>n=.s M m do.continue.end.
    if.n=x do.echo>:k return.end.
    if.-.n e.v do.v=.v,n[p=.p,n end.end.end.
  if.0=#p do.echo'no moves'return.end.
  r=.p end.
)
echo (3)6!:2 '(3 Z 5 4$0 0 0 3)solve 0;5 4$o=:3 0 0 0,16$0 2 1 0'
echo (3)6!:2 '(3 Z 7 4$0 0 0 3)solve 0;7 4$o,3 0 0 0'
echo 0.376 2.240 % 0.321 1.987
exit 0
