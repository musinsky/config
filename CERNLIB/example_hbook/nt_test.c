/*
 * nt_test.c
 *
 * minminal working example of using C source code to build CERNLIB HBOOK
 * routines.
 *
 * see
 * http://osksn2.hep.sci.osaka-u.ac.jp/~taku/doc/hbook.pdf
 * http://www2.pv.infn.it/~sc/cern/paw.pdf
 * for some of the last surviving documentation regarding HBOOK calls and
 * running PAW that I can find.
 *
 *
 * successfully compiled and ran on Fedora release 30 X86_64
 * gcc -c -DgFortran nt_test.c -I/usr/include/cernlib/2006
 * gfortran -o nt_test nt_test.o `cernlib packlib`
 *
 * Examine contents by running pawX11-gfortran:
 * h/fil 1 nt_test.hbook
 * nt/print 10
 * nt/scan 10
 * igset mtyp 3
 * nt/plot 10.x%y
 *
 * William Hanlon (whanlon@cosmic.utah.edu)
 * 14 Aug 2019
 */

#include <stdlib.h>
#include <cfortran.h>
#include <packlib.h>

#define PAWC_SIZE 20000

typedef struct { float PAW[PAWC_SIZE]; } PAWC_DEF;
#define PAWC COMMON_BLOCK(PAWC,pawc)
COMMON_BLOCK_DEF(PAWC_DEF,PAWC);
PAWC_DEF PAWC;

/* simple data struct used to fill the ntuple. */
typedef struct
{
  float x;
  float y;
} DATA_DEF;
#define Data COMMON_BLOCK(DATA, data)
COMMON_BLOCK_DEF(DATA_DEF, Data);
DATA_DEF Data;

int main(int argc, char **argv)
{
  int hid = 1, istat = 0, icycle = 0;
  char chtag_in[2][8] = {"x", "y"};
  int record_size = 1024;

  int x, y;

  HLIMIT(PAWC_SIZE);

  HROPEN(1, "TEST", "nt_test.hbook", "N", record_size, istat);

  HBNT(10, "DATA", " ");
  HBNAME(10, "NTDATA", Data.x, "X:R,Y:R");

  /* simple loop to demonstrate filling of the histogram. this can be
   * easily modified to read in data from a text file. */
  int i;
  for (i = 0; i < 10; ++i)
  {
    Data.x = i;
    Data.y = i*2;
    HFNT(10);
  }
  HROUT(10, icycle, " ");

  HREND("TEST");
  KUCLOS(1, " " , 1);

  exit(EXIT_SUCCESS);
}
