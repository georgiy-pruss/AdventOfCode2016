// AoC 2016 day 14

#define NDEBUG "gcc -O3 14.c"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stddef.h>
#include <unistd.h>
#include <assert.h>
#include "../_.h"

#define U4 uint32_t // 4 bytes
#define U1 uint8_t  // 1 byte

// md5 -------------------------------------------------------------------------

// from http://openwall.info/wiki/people/solar/software/public-domain-source-code/md5

// leftrotate function definition

#define FX(x, y, z) (z ^ ( x & (y ^ z) ))
#define GX(x, y, z) (y ^ ( z & (y ^ x) ))
#define HX(x, y, z) ((x) ^ (y) ^ (z))
#define IX(x, y, z) ((y) ^ ((x) | (~z)))

#define LEFTROTATE(x, c) (((x) << (c)) | ((x) >> (32 - (c))))

#define FF(a, b, c, d, x, s, ac) { (a) += FX((b), (c), (d)) + (x) + (U4)(ac); \
  (a) = LEFTROTATE((a), (s)); (a) += (b); }

#define GG(a, b, c, d, x, s, ac) { (a) += GX((b), (c), (d)) + (x) + (U4)(ac); \
  (a) = LEFTROTATE((a), (s)); (a) += (b); }

#define HH(a, b, c, d, x, s, ac) { (a) += HX((b), (c), (d)) + (x) + (U4)(ac); \
  (a) = LEFTROTATE((a), (s)); (a) += (b); }

#define II(a, b, c, d, x, s, ac) { (a) += IX((b), (c), (d)) + (x) + (U4)(ac); \
  (a) = LEFTROTATE((a), (s)); (a) += (b); }

U4
to_int32(K U1* bytes) __
  R (U4)bytes[0] | ((U4)bytes[1] << 8) | ((U4)bytes[2] << 16) | ((U4)bytes[3] << 24); _

V
to_bytes(U4 val, OUT U1* bytes) __
  bytes[0] = (U1)val;
  bytes[1] = (U1)(val >> 8);
  bytes[2] = (U1)(val >> 16);
  bytes[3] = (U1)(val >> 24); _

V
to_hex(U4 val, OUT U1* twochars) __
  twochars[0] = "0123456789abcdef"[val >> 4];
  twochars[1] = "0123456789abcdef"[val & 0x0f]; _

V
to_digest(U4 val, OUT U1* eightchars) __
  to_hex( (val      )&0x00ffu, OUT eightchars );
  to_hex( (val >>  8)&0x00ffu, OUT eightchars+2 );
  to_hex( (val >> 16)&0x00ffu, OUT eightchars+4 );
  to_hex( (val >> 24)&0x00ffu, OUT eightchars+6 ); _

V
md5( K U1* initial_msg, size_t initial_len, OUT U1* digest ) __
  // Returns 32-char hex digest! Without trailing '\0' <<<<<<<<<<<<<<<<<<<<<<<<<
  register U4 h0, h1, h2, h3; // These vars will contain the hash
  O U1 md5buf[100000]; // preallocated buffer, in order to skip malloc
  U1* msg = NULL; // Message (to prepare)
  U4 w[16];
  register U4 a, b, c, d, i, f, temp;
  // Initialize variables - simple count in nibbles:
  h0 = 0x67452301;
  h1 = 0xefcdab89;
  h2 = 0x98badcfe;
  h3 = 0x10325476;
  //Pre-processing:
  //append "1" bit to message
  //append "0" bits until message length in bits is 448 (mod 512)
  //append length mod (2^64) to message
  size_t new_len = initial_len + 1;
  int mod = new_len & 0x3F;
  if(mod > 56) new_len += 120 - mod;
  else if(mod < 56) new_len += 56 - mod;
  // allocate a msg with new length
  if(new_len+8>=sizeof(md5buf))
    msg = (U1*)malloc(new_len + 8);
  else
    msg = md5buf;
  // copy the original msg to the new one
  memcpy(msg, initial_msg, initial_len);
  // append "1" bit. Note that for a computer, 8bit is the minimum length of a datatype
  msg[initial_len] = 0x80;
  if(initial_len + 1 < new_len)
    memset(&msg[initial_len + 1], 0, sizeof(U1) * (new_len - 1 - initial_len));
  size_t offset;
  for(offset = initial_len + 1; offset < new_len; ++offset)
    msg[offset] = 0; // append "0" bits
  // append the lower 32 bits of len in bits at the end of the buffer.
  to_bytes(initial_len<<3, msg + new_len);
  // append the higher 32 bits of len in bits at the end of the buffer.
  to_bytes(initial_len >> 29, msg + new_len + 4);
  // Process the message in successive 512-bit chunks:
  //for each 512-bit chunk of message:
  for(offset=0; offset<new_len; offset += 64) __
    // break chunk into sixteen 32-bit words w[j], from 0 to 15
    for(i = 0; i < 16; ++i)
      w[i] = *((U4*)(msg + offset + (i<<2)));
    // Initialize hash value for this chunk:
    a = h0;
    b = h1;
    c = h2;
    d = h3;
    FF(a, b, c, d, w[ 0],  7, 0xD76AA478);
    FF(d, a, b, c, w[ 1], 12, 0xE8C7B756);
    FF(c, d, a, b, w[ 2], 17, 0x242070DB);
    FF(b, c, d, a, w[ 3], 22, 0xC1BDCEEE);
    FF(a, b, c, d, w[ 4],  7, 0xF57C0FAF);
    FF(d, a, b, c, w[ 5], 12, 0x4787C62A);
    FF(c, d, a, b, w[ 6], 17, 0xA8304613);
    FF(b, c, d, a, w[ 7], 22, 0xFD469501);
    FF(a, b, c, d, w[ 8],  7, 0x698098D8);
    FF(d, a, b, c, w[ 9], 12, 0x8B44F7AF);
    FF(c, d, a, b, w[10], 17, 0xFFFF5BB1);
    FF(b, c, d, a, w[11], 22, 0x895CD7BE);
    FF(a, b, c, d, w[12],  7, 0x6B901122);
    FF(d, a, b, c, w[13], 12, 0xFD987193);
    FF(c, d, a, b, w[14], 17, 0xA679438E);
    FF(b, c, d, a, w[15], 22, 0x49B40821);
    GG(a, b, c, d, w[ 1],  5, 0xF61E2562);
    GG(d, a, b, c, w[ 6],  9, 0xC040B340);
    GG(c, d, a, b, w[11], 14, 0x265E5A51);
    GG(b, c, d, a, w[ 0], 20, 0xE9B6C7AA);
    GG(a, b, c, d, w[ 5],  5, 0xD62F105D);
    GG(d, a, b, c, w[10],  9, 0x02441453);
    GG(c, d, a, b, w[15], 14, 0xD8A1E681);
    GG(b, c, d, a, w[ 4], 20, 0xE7D3FBC8);
    GG(a, b, c, d, w[ 9],  5, 0x21E1CDE6);
    GG(d, a, b, c, w[14],  9, 0xC33707D6);
    GG(c, d, a, b, w[ 3], 14, 0xF4D50D87);
    GG(b, c, d, a, w[ 8], 20, 0x455A14ED);
    GG(a, b, c, d, w[13],  5, 0xA9E3E905);
    GG(d, a, b, c, w[ 2],  9, 0xFCEFA3F8);
    GG(c, d, a, b, w[ 7], 14, 0x676F02D9);
    GG(b, c, d, a, w[12], 20, 0x8D2A4C8A);
    HH(a, b, c, d, w[ 5],  4, 0xFFFA3942);
    HH(d, a, b, c, w[ 8], 11, 0x8771F681);
    HH(c, d, a, b, w[11], 16, 0x6D9D6122);
    HH(b, c, d, a, w[14], 23, 0xFDE5380C);
    HH(a, b, c, d, w[ 1],  4, 0xA4BEEA44);
    HH(d, a, b, c, w[ 4], 11, 0x4BDECFA9);
    HH(c, d, a, b, w[ 7], 16, 0xF6BB4B60);
    HH(b, c, d, a, w[10], 23, 0xBEBFBC70);
    HH(a, b, c, d, w[13],  4, 0x289B7EC6);
    HH(d, a, b, c, w[ 0], 11, 0xEAA127FA);
    HH(c, d, a, b, w[ 3], 16, 0xD4EF3085);
    HH(b, c, d, a, w[ 6], 23, 0x04881D05);
    HH(a, b, c, d, w[ 9],  4, 0xD9D4D039);
    HH(d, a, b, c, w[12], 11, 0xE6DB99E5);
    HH(c, d, a, b, w[15], 16, 0x1FA27CF8);
    HH(b, c, d, a, w[ 2], 23, 0xC4AC5665);
    II(a, b, c, d, w[ 0],  6, 0xF4292244);
    II(d, a, b, c, w[ 7], 10, 0x432AFF97);
    II(c, d, a, b, w[14], 15, 0xAB9423A7);
    II(b, c, d, a, w[ 5], 21, 0xFC93A039);
    II(a, b, c, d, w[12],  6, 0x655B59C3);
    II(d, a, b, c, w[ 3], 10, 0x8F0CCC92);
    II(c, d, a, b, w[10], 15, 0xFFEFF47D);
    II(b, c, d, a, w[ 1], 21, 0x85845DD1);
    II(a, b, c, d, w[ 8],  6, 0x6FA87E4F);
    II(d, a, b, c, w[15], 10, 0xFE2CE6E0);
    II(c, d, a, b, w[ 6], 15, 0xA3014314);
    II(b, c, d, a, w[13], 21, 0x4E0811A1);
    II(a, b, c, d, w[ 4],  6, 0xF7537E82);
    II(d, a, b, c, w[11], 10, 0xBD3AF235);
    II(c, d, a, b, w[ 2], 15, 0x2AD7D2BB);
    II(b, c, d, a, w[ 9], 21, 0xEB86D391);
    // Add this chunk's hash to result so far:
    h0 += a;
    h1 += b;
    h2 += c;
    h3 += d; _
  // cleanup
  if(new_len+8>=sizeof(md5buf))
    free(msg);
  //var char digest[16] := h0 append h1 append h2 append h3 //(Output is in little-endian)
  //*((U4*)digest) = h0;
  //*((U4*)(digest + 4)) = h1;
  //*((U4*)(digest + 8)) = h2;
  //*((U4*)(digest + 12)) = h3;
  to_digest(h0, digest);
  to_digest(h1, digest + 8);
  to_digest(h2, digest + 16);
  to_digest(h3, digest + 24); _

U
testmd5() __ // https://en.wikipedia.org/wiki/MD5
  U1 msg[] = "The quick brown fox jumps over the lazy dog";
  C digest[32];
  md5( msg, sizeof(msg)-1, OUT digest );
  R memcmp( digest, "9e107d9d372bb6826bd81d3542a419d6", 32 ) == 0; _

// -----------------------------------------------------------------------------

C salt[] = "jlmsuwbz";

#define HASHSZ  32 // 32 chars in digest for 16 bytes of md5. no '\0' at end!
#define HASHSZZ 36 // with place for '\0' and to bound-4

C hashes[40000][HASHSZZ]; // plain md5 hashes
C sthshs[40000][HASHSZZ]; // stretched hashes
U nhashes = 0; // number of calculated hashes
U nsthshs = 0; // same for stretched hashes

KS
getmd5( U i ) __ // md5, possible cached, of salt + number i
  if( i<nhashes ) R hashes[i];
  assert( i==nhashes ); // they increase continuesly
  C tmpstr[100];
  U lentmp = sprintf( tmpstr, "%s%u", salt, i );
  md5( tmpstr, lentmp, OUT hashes[nhashes] ); hashes[nhashes][HASHSZ]='\0';
  R hashes[nhashes++]; _

KS
getsh( U i ) __ // md5^2017 i.e. stretched hash instead of getmd5
  if( i<nsthshs ) R sthshs[i];
  assert( i==nsthshs ); // they increase
  C h[HASHSZZ]; memcpy( h, getmd5( i ), HASHSZ ); h[HASHSZ]='\0';
  for( U l=0; l<2016; ++l )
    md5( h, HASHSZ, OUT h );
  memcpy( sthshs[nsthshs], h, HASHSZZ );
  R sthshs[nsthshs++]; _

KS
hasXXX( KS s ) __ // return 5-X pattern or NULL if 3-X pattern inside s
  O C x5[6];
  for( U i=0; i<HASHSZ-2; ++i) __
    if( s[i]==s[i+1] && s[i]==s[i+2] ) __
      x5[0]=x5[1]=x5[2]=x5[3]=x5[4]=s[i]; x5[5]='\0';
      R x5; _ _
  R NULL; _

U
findin1000( K U k, KS m, KS (*f)(U) ) __ // find  in next 1000 keys
  for( U j=k+1; j<k+1+1000; ++j ) if( strstr( f(j), m ) ) R j;
  R 0; _

U
solve( KS (*f)(U) ) __
  U k = 0;
  for( U i=0; i<64; ++i ) __ // get 64-th candidate
    for(;;) __
      KS m = hasXXX( f(k) );
      if( m && findin1000( k, m, f ) )
        break;
      ++k; _
    ++k; _
  R k-1; _

I
main() __ // 44.7 s for Python --> 8.71 --> 6.03 s GNU C
  if( !testmd5() ) R 1;
  C h[HASHSZ]; md5( "abc0", 4, OUT h ); // test also sample from Day 14
  if( memcmp( h, "577571be4de9dcce85a041ba0410f29f", HASHSZ ) !=0 ) R 1;
  printf( "%u\n", solve(getmd5) );
  printf( "%u\n", solve(getsh) );
  R 0; _
