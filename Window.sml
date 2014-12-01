(*
    Copyright (c) 2001-7
        David C.J. Matthews

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.
    
    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.
    
    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*)

structure Window : WINDOW =
struct
local
    type RECT      = { left: int, top: int, right: int, bottom: int }
    type POINT     = { x: int, y: int }
(*
    open CInterface
    open Globals
    *)
    open Base
    (*
    open Resource
    open Class
      *)

    fun checkWindow c = (checkResult(not(Handle.isHNull c)); c)
in
    type HWND = HWND and HINSTANCE = HINSTANCE and RECT = RECT and POINT = POINT
    and HMENU = HMENU

    open WinBase (* Get Style and SetWindowPositionStyle *)

    datatype ShowWindowOptions =
        SW_HIDE
    |   SW_MAXIMIZE
    |   SW_MINIMIZE
    |   SW_RESTORE
    |   SW_SHOW
    |   SW_SHOWDEFAULT
    |   SW_SHOWMAXIMIZED
    |   SW_SHOWMINIMIZED
    |   SW_SHOWMINNOACTIVE
    |   SW_SHOWNA
    |   SW_SHOWNOACTIVATE
    |   SW_SHOWNORMAL

    val SW_NORMAL = SW_SHOWNORMAL
    val SW_MAX = SW_SHOWDEFAULT

    val C_ShowWindow =
      _import "ShowWindow" stdcall
      : C_Pointer.t * int -> int;

    fun ShowWindow (win, opt) = 
    let
        val cmd =
            case opt of
                SW_HIDE             => 0
            |   SW_SHOWNORMAL       => 1
            |   SW_SHOWMINIMIZED    => 2
            |   SW_SHOWMAXIMIZED    => 3
            |   SW_MAXIMIZE         => 3
            |   SW_SHOWNOACTIVATE   => 4
            |   SW_SHOW             => 5
            |   SW_MINIMIZE         => 6
            |   SW_SHOWMINNOACTIVE  => 7
            |   SW_SHOWNA           => 8
            |   SW_RESTORE          => 9
            |   SW_SHOWDEFAULT      => 10
    in
      C_ShowWindow (Handle.ptrOfHandle win, cmd) <> 0
    end

    val C_CloseWindow =
      _import "CloseWindow" stdcall
      : C_Pointer.t -> int;

    fun CloseWindow (hWnd:HWND) =
      if C_CloseWindow (Handle.ptrOfHandle hWnd) = 0 then raise Fail "CloseWindow"
      else ()

    val C_FindWindow_string =
      _import "FindWindowA" stdcall
      : string * string -> C_Pointer.t;

    val C_FindWindow_ptr =
      _import "FindWindowA" stdcall
      : string * C_Pointer.t -> C_Pointer.t;

    fun FindWindow (className, NONE) =
      checkWindow (handleOfPtr (C_FindWindow_ptr (className, C_Pointer.null)))
      | FindWindow (className, SOME windowName) =
      checkWindow (handleOfPtr (C_FindWindow_string (className, windowName)))

    val C_FindWindowEx_str =
      _import "FindWindowExA" stdcall
      : C_Pointer.t * C_Pointer.t * string * string -> C_Pointer.t;

    val C_FindWindowEx_ptr =
      _import "FindWindowExA" stdcall
      : C_Pointer.t * C_Pointer.t * string * C_Pointer.t -> C_Pointer.t;

    fun FindWindowEx (hwndParent, hwndChildAfter, szClass, szWindow) =
    let
      val hwndParent     = Handle.ptrOfHandle (getOpt (hwndParent, Handle.hNull))
      val hwndChildAfter = Handle.ptrOfHandle (getOpt (hwndChildAfter, Handle.hNull))
      val hwnd =
          case szWindow
            of SOME szWindow => C_FindWindowEx_str (hwndParent, hwndChildAfter, szClass, szWindow)
             | NONE          => C_FindWindowEx_ptr (hwndParent, hwndChildAfter, szClass, C_Pointer.null)
    in
      Handle.handleOfPtr hwnd
    end

    val C_GetDesktopWindow =
      _import "GetDesktopWindow" stdcall
      : unit -> C_Pointer.t;

    val C_GetForegroundWindow =
      _import "GetForegroundWindow"
      : unit -> C_Pointer.t;

    val C_GetLastActivePopup =
      _import "GetLastActivePopup"
      : C_Pointer.t -> C_Pointer.t;

    val C_GetParent =
      _import "GetParent"
      : C_Pointer.t -> C_Pointer.t;

    val C_GetTopWindow =
      _import "GetTopWindow"
      : C_Pointer.t -> C_Pointer.t;

    fun GetDesktopWindow () =
      Handle.handleOfPtr (C_GetDesktopWindow ())

    fun GetForegroundWindow () =
      Handle.handleOfPtr (C_GetForegroundWindow())

    fun GetLastActivePopup hWnd =
      Handle.handleOfPtr (C_GetLastActivePopup (Handle.ptrOfHandle hWnd))

    fun GetParent hWnd =
    let
      val h = Handle.handleOfPtr (C_GetParent (Handle.ptrOfHandle hWnd))
    in
      if h = Handle.hNull
      then NONE
      else SOME h
    end

    fun GetTopWindow hwnd =
    let
      val w = case hwnd
                of SOME hWnd => C_GetTopWindow (Handle.ptrOfHandle hWnd)
                 | NONE      => C_GetTopWindow C_Pointer.null
    in
      if C_Pointer.null = w
      then NONE
      else SOME (Handle.handleOfPtr w)
    end

    val C_GetWindowTextLength =
      _import "GetWindowTextLengthA" stdcall
      : C_Pointer.t -> int;

    fun GetWindowTextLength hWnd =
      C_GetWindowTextLength (Handle.ptrOfHandle hWnd)

    val C_SetWindowText =
      _import "SetWindowTextA" stdcall
      : C_Pointer.t * string -> unit;

    fun SetWindowText (hWnd, string) =
      C_SetWindowText (Handle.ptrOfHandle hWnd, string)

    val C_GetWindowText =
      _import "GetWindowTextA" stdcall
      : C_Pointer.t * char array * int -> int;

    fun arrayToString arr =
      case String.scan ArraySlice.getItem (ArraySlice.full arr)
        of SOME(s, rs) => if ArraySlice.length rs = 0
                          then s
                          else raise Fail ("arrayToString: "^s)
           | NONE => raise Fail "arrayToString: scan"

    fun GetWindowText hWnd =
    let
      val baseLen = GetWindowTextLength hWnd
      val buff = Array.array (baseLen+1, #"0")
      val size = C_GetWindowText (Handle.ptrOfHandle hWnd, buff, baseLen+1)
    in
      if size = 0 then ""
      else arrayToString buff
    end

    (* Get the class name of a window.  The only way to do it is to loop until the
       size returned is less than the size of the buffer. *)
    val C_GetClassName =
      _import "GetClassNameA" stdcall
      : C_Pointer.t * char array * int -> int;

    fun GetClassName hWnd =
    let
      fun extBuff len =
      let
        val buff = Array.array (len+1, Char.chr 0)
      in
        if len < C_GetClassName (Handle.ptrOfHandle hWnd, buff, len+1)
        then extBuff (len * 2)
        else arrayToString buff
      end
    in
      extBuff 4
    end

    datatype GetWindowFlags =
        GW_CHILD
    |   GW_HWNDFIRST
    |   GW_HWNDLAST
    |   GW_HWNDNEXT
    |   GW_HWNDPREV
    |   GW_OWNER

      (*
    local
        fun winFlag GW_HWNDFIRST        = 0
        |   winFlag GW_HWNDLAST         = 1
        |   winFlag GW_HWNDNEXT         = 2
        |   winFlag GW_HWNDPREV         = 3
        |   winFlag GW_OWNER            = 4
        |   winFlag GW_CHILD            = 5
    in
        fun GetWindow (win, gwFlag) =
            call2 (user "GetWindow") (HWND,INT) HWNDOPT (win, winFlag gwFlag)
        (* Only GW_HWNDNEXT and GW_HWNDPREV are allowed here but it's probably not
           worth making it a special case. *)
        fun GetNextWindow(win: HWND, gwFlag) =
            checkWindow (
                call2 (user "GetNextWindow") (HWND,INT) HWND (win, winFlag gwFlag))
    end

    val IsChild                = call2 (user "IsChild") (HWND,HWND) BOOL
    val IsIconic               = call1 (user "IsIconic") (HWND) BOOL
    val IsWindow               = call1 (user "IsWindow") (HWND) BOOL
    val IsWindowVisible        = call1 (user "IsWindowVisible") (HWND) BOOL
    val IsZoomed               = call1 (user "IsZoomed") (HWND) BOOL

    fun GetClientRect(hWnd: HWND): RECT =
    let
        val buff = alloc 4 Clong
        val res = call2 (user "GetClientRect") (HWND, POINTER) BOOL (hWnd, address buff)
        val (toRect,_,_) = breakConversion RECT
    in
        checkResult res;
        toRect buff
    end

    fun GetWindowRect(hWnd: HWND): RECT =
    let
        val buff = alloc 4 Clong
        val res = call2 (user "GetWindowRect") (HWND, POINTER) BOOL (hWnd, address buff)
        val (toRect,_,_) = breakConversion RECT
    in
        checkResult res;
        toRect buff
    end

    fun AdjustWindowRect(rect: RECT, style: Style.flags, bMenu: bool): RECT =
    let
        val (toRect,fromRect,_) = breakConversion RECT
        val buff = fromRect rect
        val res = call3 (user "AdjustWindowRect") (POINTER, INT, BOOL) BOOL
                    (address buff, LargeWord.toInt(Style.toWord style), bMenu)
    in
        checkResult res;
        toRect buff
    end

    fun AdjustWindowRectEx(rect: RECT, style: Style.flags, bMenu: bool, exStyle: int): RECT =
    let
        val (toRect,fromRect,_) = breakConversion RECT
        val buff = fromRect rect
        val res = call4 (user "AdjustWindowRectEx") (POINTER, INT, BOOL, INT) BOOL
                    (address buff, LargeWord.toInt(Style.toWord style), bMenu, exStyle)
    in
        checkResult res;
        toRect buff
    end

    val ArrangeIconicWindows = call1 (user "ArrangeIconicWindows") (HWND) INT (* POSINT? *)
    val BringWindowToTop =
        call1 (user "BringWindowToTop") (HWND) (SUCCESSSTATE "BringWindowToTop")
    val OpenIcon = call1 (user "OpenIcon") (HWND) (SUCCESSSTATE "OpenIcon")
    val SetForegroundWindow = call1 (user "SetForegroundWindow") (HWND) BOOL

    fun SetParent(child: HWND, new: HWND option): HWND =
    let
        val old = call2 (user "SetParent") (HWND, HWND) HWND (child, getOpt(new, hwndNull))
    in
        checkResult(not(isHNull old));
        old
    end

    fun CreateWindowEx{class: 'a Class.ATOM, (* Window class *)
                     name: string, (* Window name *)
                     style: Style.flags, (* window style *)
                     exStyle: ExStyle.flags, (* extended style *)
                     x: int, (* horizontal position of window *)
                     y: int, (* vertical position of window *)
                     width: int, (* window width *)
                     height: int, (* window height *)
                     relation: ParentType, (* parent or owner window *)
                     instance: HINSTANCE, (* application instance *)
                     init: 'a}: HWND =
    let
        (* Set up a callback for ML classes and return the class name. *)
        val className: string =
            case class of
                Registered { proc, className} =>
                    (Message.setCallback(proc, init);  className)
            |   SystemClass s => s

        val (parent, menu, styleWord) = WinBase.unpackWindowRelation(relation, style)

        (* Create a window. *)
        val res =
            call12 (user "CreateWindowExA") (WORD, STRING, STRING, WORD, INT, INT, INT, INT,
                    HWND, INT, HINSTANCE, INT) HWND
                (ExStyle.toWord exStyle, className, name, styleWord, x, y, width, height, parent, menu,
                 instance, 0)
    in
        checkResult(not(isHNull res));
        res
    end

    fun CreateWindow{class: 'a Class.ATOM, name: string, style: Style.flags, x: int,
                     y: int, width: int, height: int, relation: ParentType, instance: HINSTANCE,
                     init: 'a}: HWND =
        CreateWindowEx{exStyle=ExStyle.flags[], class=class, name=name, style=style, x=x,
                       y=y, width=width, height=height,relation=relation, instance=instance,
                       init=init}
                       
    fun CreateMDIClient{
            relation: ParentType, (* This should always be ChildWindow *)
            style: Style.flags,
            instance: HINSTANCE,  (* application instance *)
            windowMenu: HMENU,    (* Window menu to which children are added. *)
            idFirstChild: int     (* Id of first child when it's created. *)
            }: HWND =
    let
        val (parent, menu, styleWord) =
            case relation of
                PopupWithClassMenu =>
                    (hwndNull, hmenuNull, Style.toWord(Style.clear(Style.WS_CHILD, style)))
            |   PopupWindow hm =>
                    (hwndNull, hm, Style.toWord(Style.clear(Style.WS_CHILD, style)))
            |   ChildWindow{parent, id} =>
                    (parent, handleOfInt id, Style.toWord(Style.flags[Style.WS_CHILD, style]))
        val CLIENTCREATESTRUCT = STRUCT2(HMENU, UINT)
        val (_, toCcreateStruct, _) = breakConversion CLIENTCREATESTRUCT
        val createS = address(toCcreateStruct(windowMenu, idFirstChild))
        val res =
            call12 (user "CreateWindowExA") (WORD, STRING, WORD, WORD, INT, INT, INT, INT,
                    HWND, HMENU, HINSTANCE, POINTER) HWND
                (0w0, "MDICLIENT", 0w0, styleWord, 0, 0, 0, 0, parent, menu,
                 instance, createS)
    in
        checkResult(not(isHNull res));
        res
    end

 
    fun DefWindowProc (hWnd: HWND, msg: Message.Message): Message.LRESULT  =
    let
        val (wMsg, wParam: vol, lParam: vol) = Message.compileMessage msg
        val res =
            call4 (user "DefWindowProcA") (HWND, INT, POINTER, POINTER) POINTER
                (hWnd, wMsg, wParam, lParam)
    in
        Message.messageReturnFromParams(msg, wParam, lParam, res)
    end
   
    fun DefFrameProc (hWnd: HWND, hWndMDIClient: HWND, msg: Message.Message): Message.LRESULT  =
    let
        val (wMsg, wParam: vol, lParam: vol) = Message.compileMessage msg
        val res =
            call5 (user "DefFrameProcA") (HWND, HWND, INT, POINTER, POINTER) POINTER
                (hWnd, hWndMDIClient, wMsg, wParam, lParam)
    in
        (* Write back any changes the function has made. *)
        Message.messageReturnFromParams(msg, wParam, lParam, res)
    end

    fun DefMDIChildProc (hWnd: HWND, msg: Message.Message): Message.LRESULT =
    let
        val (wMsg, wParam: vol, lParam: vol) = Message.compileMessage msg
        val res =
            call4 (user "DefMDIChildProcA") (HWND, INT, POINTER, POINTER) POINTER
                (hWnd, wMsg, wParam, lParam)
    in
        Message.messageReturnFromParams(msg, wParam, lParam, res)
    end
    

    val CW_USEDEFAULT = ~0x80000000 (* Default value for size and/ot position. *)

    fun DestroyWindow(hWnd: HWND) =
    (
        call1 (user "DestroyWindow") (HWND) (SUCCESSSTATE "DestroyWindow") hWnd;
        Message.removeCallback hWnd
    )

    *)
    (*val GWL_WNDPROC         = ~4*)
    val GWL_HINSTANCE       = ~6
    val GWL_HWNDPARENT      = ~8
    val GWL_STYLE           = ~16
    val GWL_EXSTYLE         = ~20
    val GWL_USERDATA        = ~21
    val GWL_ID              = ~12

    (*
    val GetWindowLong = call2 (user "GetWindowLongA") (HWND, INT) INT

    (* SetWindowLong is a dangerous function to export. *)
    val SetWindowLong = call3 (user "SetWindowLongA") (HWND, INT, INT) INT

    (* ML extension.  This replaces the GetWindowLong and SetWindowLong calls. *)
    val SubclassWindow = Message.subclass

    fun MoveWindow{hWnd: HWND, x: int, y: int, height: int, width: int, repaint: bool} =
        call6(user "MoveWindow") (HWND,INT,INT,INT,INT,BOOL) (SUCCESSSTATE "MoveWindow")
            (hWnd, x, y, width, height, repaint)

    val SetWindowPos = call7 (user "SetWindowPos")
        (HWND, HWND, INT, INT, INT, INT, WINDOWPOSITIONSTYLE)
            (SUCCESSSTATE "SetWindowPos")

    val SetWindowContextHelpId =
            call2 (user "SetWindowContextHelpId") (HWND, INT)
                (SUCCESSSTATE "SetWindowContextHelpId")

    val GetWindowContextHelpId = call1 (user "GetWindowContextHelpId") (HWND) INT

    local
        (* The C interface currently passes structures by reference.  That's
           certainly wrong for Microsoft C and I suspect it's also wrong on
           Unix.  I'm reluctant to change it without knowing more.  DCJM. *)
        val childWindowFromPoint =
            call3 (user "ChildWindowFromPoint") (HWND, INT, INT) HWNDOPT
        and windowFromPoint =
            call2 (user "WindowFromPoint") (INT, INT) HWNDOPT
    in
        fun ChildWindowFromPoint(hw, {x, y}:POINT) = childWindowFromPoint(hw, x, y)
        and WindowFromPoint({x, y}:POINT) = windowFromPoint(x, y)
    end
    *)
end
end;

