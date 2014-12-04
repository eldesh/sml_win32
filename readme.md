
StandardML Win32 API binding
===============================================

## prerequisites

- Windows (>= 7) 32bit
- require MLton (>= 20130715) (developped on cygwin version)
- require SML/NJ (>= 110.77) (use native windows version. cygwin is not supported.)


## build

### SML/NJ

Just type `make` in your DOS prompt.


### MLton

Add reference to win32.mlb file.
When you test win32 library,

```
$ mlton win32.mlb
```


## originate

some part of code is port from [Poly/ML Windows programming interface](http://www.polyml.org/docs/Windows.html) .


## link

- [MSDN Win32 API index](http://msdn.microsoft.com/en-us/library/windows/desktop/ff818516%28v=vs.85%29.aspx "MSDN")
- [PolyML](http://www.polyml.org/docs/Windows.html "PolyML")

