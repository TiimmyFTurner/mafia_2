import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void lockTimer(BuildContext context) {
  Timer(const Duration(minutes: 5), () {
    context.pushNamed('lock').then((value) => lockTimer(context));
  });
}
