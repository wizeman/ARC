You'll need the `ocaml` compiler installed as well as the following OCaml packages:
* `dune` (build tool)
* `yojson` (for JSON parsing)

You can compile the code with `make` or `dune build`.
The compiled binary can then be found in `_build/default/solve_missing_square.exe`.

Or you can just use the `./run.sh` script to compile and then run the binary.

The generated binary takes about 1 second to read all the data files, parse them, run the algorithm on them and finally print the ones that matched the qualifying criteria and therefore could be solved.
