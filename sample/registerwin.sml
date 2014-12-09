
structure RegisterWin =
struct
local
  open Base Window
  structure M = MessageBox
in
  local
    open Class
  in
  fun mkWindowClass (hInstance:HINSTANCE) : WndClass.t =
    WndClass.WNDCLASS
      { style = Style.CS_HREDRAW
      , wndProc = (fn (hwnd:HWND,msg,wp,lp) =>
                       F_DefWindowProcA.f (C.Ptr.inject' hwnd, msg, wp, lp))
      , cbClsExtra = 0
      , cbWndExtra = 0
      , hInstance = hInstance
      , hIcon = NONE : HICON option
      , hCursor = NONE : HCURSOR option
      , hbrBackGround = NONE : HBRUSH option
      , menuName = NONE : string option
      , className = "Class Name"
      }
  end

  fun WinMain (hInstance,hPrevInstance,argv,nCmdShow) =
  let
    val hInstance = Libloader.GetModuleHandle NONE
    val () = checkResult(not(isNull hInstance))
    val winc = mkWindowClass hInstance
    val class = Class.RegisterClass winc
    val win =
      CreateWindowEx
        {
            class = class, (* Class.Atom.Static, *)
            name = "caption",
            style = Style.WS_CAPTION,
            exStyle = ExStyle.flags[ExStyle.WS_EX_TOOLWINDOW],
            x = 100:Int32.int,
            y = 100:Int32.int,
            width = 200:Int32.int,
            height = 200:Int32.int,
            relation = ParentType.PopupWithClassMenu,
            instance = hInstance,
            (* SML/NJ *)
            init = C.Ptr.vNull
            (* MLton
            (* init = C.Ptr.vnull *)
            *)
        }
  in
    ShowWindow (win, ShowWindowOptions.SW_SHOW);
    M.MessageBox(NONE
                , "window test"
                , "CreateWindow!"
                , M.MessageBoxStyle.MB_ICONINFORMATION);
    0
  end

  fun main (name, args) =
    WinMain.main (name, args) WinMain
end
end

