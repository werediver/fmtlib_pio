# fmtlib_pio

This repository contains a [PlatformIO library manifest](https://docs.platformio.org/en/latest//librarymanager/config.html) template for [fmtlib/fmt](https://github.com/fmtlib/fmt) (a modern C++ string formatting library) and a shell-script to fetch an fmt release and publish it to the [PlatformIO library registry](https://platformio.org/lib).

## Usage

Make sure you have a [PlatformIO account](https://docs.platformio.org/en/latest//plus/pio-account.html) and you are logged-in.

Check [fmtlib/fmt/releases](https://github.com/fmtlib/fmt/releases) and choose a version you want to publish as a PlatformIO library.

Run `./mk_fmtlib_pio.sh x.y.z` substituting the actual version for `x.y.z`.

The script downloads the archived source-code for the specified release version, unpacks it into `fmt-x.y.z` directory, and copies the manifest template into the same directory substituting the actual data for placeholders (currently only the version).

Now is a good time to test the combination of the new release and the manifest by building a PlatformIO library archive with [pio package pack](https://docs.platformio.org/en/latest//core/userguide/package/cmd_pack.html) and trying it out in a test project ([pio lib install](https://docs.platformio.org/en/latest/core/userguide/lib/cmd_install.html) can install libraries from archives).

## Limitations

PlatformIO is an embedded development platform and majority of embedded targets don't have a POSIX-compatible OS on-board, hence POSIX-dependent functionality is excluded from fmt. Luckily, (as of [v7.1.3](https://github.com/fmtlib/fmt/releases/tag/7.1.3)) only one module depends on POSIX: it's [src/os.cc](https://github.com/fmtlib/fmt/blob/7bdf0628b1276379886c7f6dda2cef2b3b374f0b/src/os.cc) and its header [include/fmt/os.h](https://github.com/fmtlib/fmt/blob/7bdf0628b1276379886c7f6dda2cef2b3b374f0b/include/fmt/os.h). These files are listed for exclusion in the manifest template.