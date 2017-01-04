badfloor =: (1 e.])*.[:+./1<] NB. bad if M w/o G (=1) and present other G (>1)
badfloors =: 4 : 'if. badfloor ({.y){"1 x do. 1 else. badfloor ({:y){"1 x end.'

ku =: |.,4#.(2&* +"1 1/ ])0 0 0 1|.~"1 0 i.4 NB. 192 144 132 129 96 48 36 33 72 24 12 9 66 18 6 3
kz =: (i.16)ku}256#0

zip =: 16#.[,kz{~4#.] NB. zip state (f zip s) to a number 0..0x4fffff[ff]
unzip =: [:({.;4 4 4 4#:ku{~}.)(16$~[)#:] NB. unzip state to (f;s)

mv =: 4 : 0
  'c i j f g' =. y
  newel =. (((f{e)-c),((g{e)+c)) (f,g)}e =. i{x
  newst =. newel i}x
  if. j>:0 do.
    newel =. (((f{e)-c),((g{e)+c)) (f,g)}e =. j{x
    newst =. newel j}newst end.
  if. newst badfloors f,g do. _1 else. g zip \:~ newst end.
)

solve =: 4 : 0 NB. x - final state
  'f s' =. y NB. start floor, start state
  l =. >:#s NB. length for unzip - floor + all elements
  z =. f zip \:~ s NB. zipped state
  v =. ,z  NB. visited is only one state initially
  w =. ,_1 NB. parent state for corresponding state in v
  b =. ,<v NB. b at k=0 has only one state
  for_k. i.99 do.
    NB. echo (2":k),', states: ', (5":#>k{b), ', total: ', 5":#v
    nzs =. 0$0
    for_z. >k{b do. NB. for each state at this level k
      'f s' =. l unzip z NB. states are sorted there!
      d =. ~:s NB. differend elems positions, like 1 0 1 1 1 0
      moves =. 0 5$0 0 0 0 0 NB. move - m for elements e (and e2) from f to g
      for_i. i.#s do.
        if. 0=i{d do. continue. end.
        if. 0=c=.f{e =. i{s do. continue. end.
        for_g. ((f<3),f>0) # f+1 _1 do. NB. g - new f
          if. 3=c do.  NB. move both, move 2, move 1
            moves =. moves, 3,i,_1,f,g
            for_m. 2 1 do.
              moves =. moves, m,i,_1,f,g
              t =. 0 4$0 0 0 0
              for_j. (i+1)+(i.(#s)-(i+1)) do.
                if. -. (js=.j{s) e. t do.
                  t =. t, js
                  if. m=(fjs=.f{js) do. moves =. moves, m,i,j,f,g
                  else. if. 3=fjs do. moves =. moves, m,i,j,f,g end.end.end.end.end.
          else. NB. move one
            moves =. moves, c,i,_1,f,g
            t =. 0 4$0 0 0 0
            for_j. (i+1)+(i.(#s)-(i+1)) do.
              if. -. (js=.j{s) e. t do.
                t =. t, js
                if. c=f{js do. moves =. moves, c,i,j,f,g end.end.end.end.end.end.
      for_cijfg. moves do.
        nz =. s mv cijfg
        if. nz<0 do. continue. end.
        if. nz=x do. x showsolution k;z;v;w;l return. end. NB. wooohooooooo!
        p =. v I. nz NB. simulating a set (v) or even a dictionary (w[v])
        if. p<#v do. toadd =. nz~:p{v else. toadd =. 1 end.
        if. toadd do.
          if. p<#v do. w =. (p{.w),z,(p}.w) [ v =. (p{.v),nz,(p}.v)
          else. w =. w,z [ v =. v,nz end.
          nzs =. nzs, nz end.end.end.
    if. 0 = #nzs do. echo 'no moves' return. end.
    b =. b,<nzs
    k=.>:k end.
)

showsolution =: 4 : 0 NB. use this definition to show all moves and states
  echo l unzip x [ echo x [ echo k=.>:k [ 'k z v w l' =. y NB. and x is the final state
  whilst. z>:0 do.
    echo l unzip z [ echo z [ echo k=.<:k
    z =. w{~ v i. z end.
)

showsolution =: 4 : 'echo >:>{.y' NB. show only number of moves

(3 zip 5 4$ 0 0 0 3) solve 0; 5 4 $ 3 0 0 0  0 2 1 0  0 2 1 0  0 2 1 0  0 2 1 0
(3 zip 7 4$ 0 0 0 3) solve 0; 7 4 $ 3 0 0 0  0 2 1 0  0 2 1 0  0 2 1 0  0 2 1 0  3 0 0 0

exit 0
