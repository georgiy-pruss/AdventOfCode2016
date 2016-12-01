NB. day 01 http://adventofcode.com/2016/day/1

split0 =: ' '&$: : (<;._2 @(,~))
rmv =: #~ -.@(+./@((LF,CR,',')&(=/)))

3 : 0 rmv fread '01.dat'
  curpos=.0j0    NB. we walk on complex plane
  curdir=.0j1    NB. north
  task2=._1      NB. will be >=0 when done
  visited=.0$0j0 NB. for task2
  for_e. split0 y do.
    curdir =. curdir * 0j1 0j_1{~'R'={. >e
    len =. ".}. >e
    if. task2<0 do.
      for_p. curpos + curdir * 1+i.len do.
        if. p e. visited do. task2 =. +/|+.p break. end.
        visited =. visited, p
      end.
    end.
    curpos =. curpos + len * curdir
  end.
  echo +/|+. curpos
  echo task2
)

exit 0
