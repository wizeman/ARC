open Common

(*
 * Create output grid with the same size as the largest rectangle
 * and fill the contents with the pixels from the input that are
 * symmetrically opposed to the rectangle.
 *)
let create_output input (ll_x, ll_y) (ur_x, ur_y) =
	let input_max_y = Array.length input - 1 in
	let input_max_x = Array.length input.(0) - 1 in
	let output_y_size = ur_y - ll_y + 1 in
	let output_x_size = ur_x - ll_x + 1 in

	let init_cell opp_row ncol =
		opp_row.(input_max_x - (ll_x + ncol)) in

	let init_row nrow =
		let opp_row = input.(input_max_y - (ll_y + nrow)) in
		Array.init output_x_size (init_cell opp_row) in

	Array.init output_y_size init_row

(*
 * Transform the input into the output.
 * 
 * Returns None if the input has multiple rectangles of the largest
 * area.
 *)
let transform input =
	(* Find the largest rectangle filled with pixels of the same color *)
	match Geom.find_max_rectangle input with
	| None -> None  (* multiple rectangles found *)
	| Some (ll, ur) ->
		(* Only one rectangle was found, create the output and fill it *)
		Some (create_output input ll ur)

(*
 * Create the output from the input and check if it matches the real output
 * from the provided JSON file. If `transform` returns None, the comparison
 * will fail.
 *)
let qualifies pair =
	let guessed_output = transform (List.assoc "input" pair) in
	let real_output = List.assoc "output" pair in
	guessed_output = Some (real_output)

(*
 * If name = "train", check that `qualifies` returns true for all training inputs/outputs.
 * If name = "test", check that `qualifies` return true for all test inputs/outputs.
 *)
let all_pairs_qualify name task =
	let pairs = List.assoc name task in
	List.for_all qualifies pairs

(* Process a task *)
let process_task (path, task) =
	if all_pairs_qualify "train" task then begin
		(*
		 * All training samples produce the same output as us, so
		 * now let's check that the outputs we produce for the test
		 * inputs correspond to the expected outputs
		 *)
		assert (all_pairs_qualify "test" task);
		Printf.printf "example %s solved correctly\n%!" path
	end

let () =
	let paths = Util.all_paths () in
	let tasks = Array.map Util.parse_task paths in
	Array.iter process_task tasks
