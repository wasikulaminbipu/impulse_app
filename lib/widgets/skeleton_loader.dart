import 'package:flutter/material.dart';

class SkeletonLoader extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Animation<double> animation;

  const SkeletonLoader({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = 8.0,
    required this.animation,
  });

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader> {
  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlightColor = Theme.of(context).colorScheme.surfaceContainer;

    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              colors: [
                baseColor,
                Color.lerp(baseColor, highlightColor, widget.animation.value)!,
                baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment(-1.0 + (widget.animation.value * 2), -0.3),
              end: Alignment(1.0 + (widget.animation.value * 2), 0.3),
            ),
          ),
        );
      },
    );
  }
}

class SkeletonAnimationGroup extends StatefulWidget {
  final Widget Function(BuildContext context, Animation<double> animation) builder;

  const SkeletonAnimationGroup({super.key, required this.builder});

  @override
  State<SkeletonAnimationGroup> createState() => _SkeletonAnimationGroupState();
}

class _SkeletonAnimationGroupState extends State<SkeletonAnimationGroup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _animation);
  }
}

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimationGroup(
      builder: (context, animation) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: Theme.of(context).brightness == Brightness.dark ? 0.3 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLoader(
                width: 100,
                height: 100,
                borderRadius: 12,
                animation: animation,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLoader(height: 18, width: 160, borderRadius: 4, animation: animation),
                    const SizedBox(height: 8),
                    SkeletonLoader(height: 14, width: 100, borderRadius: 4, animation: animation),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        SkeletonLoader(height: 22, width: 60, borderRadius: 12, animation: animation),
                        const SizedBox(width: 6),
                        SkeletonLoader(height: 22, width: 60, borderRadius: 12, animation: animation),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SkeletonLoader(height: 14, width: 120, borderRadius: 4, animation: animation),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DistributorCardSkeleton extends StatelessWidget {
  const DistributorCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimationGroup(
      builder: (context, animation) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: Theme.of(context).brightness == Brightness.dark ? 0.3 : 0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLoader(height: 18, width: 200, borderRadius: 4, animation: animation),
              const SizedBox(height: 10),
              SkeletonLoader(height: 14, width: 150, borderRadius: 4, animation: animation),
              const SizedBox(height: 6),
              SkeletonLoader(height: 14, width: 180, borderRadius: 4, animation: animation),
            ],
          ),
        );
      },
    );
  }
}
