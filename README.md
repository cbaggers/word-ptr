# word-ptr

Currently SBCL doesnt unbox pointers in structs, this means that with a stuct like this:

    (defstruct bar
      (ptr (sb-sys:int-sap 0) :type sb-sys:system-area-pointer))

This code will cause consing as a tagged pointer will be created.

    (setf (bar-ptr foo) (sb-sys:sap+ (bar-ptr foo) 1))

The current work around is to use sb-sys:word instead and only convert to a pointer at the foreign function call site, as long as sb-sys:int-sap is inlined you avoid the consing there too.

This package is just a little abstraction over this solution so I get sb-sys:word on sbcl and cffi:pointers everywhere else.

I'm of course open to having equivalent hacks for other implementations but for now I just need SBCL

## Compatibility

This hack will not work on SBCL Alpha as saps can be wider than heap words there so we just use cffi:foreign-pointer there too.

## Notes

Recommended reading: [[Sbcl-help] system-area-pointer: compiler note](https://sourceforge.net/p/sbcl/mailman/sbcl-help/thread/AANLkTikbdzyFeMg7nDWUllF8aCbLCLxAEOFXOcsdH0SM@mail.gmail.com/)

Massive thanks to stassats for explaining the struct issue.
