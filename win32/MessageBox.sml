
structure MessageBox : MESSAGE_BOX =
struct
local
in
  type HWND = (ST_HWND__.tag, C.rw) C.su_obj C.ptr'

  structure MessageBoxStyle =
  struct
      type flags = Word32.word
      type t = flags

      fun toWord f = SysWord.fromLarge (Word32.toLarge f)
      fun fromWord f = Word32.fromLarge (SysWord.toLarge f)
      val flags = List.foldl Word32.orb 0w0
      fun allSet (fl1, fl2) = Word32.andb(fl1, fl2) = fl1
      fun anySet (fl1, fl2) = Word32.andb(fl1, fl2) <> 0w0
      fun clear (fl1, fl2) = Word32.andb(Word32.notb fl1, fl2)

      val MB_OK                       : t = 0wx00000000
      val MB_OKCANCEL                 : t = 0wx00000001
      val MB_ABORTRETRYIGNORE         : t = 0wx00000002
      val MB_YESNOCANCEL              : t = 0wx00000003
      val MB_YESNO                    : t = 0wx00000004
      val MB_RETRYCANCEL              : t = 0wx00000005
      val MB_CANCELTRYCONTINUE        : t = 0wx00000006

      val MB_ICONHAND                 : t = 0wx00000010
      val MB_ICONQUESTION             : t = 0wx00000020
      val MB_ICONEXCLAMATION          : t = 0wx00000030
      val MB_ICONASTERISK             : t = 0wx00000040
      val MB_USERICON                 : t = 0wx00000080
      val MB_ICONWARNING              : t = MB_ICONEXCLAMATION
      val MB_ICONERROR                : t = MB_ICONHAND

      val MB_ICONINFORMATION          : t = MB_ICONASTERISK
      val MB_ICONSTOP                 : t = MB_ICONHAND

      val MB_DEFBUTTON1               : t = 0wx00000000
      val MB_DEFBUTTON2               : t = 0wx00000100
      val MB_DEFBUTTON3               : t = 0wx00000200
      val MB_DEFBUTTON4               : t = 0wx00000300

      val MB_APPLMODAL                : t = 0wx00000000
      val MB_SYSTEMMODAL              : t = 0wx00001000
      val MB_TASKMODAL                : t = 0wx00002000
      val MB_HELP                     : t = 0wx00004000 (* Help Button *)

      val MB_NOFOCUS                  : t = 0wx00008000
      val MB_SETFOREGROUND            : t = 0wx00010000
      val MB_DEFAULT_DESKTOP_ONLY     : t = 0wx00020000

      val MB_TOPMOST                  : t = 0wx00040000
      val MB_RIGHT                    : t = 0wx00080000
      val MB_RTLREADING               : t = 0wx00100000

      val MB_SERVICE_NOTIFICATION      : t = 0wx00200000
      val MB_SERVICE_NOTIFICATION_NT3X : t = 0wx00040000

      val MB_TYPEMASK                 : t = 0wx0000000F
      val MB_ICONMASK                 : t = 0wx000000F0
      val MB_DEFMASK                  : t = 0wx00000F00
      val MB_MODEMASK                 : t = 0wx00003000
      val MB_MISCMASK                 : t = 0wx0000C000

      val all = flags[MB_OK, MB_OKCANCEL, MB_ABORTRETRYIGNORE, MB_YESNOCANCEL,
                      MB_YESNO, MB_RETRYCANCEL, MB_CANCELTRYCONTINUE, MB_ICONHAND, MB_ICONQUESTION, 
                      MB_ICONEXCLAMATION, MB_ICONASTERISK, MB_USERICON, MB_DEFBUTTON1,
                      MB_DEFBUTTON2, MB_DEFBUTTON3, MB_DEFBUTTON4, MB_APPLMODAL, 
                      MB_SYSTEMMODAL, MB_TASKMODAL, MB_HELP, MB_NOFOCUS, MB_SETFOREGROUND, 
                      MB_DEFAULT_DESKTOP_ONLY, MB_TOPMOST, MB_RIGHT, MB_RTLREADING,
                      MB_SERVICE_NOTIFICATION, MB_SERVICE_NOTIFICATION_NT3X]

      val intersect = List.foldl (fn (a, b) => Word32.andb(a,b)) all
  end

  structure Result =
  struct
    datatype t = IDOK
               | IDCANCEL
               | IDABORT
               | IDRETRY
               | IDIGNORE
               | IDYES
               | IDNO
               | IDCLOSE
               | IDHELP

    fun fromInt 1 = SOME IDOK
      | fromInt 2 = SOME IDCANCEL
      | fromInt 3 = SOME IDABORT
      | fromInt 4 = SOME IDRETRY
      | fromInt 5 = SOME IDIGNORE
      | fromInt 6 = SOME IDYES
      | fromInt 7 = SOME IDNO
      | fromInt 8 = SOME IDCLOSE
      | fromInt 9 = SOME IDHELP
      | fromInt _ = NONE

    fun toInt IDOK     = 1
      | toInt IDCANCEL = 2
      | toInt IDABORT  = 3
      | toInt IDRETRY  = 4
      | toInt IDIGNORE = 5
      | toInt IDYES    = 6
      | toInt IDNO     = 7
      | toInt IDCLOSE  = 8
      | toInt IDHELP   = 9
  end

  structure ZS = ZString

  fun MessageBox (hwnd:HWND option, text, caption, style) =
  let
    val hwnd = getOpt (hwnd, C.Ptr.null')
    val ret = valOf o Result.fromInt o MLRep.Int.Signed.toInt
  in
    ret (F_MessageBoxA.f' (hwnd, ZS.dupML' text, ZS.dupML' caption, style))
  end

  val BEEP_SIMPLE : MessageBoxStyle.t = 0wxFFFFFFFF

  fun MessageBeep uType =
  let
    val uType = MLRep.Int.Unsigned.fromLarge
                    (SysWord.toLarge (MessageBoxStyle.toWord uType))
  in
    F_MessageBeep.f uType = 0
  end
end
end

