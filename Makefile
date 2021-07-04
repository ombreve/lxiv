.POSIX:
.SUFFIXES:

TARGET = lxiv

LATEXMK = latexmk

pdf: $(TARGET).pdf

.PHONY: FORCE_MAKE
%.pdf : %.tex FORCE_MAKE
	$(LATEXMK)

clean:
	$(LATEXMK) -c

distclean:
	$(LATEXMK) -C

