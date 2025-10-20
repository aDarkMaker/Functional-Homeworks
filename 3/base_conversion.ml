let toInt b digits =
  let rec helper acc power = function
    | [] -> acc
    | d :: rest -> 
        if d >= b || d < 0 then 
          failwith "Invalid digit for given base"
        else
          helper (acc + d * power) (power * b) rest
  in
  helper 0 1 (List.rev digits)

let toBase b n =
  if n < 0 then failwith "Negative numbers not supported"
  else if n = 0 then [0]
  else
    let rec helper acc num =
      if num = 0 then acc
      else helper ((num mod b) :: acc) (num / b)
    in
    helper [] n

let convert (b1, b2) digits =
  if b1 <= 1 || b2 <= 1 then
    failwith "Base must be greater than 1"
  else
    let decimal_value = toInt b1 digits in
    toBase b2 decimal_value

let test_toInt () =
  print_endline "=== 测试 toInt 函数 ===";
  let base2ToInt = toInt 2 in
  let result1 = base2ToInt [0; 1] in
  print_endline ("[0,1] in base 2 = " ^ string_of_int result1 ^ " (expected: 2)");
  let base10ToInt = toInt 10 in
  let result2 = base10ToInt [4; 5] in
  print_endline ("[4,5] in base 10 = " ^ string_of_int result2 ^ " (expected: 54)");
  let base5ToInt = toInt 5 in
  let result3 = base5ToInt [1; 3; 2] in
  print_endline ("[1,3,2] in base 5 = " ^ string_of_int result3 ^ " (expected: 42)");
  print_endline ""

let test_toBase () =
  print_endline "=== 测试 toBase 函数 ===";
  let toBase2 = toBase 2 in
  let result1 = toBase2 10 in
  print_endline ("10 in base 2 = " ^ String.concat "," (List.map string_of_int result1) ^ " (expected: [1,0,1,0])");
  let toBase5 = toBase 5 in
  let result2 = toBase5 42 in
  print_endline ("42 in base 5 = " ^ String.concat "," (List.map string_of_int result2) ^ " (expected: [1,3,2])");
  let toBase10 = toBase 10 in
  let result3 = toBase10 123 in
  print_endline ("123 in base 10 = " ^ String.concat "," (List.map string_of_int result3) ^ " (expected: [1,2,3])");
  print_endline ""

let test_convert () =
  print_endline "=== 测试 convert 函数 ===";
  let result1 = convert (10, 5) [4; 2] in
  print_endline ("[4,2] from base 10 to base 5 = " ^ String.concat "," (List.map string_of_int result1) ^ " (expected: [1,3,2])");
  let result2 = convert (5, 2) [1; 3; 2] in
  print_endline ("[1,3,2] from base 5 to base 2 = " ^ String.concat "," (List.map string_of_int result2) ^ " (expected: [1,0,1,0,1,0])");
  let result3 = convert (2, 10) [1; 0; 1; 0] in
  print_endline ("[1,0,1,0] from base 2 to base 10 = " ^ String.concat "," (List.map string_of_int result3) ^ " (expected: [1,0])");
  print_endline ""

let test_equivalence () =
  print_endline "=== 测试数值等价性 ===";
  let original = [1; 3; 2] in
  let converted = convert (5, 2) original in
  let back_converted = convert (2, 5) converted in
  let original_value = toInt 5 original in
  let converted_value = toInt 2 converted in
  let back_value = toInt 5 back_converted in
  print_endline ("原始值 [1,3,2] (base 5) = " ^ string_of_int original_value);
  print_endline ("转换后值 (base 2) = " ^ string_of_int converted_value);
  print_endline ("再转换回 (base 5) = " ^ string_of_int back_value);
  print_endline ("等价性验证: " ^ (if original_value = converted_value && original_value = back_value then "通过" else "失败"));
  print_endline ""

let run_tests () =
  test_toInt ();
  test_toBase ();
  test_convert ();
  test_equivalence ();
  print_endline "所有测试完成！"

let () = run_tests ()
