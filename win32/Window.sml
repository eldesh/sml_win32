
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

    fun toInt opt =
      case opt of
           SW_HIDE             => 0
         | SW_SHOWNORMAL       => 1
         | SW_SHOWMINIMIZED    => 2
         | SW_SHOWMAXIMIZED    => 3
         | SW_SHOWNOACTIVATE   => 4
         | SW_SHOW             => 5
         | SW_MINIMIZE         => 6
         | SW_SHOWMINNOACTIVE  => 7
         | SW_SHOWNA           => 8
         | SW_RESTORE          => 9
         | SW_SHOWDEFAULT      => 10
         | SW_FORCEMINIMIZE    => 11

    fun fromInt n =
      case n of
           0  => SOME SW_HIDE
         | 1  => SOME SW_SHOWNORMAL
         | 2  => SOME SW_SHOWMINIMIZED
         | 3  => SOME SW_SHOWMAXIMIZED
         | 4  => SOME SW_SHOWNOACTIVATE
         | 5  => SOME SW_SHOW
         | 6  => SOME SW_MINIMIZE
         | 7  => SOME SW_SHOWMINNOACTIVE
         | 8  => SOME SW_SHOWNA
         | 9  => SOME SW_RESTORE
         | 10 => SOME SW_SHOWDEFAULT
         | 11 => SOME SW_FORCEMINIMIZE
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
      F_CreateWindowExA.f' (exStyle, `className, `name, styleWord
                            , x, y, width, height
                            , C.Ptr.inject' parent
                            , C.Ptr.inject' menu
                            , C.Ptr.inject' instance
                            , init))
  in
    checkResult(not(isNull win));
    win
  end
end
end

