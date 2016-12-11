t =: cutLF CR-.~fread '10.dat'
NB. verbs -----------------------------------
onlybots =: #~ ('bot'-:3{.>)"0
onlyvals =: #~ ('val'-:3{.>)"0
parsebot =: [:".[:>1 4 5 8 9{[:cut('to output';'0';'to bot';'1')rplc~>
parseval =: [:<[:".[:>1 5{[:cut >
val2out =: ([:{.])`([:<_1,5<.[:{:])`[ } NB. save value to output = last bots item
val2slot1 =: ([:{.])`([:<4,~[:{:])`[ }
val2slot2 =: 4 : 0
  if. 17 61 -: lh=./:~ ({.y),4{(k=.{:y){x do. echo {:y end. NB. output part 1
  ((({.y)(<k,5)}x)pv({.lh),0 1{k{x)pv({:lh),2 3{k{x NB. set slot2 and pass both values
)
val2bot =: val2slot2`val2slot1 @. (0=4{([:{:]){[) NB. choose slot
pv =: val2out`val2bot @.(1{]) NB. pass value
av =: [:< ([:>]) pv 1j1 1#!.1[:>[ NB. apply value to bots
NB. nouns -----------------------------------
bots =: (0 0,~}.)"1 /:~ parsebot"0 onlybots t NB. get all bots from input
vals =: parseval"0 onlyvals t                 NB. get all values
echo */3{.{:> av/ |.(bots,0);vals             NB. apply values to bots; part 2
exit 0
