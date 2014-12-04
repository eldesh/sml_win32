
structure WinMain =
struct
  structure ZS = ZString
  val ` = ZS.dupML'

  val WS_CAPTION : Word32.word = 0wx00C00000
  val SW_SHOW = 5

  fun WinMain (hInstance,hPrevInstance,argv,nCmdShow) =
  let
    val hwnd = F_CreateWindowExA.f'
                ( 0w0
                , `"STATIC"
                , `"Create-Window-ExA"
                , WS_CAPTION
                , 100, 100, 200, 200
                , C.Ptr.null'
                , C.Ptr.inject' C.Ptr.null'
                , hInstance
                , C.Ptr.inject' C.Ptr.null'
                )
    val _ = F_ShowWindow.f' (hwnd, MLRep.Int.Signed.fromLarge (Int.toLarge SW_SHOW))
  in
    if F_MessageBoxA.f' (C.Ptr.null'
                        , `"WinMain test..."
                        , `"Sample Program"
                        , 0wx00000040) = 1
    then OS.Process.success
    else OS.Process.failure
  end

  fun main (_:string, _:string list) =
  let
    val hInstance     = F_GetModuleHandleA.f' C.Ptr.null'
    val hPrevInstance = C.Ptr.inject' C.Ptr.null'
    val si = C.new S__STARTUPINFO.typ
    val () = F_GetStartupInfoA.f (C.Ptr.|&| (C.rw si))
    val dwFlags = C.Get.ulong (S__STARTUPINFO.f_dwFlags si)
    val wShowWindow = C.Get.ushort (S__STARTUPINFO.f_wShowWindow si)
  in
    WinMain ( hInstance
            , hPrevInstance
            , ["WinMain"]
            , if Word32.andb (dwFlags, 0w1) = 0w0
              then wShowWindow
              else 0wx10
            )
  end
end

