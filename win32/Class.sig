
signature CLASS =
sig
  structure Atom :
  sig
    eqtype t

    val Button        : t
    val ComboBox      : t
    val Edit          : t
    val ListBox       : t
    val MDIClient     : t
    val RichEdit      : t
    val RichEditClass : t
    val ScrollBar     : t
    val Static        : t

    val toString : t -> string
  end
end

