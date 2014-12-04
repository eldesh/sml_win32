

all: win32binding


.PHONY: win32binding
win32binding:
	make -C ffi

.PHONY: test
test:
	make -C ffi test

.PHONY: clean
clean:
	make -C ffi clean

