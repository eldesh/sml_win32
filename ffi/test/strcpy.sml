
structure Test =
struct
  structure lstrcpy = F_lstrcpyA
  structure ZS = ZString

  fun check s true = print ("  [PASS] "^s^"\n")
    | check s _    = raise Fail s

  fun main (_:string,_:string list) =
  let
    val testInstring = "foo Bar BAZZ"
    val buff = C.alloc C.T.uchar 0w128
  in
    let val _ = lstrcpy.f (buff, ZS.dupML testInstring) in
      check "lstrcpy0" (ZS.toML buff = testInstring)
    end;
    let val testInstring = String.map Char.toUpper testInstring in
      check "lstrcpy1" (ZS.toML (lstrcpy.f
                                  (buff
                                  , ZS.dupML testInstring)) = testInstring)
    end;
    let val testInstring = String.map Char.toLower testInstring in
      check "lstrcpy2" (ZS.toML (lstrcpy.f
                                  (buff
                                  , ZS.dupML testInstring)) = testInstring)
    end;
    OS.Process.success
  end
  handle exn => (OS.Process.failure before print (exnMessage exn^"\n"))
end

