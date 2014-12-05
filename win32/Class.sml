
structure Class: CLASS =
struct
  structure Atom =
  struct
    datatype t = SystemClass of string

    val Button        = SystemClass "Button"
    val ComboBox      = SystemClass "ComboBox"
    val Edit          = SystemClass "Edit"
    val ListBox       = SystemClass "ListBox"
    val MDIClient     = SystemClass "MDIClient" (* Maybe treat this specially. *)
    val RichEdit      = SystemClass "RichEdit"
    val RichEditClass = SystemClass "RICHEDIT_CLASS"
    val ScrollBar     = SystemClass "ScrollBar"
    val Static        = SystemClass "Static"

    fun toString (SystemClass atom) = atom
  end
end

