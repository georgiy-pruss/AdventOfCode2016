t =: CR-.~fread '08.dat'
t =: t rplc 'rotate ';''
t =: t rplc 'row y=';'r'
t =: t rplc 'column x=';'c'
t =: t rplc 'by ';''
t =: t rplc 'rect ';'i'
t =: t rplc 'x';' '
t =: cutLF t
3 : 0 t
  m =. 6 50 $ '.'
  for_s. y do. s=.>s
    if. 'i'={.s do. 'w h'=.".}.s
      for_i. i.h do.
        m=. ((w$'#'),w}.i{m)i}m
      end.
    end.
    if. 'r'={.s do. 'r n'=.".}.s
      m=. ((-n)|.r{m)r}m
    end.
    if. 'c'={.s do. 'c n'=.".}.s
      m=.|:m
      m=. ((-n)|.c{m)c}m
      m=.|:m
    end.
  end.
  echo m
)
exit 0
