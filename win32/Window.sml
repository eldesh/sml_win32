
structure Window : WINDOW =
struct
local
  open Base

  fun checkWindow c = (checkResult(not(isNull c)); c)
in
  type HWND = HWND
  type HINSTANCE = HINSTANCE
  type RECT = RECT
  type POINT = POINT
  type HMENU = HMENU

  open WinBase (* Get Style and SetWindowPositionStyle *)

  structure ShowWindowOptions =
  struct
    datatype t = SW_FORCEMINIMIZE
               | SW_HIDE
               | SW_MINIMIZE
               | SW_RESTORE
               | SW_SHOW
               | SW_SHOWDEFAULT
               | SW_SHOWMAXIMIZED
               | SW_SHOWMINIMIZED
               | SW_SHOWMINNOACTIVE
               | SW_SHOWNA
               | SW_SHOWNOACTIVATE
               | SW_SHOWNORMAL

    val SW_MAXIMIZE = SW_SHOWMAXIMIZED

    fun toWord opt : SysWord.word =
      case opt of
           SW_HIDE             => 0w0
         | SW_SHOWNORMAL       => 0w1
         | SW_SHOWMINIMIZED    => 0w2
         | SW_SHOWMAXIMIZED    => 0w3
         | SW_SHOWNOACTIVATE   => 0w4
         | SW_SHOW             => 0w5
         | SW_MINIMIZE         => 0w6
         | SW_SHOWMINNOACTIVE  => 0w7
         | SW_SHOWNA           => 0w8
         | SW_RESTORE          => 0w9
         | SW_SHOWDEFAULT      => 0w10
         | SW_FORCEMINIMIZE    => 0w11

    fun fromWord (w:SysWord.word) =
      case w of
           0w0  => SOME SW_HIDE
         | 0w1  => SOME SW_SHOWNORMAL
         | 0w2  => SOME SW_SHOWMINIMIZED
         | 0w3  => SOME SW_SHOWMAXIMIZED
         | 0w4  => SOME SW_SHOWNOACTIVATE
         | 0w5  => SOME SW_SHOW
         | 0w6  => SOME SW_MINIMIZE
         | 0w7  => SOME SW_SHOWMINNOACTIVE
         | 0w8  => SOME SW_SHOWNA
         | 0w9  => SOME SW_RESTORE
         | 0w10 => SOME SW_SHOWDEFAULT
         | 0w11 => SOME SW_FORCEMINIMIZE
         | _  => NONE
  end

  val SW_NORMAL = ShowWindowOptions.SW_SHOWNORMAL
  val SW_MAX = ShowWindowOptions.SW_SHOWDEFAULT

  fun CreateWindowEx {class: Class.Atom.t,
                      name: string,
                      style: Style.t,
                      exStyle: ExStyle.t,
                      x: Int32.int,
                      y: Int32.int,
                      width: Int32.int,
                      height: Int32.int,
                      relation: ParentType.t,
                      instance: HINSTANCE, (* application instance *)
                      init: C.voidptr}: HWND =
  let
    val ` = ZString.dupML'
    val exStyle = MLRep.Long.Unsigned.fromLarge (SysWord.toLarge (ExStyle.toWord exStyle))
    val className = Class.Atom.toString class
    val (parent, menu, styleWord) = WinBase.unpackWindowRelation(relation, style)

    (* Create a window. *)
    val win : HWND =
      C.Ptr.cast' (
      F_CreateWindowExA.f' (exStyle, `className, `name
                            , MLRep.Long.Unsigned.fromLarge (SysWord.toLarge styleWord)
                            , x, y, width, height
                            , C.Ptr.inject' parent
                            , C.Ptr.inject' menu
                            , C.Ptr.inject' instance
                            , init))
  in
    checkResult(not(isNull win));
    win
  end

  structure Visible =
  struct
    datatype t = Visible
               | NonVisible
  end

  fun ShowWindow (win, style) =
  let
    val style = MLRep.Long.Signed.fromLarge
                  (SysWord.toLargeInt
                    (ShowWindowOptions.toWord style))
  in
    if F_ShowWindow.f' (C.Ptr.inject' win, style) <> 0
    then Visible.Visible
    else Visible.NonVisible
  end

end
end

