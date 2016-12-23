r=:'/dev/grid/node-x';'';'-y';' ';'T';'';'%';'' NB. all rubish chars
d=: "."1&> cut&>2}.cutLF rplc&r CR -.~ fread'22.dat' NB. to number matrix 961 x 6
(3 : 'for_n. y do. assert. (2{n)=(3{n)+4{n end.') d NB. make sure size=used+free
u=: 3{"1 d NB. used
f=: 4{"1 d NB. avail
echo +/,(u-.0)</f NB. part 1: 934
NB. study the data *with eyes* -- the nodes are of three kind (empty, ~90T, ~500T)
echo (u>100)#d NB. all at y=15 -- see that they all are unmovable
NB. now draw the grid and solve it manually :D
echo 3 : 0 d NB. show it
  m =. 31 31$'?' NB. the grid is 31x31
  for_n. y do. m=.('.@'{~100<3{n)(<0 1{n)}m end.
  for_n. y do. if. 0=3{n do. m=.' '(<0 1{n)}m end. end. NB. free cell
  m=.'+'(<0 0)}m  NB. accessible cell
  '#'(<30 0)}m NB. cell with important data :)
)
echo 1+(29*5)+25+36 NB. part 2: move free cell up and to the left border -
NB. it's 36 moves, then down to the data - 25 more, then moving it up one
NB. position takes 5 moves, and to reach the top border is to repeat it
NB. 29 times; then the final move to (0,0).
exit 0
