(* 
 * Adapt MLRep implementation to MLton
 *)

structure MLRep = struct
  (* structure Char = ... *)
  (* structure Short = ...  *)
    structure Int =
       struct
          structure Signed = Int32
          structure Unsigned = Word32
          (* word-style bit-operations on integers... *)
          structure SignedBitops = IntBitOps(structure I = Signed
                                             structure W = Unsigned)
       end  
    (* structure Long = ...  *)
    structure LongLong =
       struct
          structure Signed = Int64
          structure Unsigned = Word64
          (* word-style bit-operations on integers... *)
          structure SignedBitops = IntBitOps(structure I = Signed
                                             structure W = Unsigned)
       end
    structure Float = Real
    structure Double = Real64
end
