# 2025-04-28

# GCC 15 (released 2025-04) changes from '-std=gnu17' to '-std=gnu23'
# CERNLIB not compile with C language standard '-std=gnu23'
GCC		= gcc
GCC_MAJOR	= $(shell $(GCC) -dumpversion | cut -f1 -d '.')
#$(info GCC_MAJOR is $(GCC_MAJOR))
GCC_15_OR_MORE	= $(shell expr $(GCC_MAJOR) \>= 15)
#$(info GCC_15_OR_MORE is $(GCC_15_OR_MORE))
GFC		= gfortran
CEXT		= c
ifeq ($(GCC_15_OR_MORE),1)
#$(info CERNLIB will not compile for C standard greater than 17)
GCCFLAGS	=-std=gnu17
endif
GCCFLAGS	+=
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
