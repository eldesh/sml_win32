
structure Msgbox =
struct
  structure ZS = ZString
  fun main (_:string, _:string list) =
    if F_MessageBoxA.f'
        (C.Ptr.null', ZS.dupML' "test foo bar bazz"
                    , ZS.dupML' "Message Box Demonstration...", 0wx04)
       = 1
    then OS.Process.success
    else OS.Process.failure
end

