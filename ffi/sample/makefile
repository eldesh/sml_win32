
SMLNJ := sml.bat
MLBUILD := ml-build.bat
NJ_SUFFIX:=$(shell echo "TextIO.output(TextIO.stdOut, SMLofNJ.SysInfo.getHeapSuffix()^\"\n\");" \
                        | $(SMLNJ) | head -n 5 | tail -n 1)

PROJECT := msgbox winmain
CMS  := $(PROJECT:=.cm)

SAMPLES := $(PROJECT:=.$(NJ_SUFFIX))

all: $(SAMPLES)
	@make -C ..
	@for p in $(PROJECT); do \
		cmd /C "$(SMLNJ) @SMLload=$${p}.$(NJ_SUFFIX)"; \
	done

msgbox.$(NJ_SUFFIX): msgbox.cm
	@echo "  [SML] $(notdir $<)"
	cmd /C '$(MLBUILD) $< Msgbox.main msgbox'

winmain.$(NJ_SUFFIX): winmain.cm
	@echo "  [SML] $(notdir $<)"
	cmd /C '$(MLBUILD) $< WinMain.main winmain'

.PHONY: clean
clean:
	-rm $(PROJECT:=.$(NJ_SUFFIX))
	rm -rf .cm

