
(* This contains various types and other values which are needed in various
   modules.
   All the exported types are contained in other structures. *)
structure Base =
struct
local
in
  (* Many system calls return bool.  If the result is false we raise an exception. *)
  fun checkResult true = () | checkResult false = raise Fail "Base.checkResult"

  type POINT = { x: int, y: int }

  type RECT =  { left: int, top: int, right: int, bottom: int }

  type SIZE = { cx: int, cy: int }

  structure Handle =
  struct
    datatype HWND      = HWND
    datatype HMENU     = HMENU
    datatype HINSTANCE = HINSTANCE
        type HMODULE   = HINSTANCE
    datatype HICON     = HICON
        type HCURSOR   = HICON
    datatype HBRUSH    = HBRUSH

    type HWND      = (HWND     , C.rw) C.su_obj C.ptr'
    type HMENU     = (HMENU    , C.rw) C.su_obj C.ptr'
    type HINSTANCE = (HINSTANCE, C.rw) C.su_obj C.ptr'
    type HMODULE   = (HMODULE  , C.rw) C.su_obj C.ptr'
    type HICON     = (HICON    , C.rw) C.su_obj C.ptr'
    type HCURSOR   = (HCURSOR  , C.rw) C.su_obj C.ptr'
    type HBRUSH    = (HBRUSH   , C.rw) C.su_obj C.ptr'

    val null : ('a, 'rw) C.su_obj C.ptr' = C.Ptr.null'
    fun isNull (p: ('a, 'rw) C.su_obj C.ptr') = C.Ptr.isNull' p
  end
  open Handle

end
end

