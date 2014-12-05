
structure WinBase =
struct
local
  open Base
in
    structure Style :>
    sig
        include BIT_FLAGS
        type t = flags
        val WS_BORDER : t
        val WS_CAPTION : t
        val WS_CHILD : t
        val WS_CHILDWINDOW : t
        val WS_CLIPCHILDREN : t
        val WS_CLIPSIBLINGS : t
        val WS_DISABLED : t
        val WS_DLGFRAME : t
        val WS_GROUP : t
        val WS_HSCROLL : t
        val WS_ICONIC : t
        val WS_MAXIMIZE : t
        val WS_MAXIMIZEBOX : t
        val WS_MINIMIZE : t
        val WS_MINIMIZEBOX : t
        val WS_OVERLAPPED : t
        val WS_OVERLAPPEDWINDOW : t
        val WS_POPUP : t
        val WS_POPUPWINDOW : t
        val WS_SIZEBOX : t
        val WS_SYSMENU : t
        val WS_TABSTOP : t
        val WS_THICKFRAME : t
        val WS_TILED : t
        val WS_TILEDWINDOW : t
        val WS_VISIBLE : t
        val WS_VSCROLL : t
    end =
    struct
        type flags = SysWord.word
        type t =flags

        fun toWord f = f
        fun fromWord f = f
        val flags = List.foldl SysWord.orb 0w0
        fun allSet (fl1, fl2) = SysWord.andb(fl1, fl2) = fl1
        fun anySet (fl1, fl2) = SysWord.andb(fl1, fl2) <> 0w0
        fun clear (fl1, fl2) = SysWord.andb(SysWord.notb fl1, fl2)

        (* Window styles. *)
        val WS_OVERLAPPED: flags                         = 0wx00000000
        val WS_POPUP: flags                              = 0wx80000000
        val WS_CHILD: flags                              = 0wx40000000
        val WS_MINIMIZE: flags                           = 0wx20000000
        val WS_VISIBLE: flags                            = 0wx10000000
        val WS_DISABLED: flags                           = 0wx08000000
        val WS_CLIPSIBLINGS: flags                       = 0wx04000000
        val WS_CLIPCHILDREN: flags                       = 0wx02000000
        val WS_MAXIMIZE: flags                           = 0wx01000000
        val WS_CAPTION: flags                            = 0wx00C00000 (* WS_BORDER | WS_DLGFRAME *)
        val WS_BORDER: flags                             = 0wx00800000
        val WS_DLGFRAME: flags                           = 0wx00400000
        val WS_VSCROLL: flags                            = 0wx00200000
        val WS_HSCROLL: flags                            = 0wx00100000
        val WS_SYSMENU: flags                            = 0wx00080000
        val WS_THICKFRAME: flags                         = 0wx00040000
        val WS_GROUP: flags                              = 0wx00020000
        val WS_TABSTOP: flags                            = 0wx00010000
        val WS_MINIMIZEBOX: flags                        = 0wx00020000
        val WS_MAXIMIZEBOX: flags                        = 0wx00010000
        val WS_TILED: flags                              = WS_OVERLAPPED
        val WS_ICONIC: flags                             = WS_MINIMIZE
        val WS_SIZEBOX: flags                            = WS_THICKFRAME
        val WS_OVERLAPPEDWINDOW =
                flags[WS_OVERLAPPED, WS_CAPTION, WS_SYSMENU,
                      WS_THICKFRAME, WS_MINIMIZEBOX, WS_MAXIMIZEBOX]
        val WS_TILEDWINDOW                               = WS_OVERLAPPEDWINDOW
        val WS_POPUPWINDOW =
                flags[WS_POPUP, WS_BORDER, WS_SYSMENU]
        val WS_CHILDWINDOW                               = WS_CHILD

        val all = flags[WS_OVERLAPPED, WS_POPUP, WS_CHILD, WS_MINIMIZE, WS_VISIBLE,
                        WS_DISABLED, WS_CLIPSIBLINGS, WS_CLIPCHILDREN, WS_MAXIMIZE,
                        WS_CAPTION, WS_BORDER, WS_DLGFRAME, WS_VSCROLL, WS_HSCROLL,
                        WS_SYSMENU, WS_THICKFRAME, WS_GROUP, WS_TABSTOP, WS_MINIMIZEBOX,
                        WS_MAXIMIZEBOX]

        val intersect = List.foldl SysWord.andb all
    end

    structure ExStyle:>
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
    end =
    struct
        type flags = SysWord.word
        type t = flags
        fun toWord f = f
        fun fromWord f = f
        val flags = List.foldl SysWord.orb 0w0
        fun allSet (fl1, fl2) = SysWord.andb(fl1, fl2) = fl1
        fun anySet (fl1, fl2) = SysWord.andb(fl1, fl2) <> 0w0
        fun clear (fl1, fl2) = SysWord.andb(SysWord.notb fl1, fl2)
        val WS_EX_DLGMODALFRAME       : t = 0wx00000001
        val WS_EX_NOPARENTNOTIFY      : t = 0wx00000004
        val WS_EX_TOPMOST             : t = 0wx00000008
        val WS_EX_ACCEPTFILES         : t = 0wx00000010
        val WS_EX_TRANSPARENT         : t = 0wx00000020
        val WS_EX_MDICHILD            : t = 0wx00000040
        val WS_EX_TOOLWINDOW          : t = 0wx00000080
        val WS_EX_WINDOWEDGE          : t = 0wx00000100
        val WS_EX_CLIENTEDGE          : t = 0wx00000200
        val WS_EX_CONTEXTHELP         : t = 0wx00000400

        val WS_EX_RIGHT               : t = 0wx00001000
        val WS_EX_LEFT                : t = 0wx00000000
        val WS_EX_RTLREADING          : t = 0wx00002000
        val WS_EX_LTRREADING          : t = 0wx00000000
        val WS_EX_LEFTSCROLLBAR       : t = 0wx00004000
        val WS_EX_RIGHTSCROLLBAR      : t = 0wx00000000
    
        val WS_EX_CONTROLPARENT       : t = 0wx00010000
        val WS_EX_STATICEDGE          : t = 0wx00020000
        val WS_EX_APPWINDOW           : t = 0wx00040000

        val WS_EX_LAYERED             : t = 0wx00080000
        val WS_EX_NOINHERITLAYOUT     : t = 0wx00100000
        val WS_EX_NOREDIRECTIONBITMAP : t = 0wx00200000
        val WS_EX_LAYOUTRTL           : t = 0wx00400000
        val WS_EX_COMPOSITED          : t = 0wx02000000
        val WS_EX_NOACTIVATE          : t = 0wx08000000

        val WS_EX_OVERLAPPEDWINDOW = flags[WS_EX_WINDOWEDGE, WS_EX_CLIENTEDGE]
        val WS_EX_PALETTEWINDOW = flags[WS_EX_WINDOWEDGE, WS_EX_TOOLWINDOW, WS_EX_TOPMOST]

        val all = flags[WS_EX_DLGMODALFRAME, WS_EX_NOPARENTNOTIFY, WS_EX_TOPMOST, WS_EX_ACCEPTFILES,
                        WS_EX_TRANSPARENT, WS_EX_MDICHILD, WS_EX_TOOLWINDOW, WS_EX_WINDOWEDGE,
                        WS_EX_CLIENTEDGE, WS_EX_CONTEXTHELP, WS_EX_RIGHT, WS_EX_LEFT, WS_EX_RTLREADING,
                        WS_EX_LTRREADING, WS_EX_LEFTSCROLLBAR, WS_EX_RIGHTSCROLLBAR, WS_EX_CONTROLPARENT,
                        WS_EX_STATICEDGE, WS_EX_APPWINDOW, WS_EX_LAYERED, WS_EX_NOINHERITLAYOUT,
                        WS_EX_NOREDIRECTIONBITMAP, WS_EX_LAYOUTRTL, WS_EX_COMPOSITED, WS_EX_NOACTIVATE]

        val intersect = List.foldl SysWord.andb all
    end

  (* In C the parent and menu arguments are combined in a rather odd way. *)
  structure ParentType =
  struct
    datatype t = PopupWithClassMenu      (* Popup or overlapped window using class menu. *)
               | PopupWindow of HMENU    (* Popup or overlapped window with supplied menu. *)
               | ChildWindow of { parent: HWND, id: int } (* Child window. *)
  end

  exception NotImplemented of string

  (* This function is used whenever windows are created. *)
  local
    open Style ParentType
  in
    (* In the case of a child window the "menu" is actually an integer
       which identifies the child in notification messages to the parent.
       We silently set or clear the WS_CHILD bit depending on the argument. *)
    fun unpackWindowRelation(relation: ParentType.t, style) =
      case relation of
          PopupWithClassMenu =>
              (Handle.null, 0, toWord(clear(WS_CHILD, style)))
      |   PopupWindow hm =>
              (Handle.null, raise NotImplemented "unpackWindowRelation", toWord(clear(WS_CHILD, style)))
      |   ChildWindow{parent, id} =>
              (parent, id, toWord(flags[WS_CHILD, style]))
  end
end (* local *)
end

