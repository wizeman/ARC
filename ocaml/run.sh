#!/usr/bin/env bash

set -euo pipefail

dune build
_build/default/solve_missing_square.exe
