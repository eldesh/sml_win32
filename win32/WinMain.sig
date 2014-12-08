
signature WIN_MAIN =
sig
  structure StartupInfoFlag :
  sig
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

    val toWord : t -> SysWord.word
    val fromWord : SysWord.word -> t option
  end

  val main : (string * string list)
             -> (Window.HINSTANCE
               * Window.HINSTANCE
               * string list
               * Window.ShowWindowOptions.t -> int) 
             -> OS.Process.status
end


