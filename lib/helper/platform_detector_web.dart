// platform_detector_web.dart

import 'dart:html' as html;

bool isIOS() =>
    html.window.navigator.userAgent.toLowerCase().contains('iphone');
bool isAndroid() =>
    html.window.navigator.userAgent.toLowerCase().contains('android');
bool isDesktop() =>
    html.window.navigator.userAgent.toLowerCase().contains('windows') ||
    html.window.navigator.userAgent.toLowerCase().contains('macintosh') ||
    html.window.navigator.userAgent.toLowerCase().contains('linux');
