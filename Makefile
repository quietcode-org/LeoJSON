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

VERSION ?= 0.7.0
DIST_DIR = dist
RELEASE_DIR = $(DIST_DIR)/LeoJSON-$(VERSION)
RELEASE_OPTFLAGS ?= -O2 -fno-common

DIST_SMOKE_SRC = examples/leojson_dist_smoke.m

.PHONY: release release-gcc42 clean-dist dist-smoke-gcc42

release: release-gcc42

release-gcc42:
	$(MAKE) clean-lib
	$(MAKE) lib-gcc42 OPTFLAGS="$(RELEASE_OPTFLAGS)"
	$(MAKE) headerdoc
	rm -rf $(RELEASE_DIR)
	mkdir -p $(RELEASE_DIR)/include
	mkdir -p $(RELEASE_DIR)/lib
	mkdir -p $(RELEASE_DIR)/docs
	cp sources/LeoJSON/LeoJSON.h $(RELEASE_DIR)/include/LeoJSON.h
	cp sources/LeoJSON/LeoJSONVersion.h $(RELEASE_DIR)/include/LeoJSONVersion.h
	cp $(BUILD_DIR)/libLeoJSON_gcc42.a $(RELEASE_DIR)/lib/libLeoJSON.a
	cp README.md $(RELEASE_DIR)/README.md
	cp LICENSE $(RELEASE_DIR)/LICENSE
	cp NOTICE $(RELEASE_DIR)/NOTICE
	cp CHANGELOG.md $(RELEASE_DIR)/CHANGELOG.md
	cp docs/*.md $(RELEASE_DIR)/docs/
	if [ -d docs/api ]; then cp -R docs/api $(RELEASE_DIR)/docs/api; fi

clean-dist:
	rm -rf $(RELEASE_DIR)

dist-smoke-gcc42: release-gcc42
	$(CC42) -ObjC -std=gnu99 -Wall -DNS_BLOCK_ASSERTIONS=1 \
		-arch $(ARCH) -isysroot $(SDKROOT) -mmacosx-version-min=$(MACOSX_VERSION_MIN) \
		-I$(RELEASE_DIR)/include $(DIST_SMOKE_SRC) $(RELEASE_DIR)/lib/libLeoJSON.a \
		$(FOUNDATION_FLAGS) \
		-o $(BUILD_DIR)/leojson_dist_smoke_gcc42

HEADERDOC ?= /Developer/usr/bin/headerdoc2html
GATHERHEADERDOC ?= /Developer/usr/bin/gatherheaderdoc
API_DOC_DIR = docs/api

.PHONY: headerdoc clean-headerdoc

headerdoc:
	rm -rf $(API_DOC_DIR)
	mkdir -p $(API_DOC_DIR)
	$(HEADERDOC) -o $(API_DOC_DIR) sources/LeoJSON/LeoJSON.h
	$(GATHERHEADERDOC) $(API_DOC_DIR)

clean-headerdoc:
	rm -rf $(API_DOC_DIR)

ERROR_SMOKE_SRC = probes/leojson_error_smoke.m

.PHONY: error-smoke-lib-gcc42

error-smoke-lib-gcc42: lib-gcc42
	$(CC42) $(COMMON_FLAGS) $(OPTFLAGS) $(ERROR_SMOKE_SRC) $(BUILD_DIR)/libLeoJSON_gcc42.a $(FOUNDATION_FLAGS) \
		-o $(BUILD_DIR)/leojson_error_smoke_lib_gcc42

.PHONY: full-smoke-gcc42

full-smoke-gcc42:
	$(MAKE) clean-lib
	$(MAKE) api-smoke-lib-gcc42 OPTFLAGS="$(RELEASE_OPTFLAGS)"
	$(BUILD_DIR)/leojson_api_smoke_lib_gcc42
	$(MAKE) error-smoke-lib-gcc42 OPTFLAGS="$(RELEASE_OPTFLAGS)"
	$(BUILD_DIR)/leojson_error_smoke_lib_gcc42
	$(MAKE) dist-smoke-gcc42
	$(BUILD_DIR)/leojson_dist_smoke_gcc42
	$(MAKE) headerdoc

RELEASE_ARCHIVE = $(DIST_DIR)/LeoJSON-$(VERSION)-Leopard-PPC.tar.gz
RELEASE_SHA256 = $(RELEASE_ARCHIVE).sha256

.PHONY: archive-gcc42 verify-archive-gcc42 clean-archive

archive-gcc42: release-gcc42
	cd $(DIST_DIR) && tar -czf LeoJSON-$(VERSION)-Leopard-PPC.tar.gz LeoJSON-$(VERSION)
	openssl dgst -sha256 $(RELEASE_ARCHIVE) > $(RELEASE_SHA256)

verify-archive-gcc42: archive-gcc42
	rm -rf $(BUILD_DIR)/archive-verify
	mkdir -p $(BUILD_DIR)/archive-verify
	tar -xzf $(RELEASE_ARCHIVE) -C $(BUILD_DIR)/archive-verify
	test -f $(BUILD_DIR)/archive-verify/LeoJSON-$(VERSION)/include/LeoJSON.h
	test -f $(BUILD_DIR)/archive-verify/LeoJSON-$(VERSION)/include/LeoJSONVersion.h
	test -f $(BUILD_DIR)/archive-verify/LeoJSON-$(VERSION)/lib/libLeoJSON.a
	test -f $(BUILD_DIR)/archive-verify/LeoJSON-$(VERSION)/README.md
	test -f $(BUILD_DIR)/archive-verify/LeoJSON-$(VERSION)/LICENSE
	test -f $(BUILD_DIR)/archive-verify/LeoJSON-$(VERSION)/NOTICE
	test -f $(BUILD_DIR)/archive-verify/LeoJSON-$(VERSION)/CHANGELOG.md
	test -f $(BUILD_DIR)/archive-verify/LeoJSON-$(VERSION)/docs/api/masterTOC.html
	test -f $(RELEASE_SHA256)
	test "`openssl dgst -sha256 $(RELEASE_ARCHIVE)`" = "`cat $(RELEASE_SHA256)`"
	$(CC42) -ObjC -std=gnu99 -Wall -DNS_BLOCK_ASSERTIONS=1 \
		-arch $(ARCH) -isysroot $(SDKROOT) -mmacosx-version-min=$(MACOSX_VERSION_MIN) \
		-I$(BUILD_DIR)/archive-verify/LeoJSON-$(VERSION)/include \
		$(DIST_SMOKE_SRC) $(BUILD_DIR)/archive-verify/LeoJSON-$(VERSION)/lib/libLeoJSON.a \
		$(FOUNDATION_FLAGS) \
		-o $(BUILD_DIR)/archive-verify/leojson_archive_smoke_gcc42
	$(BUILD_DIR)/archive-verify/leojson_archive_smoke_gcc42

clean-archive:
	rm -f $(RELEASE_ARCHIVE)
	rm -f $(RELEASE_SHA256)
	rm -rf $(BUILD_DIR)/archive-verify

.PHONY: utf8-boundary-inventory

utf8-boundary-inventory:
	tools/leojson_utf8_boundary_inventory.sh > docs/leoutf8-jsonkit-boundary-inventory.md

.PHONY: repo-hygiene

repo-hygiene:
	tools/repo_hygiene_check.sh

