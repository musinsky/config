# 2025-04-28

# GCC 15 (released 2025-04) changes '-std=gnu17' to '-std=gnu23'
# CERNLIB not compile with C language standard '-std=gnu23'
GCC		= gcc
GCC_MAJOR	= $(shell $(GCC) -dumpversion | cut -f1 -d '.')
#$(info GCC_MAJOR is $(GCC_MAJOR))
GCC_MORE_15	= $(shell [ $(GCC_MAJOR) -ge 15 ] && echo "yes")
#$(info GCC_MORE_15 is $(GCC_MORE_15))
GFC		= gfortran
CEXT		= c
ifeq "$(GCC_MORE_15)" "yes"
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
