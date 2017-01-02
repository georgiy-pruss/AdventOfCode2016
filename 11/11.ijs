e =: 0                                                 NB. elevator
s =: 5 4$ 3 0 0 0  0 2 1 0  0 2 1 0  0 2 1 0  0 2 1 0  NB. states of floors/elems

NB. i-th element on all floors  i{s
NB. i-th floor                  i{"1 s   (<(i.#s);1){s

final =: [:*./0 0 0 3-:"1~] NB. is final state: all elems on floor 3
badfloor =: (1 e.])*.[:+./1<] NB. bad if M w/o G (=1) and present other G (>1)
badfloors =: 4 : 0 NB. x - state, y - f1,f2
  if. badfloor ({.y){"1 x do. 1 return. end. badfloor ({:y){"1 x
)

ku =: |.,4#.(2&* +"1 1/ ])0 0 0 1|.~"1 0 i.4 NB. 192 144 132 129 96 48 36 33 72 24 12 9 66 18 6 3
kz =: (i.16)ku}256#0
NB. echo (4 4 4 4#:ku);(,.ku);":$.kz

zip =: 16#.[,kz{~4#.] NB. zip state (f zip s) to a number 0..0x4fffff
unzip =: [:({.;4 4 4 4#:ku{~}.)(16$~[)#:] NB. unzip state to (f;s)

NB. x - set, y - new state in zipped form (=number); return new set
put =: 4 : 'k =. x I. y if. k<#x do. if. y=k{x do. x else. (k{.x),y,(k}.x) end. else. x,y end.'
NB. x - set, y - zipped state; check if state is in set; return 0|1
chk =: 4 : 'k =. x I. y if. k<#x do. y=k{x else. 0 end.'


draw =: 4 : 0
  mrk =. {&(4 6$' -- -- -- !m !g -- !g !m')
  for_i. (<:n)-i.n=.#{.y do.
    o=.' *'{~i=x for_e. i{"1 y do. o =. o, (>mrk e)rplc'!';a.{~65+e_index end. echo o
  end.
)

NB. echo e;s
NB. echo es =: e zip s
NB. echo 6 unzip es
NB. e draw s

NB. final state
fe =: 3
fs =: 5 4$ 0 0 0 3
fz =: fe zip fs
echo fz

NB. move =: 4 : 0 NB. x - state, y - move
NB.   >{:6 unzip ?16b4fffff
NB. )

solve =: 3 : 0
  f =. 0 NB. start from floor 0
  state =. \:~ y NB. normalize initial state = sort
  z =. f zip state NB. zipped state
  v =. ,z NB. visited is only one state initially
  b =. ,<,z NB. b at k=0 has only one state

  for_k. i.36 do.
    NB.    echo 'k';k;'v';v
    NB.    echo 'b';b
    echo (":k),' - ', (":#>k{b), ' - ', ":#v
    newstates =. 0$0
    for_z. >k{b do. NB. for each state at this level k
      'f s' =. 6 unzip z NB. states are sorted there!
      echo 'from state';f;s
      NB. de =. ~.s NB. their 'where' are ~: s -- ~. == (~:#])
      d =. ~:s NB. differend elems positions, like 1 0 1 1 1 0
      NB.        echo 'f s';f;s;'diff.elems';(+/d);d;'flr';d#s
      NB. find moves (move is what-to-move, direction), prev state is here known
      NB. 1) only different moves; 2) only valid moves; 3) leading to different states (?)
      NB.   do moves - normalize - zip - add to new states at b[k+1] and save prev state there!
      NB.                                                                ---------------------
      for_el. s do.
        if. 0=el_index{d do. continue. end.
        if. 0=f{el do. continue. end.
        for_g. ((f<3),f>0) # f+1 _1 do. NB. g - new f
          echo 'el ',(":el),'  ',(":f),'-->',":g
          if. 3=f{el do.  NB. move both or move 1 and 1
            NB.        echo '3-el';el;'s';s;'#';el_index;s i. el
            for_m. 0 1 2 do.
              newel =.       (m,((g{el)+3-m)) (f,g)}el
              newst =. newel el_index}s
              NB.        echo s;el_index; 'newel'; newel; 'newst'; newst=.newel (el_index)}s
              if. newst badfloors f,g do. continue. end.
              NB.        echo 'ok'
              nz =. g zip \:~ newst
              if. nz=fz do. echo '!!!!!',":k return. end.
              echo '?3 ',":nz
              if. -. v chk nz do.
                v =. v put nz
                newstates =. newstates, nz
                echo 'added';nz;6 unzip nz
              end.
            end.
          else. NB. move one
            NB. move el,f,g,f{el
            NB.        echo ((":f{el),'-el');el;'s';s;'#';el_index;s i. el
            newel =.       (0,((g{el)+f{el)) (f,g)}el
            newst =. newel el_index}s
            NB.        echo s;el_index; 'newel'; newel; 'newst'; newst=.newel (el_index)}s
            if. newst badfloors f,g do. continue. end.
            NB.        echo 'OK'
            nz =. g zip \:~ newst
            if. nz=fz do. echo '!!!!!',":k return. end.
            echo '?X ',":nz
            if. -. v chk nz do.
              NB.        echo 'add nz ',":nz
              v =. v put nz
              newstates =. newstates, nz
              echo 'added';nz;6 unzip nz
            end.



            NB. try from different elements 1 - 1 or 2 - 2




          end.
        end.
      end.
    end.
    NB. show # b[k+1] = newstates
    NB. echo newstates
    if. 0=#newstates do. echo 'no moves' return. end.
    b =. b,<newstates
    echo 'v';v
    echo 'b';b
    k=.>:k
  end.
)

solve s

exit 0
