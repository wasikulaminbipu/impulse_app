import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_dex/screens/manufacturers_screen.dart';
import 'package:impulse_dex/screens/products_screen.dart';
import 'package:impulse_dex/screens/sales_personnels_screen.dart';
import 'package:impulse_dex/providers/app_maintenance_provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ProductsScreen(),
    ManufacturersScreen(),
    SalesPersonnelsScreen(),
  ];

  late final List<Widget?> _builtScreens = List.filled(_screens.length, null);

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(languageSettingProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      extendBody: true, // Allows the screens to scroll behind the floating glass nav bar
      body: SlideIndexedStack(
        index: _currentIndex,
        children: List.generate(_screens.length, (index) {
          if (index == _currentIndex || _builtScreens[index] != null) {
            _builtScreens[index] ??= _screens[index];
            return _builtScreens[index]!;
          }
          return const SizedBox.shrink();
        }),
      ),
      bottomNavigationBar: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null) {
            if (details.primaryVelocity! < 0) {
              // Swiped left (velocity < 0) -> go to next tab
              if (_currentIndex < _screens.length - 1) {
                setState(() {
                  _currentIndex++;
                });
              }
            } else if (details.primaryVelocity! > 0) {
              // Swiped right (velocity > 0) -> go to previous tab
              if (_currentIndex > 0) {
                setState(() {
                  _currentIndex--;
                });
              }
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface.withValues(alpha: 0.65), // more transparent for glass effect
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.2),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // stronger blur for liquid glass
              child: SafeArea(
                top: false,
                child: SizedBox(
                  height: 66,
                  child: Stack(
                    children: [
                      // Sliding Indicator
                      Positioned(
                        left: 8,
                        right: 8,
                        bottom: 0,
                        top: 0,
                        child: AnimatedAlign(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                          alignment: Alignment(
                            -1.0 + (_currentIndex * (2.0 / (_screens.length - 1))),
                            1.0,
                          ),
                          child: FractionallySizedBox(
                            widthFactor: 1.0 / _screens.length,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                height: 3.5,
                                width: 28,
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius: BorderRadius.circular(2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colorScheme.primary.withValues(alpha: 0.5),
                                      blurRadius: 8,
                                      offset: const Offset(0, -2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Nav Items
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildNavItem(
                              0,
                              Icons.inventory_2_outlined,
                              Icons.inventory_2,
                              lang == 'bn' ? 'প্রোডাক্টস' : 'Products',
                            ),
                            _buildNavItem(
                              1,
                              Icons.factory_outlined,
                              Icons.factory,
                              lang == 'bn' ? 'ম্যানুফ্যাকচারার' : 'Manufacturers',
                            ),
                            _buildNavItem(
                              2,
                              Icons.contacts_outlined,
                              Icons.contacts,
                              lang == 'bn' ? 'কন্টাক্টস' : 'Contacts',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData unselectedIcon,
    IconData selectedIcon,
    String label,
  ) {
    final isSelected = _currentIndex == index;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 4),
            AnimatedSlide(
              offset: isSelected ? const Offset(0, -0.08) : Offset.zero,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
              child: AnimatedScale(
                scale: isSelected ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutBack,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Icon(
                    isSelected ? selectedIcon : unselectedIcon,
                    key: ValueKey<bool>(isSelected),
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant.withValues(alpha: 0.55),
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                letterSpacing: 0.2,
              ),
              child: Text(label),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}

class SlideIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;

  const SlideIndexedStack({
    super.key,
    required this.index,
    required this.children,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<SlideIndexedStack> createState() => _SlideIndexedStackState();
}

class _SlideIndexedStackState extends State<SlideIndexedStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _previousIndex = 0;
  
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _previousIndex = widget.index;
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.value = 1.0;
    _updateAnimations();
  }

  void _updateAnimations() {
    final bool isSlidingRight = widget.index > _previousIndex;
    
    _slideAnimation = Tween<Offset>(
      begin: Offset(isSlidingRight ? 0.05 : -0.05, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void didUpdateWidget(SlideIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      _previousIndex = oldWidget.index;
      _updateAnimations();
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: IndexedStack(
          index: widget.index,
          children: widget.children,
        ),
      ),
    );
  }
}
