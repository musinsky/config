C 2020-05-27, Jan Musinsky, last test on Fedora 32 (gcc 10.1.1) Linux x86_64
C
C gfortran hexam.f -o hexam $(cernlib packlib)
C
C original file h.ftn from HBOOK documentation tarball file
C https://cds.cern.ch/record/2296378/files/hbook.tar.gz
C original files from CERNLIB 2006 source
C cernlib-2006/2006/src/packlib/hbook/examples/hexam*.F (except hexam8.F)
C
      PROGRAM HEXAM
*.==========>
*.           HBOOK GENERAL TEST PROGRAM
*..=========> ( R.Brun )
      PARAMETER (NWPAW=300000)
      COMMON/PAWC/H(NWPAW)
*.___________________________________________
*
      OPEN(UNIT=31,FILE='hexam.out',STATUS='UNKNOWN')
      CALL HLIMIT(NWPAW)
      CALL HOUTPU(31)
*     CALL HPAGSZ(45)
      CALL TIMED(T0)
      CALL HEXAM1
      CALL HDELET(0)
      CALL TIMED(T1)
      WRITE(31,*) 'TIME FOR EXAMPLE 1 =',T1,'  SECONDS'
      WRITE( 6,*) 'TIME FOR EXAMPLE 1 =',T1,'  SECONDS'
      CALL HEXAM2
      CALL HDELET(0)
      CALL TIMED(T2)
      WRITE(31,*) 'TIME FOR EXAMPLE 2 =',T2,'  SECONDS'
      WRITE( 6,*) 'TIME FOR EXAMPLE 2 =',T2,'  SECONDS'
      CALL HEXAM3
      CALL HDELET(0)
      CALL TIMED(T3)
      WRITE(31,*) 'TIME FOR EXAMPLE 3 =',T3,'  SECONDS'
      WRITE( 6,*) 'TIME FOR EXAMPLE 3 =',T3,'  SECONDS'
      CALL HEXAM4
      CALL HDELET(0)
      CALL TIMED(T4)
      WRITE(31,*) 'TIME FOR EXAMPLE 4 =',T4,'  SECONDS'
      WRITE( 6,*) 'TIME FOR EXAMPLE 4 =',T4,'  SECONDS'
      CALL HEXAM5
      CALL TIMED(T5)
      WRITE(31,*) 'TIME FOR EXAMPLE 5 =',T5,'  SECONDS'
      WRITE( 6,*) 'TIME FOR EXAMPLE 5 =',T5,'  SECONDS'
      CALL HDELET(0)
      CALL HEXAM6
      CALL TIMED(T6)
      WRITE(31,*) 'TIME FOR EXAMPLE 6 =',T6,'  SECONDS'
      WRITE( 6,*) 'TIME FOR EXAMPLE 6 =',T6,'  SECONDS'
      CALL HDELET(0)
      CALL HEXAM7
      CALL TIMED(T7)
      WRITE(31,*) 'TIME FOR EXAMPLE 7 =',T7,'  SECONDS'
      WRITE( 6,*) 'TIME FOR EXAMPLE 7 =',T7,'  SECONDS'
      TTOT=T1+T2+T3+T4+T5+T6+T7
      WRITE(31,*) 'TIME FOR HEXAM =',TTOT,'  SECONDS'
      WRITE( 6,*) 'TIME FOR HEXAM =',TTOT,'  SECONDS'
      END
      SUBROUTINE HEXAM1
*.==========>
*.           HBOOK BASIC EXAMPLE USING 1-DIM HISTOGRAM,
*.           SCATTER-PLOT AND TABLE.
*..=========> ( R.Brun )
*             Set global title
*
      CALL HTITLE('EXAMPLE NO = 1')
*
*             Book 1-dim, scatter-plot and table
*
      CALL HBOOK1(10,'EXAMPLE OF 1-DIM HISTOGRAM',100,1.,101.,0.)
      CALL HBOOK2(20,'EXAMPLE OF SCATTER-PLOT',100,0.,1.,40,1.,41.,30.)
      CALL HTABLE(30,'EXAMPLE OF TABLE',15,1.,16.,40,1.,41.,1000.)
*
*             Fill 1-dim histogram
*
      DO 10 I=1,100
         W=10*MOD(I,25)
         CALL HFILL(10,FLOAT(I)+0.5,0.,W)
  10  CONTINUE
*
*             Fill scatter-plot
*
      X=-0.005
      DO 30 I=1,100
         X=X+0.01
         DO 20 J=1,40
            Y=J
            IW=MOD(I,25)*MOD(J,10)
            IWMAX=J-MOD(I,25)+10
            IF(IW.GT.IWMAX)IW=0
            CALL HFILL(20,X,Y,FLOAT(IW))
  20     CONTINUE
  30  CONTINUE
*
*             Fill table
*
      DO 50 I=1,20
         DO 40 J=1,40
            CALL HFILL(30,FLOAT(I)+0.5,FLOAT(J)+0.5,FLOAT(I+J))
  40     CONTINUE
  50  CONTINUE
*
*             Print all histograms with an index
*
      CALL HISTDO
*
      END
      SUBROUTINE HEXAM2
*.==========>
*.           TEST OF SOME BOOKING OPTIONS USING HBOOK RANDOM
*.           NUMBER GENERATORS.
*..=========> ( R.Brun )
      COMMON/HDEXF/C1,C2,XM1,XM2,XS1,XS2
      DOUBLE PRECISION C1,C2,XM1,XM2,XS1,XS2
      EXTERNAL HTFUN1,HTFUN2
*.___________________________________________
*.
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
      CALL HRPUT(0,'hexam.hbook','N')
*
      CALL HDELET(100)
      CALL HDELET(200)
*
*             Printing
*
      CALL HPRINT(0)
      END
      FUNCTION HTFUN1(X)
      DOUBLE PRECISION HDFUN1
      HTFUN1=HDFUN1(X)
      END
      FUNCTION HTFUN2(X,Y)
      HTFUN2=HTFUN1(X)*HTFUN1(Y)
      END
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
      SUBROUTINE HEXAM3
*.==========>
*.           MORE BOOKING OPTIONS
*..=========> ( R.Brun )
*.
      CALL HTITLE('EXAMPLE NO = 3')
*
*             Get all histograms saved in example 2
*
      CALL HROPEN(1,'HEXAM','hexam.hbook','U',1024,ISTAT)
      CALL HRIN(0,9999,0)
      CALL HMDIR('HEXAM3','S')
*
*             Print an index of all histograms that are now in memory
*
      CALL HINDEX
*
*             Reset hist 110 and 210.  adds more options
*
      CALL HRESET(110,' ')
      CALL HRESET(210,' ')
      CALL HIDOPT(110,'STAT')
      CALL HBARX(210)
      CALL HBPROX(210,0.)
      CALL HBSLIX(210,3,1000.)
      CALL HBANDY(210,0.1,0.5,0.)
      CALL HIDOPT(0,'1EVL')
*
*             New filling
*
      DO 10 I=1,2000
         CALL HFILL(110,HRNDM1(10),0.,1.)
         CALL HRNDM2(20,X,Y)
         CALL HFILL(210,X,Y,1.)
  10  CONTINUE
*
*             Print new contents using specialized printing routines
*             Same result could be obtained using HISTDO/HPRINT(0)/HPHS.
*
      CALL HPHIST(110,'HIST',1)
      CALL HPSCAT(210)
      CALL HPHIST(210,'PROX',1)
      CALL HPHIST(210,'BANY',1)
      CALL HPHIST(210,'SLIX',0)
*
*             Save all histograms in new directory HEXAM3
*
      CALL HROUT(0,ICYCLE,' ')
      CALL HREND('HEXAM')
      CLOSE (1)
*
      END
      SUBROUTINE HEXAM4
*.==========>
*.           TEST PRINTING OPTIONS
*..=========> ( R.Brun )
      DATA XMIN,XMAX/0.,1./
*.___________________________________________
*.
      CALL HTITLE('EXAMPLE NO = 4')
*
*             Get hist 110 from data base
*
      CALL HRGET(110,'hexam.hbook',' ')
*
*             Book 2 new histograms
*
      CALL HBOOK1(1000,'TEST OF PRINTING OPTIONS',40,1.,41.,0.)
      CALL HBOOK1(2000,'TEST OF BIG BIN',20,XMIN,XMAX,0.)
      CALL HIDOPT(1000,'ERRO')
*
*             Fills new IDs
*
      DO 10 I=1,40
         J=2*I-1
         W=HI(110,J)+HI(110,J+1)
         CALL HFILL(1000,FLOAT(I),0.,W)
  10  CONTINUE
*
      DO 20 I=1,20
         J=5*I
         W=SQRT(HI(110,J))
         CALL HIX(2000,I,X)
         CALL HF1(2000,X,W)
  20  CONTINUE
*
*             Set various printing options
*
      CALL HIDOPT(110,'BLAC')
      CALL HIDOPT(110,'NPLO')
      CALL HIDOPT(110,'NPST')
      CALL HPHIST(110,'HIST',1)
      CALL HMAXIM(110,100.)
      CALL HIDOPT(110,'1EVL')
      CALL HIDOPT(110,'NPCH')
      CALL HPHIST(110,'HIST',1)
*
      CALL HIDOPT(1000,'NPCH')
      CALL HIDOPT(1000,'NPCO')
      CALL HPROT(1000,'HIST',1)
      CALL HIDOPT(1000,'LOGY')
      CALL HPRINT(1000)
      CALL HIDOPT(1000,'INTE')
      CALL HIDOPT(1000,'PERR')
      CALL HIDOPT(1000,'ROTA')
      CALL HPRINT(1000)
*
      CALL HBIGBI(2000,5)
      CALL HIDOPT(2000,'NPCO')
      CALL HIDOPT(2000,'NPLO')
      CALL HPRINT(2000)
*
      END
      SUBROUTINE HEXAM5
*.==========>
*.           OPERATIONS ON HISTOGRAMS AND FITTING
*..=========> ( R.Brun )
      COMMON/HDEXF/C1,C2,XM1,XM2,XS1,XS2
      COMMON /HEXF/A,B,C,D
      DOUBLE PRECISION C1,C2,XM1,XM2,XS1,XS2,HDFUN,HDFUN1
      DIMENSION X(100),Y(100)
      DIMENSION XF(4000,2),YF(4000),EY(4000),SIGPAR(6),COV(21),ST(6),
     +PMI(6),PMA(6)
      EXTERNAL HDFUN,HDFUN1,HFUNGA
      CHARACTER*12 TITL1
      DATA TITL1/'TITLE OF ID1'/
*.___________________________________________
*.
      CALL HTITLE('EXAMPLE NO = 5')
*
*             GET hist 110 from data base
*
      CALL HRGET(110,'hexam.hbook',' ')
      CALL HRGET(210,'hexam.hbook',' ')
*
*
      CALL HBOOK1(1,TITL1,100,0.,1.,0.)
      CALL HCOPY(1,2,'TITLE OF ID = 2')
*
*             Gets information from ID=110 and fills new IDs 1,2
*
      CALL HUNPAK(110,X,'HIST',1)
      CALL UCOPY(X,Y,100)
      CALL VZERO(X(51),50)
      CALL HPAK(1,X)
      CALL HPHIST(1,'HIST',1)
      CALL VZERO(Y,50)
      CALL HPAK(2,Y)
      CALL HPHIST(2,'HIST',1)
*
*             adds 1 and 2. Identifier 3 is created and will contain
*             result of addition
*
      CALL HOPERA(1,'+',2,3,1.,1.)
      CALL HCOPY(3,4,' ')
*
*             Fits 3 with the function HTFUN1 defined in example 2 .
*             Initializes parameters. Prints results of the last
*             iteration.
*             Superimpose result of fit to the histogram
*             The result of this fit can be compared with the initial
*             parameters of example 2
*
      C1=40.
      C2=20.
      XM1=0.4
      XM2=0.6
      XS1=0.1
      XS2=0.1
*
      CALL HFITS(3,HDFUN1,6,C1,CHI2,12,SIGPAR)
*
      CALL HPHIST(3,'HIST',1)
*
*
*            Fits a two-dimensional distribution (xf,yf) with HFITN
*            initialize parameters. Prints results of the last
*            iteration.
*            Errors EY automatically computed as SQRT(yf)
*
      NY=0
      DO 10 J=1,40
         DO 5 I=1,100
            CONT=HIJ (210,I,J)
            IF (CONT.EQ.0.) GOTO 5
            NY=NY+1
            YF(NY)=CONT
            EY(NY)=SQRT(CONT)
            CALL HIJXY (210,I,J,X1,X2)
            XF(NY,1)=X1+0.005
            XF(NY,2)=X2+0.0125
    5    CONTINUE
   10 CONTINUE
      C1=3.
      C2=1.
      XM1=0.3
      XM2=0.7
      XS1=0.07
      XS2=0.12
      DO 15 I=1,6
         ST(I)=-1.
   15 CONTINUE
*
      CALL HFITN (XF,YF,EY,NY,4000,2,HDFUN,6,C1,CHI2,11,SIGPAR,COV,
     +ST,PMI,PMA)
      WRITE(31,*) ' COVARIANCE MATRIX'
      WRITE(31,*) ' *****************'
      I2=0
      DO 20 K=1,6
         I1=I2+1
         I2=I1+K-1
         WRITE(31,*) (COV(I),I=I1,I2)
   20 CONTINUE
*
*
*       Gaussian fitting. Prints first and last iterations.
*
      CALL HDELET (0)
      A=2.
      B=0.4
      C=0.1
      CALL HBFUN1 (1,' ',100,0.,1.,HFUNGA)
      CALL HBOOK1 (5,' ',100,0.,1.,1000.)
      DO 30 I=1,5000
         XR=HRNDM1 (1)
         CALL HFILL (5,XR,0.,1.)
   30 CONTINUE
*
      CALL HFITGA (5,A,B,C,CHI2,12,SIGPAR)
      CALL HPRINT (5)
      CALL HDELET (0)
*
      END
*
*
      DOUBLE PRECISION FUNCTION HDFUN (X)
      DOUBLE PRECISION PAR,DER,DER1,HDFUN1,F1,F2
      DIMENSION DER(6),DER1(6),X(2)
      COMMON/HDEXF/PAR(6)
*
*         Compute value of the function at point X
*
      F1=HDFUN1(X(1))
      F2=HDFUN1(X(2))
      HDFUN=F1+F2
*
*         Compute derivatives
*
*      CALL HDERU1 (X(1),PAR,DER)
*      CALL HDERU1 (X(2),PAR,DER1)
*      DO 10 K=1,6
*         DER(K)=DER(K)+DER1(K)
*   10 CONTINUE
*
*      CALL HDERIV(DER)
*
      END
*
*
*
      SUBROUTINE HDERU1 (X,PAR,DER)
      DOUBLE PRECISION PAR,DER
      DIMENSION PAR(6),DER(6)
      DER(1)=EXP(-0.5*((X-PAR(3))/PAR(5))**2)
      DER(2)=EXP(-0.5*((X-PAR(4))/PAR(6))**2)
      DER(3)=PAR(1)*(X-PAR(3))/PAR(5)**2*DER(1)
      DER(4)=PAR(2)*(X-PAR(4))/PAR(6)**2*DER(2)
      DER(5)=DER(3)*(X-PAR(3))/PAR(5)
      DER(6)=DER(4)*(X-PAR(4))/PAR(6)
      END
*
*
      FUNCTION HFUNGA (X)
      COMMON /HEXF/ A,B,C,D
      HFUNGA=A*EXP(-0.5*((X-B)/C)**2)
      END
      SUBROUTINE HEXAM6
*.==========>
*.           PARAMETRIZATION      -     SMOOTHING
*..=========> ( R.Brun )
      DOUBLE PRECISION COEFF
      DIMENSION ITERM(15),COEFF(15)
*.___________________________________________
*
      CALL HTITLE('EXAMPLE NO = 6')
*
*             Get hist 110 from data base
*
      CALL HRGET(110,'hexam.hbook',' ')
*
*
*       Find best parametrization of histogram in terms of powers
*       of shifted Tchebychev polynomials
*       also produces the corresponding fortran function (here on
*       standard output)
*
*
      CALL HCOPY(110,1,' ')
      CALL HSETPR('PNBX',15.)
      CALL HSETPR('PNCX',15.)
      CALL HSETPR('PLUN',31.)
      CALL HPARAM(1,3011,1.,14,COEFF,ITERM,NCO)
      CALL HPRINT(1)
*
*
*        ID=2 is smoothed with B-splines
*        statistical errors (sqrt of contents) are drawn
*
*
      CALL HCOPY(110,2,' ')
      CALL HSPLI1(2,2,14,3,CHI2)
      CALL HIDOPT(2,'ERRO')
      CALL HPHIST(2,'HIST',1)
      END
      SUBROUTINE HEXAM7
*.==========>
*.           Example of N-tuples.
*..=========> ( R.Brun )
      DIMENSION X(3)
      CHARACTER*8 CHTAGS(3)
      DATA CHTAGS/'   X   ','   Y   ','   Z   '/
*.___________________________________________
*.
      CALL HTITLE('EXAMPLE NO = 7')
*
*             Reopen data base
*
      CALL HROPEN(1,'HEXAM7','hexam.hbook','U',1024,ISTAT)
      CALL HMDIR('NTUPLES','S')
*
      CALL HBOOK1(10,'TEST1',100,-3.,3.,0.)
      CALL HBOOK2(20,'TEST2',20,-3.,3.,20,-3.,3.,250.)
      CALL HBOOKN(30,'N-TUPLE',3,'//HEXAM7/NTUPLES',1000,CHTAGS)
*
      DO 10 I=1,10000
         CALL RANNOR(A,B)
         X(1)=A
         X(2)=B
         X(3)=A*A+B*B
         CALL HFN(30,X)
  10  CONTINUE
*
      CALL HROUT(30,ICYCLE,' ')
      CALL HPROJ1(10,30,0,0,1,999999,1)
      CALL HPROJ2(20,30,0,0,1,999999,1,2)
      CALL HPRINT(0)
*
      CALL HROUT(10,ICYCLE,' ')
      CALL HROUT(20,ICYCLE,' ')
*
      CALL HLDIR(' ',' ')
*
      CALL HREND('HEXAM7')
      CLOSE (1)
*
      END
