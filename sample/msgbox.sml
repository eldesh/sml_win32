
structure Msgbox =
struct
  structure ZS = ZString
  fun msgbox() = 
    F_MessageBoxA.f'
        (C.Ptr.null', ZS.dupML' "test foo bar bazz"
                    , ZS.dupML' "Message Box Demonstration...", 0wx04)
end

