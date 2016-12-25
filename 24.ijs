m =: '#'= s =: >cutLF CR-.~fread '24.dat'
t =: ($s) #: (,s) i. /:~ '.#'-.~ ~.,s NB. marked position coords

s =: 4 : 0 NB. do one step
  next =. 0 2$0 [ g =. >1{y NB. y = end points at level p; goal coords; p
  for_xy. >{.y do. x=.1 (<xy)}x NB. mark cells in ends first
    NB. for_d. xy+4 2$_1 0 1 0 0 _1 0 1 do. NB. for all possible directions at xy
    for_d. xy+"1(+,-)1 0,:0 1 do. NB. for all possible directions at xy
      if. d -: g do. >{:y return. end. NB. got it! finish!
      if. x{~<d do. continue. end. NB. if not free cell, continue looking
      if. -.d e. next do. next=.next,d end. end. end.
  x s next;g;>:>{:y NB. do next step
)

d =: 3 : 0 [0$~2$#t NB. distance matrix
  for_i. i.<:#t do. for_j. i+1+i.<:i-~#t do. NB. 0 1, 0 2, ... 0 7, 1 2, ... 6 7
    y =. (m s (,:i{t);1;~j{t) ((j,i);i,j) }y end. end. NB. return y
)

echo <./ +/"1 d{~<"1 ((0,}:),.])"1 p =: >:(i.@!A.i.)<:#t
echo <./ +/"1 d{~<"1 ((0,]),.0,~])"1 p

exit 0
