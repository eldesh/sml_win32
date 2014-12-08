
structure WinMain :> WIN_MAIN =
struct
  open Window

  structure StartupInfoFlag =
  struct
    datatype t = STARTF_FORCEONFEEDBACK
               | STARTF_FORCEOFFFEEDBACK
               | STARTF_PREVENTPINNING
               | STARTF_RUNFULLSCREEN
               | STARTF_TITLEISAPPID
               | STARTF_TITLEISLINKNAME
               | STARTF_USECOUNTCHARS
               | STARTF_USEFILLATTRIBUTE
               | STARTF_USEHOTKEY
               | STARTF_USEPOSITION
               | STARTF_USESHOWWINDOW
               | STARTF_USESIZE
               | STARTF_USESTDHANDLES

    fun toWord t : SysWord.word =
      case t
        of STARTF_FORCEONFEEDBACK  => 0wx00000040 
         | STARTF_FORCEOFFFEEDBACK => 0wx00000080 
         | STARTF_PREVENTPINNING   => 0wx00002000 
         | STARTF_RUNFULLSCREEN    => 0wx00000020 
         | STARTF_TITLEISAPPID     => 0wx00001000 
         | STARTF_TITLEISLINKNAME  => 0wx00000800 
         | STARTF_USECOUNTCHARS    => 0wx00000008 
         | STARTF_USEFILLATTRIBUTE => 0wx00000010 
         | STARTF_USEHOTKEY        => 0wx00000200 
         | STARTF_USEPOSITION      => 0wx00000004 
         | STARTF_USESHOWWINDOW    => 0wx00000001 
         | STARTF_USESIZE          => 0wx00000002 
         | STARTF_USESTDHANDLES    => 0wx00000100 

    fun fromWord (w:SysWord.word) =
      case w
        of 0wx00000040 => SOME STARTF_FORCEONFEEDBACK  
         | 0wx00000080 => SOME STARTF_FORCEOFFFEEDBACK 
         | 0wx00002000 => SOME STARTF_PREVENTPINNING   
         | 0wx00000020 => SOME STARTF_RUNFULLSCREEN    
         | 0wx00001000 => SOME STARTF_TITLEISAPPID     
         | 0wx00000800 => SOME STARTF_TITLEISLINKNAME  
         | 0wx00000008 => SOME STARTF_USECOUNTCHARS    
         | 0wx00000010 => SOME STARTF_USEFILLATTRIBUTE 
         | 0wx00000200 => SOME STARTF_USEHOTKEY        
         | 0wx00000004 => SOME STARTF_USEPOSITION      
         | 0wx00000001 => SOME STARTF_USESHOWWINDOW    
         | 0wx00000002 => SOME STARTF_USESIZE          
         | 0wx00000100 => SOME STARTF_USESTDHANDLES    
         | _           => NONE
  end

  fun main (name, args) WinMain =
  let
    val hInstance     : Window.HINSTANCE = Libloader.GetModuleHandle NONE
    val hPrevInstance : Window.HINSTANCE = C.Ptr.null'
    val si = C.new S__STARTUPINFO.typ
    val () = F_GetStartupInfoA.f (C.Ptr.|&| (C.rw si))
    val dwFlags = SysWord.fromLarge
                    (MLRep.Long.Unsigned.toLarge
                          (C.Get.ulong (S__STARTUPINFO.f_dwFlags si)))
    val wShowWindow = SysWord.fromLarge
                        (MLRep.Short.Unsigned.toLarge
                            (C.Get.ushort (S__STARTUPINFO.f_wShowWindow si)))
    (* dwFlags = 0?
    val nCmdShow = if valOf (StartupInfoFlag.fromWord dwFlags) = StartupInfoFlag.STARTF_USESHOWWINDOW
                   then valOf (ShowWindowOptions.fromWord wShowWindow)
                   else ShowWindowOptions.SW_SHOWDEFAULT
    *)
    val nCmdShow = ShowWindowOptions.SW_SHOWDEFAULT
  in
    if WinMain ( hInstance
               , hPrevInstance
               , name::args
               , nCmdShow
               ) = 0
    then OS.Process.success
    else OS.Process.failure
  end
end


