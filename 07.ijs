t =: cutLF CR-.~fread '07.dat'

spl =: (<;.2@,)&']' NB. split into parts with ']'
div =: (<;.2@,)&'[' NB. divide into '....[' and '....]'(,'[')
arr =: [:|:[:div@>spl NB. array of parts, row 0 positive, row 1 in [...]

hasabba =: [:+./4(0 1 1-:(0 0 1{])=1 3 2{])\] NB. string has pattern 'abba'
v1 =: 1 0-:(hasabba@;"1)@arr NB. row 0 has 'abba', row 1 has not
echo +/ v1&> t

isaba =: 0 1-:(0 0{])=1 2{] NB. string is of pattern 'aba'
bab =: [:1 0 1&{&.>[:(#~isaba&>)3<\[:;0{arr NB. array of 'bab' strings
rw1 =: ;@(1&{)@arr
v2 =: +./@(,&':'@(>@bab)+./@E."1 1 rw1) NB. ,'!' for empty boxes
echo +/ v2&> t

exit 0
