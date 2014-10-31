LOCAL_PATH              := $(call my-dir)
LLMR_ROOT               := ../../..
LLMR_INC_ROOT           := ../..
BUILDTYPE               ?= Debug
LLMR_OUT                := $(LLMR_ROOT)/build/$(BUILDTYPE)/obj
LLMR_OUT_TARGET         := $(LLMR_ROOT)/build/$(BUILDTYPE)/obj.target
MAPNIK_PACKAGING_OUT    := /mapnik-packaging/osx/out/build-cpp11-libstdcpp-gcc-arm-android
MAPNIK_PACKAGING_LIB    := $LLMR_ROOT/mapnik-packaging/osx/out/build-cpp11-libcpp-gcc-arm-android/lib
MAPNIK_PACKAGING_INC    := $LLMR_ROOT/mapnik-packaging/osx/out/build-cpp11-libcpp-gcc-arm-android/include

include $(CLEAR_VARS)
LOCAL_MODULE            := png
LOCAL_SRC_FILES         := $(MAPNIK_PACKAGING_LIB)/libpng.a
LOCAL_EXPORT_C_INCLUDES := $(MAPNIK_PACKAGING_INC)
LOCAL_EXPORT_LDLIBS     := -lz
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE            := uv
LOCAL_SRC_FILES         := $(MAPNIK_PACKAGING_LIB)/libuv.a
LOCAL_EXPORT_C_INCLUDES := $(MAPNIK_PACKAGING_INC)
include $(PREBUILT_STATIC_LIBRARY)

#include $(CLEAR_VARS)
#LOCAL_MODULE            := ssl
#LOCAL_SRC_FILES         := $(MAPNIK_PACKAGING_LIB)/libssl.a
#LOCAL_EXPORT_C_INCLUDES := $(MAPNIK_PACKAGING_INC)
#include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE            := curl
LOCAL_SRC_FILES         := $(MAPNIK_PACKAGING_LIB)/libcurl.a
LOCAL_EXPORT_C_INCLUDES := $(MAPNIK_PACKAGING_INC)
LOCAL_EXPORT_LDLIBS     := -lz
#LOCAL_STATIC_LIBRARIES  := ssl
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE            := sqlite3
LOCAL_SRC_FILES         := $(MAPNIK_PACKAGING_LIB)/libsqlite3.a
LOCAL_EXPORT_C_INCLUDES := $(MAPNIK_PACKAGING_INC)
#LOCAL_EXPORT_LDLIBS     := -lsqlite3
#LOCAL_STATIC_LIBRARIES  := sqlite3
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE            := llmr
LOCAL_SRC_FILES         := $LLMR_ROOT/build/Release/obj.target/libmapboxgl.a
LOCAL_EXPORT_C_INCLUDES := $LLMR_ROOT/include
LOCAL_EXPORT_LDLIBS     := -latomic
LOCAL_STATIC_LIBRARIES  := png uv
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE            := NativeMapView
LOCAL_SRC_FILES         := NativeMapView.cpp \
                           JNI.cpp 
LOCAL_STATIC_LIBRARIES  := llmr curl sqlite3
LOCAL_LDLIBS            := -llog -landroid -lEGL -lGLESv2
include $(BUILD_SHARED_LIBRARY)
