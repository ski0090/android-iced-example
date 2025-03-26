LOCAL_PATH := $(call my-dir)

ifndef GSTREAMER_ROOT_ANDROID
$(error GSTREAMER_ROOT_ANDROID is not defined!)
endif

# 아키텍처별 경로 설정
GSTREAMER_ROOT := $(GSTREAMER_ROOT_ANDROID)/x86_64
GSTREAMER_NDK_BUILD_PATH := $(GSTREAMER_ROOT)/share/gst-android/ndk-build

# GStreamer 플러그인 및 의존성 설정
include $(GSTREAMER_NDK_BUILD_PATH)/plugins.mk
GSTREAMER_PLUGINS := $(GSTREAMER_PLUGINS_CORE) \
                    $(GSTREAMER_PLUGINS_PLAYBACK) \
                    $(GSTREAMER_PLUGINS_CODECS) \
                    $(GSTREAMER_PLUGINS_CODECS_RESTRICTED) \
                    $(GSTREAMER_PLUGINS_NET) \
                    $(GSTREAMER_PLUGINS_SYS)

G_IO_MODULES := openssl
GSTREAMER_EXTRA_DEPS := gstreamer-video-1.0

# NDK include 경로 설정
GSTREAMER_ANDROID_CFLAGS := -I$(GSTREAMER_ROOT)/include/gstreamer-1.0 \
                           -I$(GSTREAMER_ROOT)/include \
                           -I$(GSTREAMER_ROOT)/include/glib-2.0 \
                           -I$(GSTREAMER_ROOT)/lib/glib-2.0/include

# 컴파일러 플래그 설정
CFLAGS := $(GSTREAMER_ANDROID_CFLAGS) -DGST_DISABLE_DEPRECATED
CXXFLAGS := $(GSTREAMER_ANDROID_CFLAGS) -DGST_DISABLE_DEPRECATED
TARGET_CFLAGS += $(GSTREAMER_ANDROID_CFLAGS)

# GStreamer 빌드 설정
include $(GSTREAMER_NDK_BUILD_PATH)/gstreamer-1.0.mk

# 네이티브 액티비티 빌드 설정
include $(CLEAR_VARS)
LOCAL_MODULE := native-activity
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../src/lib.rs
LOCAL_LDLIBS := -landroid -llog
LOCAL_SHARED_LIBRARIES := gstreamer_android
LOCAL_C_INCLUDES := $(GSTREAMER_ROOT)/include/gstreamer-1.0 \
                   $(GSTREAMER_ROOT)/include \
                   $(GSTREAMER_ROOT)/include/glib-2.0 \
                   $(GSTREAMER_ROOT)/lib/glib-2.0/include

include $(BUILD_SHARED_LIBRARY)