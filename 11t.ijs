badfloor =: (1 e.])*.[:+./1<] NB. bad if M w/o G (=1) and present other G (>1)
badfloors =: badfloor@({:@] {"1 [)`1:@.(badfloor@({.@] {"1 [))

ku =: |.,4#.(2&*+"1 1/])0 0 0 1|.~"1 0 i.4 NB. 192 144 132 129 96 48 36 33 72 24 12 9 66 18 6 3
kz =: (i.16)ku}256#0

zip =: 16#.[,kz{~4#.] NB. zip state (f zip s) to a number 0..0x4fffff[ff]
unzip =: [:({.;4 4 4 4#:ku{~}.)(16$~[)#:] NB. unzip state to (f;s)

mv =: 4 : '(((_1 1*>{.y)+"1 (<}.y){x) (<}.y)}x) ({:@] (zip \:~)[ )`(_1"_)@.badfloors >{:y'

solve =: 4 : 0 NB. x - final state
  'f s' =. y NB. start floor, start state
  l =. >:#s NB. length for unzip - floor + all elements
  z =. f zip \:~ s NB. zipped state
  v =. ,z   NB. visited states, is only one state initially
  w =. ,_1  NB. parent state for corresponding state in v
  zz =. ,z  NB. (zipped) states to analyze
  for_k. i.99 do. NB. let's try up to 99 moves
    NB. echo (2":k),', states: ', (5":#>k{b), ', total: ', 5":#v
    xx =. 0$0 NB. next level (after k-th move) states
    for_z. zz do. NB. for each state at this level
      'f s' =. l unzip z NB. states are sorted there!
      d =. ~:s NB. differend elems positions, like 1 0 1 1 1 0
      mvs =. 0 3$0 NB. move - m for elements e (and e2) from f to g
      for_i. i.#s do.
        if. 0=i{d do. continue. end.
        if. 0=c=.f{e =. i{s do. continue. end.
        for_g. ((f<3),f>0) # f+1 _1 do. NB. g - new f
          if. 3=c do.  NB. move both, or move 2, move 1
            mvs =. mvs, 3;i;f,g
            for_m. 2 1 do.
              mvs =. mvs, m;i;f,g
              t =. 0 4$0 0 0 0
              for_j. (i+1)+(i.(#s)-(i+1)) do. NB. and maybe move other element too
                if. -. (js=.j{s) e. t do. t =. t, js
                  if. (3,m)e.~f{js do. mvs =. mvs, m;(i,j);f,g end.end.end.end.
          else. NB. move one, 2 or 1
            mvs =. mvs, c;i;f,g
            t =. 0 4$0 0 0 0
            for_j. (i+1)+(i.(#s)-(i+1)) do. NB. and maybe move other element too
              if. -. (js=.j{s) e. t do. t =. t, js
                if. (3,c)e.~f{js do. mvs =. mvs, c;(i,j);f,g end.end.end.end.end.end.
      for_m. mvs do. NB. try to do moves; analyze new states nz
        if. 0 > nz =. s mv m do. continue. end. NB. illegal move
        if. nz=x do. x showsolution k;z;v;w;l return. end. NB. wooohooooooo!
        if. -. nz e. v do. w =. w,z [ v =. v,nz [ xx =. xx,nz end. end. end.
    if. 0 = #xx do. echo 'no moves' return. end.
    zz =. xx end.
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
