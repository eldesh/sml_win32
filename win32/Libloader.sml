
structure Libloader :> LIB_LOADER =
struct
  fun GetModuleHandle name : Base.HMODULE =
  let
    val name = case name
                 of SOME name => ZString.dupML' name
                  | NONE => C.Ptr.null'
  in
    C.Ptr.cast' (F_GetModuleHandleA.f' name)
  end
end

