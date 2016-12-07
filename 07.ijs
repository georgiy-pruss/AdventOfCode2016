t =: cutLF CR-.~fread '07.dat'

0 : 0 NB. variants
1.
  hasabba =: 3 : 0
    a =. (#~ 0&<) , I. 1 0 0 1 E."1 s=. = ':',y
    b =. (#~ 0&<) , I. 0 1 1 0 E."1 s
    +./+./a=/b
  ))
  spl =: ']'&(<;._2@,~)
  div =: '['&(<;._2@,~)
  valid =: 1 0 -: [: hasabba@;"1 [: |: [: ,&';'&.> [: div@> spl
2.
  hasabba =: +./@(+./@(I.@(1&|.= 2&|.)=/I.@(=3&|.)))
  v =: 0 1 1 -: (0 0 1 { ]) = 1 3 2 { ]
  hasabba =: [: +./ 4 v\ ] NB. or below:
3.
  hasabba =: [:+./4(0 1 1-:(0 0 1&{=1 3 2&{)@])\]
)

hasabba =: [:+./4(0 1 1-:(0 0 1{])=1 3 2{])\]

spl =: (<;.2@,)&']' NB. split into parts with ']'
div =: (<;.2@,)&'[' NB. divide into '....[' and '....]'(,'[')
arr =: [:|:[:div@>spl NB. array of parts, row 0 positive, row 1 in [...]

v1 =: 1 0-:(hasabba@;"1)@arr NB. row 0 has 'abba', row 1 has not

echo +/ v1&> t

isaba =: ((0{])~:1{])*.(0{])=2{] NB. string is 'aba'
isaba =: 0 1-:(0 0{])=1 2{]

v2 =: 3 : '+./ ((+./@ E.)&(;1{arr y))&> (1 0 1&{)&.> (#~isaba&>) 3<\ ;0{ arr y'
echo +/ v2&> t

echo >1{t
echo arr >1{t
NB. exit 0
