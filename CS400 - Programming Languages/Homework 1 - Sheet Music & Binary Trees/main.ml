open Javascript_main;;
open Flags;;

let list_check name f l (num_total,num_failed) = (
  Printf.printf "Running \"%s\" tests...\n" name;
  let failed = List.rev (fst (List.fold_left (fun (acc,count) (name, a,b) ->
    let name = (match name with
    | None -> string_of_int count
    | Some(s) -> Printf.sprintf "\"%s\"" s) in
    let b2 = f a in
    ((if b2=b then (
      Printf.printf "Test %s passed\n" name;
      acc
    ) else (
      Printf.printf "Test %s FAILED\n" name;
      (b2::acc))), (count+1))
    ) ([],1) l)) in
    (num_total + (List.length l), num_failed + (List.length failed))
  ) in


let i = parse_command_line () in (match i with
| Some(i) ->
    let result = get_ast i in
    ignore result;
    (* Ast.print_grammar 0 result;
    print_newline(); *)
    print_string (Javascript_ast.str_program result);
    print_newline ();
| _ -> ()
);
(match !Flags.test with
| Some("hw02") ->
  let n = list_check "Sheet Music" Homework02.get_duration Homework02.sheet_music_tests (0,0) in
  let n = list_check "Sum" Homework02.sum Homework02.sum_tests n in
  let n = list_check "Tree" Homework02.traverse2 Homework02.tree_tests n in
  let n = list_check "Tree (Pre-order)" Homework02.traverse2_pre Homework02.tree_tests_pre n in
  let n = list_check "Tree (Post-order)" Homework02.traverse2_post Homework02.tree_tests_post n in
  let (total,failed) = n in
  Printf.printf "Total = %d; failed = %d\n" total failed
| _ -> ()
);
exit 0;;
