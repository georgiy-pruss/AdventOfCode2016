m =: '#'= s =: >cutLF CR-.~fread '24.dat'
t =: ($s) #: (,s) i. /:~ '.#'-.~ ~.,s NB. only 8 marked positions there

go =: 4 : 0 NB. uses x show tgt to display the maze at the end
  next =. 0 2$0 [ 'ends tgt p' =. y
  for_xy. ends do. x=.p (<xy)}x NB. mark cells in ends first
    NB. for_d. xy+4 2$_1 0 1 0 0 _1 0 1 do. NB. for all possible directions at xy
    for_d. xy+"1(+,-)1 0,:0 1 do. NB. for all possible directions at xy
      if. d -: tgt do. p return. end. NB. got it! finish!
      if. x{~<d do. continue. end. NB. if not free cell, continue looking
      if. -.d e. next do. next=.next,d end. end. end.
  x go next;tgt;p+1 NB. do next step
)

d =: 3 : 0 [0$~2$#t NB. distance matrix
  for_i. i.<:#t do. for_j. i+1+i.<:i-~#t do. NB. 0 1, 0 2, ... 0 7, 1 2, ... 6 7
    y =. (m go (,:i{t);(j{t);1) ((j,i);i,j) }y
  end. end.
)

tap =: i.@! A. i.

minsum =: 4 : 0
 s =. z =. 999999
 for_p. >:tap <:y do.
   s =. s <. +/x{~<"1 (0,}:p),.p
   z =. z <. +/x{~<"1 (0,p),.p,0
 end.
 s,z
)

echo d minsum #t
exit 0
