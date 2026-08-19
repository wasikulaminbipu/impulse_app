import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TactileButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Duration duration;
  final double scaleFactor;
  final bool enableHaptics;

  const TactileButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.duration = const Duration(milliseconds: 100),
    this.scaleFactor = 0.96,
    this.enableHaptics = true,
  });

  @override
  State<TactileButton> createState() => _TactileButtonState();
}

class _TactileButtonState extends State<TactileButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scaleFactor).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: isDisabled
          ? null
          : (_) {
              _controller.forward();
              if (widget.enableHaptics) {
                HapticFeedback.lightImpact();
              }
            },
      onTapUp: isDisabled
          ? null
          : (_) {
              _controller.reverse();
              widget.onPressed?.call();
            },
      onTapCancel: isDisabled
          ? null
          : () {
              _controller.reverse();
            },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 48,
            minHeight: 48,
          ),
          child: Center(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
