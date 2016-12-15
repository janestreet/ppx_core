(** Match source code against generated code *)

(** Checks that the given code starts with [expected] followed by [@@@deriving.end] or
    [@@@end].

    Raises if there is no [@@@deriving.end].

    If some items don't match, it calls [mismatch_handler] with the location of the source
    items and the expected code.
*)
val match_structure
  :  pos:Lexing.position
  -> expected:Parsetree.structure
  -> mismatch_handler:(Location.t -> Parsetree.structure -> unit)
  -> Parsetree.structure
  -> unit

(** Same for signatures *)
val match_signature
  :  pos:Lexing.position
  -> expected:Parsetree.signature
  -> mismatch_handler:(Location.t -> Parsetree.signature -> unit)
  -> Parsetree.signature
  -> unit
