
EXE := .exe
SMLNJ := sml.bat
MLBUILD := ml-build.bat
NJ_SUFFIX:=$(shell echo "TextIO.output(TextIO.stdOut, SMLofNJ.SysInfo.getHeapSuffix()^\"\n\");" \
                        | $(SMLNJ) | head -n 5 | tail -n 1)

PROJECT := createwin
CMS  := $(PROJECT:=.cm)

SAMPLES := $(PROJECT:=.$(NJ_SUFFIX))

all: $(SAMPLES)
	@make -C ..
	@for p in $(PROJECT); do \
		cmd /C "$(SMLNJ) @SMLload=$${p}.$(NJ_SUFFIX)"; \
	done

createwin.$(NJ_SUFFIX): createwin.cm
	@echo "  [SML] $(notdir $<)"
	cmd /C '$(MLBUILD) $< CreateWin.main createwin'

createwin$(EXE): createwin.mlb createwin.sml
	mlton -output $@ $<

.PHONY: clean
clean:
	-rm $(PROJECT)$(EXE)
	-rm $(PROJECT:=.$(NJ_SUFFIX))
	rm -rf .cm

