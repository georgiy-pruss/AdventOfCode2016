t =: CR-.~fread '08.dat'
t =: t rplc 'rotate ';'';'row y=';'r';'column x=';'c';'by ';'';'rect ';'i';'x';' '
3 : 0 cutLF t
  m =. 6 50 $ '.' [ X=.'#'
  for_s. y do. s=.>s
    if. 'i'={.s do. 'w h'=.".}.s for_i. i.h do. m=.((w$X),w}.i{m)i}m end. end.
    if. 'r'={.s do. m=.((-n)|.r{m)r}m [ 'r n'=.".}.s end.
    if. 'c'={.s do. m=.|:((-n)|.c{w)c}w=.|:m [ 'c n'=.".}.s end.
  end.
  echo +/+/m=X
  echo m
)
exit 0
