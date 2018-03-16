(** This library is deprecated, use Ppxlib instead *)

open Ppxlib

(** Ppx_core is our stdlib for the ppx code so we just include Base here *)

module Base  = Base
module Stdio = Stdio

include Base  (* @closed *)
include Stdio (* @closed *)

(** Make sure code using Ppx_core doesn't refer to compiler-libs without being explicit
    about it *)
include struct
  [@@@warning "-3"]
  open Ocaml_shadow

  include (Ocaml_shadow : module type of struct include Ocaml_shadow end
           with module Ast_helper   := Ast_helper
           with module Asttypes     := Asttypes
           with module Docstrings   := Docstrings
           with module Identifiable := Identifiable
           with module Lexer        := Lexer
           with module Location     := Location
           with module Longident    := Longident
           with module Parse        := Parse
           with module Parser       := Parser
           with module Parsetree    := Parsetree
           with module Pprintast    := Pprintast
           with module Syntaxerr    := Syntaxerr
          )
end (** @inline *)

module Std = struct
  (* This module is deprecated, but we keep it for compatiblity with external code *)
  module Ast_builder         = Ast_builder
  module Ast_pattern         = Ast_pattern
  module Ast_traverse        = Ast_traverse
  module Attribute           = Attribute
  module Caller_id           = Caller_id
  module Context_free        = Context_free
  module Extension           = Extension
  module File_path           = File_path
  module Loc                 = Loc
  module Merlin_helpers      = Merlin_helpers
  module Reserved_namespaces = Reserved_namespaces
  module Spellcheck          = Spellcheck
  include Ppxlib_private.Common
end [@@deprecated "[since 2017-01] Use Ppx_core or Ppx_core.Light instead"]

(** You should open this module if you intend to use Ppx_core with a standard library that
    is not Base. *)
module Light = struct
  (** Includes the overrides from Ppxlib_ast, as well as all the Ast definitions since we
      need them in every single ppx *)
  include Ppxlib_ast
  include Ast

  include Std [@@warning "-3"]


  (** We don't include these in [Std] as these are likely to break external code *)

  module Location  = Location
  module Longident = Longident

  (** The API of these modules won't change when we upgrade the AST defined by ppxlib_ast. *)

  module Ast_builder_403 = Ast_builder
  module Ast_pattern_403 = Ast_pattern
end
include Light

(**/**)

module Ppx_core_private = struct
  module Name = Ppxlib_private.Name
end

let (^^) = Caml.(^^)
module Type_conv = Ppxlib.Deriving
