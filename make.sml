
(**
 * load ffi generated test
 *)

val ret =
  if CM.make "win32/nlffi-generated.cm"
  then OS.Process.success before print "load success\n"
  else OS.Process.failure before print "load failure\n"

val () = OS.Process.exit ret;

