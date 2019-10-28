(* generated by ocamltarzan with: camlp4o -o /tmp/yyy.ml -I pa/ pa_type_conv.cmo pa_vof.cmo  pr_o.cmo /tmp/xxx.ml  *)

open Ast_java

let rec vof_tok v = Parse_info.vof_info v
and vof_wrap _of_a (v1, v2) =
  let v1 = _of_a v1 and v2 = vof_tok v2 in Ocaml.VTuple [ v1; v2 ]
and vof_list1 _of_a = Ocaml.vof_list _of_a

let vof_ident v = vof_wrap Ocaml.vof_string v

let vof_qualified_ident v = Ocaml.vof_list vof_ident v

let rec vof_typ =
  function
  | TBasic v1 ->
      let v1 = vof_wrap Ocaml.vof_string v1
      in Ocaml.VSum (("TBasic", [ v1 ]))
  | TClass v1 ->
      let v1 = vof_class_type v1 in Ocaml.VSum (("TClass", [ v1 ]))
  | TArray v1 -> let v1 = vof_typ v1 in Ocaml.VSum (("TArray", [ v1 ]))
and vof_class_type v =
  vof_list1
    (fun (v1, v2) ->
       let v1 = vof_ident v1
       and v2 = Ocaml.vof_list vof_type_argument v2
       in Ocaml.VTuple [ v1; v2 ])
    v
and vof_type_argument =
  function
  | TArgument v1 ->
      let v1 = vof_ref_type v1 in Ocaml.VSum (("TArgument", [ v1 ]))
  | TQuestion v1 ->
      let v1 =
        Ocaml.vof_option
          (fun (v1, v2) ->
             let v1 = Ocaml.vof_bool v1
             and v2 = vof_ref_type v2
             in Ocaml.VTuple [ v1; v2 ])
          v1
      in Ocaml.VSum (("TQuestion", [ v1 ]))
and vof_ref_type v = vof_typ v

let vof_type_parameter =
  function
  | TParam ((v1, v2)) ->
      let v1 = vof_ident v1
      and v2 = Ocaml.vof_list vof_ref_type v2
      in Ocaml.VSum (("TParam", [ v1; v2 ]))

let rec vof_modifier =
  function
  | Public -> Ocaml.VSum (("Public", []))
  | Protected -> Ocaml.VSum (("Protected", []))
  | Private -> Ocaml.VSum (("Private", []))
  | Abstract -> Ocaml.VSum (("Abstract", []))
  | Static -> Ocaml.VSum (("Static", []))
  | Final -> Ocaml.VSum (("Final", []))
  | StrictFP -> Ocaml.VSum (("StrictFP", []))
  | Transient -> Ocaml.VSum (("Transient", []))
  | Volatile -> Ocaml.VSum (("Volatile", []))
  | Synchronized -> Ocaml.VSum (("Synchronized", []))
  | Native -> Ocaml.VSum (("Native", []))
  | Annotation v1 ->
      let v1 = vof_annotation v1 in Ocaml.VSum (("Annotation", [ v1 ]))
and vof_annotation (v1, v2) =
  let v1 = vof_name_or_class_type v1
  and v2 = Ocaml.vof_option vof_annotation_element v2
  in Ocaml.VTuple [ v1; v2 ]
and vof_modifiers v = Ocaml.vof_list (vof_wrap vof_modifier) v
and vof_annotation_element =
  function
  | AnnotArgValue v1 ->
      let v1 = vof_element_value v1 in Ocaml.VSum (("AnnotArgValue", [ v1 ]))
  | AnnotArgPairInit v1 ->
      let v1 = Ocaml.vof_list vof_annotation_pair v1
      in Ocaml.VSum (("AnnotArgPairInit", [ v1 ]))
  | EmptyAnnotArg -> Ocaml.VSum (("EmptyAnnotArg", []))
and vof_element_value =
  function
  | AnnotExprInit v1 ->
      let v1 = vof_expr v1 in Ocaml.VSum (("AnnotExprInit", [ v1 ]))
  | AnnotNestedAnnot v1 ->
      let v1 = vof_annotation v1 in Ocaml.VSum (("AnnotNestedAnnot", [ v1 ]))
  | AnnotArrayInit v1 ->
      let v1 = vof_list1 vof_element_value v1
      in Ocaml.VSum (("AnnotArrayInit", [ v1 ]))
and vof_annotation_pair (v1, v2) =
  let v1 = vof_ident v1
  and v2 = vof_element_value v2
  in Ocaml.VTuple [ v1; v2 ]
and vof_name_or_class_type v = Ocaml.vof_list vof_identifier_ v
and vof_identifier_ =
  function
  | Id v1 -> let v1 = vof_ident v1 in Ocaml.VSum (("Id", [ v1 ]))
  | Id_then_TypeArgs ((v1, v2)) ->
      let v1 = vof_ident v1
      and v2 = Ocaml.vof_list vof_type_argument v2
      in Ocaml.VSum (("Id_then_TypeArgs", [ v1; v2 ]))
  | TypeArgs_then_Id ((v1, v2)) ->
      let v1 = Ocaml.vof_list vof_type_argument v1
      and v2 = vof_identifier_ v2
      in Ocaml.VSum (("TypeArgs_then_Id", [ v1; v2 ]))
and vof_name v =
  vof_list1
    (fun (v1, v2) ->
       let v1 = Ocaml.vof_list vof_type_argument v1
       and v2 = vof_ident v2
       in Ocaml.VTuple [ v1; v2 ])
    v
and vof_literal =
  function
  | Bool v1 ->
      let v1 = vof_wrap Ocaml.vof_bool v1 in Ocaml.VSum (("Bool", [ v1 ]))
  | Int v1 ->
      let v1 = vof_wrap Ocaml.vof_string v1 in Ocaml.VSum (("Int", [ v1 ]))
  | Float v1 ->
      let v1 = vof_wrap Ocaml.vof_string v1 in Ocaml.VSum (("Float", [ v1 ]))
  | Char v1 ->
      let v1 = vof_wrap Ocaml.vof_string v1 in Ocaml.VSum (("Char", [ v1 ]))
  | String v1 ->
      let v1 = vof_wrap Ocaml.vof_string v1
      in Ocaml.VSum (("String", [ v1 ]))
  | Null v1 -> let v1 = vof_tok v1 in Ocaml.VSum (("Null", [ v1 ]))


and vof_expr =
  function
  | Name v1 -> let v1 = vof_name v1 in Ocaml.VSum (("Name", [ v1 ]))
  | NameOrClassType v1 ->
      let v1 = vof_name_or_class_type v1
      in Ocaml.VSum (("NameOrClassType", [ v1 ]))
  | Literal v1 ->
      let v1 = vof_literal v1
      in Ocaml.VSum (("Literal", [ v1 ]))
  | ClassLiteral v1 ->
      let v1 = vof_typ v1 in Ocaml.VSum (("ClassLiteral", [ v1 ]))
  | NewClass ((v1, v2, v3)) ->
      let v1 = vof_typ v1
      and v2 = vof_arguments v2
      and v3 = Ocaml.vof_option vof_decls v3
      in Ocaml.VSum (("NewClass", [ v1; v2; v3 ]))
  | NewArray ((v1, v2, v3, v4)) ->
      let v1 = vof_typ v1
      and v2 = vof_arguments v2
      and v3 = Ocaml.vof_int v3
      and v4 = Ocaml.vof_option vof_init v4
      in Ocaml.VSum (("NewArray", [ v1; v2; v3; v4 ]))
  | NewQualifiedClass ((v1, v2, v3, v4)) ->
      let v1 = vof_expr v1
      and v2 = vof_ident v2
      and v3 = vof_arguments v3
      and v4 = Ocaml.vof_option vof_decls v4
      in Ocaml.VSum (("NewQualifiedClass", [ v1; v2; v3; v4 ]))
  | Call ((v1, v2)) ->
      let v1 = vof_expr v1
      and v2 = vof_arguments v2
      in Ocaml.VSum (("Call", [ v1; v2 ]))
  | Dot ((v1, v2)) ->
      let v1 = vof_expr v1
      and v2 = vof_ident v2
      in Ocaml.VSum (("Dot", [ v1; v2 ]))
  | ArrayAccess ((v1, v2)) ->
      let v1 = vof_expr v1
      and v2 = vof_expr v2
      in Ocaml.VSum (("ArrayAccess", [ v1; v2 ]))
  | Postfix ((v1, v2)) ->
      let v1 = vof_expr v1
      and v2 = vof_op v2
      in Ocaml.VSum (("Postfix", [ v1; v2 ]))
  | Prefix ((v1, v2)) ->
      let v1 = vof_op v1
      and v2 = vof_expr v2
      in Ocaml.VSum (("Prefix", [ v1; v2 ]))
  | Infix ((v1, v2, v3)) ->
      let v1 = vof_expr v1
      and v2 = vof_op v2
      and v3 = vof_expr v3
      in Ocaml.VSum (("Infix", [ v1; v2; v3 ]))
  | Cast ((v1, v2)) ->
      let v1 = vof_typ v1
      and v2 = vof_expr v2
      in Ocaml.VSum (("Cast", [ v1; v2 ]))
  | InstanceOf ((v1, v2)) ->
      let v1 = vof_expr v1
      and v2 = vof_ref_type v2
      in Ocaml.VSum (("InstanceOf", [ v1; v2 ]))
  | Conditional ((v1, v2, v3)) ->
      let v1 = vof_expr v1
      and v2 = vof_expr v2
      and v3 = vof_expr v3
      in Ocaml.VSum (("Conditional", [ v1; v2; v3 ]))
  | Assignment ((v1, v2, v3)) ->
      let v1 = vof_expr v1
      and v2 = vof_op v2
      and v3 = vof_expr v3
      in Ocaml.VSum (("Assignment", [ v1; v2; v3 ]))
and vof_arguments v = Ocaml.vof_list vof_expr v
and vof_op v = Ocaml.vof_string v
and vof_stmt =
  function
  | Empty -> Ocaml.VSum (("Empty", []))
  | Block v1 -> let v1 = vof_stmts v1 in Ocaml.VSum (("Block", [ v1 ]))
  | Expr v1 -> let v1 = vof_expr v1 in Ocaml.VSum (("Expr", [ v1 ]))
  | If ((v1, v2, v3)) ->
      let v1 = vof_expr v1
      and v2 = vof_stmt v2
      and v3 = vof_stmt v3
      in Ocaml.VSum (("If", [ v1; v2; v3 ]))
  | Switch ((v1, v2)) ->
      let v1 = vof_expr v1
      and v2 =
        Ocaml.vof_list
          (fun (v1, v2) ->
             let v1 = vof_cases v1
             and v2 = vof_stmts v2
             in Ocaml.VTuple [ v1; v2 ])
          v2
      in Ocaml.VSum (("Switch", [ v1; v2 ]))
  | While ((v1, v2)) ->
      let v1 = vof_expr v1
      and v2 = vof_stmt v2
      in Ocaml.VSum (("While", [ v1; v2 ]))
  | Do ((v1, v2)) ->
      let v1 = vof_stmt v1
      and v2 = vof_expr v2
      in Ocaml.VSum (("Do", [ v1; v2 ]))
  | For ((v1, v2)) ->
      let v1 = vof_for_control v1
      and v2 = vof_stmt v2
      in Ocaml.VSum (("For", [ v1; v2 ]))
  | Break v1 ->
      let v1 = Ocaml.vof_option vof_ident v1
      in Ocaml.VSum (("Break", [ v1 ]))
  | Continue v1 ->
      let v1 = Ocaml.vof_option vof_ident v1
      in Ocaml.VSum (("Continue", [ v1 ]))
  | Return v1 ->
      let v1 = Ocaml.vof_option vof_expr v1
      in Ocaml.VSum (("Return", [ v1 ]))
  | Label ((v1, v2)) ->
      let v1 = vof_ident v1
      and v2 = vof_stmt v2
      in Ocaml.VSum (("Label", [ v1; v2 ]))
  | Sync ((v1, v2)) ->
      let v1 = vof_expr v1
      and v2 = vof_stmt v2
      in Ocaml.VSum (("Sync", [ v1; v2 ]))
  | Try ((v1, v2, v3)) ->
      let v1 = vof_stmt v1
      and v2 = vof_catches v2
      and v3 = Ocaml.vof_option vof_stmt v3
      in Ocaml.VSum (("Try", [ v1; v2; v3 ]))
  | Throw v1 -> let v1 = vof_expr v1 in Ocaml.VSum (("Throw", [ v1 ]))
  | LocalVar v1 ->
      let v1 = vof_var_with_init v1 in Ocaml.VSum (("LocalVar", [ v1 ]))
  | LocalClass v1 ->
      let v1 = vof_class_decl v1 in Ocaml.VSum (("LocalClass", [ v1 ]))
  | Assert ((v1, v2)) ->
      let v1 = vof_expr v1
      and v2 = Ocaml.vof_option vof_expr v2
      in Ocaml.VSum (("Assert", [ v1; v2 ]))
and vof_stmts v = Ocaml.vof_list vof_stmt v
and vof_case =
  function
  | Case v1 -> let v1 = vof_expr v1 in Ocaml.VSum (("Case", [ v1 ]))
  | Default -> Ocaml.VSum (("Default", []))
and vof_cases v = Ocaml.vof_list vof_case v
and vof_for_control =
  function
  | ForClassic ((v1, v2, v3)) ->
      let v1 = vof_for_init v1
      and v2 = Ocaml.vof_list vof_expr v2
      and v3 = Ocaml.vof_list vof_expr v3
      in Ocaml.VSum (("ForClassic", [ v1; v2; v3 ]))
  | Foreach ((v1, v2)) ->
      let v1 = vof_var v1
      and v2 = vof_expr v2
      in Ocaml.VSum (("Foreach", [ v1; v2 ]))
and vof_for_init =
  function
  | ForInitVars v1 ->
      let v1 = Ocaml.vof_list vof_var_with_init v1
      in Ocaml.VSum (("ForInitVars", [ v1 ]))
  | ForInitExprs v1 ->
      let v1 = Ocaml.vof_list vof_expr v1
      in Ocaml.VSum (("ForInitExprs", [ v1 ]))
and vof_catch (v1, v2) =
  let v1 = vof_var v1 and v2 = vof_stmt v2 in Ocaml.VTuple [ v1; v2 ]
and vof_catches v = Ocaml.vof_list vof_catch v
and vof_var { v_name = v_v_name; v_mods = v_v_mods; v_type = v_v_type } =
  let bnds = [] in
  let arg = vof_typ v_v_type in
  let bnd = ("v_type", arg) in
  let bnds = bnd :: bnds in
  let arg = vof_modifiers v_v_mods in
  let bnd = ("v_mods", arg) in
  let bnds = bnd :: bnds in
  let arg = vof_ident v_v_name in
  let bnd = ("v_name", arg) in let bnds = bnd :: bnds in Ocaml.VDict bnds
and vof_vars v = Ocaml.vof_list vof_var v
and vof_var_with_init { f_var = v_f_var; f_init = v_f_init } =
  let bnds = [] in
  let arg = Ocaml.vof_option vof_init v_f_init in
  let bnd = ("f_init", arg) in
  let bnds = bnd :: bnds in
  let arg = vof_var v_f_var in
  let bnd = ("f_var", arg) in let bnds = bnd :: bnds in Ocaml.VDict bnds
and vof_init =
  function
  | ExprInit v1 -> let v1 = vof_expr v1 in Ocaml.VSum (("ExprInit", [ v1 ]))
  | ArrayInit v1 ->
      let v1 = Ocaml.vof_list vof_init v1
      in Ocaml.VSum (("ArrayInit", [ v1 ]))
and
  vof_method_decl {
                    m_var = v_m_var;
                    m_formals = v_m_formals;
                    m_throws = v_m_throws;
                    m_body = v_m_body
                  } =
  let bnds = [] in
  let arg = vof_stmt v_m_body in
  let bnd = ("m_body", arg) in
  let bnds = bnd :: bnds in
  let arg = Ocaml.vof_list vof_qualified_ident v_m_throws in
  let bnd = ("m_throws", arg) in
  let bnds = bnd :: bnds in
  let arg = vof_vars v_m_formals in
  let bnd = ("m_formals", arg) in
  let bnds = bnd :: bnds in
  let arg = vof_var v_m_var in
  let bnd = ("m_var", arg) in let bnds = bnd :: bnds in Ocaml.VDict bnds
and vof_field v = vof_var_with_init v
and
  vof_enum_decl {
                  en_name = v_en_name;
                  en_mods = v_en_mods;
                  en_impls = v_en_impls;
                  en_body = v_en_body
                } =
  let bnds = [] in
  let arg =
    match v_en_body with
    | (v1, v2) ->
        let v1 = Ocaml.vof_list vof_enum_constant v1
        and v2 = vof_decls v2
        in Ocaml.VTuple [ v1; v2 ] in
  let bnd = ("en_body", arg) in
  let bnds = bnd :: bnds in
  let arg = Ocaml.vof_list vof_ref_type v_en_impls in
  let bnd = ("en_impls", arg) in
  let bnds = bnd :: bnds in
  let arg = vof_modifiers v_en_mods in
  let bnd = ("en_mods", arg) in
  let bnds = bnd :: bnds in
  let arg = vof_ident v_en_name in
  let bnd = ("en_name", arg) in let bnds = bnd :: bnds in Ocaml.VDict bnds
and vof_enum_constant =
  function
  | EnumSimple v1 ->
      let v1 = vof_ident v1 in Ocaml.VSum (("EnumSimple", [ v1 ]))
  | EnumConstructor ((v1, v2)) ->
      let v1 = vof_ident v1
      and v2 = vof_arguments v2
      in Ocaml.VSum (("EnumConstructor", [ v1; v2 ]))
  | EnumWithMethods ((v1, v2)) ->
      let v1 = vof_ident v1
      and v2 = Ocaml.vof_list vof_method_decl v2
      in Ocaml.VSum (("EnumWithMethods", [ v1; v2 ]))
and
  vof_class_decl {
                   cl_name = v_cl_name;
                   cl_kind = v_cl_kind;
                   cl_tparams = v_cl_tparams;
                   cl_mods = v_cl_mods;
                   cl_extends = v_cl_extends;
                   cl_impls = v_cl_impls;
                   cl_body = v_cl_body
                 } =
  let bnds = [] in
  let arg = vof_decls v_cl_body in
  let bnd = ("cl_body", arg) in
  let bnds = bnd :: bnds in
  let arg = Ocaml.vof_list vof_ref_type v_cl_impls in
  let bnd = ("cl_impls", arg) in
  let bnds = bnd :: bnds in
  let arg = Ocaml.vof_option vof_typ v_cl_extends in
  let bnd = ("cl_extends", arg) in
  let bnds = bnd :: bnds in
  let arg = vof_modifiers v_cl_mods in
  let bnd = ("cl_mods", arg) in
  let bnds = bnd :: bnds in
  let arg = Ocaml.vof_list vof_type_parameter v_cl_tparams in
  let bnd = ("cl_tparams", arg) in
  let bnds = bnd :: bnds in
  let arg = vof_class_kind v_cl_kind in
  let bnd = ("cl_kind", arg) in
  let bnds = bnd :: bnds in
  let arg = vof_ident v_cl_name in
  let bnd = ("cl_name", arg) in let bnds = bnd :: bnds in Ocaml.VDict bnds
and vof_class_kind =
  function
  | ClassRegular -> Ocaml.VSum (("ClassRegular", []))
  | Interface -> Ocaml.VSum (("Interface", []))
and vof_decl =
  function
  | Class v1 -> let v1 = vof_class_decl v1 in Ocaml.VSum (("Class", [ v1 ]))
  | Method v1 ->
      let v1 = vof_method_decl v1 in Ocaml.VSum (("Method", [ v1 ]))
  | Field v1 -> let v1 = vof_field v1 in Ocaml.VSum (("Field", [ v1 ]))
  | Enum v1 -> let v1 = vof_enum_decl v1 in Ocaml.VSum (("Enum", [ v1 ]))
  | Init ((v1, v2)) ->
      let v1 = Ocaml.vof_bool v1
      and v2 = vof_stmt v2
      in Ocaml.VSum (("Init", [ v1; v2 ]))
and vof_decls v = Ocaml.vof_list vof_decl v

let vof_compilation_unit {
                           package = v_package;
                           imports = v_imports;
                           decls = v_decls
                         } =
  let bnds = [] in
  let arg = vof_decls v_decls in
  let bnd = ("decls", arg) in
  let bnds = bnd :: bnds in
  let arg =
    Ocaml.vof_list
      (fun (v1, v2) ->
         let v1 = Ocaml.vof_bool v1
         and v2 = vof_qualified_ident v2
         in Ocaml.VTuple [ v1; v2 ])
      v_imports in
  let bnd = ("imports", arg) in
  let bnds = bnd :: bnds in
  let arg = Ocaml.vof_option vof_qualified_ident v_package in
  let bnd = ("package", arg) in let bnds = bnd :: bnds in Ocaml.VDict bnds

let vof_program v = vof_compilation_unit v

let vof_any =
  function
  | AIdent v1 -> let v1 = vof_ident v1 in Ocaml.VSum (("AIdent", [ v1 ]))
  | AExpr v1 -> let v1 = vof_expr v1 in Ocaml.VSum (("AExpr", [ v1 ]))
  | AStmt v1 -> let v1 = vof_stmt v1 in Ocaml.VSum (("AStmt", [ v1 ]))
  | ATyp v1 -> let v1 = vof_typ v1 in Ocaml.VSum (("ATyp", [ v1 ]))
  | AVar v1 -> let v1 = vof_var v1 in Ocaml.VSum (("AVar", [ v1 ]))
  | AInit v1 -> let v1 = vof_init v1 in Ocaml.VSum (("AInit", [ v1 ]))
  | AMethod v1 ->
      let v1 = vof_method_decl v1 in Ocaml.VSum (("AMethod", [ v1 ]))
  | AField v1 -> let v1 = vof_field v1 in Ocaml.VSum (("AField", [ v1 ]))
  | AClass v1 ->
      let v1 = vof_class_decl v1 in Ocaml.VSum (("AClass", [ v1 ]))
  | ADecl v1 -> let v1 = vof_decl v1 in Ocaml.VSum (("ADecl", [ v1 ]))
  | AProgram v1 ->
      let v1 = vof_program v1 in Ocaml.VSum (("AProgram", [ v1 ]))
