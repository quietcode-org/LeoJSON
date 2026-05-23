SDKROOT ?= /Developer/SDKs/MacOSX10.5.sdk
ARCH ?= ppc
MACOSX_VERSION_MIN ?= 10.5
CC40 ?= /Developer/usr/bin/gcc-4.0
CC42 ?= /Developer/usr/bin/gcc-4.2

COMMON_FLAGS = -ObjC -std=gnu99 -Wall -DNS_BLOCK_ASSERTIONS=1 \
	-arch $(ARCH) -isysroot $(SDKROOT) -mmacosx-version-min=$(MACOSX_VERSION_MIN) \
	-Ivendor/JSONKit

FOUNDATION_FLAGS = -framework Foundation

OPTFLAGS ?= -O2

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
	$(CC40) $(COMMON_FLAGS) $(OPTFLAGS) $(BENCH_SRC) $(JSONKIT_SRC) $(FOUNDATION_FLAGS) \
		-o $(BUILD_DIR)/leojson_jsonkit_bench_gcc40

bench-gcc42: $(BUILD_DIR)
	$(CC42) $(COMMON_FLAGS) $(OPTFLAGS) $(BENCH_SRC) $(JSONKIT_SRC) $(FOUNDATION_FLAGS) \
		-o $(BUILD_DIR)/leojson_jsonkit_bench_gcc42

LEOJSON_SRC = sources/LeoJSON/LeoJSON.m
API_SMOKE_SRC = probes/leojson_api_smoke.m

COMMON_FLAGS += -Isources/LeoJSON

.PHONY: api-smoke api-smoke-gcc40 api-smoke-gcc42

api-smoke: api-smoke-gcc40 api-smoke-gcc42

api-smoke-gcc40: $(BUILD_DIR)
	$(CC40) $(COMMON_FLAGS) $(API_SMOKE_SRC) $(LEOJSON_SRC) $(JSONKIT_SRC) $(FOUNDATION_FLAGS) \
		-o $(BUILD_DIR)/leojson_api_smoke_gcc40

api-smoke-gcc42: $(BUILD_DIR)
	$(CC42) $(COMMON_FLAGS) $(API_SMOKE_SRC) $(LEOJSON_SRC) $(JSONKIT_SRC) $(FOUNDATION_FLAGS) \
		-o $(BUILD_DIR)/leojson_api_smoke_gcc42

AR ?= /usr/bin/ar
RANLIB ?= /usr/bin/ranlib

LEOJSON_OBJ_GCC40 = $(BUILD_DIR)/LeoJSON_gcc40.o
JSONKIT_OBJ_GCC40 = $(BUILD_DIR)/JSONKit_gcc40.o
LEOJSON_OBJ_GCC42 = $(BUILD_DIR)/LeoJSON_gcc42.o
JSONKIT_OBJ_GCC42 = $(BUILD_DIR)/JSONKit_gcc42.o

.PHONY: lib lib-gcc40 lib-gcc42 api-smoke-lib api-smoke-lib-gcc40 api-smoke-lib-gcc42 clean-lib

lib: lib-gcc40 lib-gcc42

$(LEOJSON_OBJ_GCC40): $(LEOJSON_SRC) sources/LeoJSON/LeoJSON.h | $(BUILD_DIR)
	$(CC40) $(COMMON_FLAGS) $(OPTFLAGS) -c $(LEOJSON_SRC) -o $@

$(JSONKIT_OBJ_GCC40): $(JSONKIT_SRC) vendor/JSONKit/JSONKit.h | $(BUILD_DIR)
	$(CC40) $(COMMON_FLAGS) $(OPTFLAGS) -c $(JSONKIT_SRC) -o $@

$(LEOJSON_OBJ_GCC42): $(LEOJSON_SRC) sources/LeoJSON/LeoJSON.h | $(BUILD_DIR)
	$(CC42) $(COMMON_FLAGS) $(OPTFLAGS) -c $(LEOJSON_SRC) -o $@

$(JSONKIT_OBJ_GCC42): $(JSONKIT_SRC) vendor/JSONKit/JSONKit.h | $(BUILD_DIR)
	$(CC42) $(COMMON_FLAGS) $(OPTFLAGS) -c $(JSONKIT_SRC) -o $@

lib-gcc40: $(LEOJSON_OBJ_GCC40) $(JSONKIT_OBJ_GCC40)
	$(AR) rcs $(BUILD_DIR)/libLeoJSON_gcc40.a $(LEOJSON_OBJ_GCC40) $(JSONKIT_OBJ_GCC40)
	$(RANLIB) $(BUILD_DIR)/libLeoJSON_gcc40.a

lib-gcc42: $(LEOJSON_OBJ_GCC42) $(JSONKIT_OBJ_GCC42)
	$(AR) rcs $(BUILD_DIR)/libLeoJSON_gcc42.a $(LEOJSON_OBJ_GCC42) $(JSONKIT_OBJ_GCC42)
	$(RANLIB) $(BUILD_DIR)/libLeoJSON_gcc42.a

api-smoke-lib: api-smoke-lib-gcc40 api-smoke-lib-gcc42

api-smoke-lib-gcc40: lib-gcc40
	$(CC40) $(COMMON_FLAGS) $(OPTFLAGS) $(API_SMOKE_SRC) $(BUILD_DIR)/libLeoJSON_gcc40.a $(FOUNDATION_FLAGS) \
		-o $(BUILD_DIR)/leojson_api_smoke_lib_gcc40

api-smoke-lib-gcc42: lib-gcc42
	$(CC42) $(COMMON_FLAGS) $(OPTFLAGS) $(API_SMOKE_SRC) $(BUILD_DIR)/libLeoJSON_gcc42.a $(FOUNDATION_FLAGS) \
		-o $(BUILD_DIR)/leojson_api_smoke_lib_gcc42

clean-lib:
	rm -f $(BUILD_DIR)/*.o
	rm -f $(BUILD_DIR)/libLeoJSON_gcc40.a
	rm -f $(BUILD_DIR)/libLeoJSON_gcc42.a
	rm -f $(BUILD_DIR)/leojson_api_smoke_lib_gcc40
	rm -f $(BUILD_DIR)/leojson_api_smoke_lib_gcc42
