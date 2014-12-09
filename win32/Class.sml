
structure Class : CLASS =
struct
local
  open Base
in
  structure Atom =
  struct
    datatype t = Registered of MLRep.Short.Unsigned.word
               | SystemClass of string

    val Button        = SystemClass "Button"
    val ComboBox      = SystemClass "ComboBox"
    val Edit          = SystemClass "Edit"
    val ListBox       = SystemClass "ListBox"
    val MDIClient     = SystemClass "MDIClient" (* Maybe treat this specially. *)
    val RichEdit      = SystemClass "RichEdit"
    val RichEditClass = SystemClass "RICHEDIT_CLASS"
    val ScrollBar     = SystemClass "ScrollBar"
    val Static        = SystemClass "Static"

    fun toString (Registered    id) = MLRep.Short.Unsigned.toString id
      | toString (SystemClass atom) = atom
  end

  type HINSTANCE = HINSTANCE
  type HICON     = HICON
  type HCURSOR   = HCURSOR
  type HBRUSH    = HBRUSH
  type HWND      = HWND

  structure Style =
  struct
    type flags = SysWord.word
    type t = flags
    fun toWord f = f
    fun fromWord f = f
    val flags = List.foldl SysWord.orb 0w0
    fun allSet (fl1, fl2) = SysWord.andb(fl1, fl2) = fl1
    fun anySet (fl1, fl2) = SysWord.andb(fl1, fl2) <> 0w0
    fun clear (fl1, fl2) = SysWord.andb(SysWord.notb fl1, fl2)

    val CS_VREDRAW: flags          = 0wx00000001
    val CS_HREDRAW: flags          = 0wx00000002
    val CS_KEYCVTWINDOW: flags     = 0wx00000004
    val CS_DBLCLKS: flags          = 0wx00000008
    val CS_OWNDC: flags            = 0wx00000020
    val CS_CLASSDC: flags          = 0wx00000040
    val CS_PARENTDC: flags         = 0wx00000080
    val CS_NOKEYCVT: flags         = 0wx00000100
    val CS_NOCLOSE: flags          = 0wx00000200
    val CS_SAVEBITS: flags         = 0wx00000800
    val CS_BYTEALIGNCLIENT: flags  = 0wx00001000
    val CS_BYTEALIGNWINDOW: flags  = 0wx00002000
    val CS_GLOBALCLASS: flags      = 0wx00004000

    val CS_DROPSHADOW: flags       = 0wx00020000

    val all = flags[CS_VREDRAW, CS_HREDRAW, CS_KEYCVTWINDOW, CS_DBLCLKS, CS_OWNDC,
                    CS_CLASSDC, CS_NOKEYCVT, CS_NOCLOSE, CS_SAVEBITS,
                    CS_BYTEALIGNCLIENT, CS_BYTEALIGNWINDOW, CS_GLOBALCLASS]

    val intersect = List.foldl SysWord.andb all
  end

  val DLGWINDOWEXTRA = 30 (* : int = .cbWndExtra *)

  structure WndClass =
  struct
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

  local
    structure W = S_tagWNDCLASS
  in
  fun RegisterClass (WndClass.WNDCLASS
                       { style
                       , wndProc
                       , cbClsExtra
                       , cbWndExtra
                       , hInstance
                       , hIcon
                       , hCursor
                       , hbrBackground
                       , menuName
                       , className
                       }) =
  let
    val () = raise Fail "NotImplementedYet RegisterClass"
    val winc : (W.tag C.su, C.rw) C.obj = C.new W.typ
    val style = MLRep.Long.Unsigned.fromLarge (SysWord.toLarge (Style.toWord style))
    val () = C.Set.uint (W.f_style winc, style)
    val _ = W.f_lpfnWndProc winc

    val ret = F_RegisterClassA.f (C.Ptr.ro (C.Ptr.|&| winc))
  in
    Atom.Registered (if ret = 0w0
                     then raise Fail "RgisterClassA"
                     else ret)
  end
  end

  fun UnregisterClass (className, hInstance) =
  let
    val className = ZString.dupML' className
  in
    F_UnregisterClassA.f' (className, C.Ptr.inject' hInstance) <> 0
  end
end (* local *)
end

