import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride, kIsWeb;
import 'package:flutter/material.dart';
import 'typing_practice_app.dart';

void main() {
  if (!kIsWeb && debugDefaultTargetPlatformOverride == null) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  runApp(TypingPracticeApp());
}



