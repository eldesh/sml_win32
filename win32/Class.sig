
signature CLASS =
sig
  type HINSTANCE
  type HICON
  type HCURSOR
  type HBRUSH
  type HWND

  structure Atom :
  sig
    eqtype t

    val Button        : t
    val ComboBox      : t
    val Edit          : t
    val ListBox       : t
    val MDIClient     : t
    val RichEdit      : t
    val RichEditClass : t
    val ScrollBar     : t
    val Static        : t

    val toString : t -> string
  end

  structure Style :
  sig
    include BIT_FLAGS
    type t = flags

    val CS_BYTEALIGNCLIENT : flags
    val CS_BYTEALIGNWINDOW : flags
    val CS_CLASSDC : flags
    val CS_DBLCLKS : flags
    val CS_GLOBALCLASS : flags
    val CS_HREDRAW : flags
    val CS_KEYCVTWINDOW : flags
    val CS_NOCLOSE : flags
    val CS_NOKEYCVT : flags
    val CS_OWNDC : flags
    val CS_PARENTDC : flags
    val CS_SAVEBITS : flags
    val CS_VREDRAW : flags
    val CS_DROPSHADOW: flags
  end

  val DLGWINDOWEXTRA : int

  structure WndClass :
  sig
    datatype t = WNDCLASS of
                 { style: Style.t
                 , wndProc: (HWND
                            * MLRep.Long.Unsigned.word
                            * MLRep.Long.Unsigned.word
                            * MLRep.Long.Signed.int
                            -> MLRep.Long.Signed.int)
                 , cbClsExtra: int
                 , cbWndExtra: int
                 , hInstance: HINSTANCE
                 , hIcon: HICON option
                 , hCursor: HCURSOR option
                 , hbrBackground : HBRUSH option
                 , menuName : string option
                 , className : string
                 }
  end
  type WNDCLASS = WndClass.t

  val RegisterClass : WndClass.t -> Atom.t
  val UnregisterClass : string * HINSTANCE -> bool
end

