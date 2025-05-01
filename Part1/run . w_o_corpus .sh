git clone --single-branch --branch CS412Lab2Part1 https://github.com/google/oss-fuzz && cd oss-fuzz
python3 infra/helper.py build_image libpng
python3 infra/helper.py build_fuzzers libpng
mkdir build/out/corpus/
python3 infra/helper.py run_fuzzer libpng libpng_read_fuzzer --corpus-dir build/out/corpus -- -max_total_time=14400
python3 infra/helper.py build_fuzzers --sanitizer coverage libpng
python3 infra/helper.py coverage libpng --corpus-dir build/out/corpus/ --fuzz-target libpng_read_fuzzer