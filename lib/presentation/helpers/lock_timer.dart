// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:mafia_2/infrastructure/router/routes_constant.dart';

void lockTimer(BuildContext context) {
  Timer(const Duration(minutes: 5), () {
    context.push(Routes.lockRoutePath).then((value) => lockTimer(context));
  });
}
