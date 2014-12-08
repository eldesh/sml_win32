
MODULES := user32 kernel32
FFICMS := $(MODULES:=/nlffi-generated.cm)

all: $(FFICMS)


%/nlffi-generated.cm: %/libh.sml include/%.h include/wintype.h
	@echo " [FFIGen] $(patsubst %/,%,$(dir $@))"
	@cmd /C 'ml-nlffigen -dir $(patsubst %/,%,$(dir $@)) -include libh.sml include/$(patsubst %/,%,$(dir $@)).h'


.SECONDARY: $(MODULES:=/libh.sml)
%/libh.sml: libh.sml.in
	@mkdir -p $(dir $@)
	@sed -e "s|@SHARED_LIB@|$(patsubst %/,%,$(dir $@)).dll|" $< > $@

#
#%/libh.sml: libh.sml.in
#	@mkdir -p $(dir $@)
#	@sed -e "s|lib.*=.*@SHARED_LIB@.*|lib = DynLinkage.main_lib|" $< > $@
#

.PHONY: test test_load
test_load: all
	@for cm in $(FFICMS); do \
		cmd /C "sml test/make.sml $${cm}"; \
	 done

test: all test_load
	cmd /C 'cd test & ml-build strcpy.cm Test.main strcpy'
	cmd /C 'cd test & sml @SMLload=strcpy.x86-win32'


.PHONY: clean
clean:
	rm -rf $(MODULES)
	rm -rf $(addsuffix /libh.sml, $(MODULES))
	find . -name .cm -type d | xargs rm -rf

