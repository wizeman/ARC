#!/usr/bin/env bash

set -euo pipefail

make
_build/default/solve_missing_square.exe
