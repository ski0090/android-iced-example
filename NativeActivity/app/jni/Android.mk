LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := native-activity
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../src/lib.rs
LOCAL_SHARED_LIBRARIES := gstreamer_android
LOCAL_LDLIBS := -landroid -llog

include $(BUILD_SHARED_LIBRARY)

ifndef GSTREAMER_ROOT_ANDROID
$(error GSTREAMER_ROOT_ANDROID is not defined!)
endif

# 아키텍처별 경로 설정
GSTREAMER_ROOT := $(GSTREAMER_ROOT_ANDROID)/armv7  # armeabi-v7a
GSTREAMER_ROOT := $(GSTREAMER_ROOT_ANDROID)/arm64  # arm64-v8a
GSTREAMER_ROOT := $(GSTREAMER_ROOT_ANDROID)/x86  # x86
GSTREAMER_ROOT := $(GSTREAMER_ROOT_ANDROID)/x86_64  # x86_64
GSTREAMER_NDK_BUILD_PATH  := $(GSTREAMER_ROOT)/share/gst-android/ndk-build/

# 필요한 GStreamer 플러그인 지정
GSTREAMER_PLUGINS := coreelements videoconvert audioresample playback opensles soup

# HTTPS/TLS 지원을 위한 설정
G_IO_MODULES := gnutls

# 필요한 GStreamer 라이브러리 지정
GSTREAMER_EXTRA_DEPS := gstreamer-video-1.0 gstreamer-1.0 glib-2.0 gobject-2.0 gio-2.0

include $(GSTREAMER_NDK_BUILD_PATH)/gstreamer.mk 