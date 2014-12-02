
all: win32/nlffi-generated.cm

win32/nlffi-generated.cm: include/win32api.h
	cmd /C 'ml-nlffigen -dir win32 -include ../libh.sml include/win32api.h'
	cmd /C 'sml make.sml'

.PHONY: clean
clean:
	rm -rf win32

