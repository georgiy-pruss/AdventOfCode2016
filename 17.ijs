md5 =: 3 : 0
  m=.,y
  c=. '"',libjqt,'" gethash ',(IFWIN#'+'),' i *c *c i * *i'
  'r t m w p n'=. c cd 'md5';m;(#m);(,2);,0
  res=. memr p,0,n
  if. r do. res (13!:8) 3 end.
  res
)

ns =: 0,.(_4 4|.!.0"0 1>:i.16),((*(0~:4|])),:1|.>:*0~:4|])i.16

whatdoorsopen =: 'bcdef'e.~4{.md5

moves =: 4 : 0
  sp =. 0 2$<0 NB. new
  for_e. whatdoorsopen y do.
    if. e do. if. z=. x{e_index{ns do. sp =. sp, z;e_index{'UDLR' end. end. end.
  sp
)

play =: 4 : 0 NB. x = max number of steps; y = md5 salt
  state =. 1 [ final =. 16 [ shortest =. longest =. ''
  states =. 1 2$ state;''  NB. all states at step 0
  for_k. i. x do. NB. let's stop at some point
    nstates =. 0 2$ 0;'' NB. new states, on step k+1
    for_sp. states do.
      newsp =. ((>{.sp)) moves y,path =. >{:sp
      for_nsnp. newsp do. 'ns np'=.nsnp
        if. ns=final do. NB. reached final cell
          longest =. path,np
          if. 0=#shortest do. shortest =. longest end.
        else.
          nstates =. nstates, ns;path,np end. end. end.
    if. 0=#nstates do. shortest,4":#longest return. end. NB. no more moves
    states =. nstates end. NB. all states at the new level
  'not finished' NB. not finished for the given number of steps
)

echo 500 play 'bwnlcvfs'
NB. echo 400 play 'ihgpwlah' NB. DDRRRD 370
NB. echo 600 play 'kglvqrro' NB. DDUDRLRRUDRD 492
NB. echo 900 play 'ulqzkmiv' NB. DRURDRUDDLLDLUURRDULRLDUUDDDRR 830
exit 0
