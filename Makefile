
MODULES := user32 kernel32
FFICMS := $(MODULES:=/nlffi-generated.cm)

all: $(FFICMS)


%/nlffi-generated.cm: %/libh.sml include/%.h
	@echo " [FFIGen] $(patsubst %/,%,$(dir $@))"
	@cmd /C 'ml-nlffigen -dir $(patsubst %/,%,$(dir $@)) -include libh.sml include/$(patsubst %/,%,$(dir $@)).h'


.SECONDARY: $(MODULES:=/libh.sml)
%/libh.sml: libh.sml.in
	@mkdir -p $(dir $@)
	@sed -e "s|@SHARED_LIB@|$(patsubst %/,%,$(dir $@)).dll|" $< > $@


.PHONY: test
test: all
	@for cm in $(FFICMS); do \
		cmd /C "sml make.sml $${cm}"; \
	 done


.PHONY: clean
clean:
	rm -rf user32
	rm -rf kernel32
	rm -rf user32/libh.sml
	rm -rf kernel32/libh.sml
	find . -name .cm -type d | xargs rm -rf

