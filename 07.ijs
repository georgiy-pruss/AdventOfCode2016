t =: cutLF CR-.~fread '07.dat'

hasabba =: 3 : 0
  a =. (#~ 0&<) , I. 1 0 0 1 E."1 s=. = ':',y
  b =. (#~ 0&<) , I. 0 1 1 0 E."1 s
  +./+./a=/b
)
spl =: ']'&(<;._2@,~)
div =: '['&(<;._2@,~)
valid =: 1 0 -: [: hasabba@;"1 [: |: [: ,&';'&.> [: div@> spl

echo +/ valid&> t
exit 0
