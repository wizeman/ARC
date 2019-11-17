let find_max_rectangle input =
	let max_area = ref 0 in
	let duplicate = ref false in
	let best_ll = ref (-1, -1) in
	let best_ur = ref (-1, -1) in

	let max_y = Array.length input - 1 in
	let max_x = Array.length input.(0) - 1 in

	let check_filled ll_x ll_y ur_x ur_y =
		let color = input.(ll_y).(ll_x) in
		let rows = Array.sub input ll_y (ur_y - ll_y + 1) in
		let check_row row =
			let cells = Array.sub row ll_x (ur_x - ll_x + 1) in
			Array.for_all (Int.equal color) cells in
		Array.for_all check_row rows in

	let get_area ll_x ll_y ur_x ur_y =
		(ur_x - ll_x + 1) * (ur_y - ll_y + 1) in

	let process_rectangle ll_x ll_y ur_x ur_y =
		let filled = check_filled ll_x ll_y ur_x ur_y in
		if filled then begin
			let area = get_area ll_x ll_y ur_x ur_y in
			if area >= !max_area then begin
				if area = !max_area then
					duplicate := true
				else begin
					max_area := area;
					duplicate := false;
					best_ll := (ll_x, ll_y);
					best_ur := (ur_x, ur_y)
				end
			end
		end in

	(* Let's use the naive algorithm, as it's fast enough *)
	(* Extreme indentation follows for fun and profit *)
	for ll_y = 0 to max_y do
		for ll_x = 0 to max_x do
			for ur_y = ll_y to max_y do
				for ur_x = ll_x to max_x do
					process_rectangle ll_x ll_y ur_x ur_y
				done
			done
		done
	done;

	if !duplicate || !max_area = 0 then
		None
	else
		Some (!best_ll, !best_ur)

