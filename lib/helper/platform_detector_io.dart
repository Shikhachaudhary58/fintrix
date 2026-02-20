// platform_detector_io.dart
import 'dart:io' as io;

bool isIOS() => io.Platform.isIOS;
bool isAndroid() => io.Platform.isAndroid;
bool isDesktop() =>
    io.Platform.isWindows || io.Platform.isMacOS || io.Platform.isLinux;
