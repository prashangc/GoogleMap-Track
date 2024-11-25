import 'dart:developer';

import 'package:share_plus/share_plus.dart';

class ShareHelper {
  static void shareLink({required String url, String? message}) {
    try {
      final content = message != null ? "$message\n$url" : url;
      Share.share(content);
    } catch (e) {
      log('Error sharing link: $e');
    }
  }
}
