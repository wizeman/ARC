let training_dir = "../data/training"
let evaluation_dir = "../data/evaluation"

let parse_grid json name =
	let open Yojson.Basic.Util in
	let rows = json |> member name |> to_list |> Array.of_list in
	let grid = Array.map (fun row -> row |> to_list |> List.map to_int |> Array.of_list) rows in
	(name, grid)

let parse_grids json name =
	let open Yojson.Basic.Util in
	let examples_json = json |> member name |> to_list in
	let grids = List.map (fun json -> [parse_grid json "input"; parse_grid json "output"]) examples_json in
	(name, grids)

let parse_task path =
	let json = Yojson.Basic.from_file path in
	(path, [parse_grids json "train"; parse_grids json "test"])

let get_paths dir =
	Array.map (Filename.concat dir) (Sys.readdir dir)

let training_paths () = get_paths training_dir
let evaluation_paths () = get_paths evaluation_dir
let all_paths () = Array.append (training_paths ()) (evaluation_paths ())
