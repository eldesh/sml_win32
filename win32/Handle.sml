
structure Handle :> HANDLE =
struct
  datatype 'a t = Hand of C_Pointer.t
  val hNull = Hand C_Pointer.null
  fun isHNull ptr = hNull = ptr

  (* We sometimes need the next two functions internally.
     They're needed externally unless we change the result type
     of SendMessage to allow us to return a handle for certain
     messages. *)
  val handleOfPtr = Hand
  fun ptrOfHandle (Hand n) = n

  (* We just need these as placeholders. We never create values of
     these types.  They are used simply as a way of creating different
     handle types. *)
  datatype GdiObj = GdiObj
  and Instance = Instance
  and Drop = Drop
  and DeviceContext = DeviceContext
  and Menu = Menu
  and Window = Window

  (* HINSTANCE is used as an instance of a module. *)
  type HINSTANCE = Instance t
  and  HDROP     = Drop t
  and  HGDIOBJ   = GdiObj t
  and  HDC       = DeviceContext t
  and  HMENU     = Menu t
  and  HWND      = Window t
end


