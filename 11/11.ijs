badfloor =: (1 e.])*.[:+./1<] NB. bad if M w/o G (=1) and present other G (>1)
badfloors =: 4 : 0 NB. x - state, y - f1,f2
  if. badfloor ({.y){"1 x do. 1 return. end. badfloor ({:y){"1 x
)

ku =: |.,4#.(2&* +"1 1/ ])0 0 0 1|.~"1 0 i.4 NB. 192 144 132 129 96 48 36 33 72 24 12 9 66 18 6 3
kz =: (i.16)ku}256#0

zip =: 16#.[,kz{~4#.] NB. zip state (f zip s) to a number 0..0x4fffff
unzip =: [:({.;4 4 4 4#:ku{~}.)(16$~[)#:] NB. unzip state to (f;s)

draw =: 4 : 0
  mrk =. {&(4 6$' -- -- -- !m !g -- !g !m')
  for_i. (<:n)-i.n=.#{.y do.
    o=.' *'{~i=x for_e. i{"1 y do. o =. o, (>mrk e)rplc'!';a.{~65+e_index end. echo o
  end.
)

mv =: 4 : 0
  'c i j f g' =. y NB. c,f,g,index,j
  e =. i{x
  newel =. (((f{e)-c),((g{e)+c)) (f,g)}e
  newst =. newel i}x
  if. j>:0 do.
    e =. j{x
    newel =. (((f{e)-c),((g{e)+c)) (f,g)}e
    newst =. newel j}newst
  end.
  if. newst badfloors f,g do. _1 return. end.
  g zip \:~ newst
)

solve =: 4 : 0 NB. x - final state
  'f s' =. y NB. start floor, start state
  z =. f zip \:~ s NB. zipped state
  v =. ,z NB. visited is only one state initially
  w =. ,_1 NB. parent state for corresponding state in v
  b =. ,<v NB. b at k=0 has only one state
  for_k. i.56 do.
    echo ''
    echo '******************************************'
    echo (":k),' - ', (":#>k{b), ' - ', ":#v
    nzs =. 0$0
    for_z. >k{b do. NB. for each state at this level k
      'f s' =. 6 unzip z NB. states are sorted there!
      d =. ~:s NB. differend elems positions, like 1 0 1 1 1 0
      NB.          echo 'from state';f;s;,.d
      moves =. 0 5$0 0 0 0 0 NB. move - m for elements e (and e2) from f to g
      for_i. i.#s do.
        e =. i{s
        if. 0=i{d do. continue. end.
        if. 0=c=.f{e do. continue. end.
        for_g. ((f<3),f>0) # f+1 _1 do. NB. g - new f
          NB.                  echo 'e: ',(":e),'  ',(":f),'-->',":g
          if. 3=c do.  NB. move both, move 2, move 1
            moves =. moves, (3, i, _1, f, g)
            for_m. 2 1 do.
              moves =. moves, (m, i, _1, f, g)
              tempcache =. 0 4$0 0 0 0
              for_j. (i+1)+(i.(#s)-(i+1)) do.
                if. -. (js=.j{s) e. tempcache do.
                  tempcache =. tempcache, js
                  if. m=f{js do.
                    moves =. moves, (m, i, j, f, g)
                  end.
                end.
              end.
            end.
          else. NB. move one
            moves =. moves, (c, i, _1, f, g)
            tempcache =. 0 4$0 0 0 0
            for_j. (i+1)+(i.(#s)-(i+1)) do.
              if. -. (js=.j{s) e. tempcache do.
                tempcache =. tempcache, js
                if. c=f{js do.
                  moves =. moves, (c, i, j, f, g)
                end.
              end.
            end.
          end.
        end.
      end.
      echo 'from';z;f;s;,.d
      echo 'moves';moves
      for_cijfg. moves do.
        nz =. s mv cijfg
        if. nz<0 do. continue. end.
        if. nz=x do. x showsol k;z;v;w return. end.
        p =. v I. nz
        if. p<#v do. toadd =. nz~:p{v else. toadd =. 1 end.
        if. toadd do.
          if. p<#v do.
            v =. (p{.v),nz,(p}.v)
            w =. (p{.w),z,(p}.w)
          else.
            v =. v,nz
            w =. w,z
          end.
          nzs =. nzs, nz
        end.
      end.
    end.
    if. 0=#nzs do. echo 'no moves' return. end.
    b =. b,<nzs
    k=.>:k
    echo ''
    echo 'next will be:'
    echo (k+1),#nzs
    for_nz. nzs do.
      echo nz; 6 unzip nz
    end.
  end.
)

showsol =: 4 : 0 NB. x - final state
  'k z v w' =. y
  echo k
  echo 6 unzip x
  NB. f draw s
  whilst. z>:0 do.
    echo k=.<:k
    echo 6 unzip z
    NB. f draw s
    z =. w{~ v i. z
  end.
)

e =: 0                                                 NB. elevator
s =: 5 4$ 3 0 0 0  0 2 1 0  0 2 1 0  0 2 1 0  0 2 1 0  NB. states of floors/elems
NB. i-th element  i{s
NB. i-th floor    i{"1 s

fz =: 3 zip 5 4$ 0 0 0 3 NB. final state: floor 3; all elements on floor 3

fz solve e;s

exit 0
