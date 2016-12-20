3 : 0 /:~ "."1>('-'&cut)&>cutLF(CR,'.#')-.~fread'20.dat'
  u=.c=.i=.0 NB. upper bound, counter, index
  while. do.
    while. i<#y do. if. (>:u)<{.i{y do. break. end. i=.>:i [ u=.u>.{:i{y end.
    if. i>:#y do. break. end.
    if. c=0 do. echo >:u end.
    u=.{:i{y[c=.c+>:(<:{.i{y)->:u
  end.
  echo c
)
exit 0
