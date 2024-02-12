import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class LockScreen extends StatelessWidget {
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100 ,vertical: 20),
              child: Image.asset('asset/theme/lock.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ActionSlider.standard(
                successIcon: const Icon(Icons.lock_open),
                sliderBehavior: SliderBehavior.stretch,
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                action: (controller) async {
                  controller.success();
                  HapticFeedback.lightImpact();
                  await Future.delayed(const Duration(seconds: 1));
                  if (!context.mounted) return;
                  context.pop();
                },
                child: const Text("برای باز کردن قفل بکشید"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
