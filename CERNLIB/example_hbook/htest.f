C 2021-12-01, Jan Musinsky, last test on Fedora 35 (gcc 11.2.1) Linux x86_64
C
C gfortran htest.f -o htest $(cernlib packlib)
C
C original file htest.f from HBOOK documentation tarball file
C https://cds.cern.ch/record/2296378/files/hbook.tar.gz
C based on original files from CERNLIB 2006 source
C cernlib-2006/2006/src/packlib/hbook/examples/hexam2.F
C
      PROGRAM HTEST
      PARAMETER (NWPAWC=20000)
      COMMON/PAWC/H(NWPAWC)
      EXTERNAL HTFUN1,HTFUN2
      CALL HLIMIT(NWPAWC)
*     Book histograms and declare functions
      CALL HBFUN1(100,'Test of HRNDM1',100,0.,1.,HTFUN1)
      CALL HBOOK1(110,'Filled according to HTFUN1',100,0.,1.,1000.)
      CALL HBFUN2(200,'Test of HRNDM2',100,0.,1.,40,0.,1.,HTFUN2)
      CALL HSCALE(200,0.)
      CALL HBOOK2(210,'Filled according to HTFUN2',
     +     100,0.,1.,40,0.,1.,30.)
*     Fill histograms
      DO 10 I=1,10000
         X=HRNDM1(100)
         CALL HFILL(110,X,0.,1.)
         CALL HRNDM2(200,X,Y)
         CALL HFILL(210,X,Y,1.)
   10 CONTINUE
*     Save all histograms on file htest.hbook
      CALL HRPUT(0,'htest.hbook','N')
      CALL HDELET(100)
      CALL HDELET(200)
      CALL HPRINT(0)
      END
      FUNCTION HTFUN2(X,Y)
*     Two-dimensional gaussian
      HTFUN2=HTFUN1(X)*HTFUN1(Y)
      RETURN
      END
      FUNCTION HTFUN1(X)
*     Constants for gaussians
      DATA C1,C2/1.,0.5/
      DATA XM1,XM2/0.3,0.7/
      DATA XS1,XS2/0.07,0.12/
*     Calculate the gaussians
      A1=-0.5*((X-XM1)/XS1)**2
      A2=-0.5*((X-XM2)/XS2)**2
      X1=C1
      X2=C2
      IF(ABS(A1).GT.0.0001)X1=C1*EXP(A1)
      IF(ABS(A2).GT.0.0001)X2=C2*EXP(A2)
*     Return function value
      HTFUN1=X1+X2
      RETURN
      END
