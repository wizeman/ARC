This code is written in OCaml, so you'll need the following OCaml packages (check your distro manual for how to install them or just use [opam](https://opam.ocaml.org/)):
* `ocaml` (the OCaml compiler)
* `dune` (build tool)
* `yojson` (for JSON parsing)

You can compile the code with `make` or `dune build`.
The compiled binary can then be found in `_build/default/solve_missing_square.exe`.

Or you can just use the `./run.sh` script to compile and then run the binary.

The generated binary takes about 1 second to read all the data files, parse them, run the algorithm on them and finally print the ones that matched the qualifying criteria, which are verified to actually be solved correctly.

## Source code structure

The main code is in the `solve_missing_square.ml` file.

It relies on a function for finding the largest rectangle filled with pixels of the same color, which can be found on the `geom.ml` file.
This function looks complicated but is actually very simple.
I'm sure it would look much shorter/simpler in Python, for instance, or if it was written by a better programmer ;)

The I/O and JSON parsing code is in the `util.ml` file.
