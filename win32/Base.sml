
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
    type HWND = (ST_HWND__.tag, C.rw) C.su_obj C.ptr'
    val null : HWND = C.Ptr.null'
  end
  open Handle
end
end

