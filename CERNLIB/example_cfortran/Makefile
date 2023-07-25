# 2023-07-25

GCC		= gcc
GFC		= gfortran
CEXT		= c
GCCFLAGS	=
GFCFLAGS	=
CERNLIBINC	= '/usr/include/cernlib/2006'

SOURCES		= $(wildcard *.$(CEXT))
TARGETS		= $(patsubst %.$(CEXT), %, $(SOURCES))


.SUFFIXES:	# delete the default suffixes
.INTERMEDIATE:	chplot-example.o

all:		$(TARGETS)

%.o:		%.$(CEXT)
	$(GCC) $(GCCFLAGS) -c $< -o $@ -I$(CERNLIBINC)

%:		%.o
	$(GFC) $(GFCFLAGS) -o $@ $< $$(cernlib packlib)
	@echo

chplot-example:	chplot-example.o
	$(GFC) $(GFCFLAGS) -o $@ $< $$(cernlib graflib mathlib)
	@echo

clean:
	rm -fv $(TARGETS)
	rm -fv *.hbook *.ps last.kumac* paw.metafile
