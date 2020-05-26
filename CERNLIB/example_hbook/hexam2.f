C 2020-05-27, Jan Musinsky, last test on Fedora 32 (gcc 10.1.1) Linux x86_64
C
C gfortran hexam2.f -o hexam2 $(cernlib packlib)
C
C original files from CERNLIB 2006 source
C cernlib-2006/2006/src/packlib/hbook/examples/hexam.F
C cernlib-2006/2006/src/packlib/hbook/examples/hexam2.F
C
      PROGRAM HEXAM2
*.==========>
*.           HBOOK GENERAL TEST PROGRAM
*..=========> ( R.Brun )
      PARAMETER (NWPAW=300000)
      COMMON/PAWC/H(NWPAW)
*.==========>
*.           TEST OF SOME BOOKING OPTIONS USING HBOOK RANDOM
*.           NUMBER GENERATORS.
*..=========> ( R.Brun )
      COMMON/HDEXF/C1,C2,XM1,XM2,XS1,XS2
      DOUBLE PRECISION C1,C2,XM1,XM2,XS1,XS2
      EXTERNAL HTFUN1,HTFUN2
*.___________________________________________
*.
      CALL HLIMIT(NWPAW)
      CALL HTITLE('EXAMPLE NO = 2')
*
*             Booking
*
      C1=1.
      C2=0.5
      XM1=0.3
      XM2=0.7
      XS1=0.07
      XS2=0.12
*
      CALL HBFUN1(100,'TEST OF HRNDM1',100,0.,1.,HTFUN1)
      CALL HIDOPT(100,'STAR')
      CALL HCOPY(100,10,' ')
*
      CALL HBOOK1(110,  'THIS HISTOGRAM IS FILLED ACCORDING TO THE FUNCT
     +ION HTFUN1'
     +  ,100,0.,1.,1000.)
*
      CALL HBFUN2(200,'TEST OF HRNDM2',100,0.,1.,40,0.,1.,HTFUN2)
      CALL HSCALE(200,0.)
      CALL HCOPY(200,20,' ')
*
      CALL HBOOK2(210,'HIST FILLED WITH HFILL AND HRNDM2' ,100,0.,1.,
     +  40,0.,1.,30.)
*
*             Filling
*
      DO 10 I=1,5000
         X=HRNDM1(100)
         CALL HFILL(110,X,0.,1.)
         CALL HRNDM2(200,X,Y)
         CALL HFILL(210,X,Y,1.)
  10  CONTINUE
*
*             Save all histograms on file 'hexam.dat'
*
      CALL HRPUT(0,'hexam2.hbook','N')
*
      CALL HDELET(100)
      CALL HDELET(200)
*
*             Printing
*
      CALL HPRINT(0)
      END
*
*
      FUNCTION HTFUN1(X)
      DOUBLE PRECISION HDFUN1
      HTFUN1=HDFUN1(X)
      END
*
*
      FUNCTION HTFUN2(X,Y)
      HTFUN2=HTFUN1(X)*HTFUN1(Y)
      END
*
*
      DOUBLE PRECISION FUNCTION HDFUN1(X)
      COMMON/HDEXF/C1,C2,XM1,XM2,XS1,XS2
      DOUBLE PRECISION C1,C2,XM1,XM2,XS1,XS2,A1,A2,X1,X2
*
      A1=-0.5*((X-XM1)/XS1)**2
      A2=-0.5*((X-XM2)/XS2)**2
      IF(A1.LT.-20.)THEN
         X1=0.
      ELSEIF(A1.GT.20.)THEN
         X1=1.E5
      ELSE
         X1=C1*EXP(A1)
      ENDIF
      IF(A2.LT.-20.)THEN
         X2=0.
      ELSEIF(A2.GT.20.)THEN
         X2=1.E5
      ELSE
         X2=C2*EXP(A2)
      ENDIF
      HDFUN1=X1+X2
      END
