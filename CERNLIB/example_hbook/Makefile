# 2023-07-25

GFC	= gfortran
FEXT	= f
GFCFLAGS=

SOURCES	= $(wildcard *.$(FEXT))
TARGETS	= $(patsubst %.$(FEXT), %, $(SOURCES))

all:	$(TARGETS)

%:	%.$(FEXT)
	$(GFC) $(GFCFLAGS) $< -o $@ $$(cernlib packlib)

clean:
	rm -fv $(TARGETS)
	rm -fv *.hbook *.out last.kumac* paw.metafile
