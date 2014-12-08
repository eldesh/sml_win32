
signature WINDOW =
sig
    type HWND and HINSTANCE and HMENU
    type POINT = { x: int, y: int }
    type RECT =  { left: int, top: int, right: int, bottom: int }

    structure Style:
    sig
        include BIT_FLAGS
        type t = flags
        val WS_OVERLAPPED: flags and WS_POPUP: flags and WS_CHILD: flags and WS_MINIMIZE: flags
        and WS_VISIBLE: flags and WS_DISABLED:flags and WS_CLIPSIBLINGS:flags
        and WS_CLIPCHILDREN:flags and WS_MAXIMIZE:flags and WS_CAPTION:flags
        and WS_BORDER:flags and WS_DLGFRAME:flags and WS_VSCROLL:flags and WS_HSCROLL:flags
        and WS_SYSMENU:flags and WS_THICKFRAME:flags and WS_GROUP:flags and WS_TABSTOP:flags
        and WS_MINIMIZEBOX:flags and WS_MAXIMIZEBOX:flags and WS_TILED:flags and WS_ICONIC:flags
        and WS_SIZEBOX:flags and WS_OVERLAPPEDWINDOW:flags and WS_TILEDWINDOW:flags
        and WS_POPUPWINDOW:flags and WS_CHILDWINDOW:flags
    end
    
    structure ExStyle :
    sig
        include BIT_FLAGS
        type t = flags
        val WS_EX_DLGMODALFRAME: flags and WS_EX_NOPARENTNOTIFY: flags and WS_EX_TOPMOST: flags
        and WS_EX_ACCEPTFILES : flags and WS_EX_TRANSPARENT: flags and WS_EX_MDICHILD: flags
        and WS_EX_TOOLWINDOW: flags and WS_EX_WINDOWEDGE: flags and WS_EX_CLIENTEDGE: flags
        and WS_EX_CONTEXTHELP: flags and WS_EX_RIGHT: flags and WS_EX_LEFT: flags
        and WS_EX_RTLREADING: flags and WS_EX_LTRREADING: flags and WS_EX_LEFTSCROLLBAR: flags
        and WS_EX_RIGHTSCROLLBAR: flags and WS_EX_CONTROLPARENT: flags and WS_EX_STATICEDGE: flags
        and WS_EX_APPWINDOW: flags and WS_EX_OVERLAPPEDWINDOW: flags and WS_EX_PALETTEWINDOW: flags
        and WS_EX_LAYERED: flags and WS_EX_NOINHERITLAYOUT: flags and WS_EX_NOREDIRECTIONBITMAP: flags
        and WS_EX_LAYOUTRTL: flags and WS_EX_COMPOSITED: flags and WS_EX_NOACTIVATE: flags
    end

    structure ShowWindowOptions :
    sig
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

      val SW_MAXIMIZE : t
      val toWord : t -> SysWord.word
      val fromWord : SysWord.word -> t option
    end

    val SW_NORMAL: ShowWindowOptions.t
    val SW_MAX: ShowWindowOptions.t

    structure ParentType :
    sig
      datatype t = PopupWithClassMenu
                 | PopupWindow of HMENU
                 | ChildWindow of { parent: HWND, id: MLRep.Long.Unsigned.word }
    end

    (*
    val CreateWindow :
       {x: int, y: int, init: 'a, name: string, class: 'a Class.ATOM,
         style: Style.flags, width: int, height: int,
         instance: HINSTANCE, relation: ParentType} -> HWND
         *)
    val CreateWindowEx :
       {x: Int32.int, y: Int32.int, init: C.voidptr, name: string, class: Class.Atom.t,
         style: Style.t, width: Int32.int, height: Int32.int,
         instance: HINSTANCE, relation: ParentType.t, exStyle: ExStyle.t} -> HWND

    structure Visible :
    sig
      datatype t = Visible
                 | NonVisible
    end

    val ShowWindow : HWND * ShowWindowOptions.t -> Visible.t

end

