
structure Msgbox =
struct
  structure ZS = ZString
  val null = C.Ptr.null (C.T.pointer C.T.sint)
  fun msgbox() = 
    F_MessageBoxA.f (Unsafe.cast null, ZS.dupML "�ǂ����܂����H", ZS.dupML
    "���b�Z�[�W�{�b�N�X�̃f��", 0wx04)
end

