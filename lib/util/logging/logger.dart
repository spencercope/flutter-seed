import 'package:flutter/cupertino.dart';

void appLogger(String content, {String? tag}) {
  if (tag != null) {
    debugPrint('$tag ~ $content');
  } else {
    debugPrint(content);
  }
}
