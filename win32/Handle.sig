
signature HANDLE =
sig
  eqtype ''a t
  val hNull : ''a t
  val isHNull : ''a t -> bool

  val handleOfPtr : C_Pointer.t -> ''a t
  val ptrOfHandle : ''a t -> C_Pointer.t

  eqtype GdiObj
  eqtype Instance
  eqtype Drop
  eqtype DeviceContext
  eqtype Menu
  eqtype Window

  (* HINSTANCE is used as an instance of a module. *)
  type HINSTANCE = Instance t
  and  HDROP     = Drop t
  and  HGDIOBJ   = GdiObj t
  and  HDC       = DeviceContext t
  and  HMENU     = Menu t
  and  HWND      = Window t
end

