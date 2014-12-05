
FFIWIN32 := ffiwin32/.cm
WIN32    := win32/.cm


all: $(WIN32)


$(FFIWIN32):
	make -C ffi


$(WIN32): $(FFIWIN32)
	make -C win32


.PHONY: test
test:
	make -C ffi test

.PHONY: clean
clean:
	make -C ffi clean
	make -C win32 clean

