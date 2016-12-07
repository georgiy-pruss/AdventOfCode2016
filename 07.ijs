t =: cutLF CR-.~fread '07.dat'

hasabba =: [:+./4(0 1 1-:(0 0 1{])=1 3 2{])\] NB. string has pattern 'abba'

spl =: (<;.2@,)&']' NB. split into parts with ']'
div =: (<;.2@,)&'[' NB. divide into '....[' and '....]'(,'[')
arr =: [:|:[:div@>spl NB. array of parts, row 0 positive, row 1 in [...]

v1 =: 1 0-:(hasabba@;"1)@arr NB. row 0 has 'abba', row 1 has not

echo +/ v1&> t

isaba =: 0 1-:(0 0{])=1 2{] NB. string is of pattern 'aba'

NB. get all 'aba' strings from row 0 and check it they are in join of row 1
v2 =: 3 : '+./ ((+./@ E.)&(;1{arr y))&> (1 0 1&{)&.> (#~isaba&>) 3<\ ;0{ arr y'
        NB.                           [: 1 0 1&{&.>[:(#~isaba&>) 3<\[:;0{arr

echo +/ v2&> t

aba =: 3 : '(1 0 1&{)&.> (#~isaba&>) 3<\ ;0{ arr y'
    NB.   [: 1 0 1&{&.> [: (#~ isaba&>) 3 <\ [: ; 0 { arr
v3 =: 3 : '+./ ((+./@ E.)&(;1{arr y))&> aba y'

NB. exit 0
