/*
 * 2020-01-16, Jan Musinsky, tested on Fedora31 (gcc 9.2.1) x86_64 linux
 *
 * gcc -c minuit-example.c -I/usr/include/cernlib/2006
 * gfortran -o minuit-example minuit-example.o $(cernlib packlib)
 *
 * original files from CERNLIB 2006 source
 * cernlib-2006/2006/src/cfortran/Examples/minuit-main.c
 * cernlib-2006/2006/src/cfortran/Examples/minuit-fcn.c
 * cernlib-2006/2006/src/cfortran/Examples/minuit-fcn.f
 */

/*
 * This example demonstrate how to call MINUIT from C
 *
 * For question/problems contact: Heplib.Support@cern.ch
 *
 * Authors: William Hanlon <whanlon@cosmic.utah.edu>,
 *          Gunter Folger <Gunter.Folger@cern.ch>
 */

#include <math.h>
#include <string.h>
#include <cfortran.h>
#include <minuit.h>

#define Ncont 20

int main()
{
  int error_flag=0;
  PROTOCCALLSFSUB0(FCN,fcn);
  struct {
    double x[Ncont];
    double y[Ncont];
    int n;
  } pts;
  double f_null=0.;

  MNINIT(5,6,7);   /*  initialise  */
  MNSETI(" Minuit Example ");   /* set title */
  MNPARM(1,"X",0.,.1,f_null,f_null,error_flag);
  MNPARM(2,"-Y-",0.,.01,f_null,f_null,error_flag);
  MNEXCM(C_FUNCTION(FCN,fcn),"MIGRAD",0,0,error_flag,0);
  MNEXCM(C_FUNCTION(FCN,fcn),"MINOS",0,0,error_flag,0);
  MNCONT(C_FUNCTION(FCN,fcn),1,2,Ncont,pts.x[0],pts.y[0],pts.n, 0);
}

/* prototype for benefit of the wrapper */
void fcn(int npar, double grad[3], double * fcnval,
         double xval[2],int iflag, void (*Dummy)());

/* this macro creates a wrapper function called fcn_, which in turn calls the
 * function fcn defined below. The wrapper properly passes ints by value to
 * fcn, while it receives ints by reference from the fortran calling routine.
 */
FCALLSCSUB6(fcn,FCN,fcn,INT,DOUBLEV,PDOUBLE,DOUBLEV,INT,ROUTINE);

void fcn(int npar, double grad[3], double * fcnval,
         double xval[2],int iflag, void (*Dummy)())
{
  double Xc=1.11,Yc=3.14;

  switch(iflag) {
  case 1:
    /*
     *      Initialise.
     */
    printf(" fcn_c called to initialise\n");
    break;
  case 2:
    /*
     *        derivatives...
     */
    break;

  default:
    *fcnval = pow(xval[0]-Xc,2.) + pow((xval[1]-Yc),3.)*xval[1];
    break;
  }
}
