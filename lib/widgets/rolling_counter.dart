import 'package:flutter/material.dart';

class RollingCounterText extends StatelessWidget {
  final String value;
  final TextStyle? style;
  final Duration duration;

  const RollingCounterText({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 250),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(0.0, 0.3),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: Text(value, key: ValueKey<String>(value), style: style),
    );
  }
}
