t =: CR-.~fread '08.dat'
t =: t rplc 'rotate ';'';'row y=';'r';'column x=';'c';'by ';'';'rect ';'i';'x';' '
3 : 0 cutLF t
  m =. 6 50$0
  for_s. y do. select. {.s [ 'j k'=.".}.s=.>s
    case.'i' do. m=.1(<(i.k);i.j)}m
    case.'r' do. m=.((-k)|.j{m)j}m
    case.'c' do. m=.|:((-k)|.j{w)j}w=.|:m end. NB. last case can be even w/o 'c'
    NB. no c}"1 m :(  ((-k)|.j{"1 m)(<(i.#m);j)}m NB. change just column, w/o |:
  end.
  echo +/,m        NB. 121
  echo m{32 219{a. NB. RURUCEOEIL
  NB. echo <"2 }:"1"2 |:"2 ] _5]\ |: m{' #'
)
exit 0
