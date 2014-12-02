structure ZS = ZString;
val null = C.Ptr.null (C.T.pointer C.T.sint);
fun msgbox() = 
  F_MessageBoxA.f (Unsafe.cast null, ZS.dupML "どうしますか？", ZS.dupML
  "メッセージボックスのデモ", 0wx04);
