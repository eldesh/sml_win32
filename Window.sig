
signature WINDOW =
sig
    type HWND and HINSTANCE and HMENU
    type POINT = { x: int, y: int }
    type RECT =  { left: int, top: int, right: int, bottom: int }

    structure Style:
    sig
        include BIT_FLAGS
        val WS_OVERLAPPED: flags and WS_POPUP: flags and WS_CHILD: flags and WS_MINIMIZE: flags
        and WS_VISIBLE: flags and WS_DISABLED:flags and WS_CLIPSIBLINGS:flags
        and WS_CLIPCHILDREN:flags and WS_MAXIMIZE:flags and WS_CAPTION:flags
        and WS_BORDER:flags and WS_DLGFRAME:flags and WS_VSCROLL:flags and WS_HSCROLL:flags
        and WS_SYSMENU:flags and WS_THICKFRAME:flags and WS_GROUP:flags and WS_TABSTOP:flags
        and WS_MINIMIZEBOX:flags and WS_MAXIMIZEBOX:flags and WS_TILED:flags and WS_ICONIC:flags
        and WS_SIZEBOX:flags and WS_OVERLAPPEDWINDOW:flags and WS_TILEDWINDOW:flags
        and WS_POPUPWINDOW:flags and WS_CHILDWINDOW:flags
    end
    
    structure ExStyle:
    sig
        include BIT_FLAGS
        val WS_EX_DLGMODALFRAME: flags and WS_EX_NOPARENTNOTIFY: flags and WS_EX_TOPMOST: flags
        and WS_EX_ACCEPTFILES : flags and WS_EX_TRANSPARENT: flags and WS_EX_MDICHILD: flags
        and WS_EX_TOOLWINDOW: flags and WS_EX_WINDOWEDGE: flags and WS_EX_CLIENTEDGE: flags
        and WS_EX_CONTEXTHELP: flags and WS_EX_RIGHT: flags and WS_EX_LEFT: flags
        and WS_EX_RTLREADING: flags and WS_EX_LTRREADING: flags and WS_EX_LEFTSCROLLBAR: flags
        and WS_EX_RIGHTSCROLLBAR: flags and WS_EX_CONTROLPARENT: flags and WS_EX_STATICEDGE: flags
        and WS_EX_APPWINDOW: flags and WS_EX_OVERLAPPEDWINDOW: flags and WS_EX_PALETTEWINDOW: flags
    end

    datatype WindowPositionStyle =
            SWP_ASYNCWINDOWPOS
        |   SWP_DEFERERASE
        |   SWP_FRAMECHANGED
        |   SWP_HIDEWINDOW
        |   SWP_NOACTIVATE
        |   SWP_NOCOPYBITS
        |   SWP_NOMOVE
        |   SWP_NOOWNERZORDER
        |   SWP_NOREDRAW
        |   SWP_NOSENDCHANGING
        |   SWP_NOSIZE
        |   SWP_NOZORDER
        |   SWP_SHOWWINDOW
        |   SWP_OTHER of int

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

    val SW_NORMAL: ShowWindowOptions
    val SW_MAX: ShowWindowOptions

    val ShowWindow: HWND * ShowWindowOptions -> bool

    datatype GetWindowFlags =
        GW_CHILD
    |   GW_HWNDFIRST
    |   GW_HWNDLAST
    |   GW_HWNDNEXT
    |   GW_HWNDPREV
    |   GW_OWNER

    datatype ParentType =
          ChildWindow of {id: int, parent: HWND}
        | PopupWindow of HMENU
        | PopupWithClassMenu

    val GWL_EXSTYLE : int
    val GWL_HINSTANCE : int
    val GWL_HWNDPARENT : int
    val GWL_ID : int
    val GWL_STYLE : int
    val GWL_USERDATA : int

(*
    val AdjustWindowRect : RECT * Style.flags * bool -> RECT
    val AdjustWindowRectEx :  RECT * Style.flags * bool * int -> RECT
    val ArrangeIconicWindows : HWND -> int
    val BringWindowToTop : HWND -> unit
    val CW_USEDEFAULT : int
    val ChildWindowFromPoint : HWND * POINT -> HWND option
	*)
    val CloseWindow : HWND -> unit
	(*
    val CreateWindow :
       {x: int, y: int, init: 'a, name: string, class: 'a Class.ATOM,
         style: Style.flags, width: int, height: int,
         instance: HINSTANCE, relation: ParentType} -> HWND
    val CreateWindowEx :
       {x: int, y: int, init: 'a, name: string, class: 'a Class.ATOM,
         style: Style.flags, width: int, height: int,
         instance: HINSTANCE, relation: ParentType, exStyle: ExStyle.flags} -> HWND
    val CreateMDIClient: {
            relation: ParentType, style: Style.flags, instance: HINSTANCE, windowMenu: HMENU,
            idFirstChild: int} -> HWND
    val DefWindowProc: HWND * Message.Message -> Message.LRESULT
    val DefFrameProc: HWND * HWND * Message.Message -> Message.LRESULT
    val DefMDIChildProc: HWND * Message.Message -> Message.LRESULT
    val DestroyWindow: HWND -> unit
	*)
    val FindWindow: string * string option -> HWND
    val FindWindowEx: HWND option * HWND option * string * string option -> HWND
    val GetClassName : HWND -> string
    val GetClientRect : HWND -> RECT
    val GetDesktopWindow : unit -> HWND
    val GetForegroundWindow : unit -> HWND
    val GetLastActivePopup : HWND -> HWND
    val GetNextWindow : HWND * GetWindowFlags -> HWND
    val GetParent : HWND -> HWND option
    val GetTopWindow : HWND option -> HWND option
    val GetWindow : HWND * GetWindowFlags -> HWND option
	(*
    val GetWindowContextHelpId : HWND -> int
    val GetWindowLong : HWND * int -> int
	*)
    val GetWindowRect : HWND -> RECT
    val GetWindowText : HWND -> string
    val GetWindowTextLength : HWND -> int
    val IsChild : HWND * HWND -> bool
    val IsIconic : HWND -> bool
    val IsWindow : HWND -> bool
    val IsWindowVisible : HWND -> bool
    val IsZoomed : HWND -> bool
	(*
    val MoveWindow : {x: int, y: int, hWnd: HWND, width: int, height: int, repaint: bool} -> unit
    val OpenIcon : HWND -> unit
    val SetForegroundWindow : HWND -> bool
    val SetParent : HWND * HWND option -> HWND
    val SetWindowContextHelpId : HWND * int -> unit
    val SetWindowLong : HWND * int * int -> int
    val SetWindowPos : HWND * HWND * int * int * int * int * WindowPositionStyle list -> unit
	*)
    val SetWindowText : HWND * string -> unit
	(*
    val SubclassWindow :
       HWND *
       (HWND * Message.Message * 'a -> Message.LRESULT * 'a) * 'a ->
           (HWND  * Message.Message) -> Message.LRESULT
    val WindowFromPoint : POINT -> HWND option
	*)
end

