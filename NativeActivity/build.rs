use pkg_config;

fn main() {
    if cfg!(target_os = "android") {
        let gst_root = std::env::var("GSTREAMER_ROOT_ANDROID").unwrap();
        let target_arch = std::env::var("CARGO_CFG_TARGET_ARCH").unwrap();

        let arch_dir = match target_arch.as_str() {
            "aarch64" => "arm64",
            "arm" => "armv7",
            "x86" => "x86",
            "x86_64" => "x86_64",
            _ => panic!("Unsupported architecture: {}", target_arch),
        };

        // pkg-config 설정
        std::env::set_var("PKG_CONFIG_ALLOW_CROSS", "1");
        std::env::set_var(
            "PKG_CONFIG_PATH",
            format!("{}/{}/lib/pkgconfig", gst_root, arch_dir),
        );
        std::env::set_var(
            "PKG_CONFIG_SYSROOT_DIR",
            format!("{}/{}", gst_root, arch_dir),
        );

        // 정적 라이브러리 경로 추가
        println!(
            "cargo:rustc-link-search=native={}/{}/lib",
            gst_root, arch_dir
        );

        // pkg-config를 통한 라이브러리 검색
        pkg_config::Config::new()
            .statik(true)
            .probe("gstreamer-1.0")
            .unwrap();
        pkg_config::Config::new()
            .statik(true)
            .probe("gstreamer-app-1.0")
            .unwrap();
        pkg_config::Config::new()
            .statik(true)
            .probe("gstreamer-video-1.0")
            .unwrap();

        // 기본 시스템 라이브러리
        println!("cargo:rustc-link-lib=static=ffi");
        println!("cargo:rustc-link-lib=static=intl");
        println!("cargo:rustc-link-lib=static=iconv");
        println!("cargo:rustc-link-lib=static=z");

        // GLib/GObject 라이브러리
        println!("cargo:rustc-link-lib=static=glib-2.0");
        println!("cargo:rustc-link-lib=static=gobject-2.0");
        println!("cargo:rustc-link-lib=static=gio-2.0");

        // GStreamer 코어
        println!("cargo:rustc-link-lib=static=gstreamer-1.0");
        println!("cargo:rustc-link-lib=static=gstbase-1.0");

        // GStreamer 플러그인
        println!("cargo:rustc-link-lib=static=gstvideo-1.0");
        println!("cargo:rustc-link-lib=static=gstapp-1.0");
        println!("cargo:rustc-link-lib=static=gstpbutils-1.0");
        println!("cargo:rustc-link-lib=static=gstaudio-1.0");
        println!("cargo:rustc-link-lib=static=gsttag-1.0");
        println!("cargo:rustc-link-lib=static=gstcodecparsers-1.0");
        println!("cargo:rustc-link-lib=static=gstgl-1.0");

        // Android 시스템 라이브러리
        println!("cargo:rustc-link-lib=log");
        println!("cargo:rustc-link-lib=android");
    }
}
