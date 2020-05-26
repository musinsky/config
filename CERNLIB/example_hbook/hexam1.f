C 2020-05-27, Jan Musinsky, last test on Fedora 32 (gcc 10.1.1) Linux x86_64
C
C gfortran hexam1.f -o hexam1 $(cernlib packlib)
C
C original files from CERNLIB 2006 source
C cernlib-2006/2006/src/packlib/hbook/examples/hexam.F
C cernlib-2006/2006/src/packlib/hbook/examples/hexam1.F
C
      PROGRAM HEXAM1
*.==========>
*.           HBOOK GENERAL TEST PROGRAM
*..=========> ( R.Brun )
      PARAMETER (NWPAW=300000)
      COMMON/PAWC/H(NWPAW)
      CALL HLIMIT(NWPAW)
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
