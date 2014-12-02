
all: user32/nlffi-generated.cm kernel32/nlffi-generated.cm


user32/nlffi-generated.cm: user32/libh.sml include/user32.h
	@cmd /C 'ml-nlffigen -dir user32 -include libh.sml include/user32.h'


kernel32/nlffi-generated.cm: kernel32/libh.sml include/kernel32.h
	@cmd /C 'ml-nlffigen -dir kernel32 -include libh.sml include/kernel32.h'


%/libh.sml: libh.sml.in
	@mkdir -p $(dir $@)
	@sed -e "s|@SHARED_LIB@|$(patsubst %/,%,$(dir $@)).dll|" $< > $@


.PHONY: test
test: all
	cmd /C 'sml make.sml'


.PHONY: clean
clean:
	rm -rf user32
	rm -rf kernel32
	rm -rf user32/libh.sml
	rm -rf kernel32/libh.sml
	find . -name .cm -type d | xargs rm -rf

