
(**
 * load ffi generated test
 *)
val (name, [fficm]) = (CommandLine.name(), CommandLine.arguments())
val () = print(concat["name: ", name, "\n"])

val ret =
  if CM.make fficm
  then OS.Process.success before print(concat["  [PASS] ", fficm, "\n"])
  else OS.Process.failure before print(concat["  [FAIL] ", fficm, "\n"])

val () = OS.Process.exit ret;

