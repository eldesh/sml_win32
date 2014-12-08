
structure CreateWin =
struct
local
  open Base Window
  structure M = MessageBox
in
  fun WinMain (hInstance,hPrevInstance,argv,nCmdShow) =
  let
    val hInstance = Libloader.GetModuleHandle NONE
    val () = checkResult(not(isNull hInstance))
    val win =
      CreateWindowEx
        {
            class = Class.Atom.Static,
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

end (* local *)
end

