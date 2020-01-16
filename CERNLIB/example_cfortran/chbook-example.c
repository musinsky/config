/*
 * 2020-01-16, Jan Musinsky, tested on Fedora31 (gcc 9.2.1) x86_64 linux
 *
 * gcc -c chbook-example.c -I/usr/include/cernlib/2006
 * gfortran -o chbook-example chbook-example.o $(cernlib packlib)
 *
 * original files from CERNLIB 2006 source
 * cernlib-2006/2006/src/cfortran/Examples/chbook-example.c
 */

/*
 * This example demonstrate how to call HBOOK from C (histogram part)
 *
 * For question/problems contact: Heplib.Support@cern.ch
 *
 */

#include <stdlib.h>
#include <cfortran.h>
#include <hbook.h>

#define PAWC_SIZE 50000

typedef struct { float PAW[PAWC_SIZE]; } PAWC_DEF;
#define PAWC COMMON_BLOCK(PAWC,pawc)
COMMON_BLOCK_DEF(PAWC_DEF,PAWC);
PAWC_DEF PAWC;   // important

void main()
{
  printf("RAND_MAX = %d\n", RAND_MAX); // 2147483647 on linux

  int hid = 1;
  int i, j;
  float r;

  HLIMIT(PAWC_SIZE);
  HBOOK1(hid,"Some random distribution",20000,-4.,4.,0.);

  for (i = 0; i < 100000; i++) {
    r = -4. + 8./100000.*i;
    for (j = 0; j < 10; j++) {
      r = r + rand()/RAND_MAX*8./100000.;
      /* printf("random number is %f\n",r); */
      HFILL(hid,r,0.,1.);
    }
  }

  HPRINT(hid);
}
