let training_dir = "../data/training"
let evaluation_dir = "../data/evaluation"

module Yo = Yojson.Basic
module Yu = Yo.Util

let parse_grid (name, json) =
	let rows = json |> Yu.to_list |> Array.of_list in
	let grid = Array.map (fun row -> row |> Yu.to_list |> List.map Yu.to_int |> Array.of_list) rows in
	(name, grid)

let parse_grids (name, json) =
	let pairs_json = json |> Yu.to_list in
	let grids = List.map (fun json -> json |> Yu.to_assoc |> List.map parse_grid) pairs_json in
	(name, grids)

let parse_task path =
	let json = Yo.from_file path in
	(path, json |> Yu.to_assoc |> List.map parse_grids)

let get_paths dir =
	Array.map (Filename.concat dir) (Sys.readdir dir)

let training_paths () = get_paths training_dir
let evaluation_paths () = get_paths evaluation_dir
let all_paths () = Array.append (training_paths ()) (evaluation_paths ())
