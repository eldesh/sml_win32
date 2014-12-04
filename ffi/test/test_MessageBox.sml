
structure Test =
struct
  fun main (_, _) =
    (MessageBox.MessageBox
        (NONE, "test MessageBox", "test MessageBox caption"
        , MessageBox.MessageBoxStyle.MB_OK);
     OS.Process.success
     )
end


