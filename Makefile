SDKROOT ?= /Developer/SDKs/MacOSX10.5.sdk
ARCH ?= ppc
MACOSX_VERSION_MIN ?= 10.5
CC40 ?= /Developer/usr/bin/gcc-4.0
CC42 ?= /Developer/usr/bin/gcc-4.2

COMMON_FLAGS = -ObjC -std=gnu99 -Wall -DNS_BLOCK_ASSERTIONS=1 \
	-arch $(ARCH) -isysroot $(SDKROOT) -mmacosx-version-min=$(MACOSX_VERSION_MIN) \
	-Ivendor/JSONKit

FOUNDATION_FLAGS = -framework Foundation

BUILD_DIR = build

JSONKIT_SRC = vendor/JSONKit/JSONKit.m
SMOKE_SRC = probes/leojson_jsonkit_smoke.m

.PHONY: all smoke smoke-gcc40 smoke-gcc42 clean

all: smoke

smoke: smoke-gcc40 smoke-gcc42

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

smoke-gcc40: $(BUILD_DIR)
	$(CC40) $(COMMON_FLAGS) $(SMOKE_SRC) $(JSONKIT_SRC) $(FOUNDATION_FLAGS) \
		-o $(BUILD_DIR)/leojson_jsonkit_smoke_gcc40

smoke-gcc42: $(BUILD_DIR)
	$(CC42) $(COMMON_FLAGS) $(SMOKE_SRC) $(JSONKIT_SRC) $(FOUNDATION_FLAGS) \
		-o $(BUILD_DIR)/leojson_jsonkit_smoke_gcc42

clean:
	rm -rf $(BUILD_DIR)/leojson_jsonkit_smoke_gcc40
	rm -rf $(BUILD_DIR)/leojson_jsonkit_smoke_gcc42

BENCH_SRC = probes/leojson_jsonkit_bench.m

.PHONY: bench bench-gcc40 bench-gcc42

bench: bench-gcc40 bench-gcc42

bench-gcc40: $(BUILD_DIR)
	$(CC40) $(COMMON_FLAGS) -O2 $(BENCH_SRC) $(JSONKIT_SRC) $(FOUNDATION_FLAGS) \
		-o $(BUILD_DIR)/leojson_jsonkit_bench_gcc40

bench-gcc42: $(BUILD_DIR)
	$(CC42) $(COMMON_FLAGS) -O2 $(BENCH_SRC) $(JSONKIT_SRC) $(FOUNDATION_FLAGS) \
		-o $(BUILD_DIR)/leojson_jsonkit_bench_gcc42
