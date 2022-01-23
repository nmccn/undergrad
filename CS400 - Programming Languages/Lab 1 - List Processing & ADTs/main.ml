open Javascript_main
open Flags
open Testing

let _ =
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
let (total,failed) = 
(match !Flags.test with
| Some("lab1") ->
  reset_test_counts ();
  let _ = list_check Lab1.replace_tests in
  let _ = list_check Lab1.get_max_tests in
  let _ = list_check Lab1.get_min_tests in
  let _ = list_check Lab1.is_bst_tests in
  let _ = list_check Lab1.insert_bst_tests in
  let _ = list_check Lab1.search_bst_tests in
  let _ = list_check Lab1.reverse_tests in
  let _ = list_check Lab1.sort_tests in
  let _ = list_check Lab1.map_tests in
  let _ = list_check Lab1.fold_left_tests in
  let _ = list_check Lab1.fold_right_tests in
  let _ = list_check Lab1.filter_tests in
  get_test_counts ()
| _ -> (0,0)
) in
Printf.printf "total = %d; failed = %d\n" total failed;
exit 0
