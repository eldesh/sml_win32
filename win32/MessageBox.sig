
signature MESSAGE_BOX =
sig
  type HWND

  structure MessageBoxStyle :
  sig
    include BIT_FLAGS
    type t = flags
    val MB_ABORTRETRYIGNORE : t
    val MB_APPLMODAL : t
    val MB_CANCELTRYCONTINUE : t
    val MB_DEFAULT_DESKTOP_ONLY : t
    val MB_DEFBUTTON1 : t
    val MB_DEFBUTTON2 : t
    val MB_DEFBUTTON3 : t
    val MB_DEFBUTTON4 : t
    val MB_HELP : t
    val MB_ICONASTERISK : t
    val MB_ICONERROR : t
    val MB_ICONEXCLAMATION : t
    val MB_ICONHAND : t
    val MB_ICONINFORMATION : t
    val MB_ICONQUESTION : t
    val MB_ICONSTOP : t
    val MB_ICONWARNING : t
    val MB_NOFOCUS : t
    val MB_OK : t
    val MB_OKCANCEL : t
    val MB_RETRYCANCEL : t
    val MB_RIGHT : t
    val MB_RTLREADING : t
    val MB_SERVICE_NOTIFICATION : t
    val MB_SERVICE_NOTIFICATION_NT3X : t
    val MB_SETFOREGROUND : t
    val MB_SYSTEMMODAL : t
    val MB_TASKMODAL : t
    val MB_TOPMOST : t
    val MB_USERICON : t
    val MB_YESNO : t
    val MB_YESNOCANCEL : t

    val MB_TYPEMASK : t
    val MB_ICONMASK : t
    val MB_DEFMASK  : t
    val MB_MODEMASK : t
    val MB_MISCMASK : t
  end

  (**
   * for MessageBeep
   *)
  val BEEP_SIMPLE : MessageBoxStyle.t

  structure Result :
  sig
    datatype t = IDOK
               | IDCANCEL
               | IDABORT
               | IDRETRY
               | IDIGNORE
               | IDYES
               | IDNO
               | IDCLOSE
               | IDHELP

    val toInt : t -> int
    val fromInt : int -> t option
  end

  val MessageBox : HWND option * string * string * MessageBoxStyle.t -> Result.t
  val MessageBeep: MessageBoxStyle.t -> bool
end

