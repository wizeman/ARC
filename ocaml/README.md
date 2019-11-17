You'll need the `ocaml` compiler installed as well as the following OCaml packages:
* dune (build tool)
* yojson (for JSON parsing)

You can compile the code with `make` or `dune build`.
The compiled binary can then be found in `_build/default/solve_missing_square.exe`.

The `./run.sh` script will call make and then run the binary.
