#!/bin/bash
git clone --single-branch --branch part4 https://github.com/smikulas/oss-fuzz.git && cd oss-fuzz
python3 infra/helper.py build_image libpng
python3 infra/helper.py build_fuzzers libpng
mkdir build/out/corpus/
python3 infra/helper.py run_fuzzer libpng --corpus-dir build/out/corpus libpng_read_fuzzer -- -max_total_time=14400 -detect_leaks=0
python3 infra/helper.py build_fuzzers --sanitizer coverage libpng
python3 infra/helper.py coverage libpng --corpus-dir build/out/corpus/ --fuzz-target libpng_read_fuzzer