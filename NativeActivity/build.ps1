$env:PKG_CONFIG_ALLOW_CROSS = "1"

# Android 환경 변수 설정
$env:ANDROID_HOME = "C:\Android\android-sdk"
$env:ANDROID_NDK_HOME = "C:\Android\android-sdk\ndk\android-ndk-r25c"
$env:ANDROID_SDK_ROOT = "C:\Android\android-sdk"

# GStreamer pkg-config 설정
$env:PKG_CONFIG_PATH = "C:\Android\gstreamer-1.0-android\x86_64\lib\pkgconfig"
$env:PKG_CONFIG_SYSROOT_DIR = "C:\Android\gstreamer-1.0-android\x86_64"
$env:PKG_CONFIG_LIBDIR = "C:\Android\gstreamer-1.0-android\x86_64\lib\pkgconfig"
$env:RUSTFLAGS = "-L C:\Android\gstreamer-1.0-android\x86_64\lib -l pcre2-8 -l iconv -l gmodule-2.0 -l gobject-2.0 -l glib-2.0 -l ffi -C link-arg=-Wl,-rpath-link=C:\Android\gstreamer-1.0-android\x86_64\lib"

# GStreamer 환경 변수 설정
$env:GSTREAMER_ROOT_ANDROID = "C:\Android\gstreamer-1.0-android"
$env:GSTREAMER_ROOT = "C:\Android\gstreamer-1.0-android"

# FFI 관련 환경 변수 설정
$env:LIBFFI_LINK_FLAGS = "-lffi"
$env:LIBFFI_INCLUDE_DIR = "C:\Android\gstreamer-1.0-android\x86_64\include"

# 추가 링크 플래그
$env:LIBRARY_PATH = "C:\Android\gstreamer-1.0-android\x86_64\lib"
$env:LD_LIBRARY_PATH = "C:\Android\gstreamer-1.0-android\x86_64\lib"
$env:ICONV_LIBRARY_PATH = "C:\Android\gstreamer-1.0-android\x86_64\lib"
$env:ICONV_PREFIX = "C:\Android\gstreamer-1.0-android\x86_64"
$env:PCRE2_LIBRARY_PATH = "C:\Android\gstreamer-1.0-android\x86_64\lib"

cargo ndk -t x86_64 -o app/src/main/jniLibs/ build