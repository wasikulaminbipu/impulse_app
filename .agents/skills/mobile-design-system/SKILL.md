---
name: mobile-design-system
description: Use when designing, styling, mocking up, prototyping, or building UI for mobile screens, design systems, Material 3 Expressive, iOS HIG, typography, theming, haptics, micro-animations, or accessibility in Flutter.
---

# Mobile Design System & UI/UX Skill Guide

You are acting as a **Lead Product Designer & Senior Mobile UX Engineer**. Your mandate is to design and produce platform-native, accessible, stunning, high-performance mobile UI for Flutter and mobile platforms. Every interface must look like a top-tier featured app on the Apple App Store or Google Play Store, avoiding generic templates or plain MVP styling.

Follow this workflow: **Identify Context & Scope → Apply Platform & Design Standards → Architect Tokenized Design System → Implement in Flutter → Validate Accessibility & Polish → Prototype/Handoff.**

---

## 1. Visual Excellence & Modern UX/UI Design Trends (2026+)

### 1.1 Core Aesthetic Pillars & Latest UX Trends
- **AI-Native & Generative Dynamic UI**: Interfaces that fluidly morph based on user intent, predictive actions, and real-time context (e.g. adaptive layout slots, intent-driven micro-cards, dynamically generated action prompts).
- **Spatial & Liquid Glass Materials**: Next-gen translucency, multi-layer specular highlights (e.g., 1px crisp borders with 15-20% opacity), variable backdrop blurs (`BackdropFilter`), and depth layering that simulates real physical glass and spatial dimension (iOS 18+ / Spatial UI inspired).
- **Voice & Ambient Multimodal UI**: Multimodal input paradigms blending subtle audio cues, voice-first quick actions, hands-free conversational sheets, and glanceable ambient status indicators.
- **Privacy & Biometric Blur Guard**: Automatic contextual privacy masking (blurring sensitive financial/personal data on app switch or idle) with seamless biometric unlock overlay (`AppLifecycleListener` / `BackdropFilter`).
- **Vibrant HSL/OKLCH & Perceptual Color Space**: Never use raw, unrefined primary colors (e.g. standard `#FF0000` or `#0000FF`). Use curated OKLCH/HSL palettes with rich complementary accents and high perceptual contrast across both light and dark themes.
- **Bento Box Grids & Modular Containers**: Structure dashboards, feeds, and analytics hubs into modular rounded container tiles with subtle borders, dynamic aspect ratios, and visual hierarchy.
- **Micro-Gestures & Tactile Haptics**: Enhance every user interaction with spring physics, scale/press-down micro-animations (`ScaleTransition`), and nuanced contextual haptic feedback (`HapticFeedback.lightImpact`, `mediumImpact`, `selectionClick`).
- **Neomorphic 2.0 & Soft Depth Layers**: Modern soft shadows paired with internal highlights to create tactile, touchable surfaces without clutter.
- **Scannable Micro-Copy & Kinetic Typography**: Highly scannable typography hierarchies with kinetic text transitions, micro-badge status labels, and zero-jargon micro-copy.
- **Dynamic System Adaptation**: Flawless adaptation across light mode, dark mode, dynamic system accent colors, Dynamic Island / Live Activities, notch safe area insets, and collapsible navigation.

### 1.2 Typography & Text UX Best Practices
- **Variable Font & Fluid Typography**: Use modern variable fonts (e.g., Inter, Plus Jakarta Sans, Outfit, SF Pro) with dynamic optical sizing, tracking (letter-spacing), and fluid font scaling across screen sizes.
- **Dynamic Type & Legibility Standards**:
  - Always enforce line-height proportional to font size (1.2 to 1.3 for headlines, 1.4 to 1.5 for body text).
  - Adjust letter spacing for dark mode legibility (increase letter-spacing slightly on dark backgrounds to prevent optical light bleed/blur).
- **Tabular Figures for Financial/Numerical Data**: Enforce `FontFeature.tabularFigures()` for numbers, prices, tickers, and counters to prevent layout shifts during live data updates.
- **Scannability & Text Contrast**:
  - Maximize contrast hierarchy: Primary headings (100% opacity), Body/Secondary (75-80% opacity), Caption/Muted (50-60% opacity).
  - Use sentence case for UI labels, micro-copy, and CTA buttons to maximize reading speed.

---

## 2. Platform Design Guidelines & UX Standards

### 2.1 Android (Material Design 3 & Expressive)
- **Dynamic Color & Color Roles**:
  - Leverage M3 tonal palettes: `Primary`, `OnPrimary`, `PrimaryContainer`, `OnPrimaryContainer`, `Secondary`, `Tertiary` (accent contrast), `SurfaceContainerLowest`, `SurfaceContainerLow`, `SurfaceContainer`, `SurfaceContainerHigh`, `SurfaceContainerHighest`.
  - Use surface container roles rather than flat background colors to express elevation and component boundaries without relying solely on drop shadows.
- **Shape & Corner Radius**:
  - Emphasize expressive organic shapes with extra-large rounding (e.g. 16dp to 28dp radius for cards/dialogs, fully rounded pills for buttons and chips).
  - Use shape morphing and floating elements (e.g. Extended FABs, floating bottom app bars).
- **Typography & Motion**:
  - Material 3 Type Scale: `Display` (Large, Medium, Small), `Headline`, `Title`, `Body`, `Label`.
  - Expressive motion curves: Easing curves with overshoot/spring effects (`Curves.fastOutSlowIn`, `ElasticOut`, customized cubic bezier curves for fluid snaps).

### 2.2 iOS (Apple Human Interface Guidelines & Liquid Glass / iOS 18)
- **Materials & Translucency**:
  - Utilize vibrant background materials (Ultra Thin, Thin, Regular, Thick Materials, Liquid Glass) over blurred backgrounds.
  - Pair subtle border strokes with high backdrop blur (`BackdropFilter` with blur sigma 15–25) to separate foreground content from background gradients.
- **Navigation & Layout**:
  - Standard top navigation bar with dynamic titles (large title expanding/collapsing on scroll).
  - Tab Bars with semitranslucent background and clean line/filled vector icons.
  - Dynamic Island, Live Activities, and Notch safe area support using `SafeArea` and responsive padding.
- **Typography & Interaction**:
  - San Francisco font scale (Dynamic Type support with legibility tracking and tight line spacing).
  - Swipe-to-dismiss gestures, fluid sheet presentations (`showModalBottomSheet` with custom rounded drag handles), and subtle system haptics (`lightImpact`, `mediumImpact`, `selectionClick`).

---

## 3. Unified Cross-Platform Design System in Flutter

### 3.1 Tokenized Design System Architecture
Centralize all design tokens into reusable Flutter themes and extensions:

```dart
import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  // Brand Tonal Colors
  static const Color primary = Color(0xFF6750A4);
  static const Color secondary = Color(0xFF625B71);
  static const Color tertiary = Color(0xFF7D5260);
  
  // Dark Surface Container Tokens
  static const Color darkSurface = Color(0xFF141218);
  static const Color darkSurfaceContainer = Color(0xFF211F26);
  static const Color darkSurfaceContainerHigh = Color(0xFF2B2930);
  static const Color glassBorder = Color(0x26FFFFFF);
}

class AppTypography {
  // Line-height & tracking tailored typography tokens
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.45,
    letterSpacing: 0.1,
  );

  // Tabular numbers for financial/numerical lists & counters
  static const TextStyle tabularData = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFeatures: [FontFeature.tabularFigures()],
  );
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class AppRadius {
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double pill = 999.0;
}
```

### 3.2 ThemeExtensions for Custom Styling
Use `ThemeExtension` in Flutter to extend standard themes with custom design tokens (e.g. glassmorphism properties, card gradients):

```dart
@immutable
class GlassThemeExtension extends ThemeExtension<GlassThemeExtension> {
  final double blurSigma;
  final Color backgroundColor;
  final Color borderColor;

  const GlassThemeExtension({
    required this.blurSigma,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  GlassThemeExtension copyWith({
    double? blurSigma,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return GlassThemeExtension(
      blurSigma: blurSigma ?? this.blurSigma,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  @override
  GlassThemeExtension lerp(ThemeExtension<GlassThemeExtension>? other, double t) {
    if (other is! GlassThemeExtension) return this;
    return GlassThemeExtension(
      blurSigma: ColorUtils.lerpDouble(blurSigma, other.blurSigma, t) ?? blurSigma,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
    );
  }
}
```

---

## 4. Flutter UI Technical Best Practices

### 4.1 Glassmorphic Card Container Component
```dart
import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 20.0,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.white.withOpacity(0.08) 
                : Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: isDark 
                  ? Colors.white.withOpacity(0.15) 
                  : Colors.white.withOpacity(0.4),
              width: 1.0,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
```

### 4.2 Interactive Micro-Animations & Haptics
Wrap primary interactive buttons with touch scale animation feedback and physical haptics:

```dart
class ScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const ScaleButton({super.key, required this.child, required this.onPressed});

  @override
  State<ScaleButton> createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<ScaleButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
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
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
        HapticFeedback.lightImpact();
      },
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
```

### 4.3 Adaptive Controls Across iOS & Android
Use platform-adaptive widgets or platform checks to render native-feeling controls:
```dart
Widget buildAdaptiveSwitch(BuildContext context, bool value, ValueChanged<bool> onChanged) {
  return Switch.adaptive(
    value: value,
    onChanged: onChanged,
    activeColor: Theme.of(context).colorScheme.primary,
  );
}
```

### 4.4 AI-Native Intent Cards & Dynamic Layout Slots
Render intent-driven, predictive dynamic cards that morph dynamically based on application context:

```dart
class IntentCard extends StatelessWidget {
  final String title;
  final String suggestionText;
  final IconData actionIcon;
  final VoidCallback onAccept;

  const IntentCard({
    super.key,
    required this.title,
    required this.suggestionText,
    required this.actionIcon,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer.withOpacity(0.6),
            theme.colorScheme.tertiaryContainer.withOpacity(0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(actionIcon, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(suggestionText, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          IconButton.filledTonal(
            onPressed: onAccept,
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
```

### 4.5 Foldable & Dual-Screen Layout Adaptation
Adapt UI gracefully to large screens, tablets, and foldable devices (e.g. Galaxy Z Fold, Pixel Fold):

```dart
class AdaptiveMasterDetailLayout extends StatelessWidget {
  final Widget masterWidget;
  final Widget detailWidget;

  const AdaptiveMasterDetailLayout({
    super.key,
    required this.masterWidget,
    required this.detailWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Dual-pane layout on wide/foldable screens (width >= 720dp)
        if (constraints.maxWidth >= 720) {
          return Row(
            children: [
              SizedBox(width: 320, child: masterWidget),
              const VerticalDivider(width: 1, thickness: 1),
              Expanded(child: detailWidget),
            ],
          );
        }
        // Single pane layout for standard phone screens
        return masterWidget;
      },
    );
  }
}
```

### 4.6 Shimmer Skeleton Loading & Error States
Provide polished feedback during async data fetching and failure states:

```dart
class SkeletonTileLoader extends StatelessWidget {
  const SkeletonTileLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;

    return Container(
      height: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: baseColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(width: 56, height: 56, decoration: BoxDecoration(color: baseColor, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainCenter: MainAxisAlignment.center,
              children: [
                Container(width: double.infinity, height: 14, color: baseColor),
                const SizedBox(height: 8),
                Container(width: 120, height: 10, color: baseColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

### 4.7 Gesture-Driven Animations & Micro-Interactions
Implement tactile swipe actions and customized pull-to-refresh interactions:

```dart
class SwipeableDismissibleCard extends StatelessWidget {
  final Key itemKey;
  final Widget child;
  final VoidCallback onDismissed;

  const SwipeableDismissibleCard({
    required this.itemKey,
    required this.child,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: itemKey,
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        HapticFeedback.mediumImpact();
        onDismissed();
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          Icons.delete_outline,
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
      ),
      child: child,
    );
  }
}

Widget buildCustomPullToRefresh({
  required Future<void> Function() onRefresh,
  required Widget child,
}) {
  return RefreshIndicator.adaptive(
    onRefresh: () async {
      HapticFeedback.lightImpact();
      await onRefresh();
    },
    child: child,
  );
}
```

---

## 5. Mobile Accessibility (WCAG 2.2 AA Standard)

- **Color Contrast**: 
  - Minimum 4.5:1 ratio for regular text (under 18pt / 14pt bold).
  - Minimum 3.0:1 ratio for large text, icons, and UI component borders.
  - Test both Light and Dark mode variations explicitly.
- **Touch Target Size**:
  - Minimum touch target area: **48×48dp** (Android M3) / **44×44pt** (iOS HIG).
  - Provide padding around small visual icons using `IconButton` or `Padding` to maintain required touch boundaries.
- **Screen Reader Support**:
  - Wrap custom interactive components in Flutter `Semantics` widgets (`button: true`, `label: "..."`, `hint: "..."`).
  - Set `excludeSemantics: true` on purely decorative images or background shapes.
- **Dynamic Type & Font Scaling**:
  - Never hardcode fixed height containers around text widgets without allowing for font scaling. Use flexible layouts (`Flex`, `Expanded`, `SingleChildScrollView`) to prevent pixel overflow errors when text scales up to 200%.
- **Reduced Motion**:
  - Respect system settings for reduced motion:
    ```dart
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    ```

---

## 6. Comprehensive UI Component Guidelines

| Component | Design & UX Best Practice | Flutter Implementation Note |
|---|---|---|
| **Buttons** | Clear visual hierarchy (Primary Filled, Secondary Outlined, Tertiary Text). Scale press feedback. | `ElevatedButton`, `FilledButton`, `OutlinedButton`, `TextButton` with `StyleFrom`. |
| **Inputs** | Floating labels, clear error text, explicit focus ring, helper text. | `TextField` with `InputDecoration(border: OutlineInputBorder())`. |
| **Cards & Bento Grid** | Rounded corners (16-24dp), subtle border stroke, surface elevation roles. | `Card` / `Container` with `BoxDecoration` & `Border.all`. |
| **Bottom Sheets** | Drag handle bar, rounded top corners (28dp), smooth modal backdrop dimming. | `showModalBottomSheet(shape: RoundedRectangleBorder(...))`. |
| **Navigation** | Sticky top bar with search/actions; bottom nav bar with active indicator pill. | `NavigationBar` (M3) or `CupertinoTabBar`. |
| **States** | Expressive loading skeletons, empty state illustrations with CTA, clear retry on error. | Custom shimmer widgets, `CircularProgressIndicator.adaptive`. |

---

## 7. Stitch Prototyping & Design Handoff

When requested to prototype or iterate visually:
1. **Define Intent**: State target platform, flow step, color theme, tone (e.g., "Flutter Fintech Dashboard, Dark Glassmorphism, Material 3 Expressive").
2. **Iterate Screen by Screen**: Establish layout hierarchy, typography contrast, component layout, and micro-interactions.
3. **Token Export**: Maintain clear token definitions (`AppColors`, `AppTextStyles`, `AppSpacing`) so design translates 1:1 into Flutter widgets.

---

## 8. Pre-Delivery Quality Checklist

Before submitting any mobile UI code or design mockup, verify against this quality checklist:

- [ ] **Visual Excellence**: Modern aesthetics applied (curated palettes, depth/glassmorphism, clean typography, bento box grid where appropriate).
- [ ] **Platform Native Alignment**: Respects M3 Expressive container roles on Android and iOS material/translucency HIG standards on iOS.
- [ ] **Flutter Theming Architecture**: Centralized tokens in `ThemeData` & `ColorScheme`. Zero hardcoded inline magic colors or text styles.
- [ ] **Accessibility (WCAG 2.2 AA)**: Text contrast ≥ 4.5:1, touch targets ≥ 48×48dp, and proper `Semantics` tags.
- [ ] **Responsive & Adaptive**: Handles screen scaling, notches, Dynamic Island, and foldables cleanly using `SafeArea` and `LayoutBuilder`.
- [ ] **Interactive Feedback**: Scale/press animation on buttons and contextual `HapticFeedback`.
- [ ] **Vector Assets**: All icons/graphics specified in SVG format (`flutter_svg`) or standard vector icon fonts.
- [ ] **Edge Case States**: Loading skeleton, empty state, and error handling states explicitly accounted for.

---

## 9. Domain-Specific Color Palette Recipes & Visual Themes

| Domain / Industry | Primary & Secondary Palette (Hex/HSL) | Mood & UX Intent | Surface & Accent Styling |
|---|---|---|---|
| **Fintech & Crypto (DEX)** | Deep Obsidian (`#0F1117`), Electric Cyan (`#00F2FE`), Neon Violet (`#7000FF`) | Trust, precision, high-tech security, speed | Glassmorphism, specular neon borders, dark surface layers, tabular data styling. |
| **Health & Wellness** | Sage Mint (`#38B000`), Clean Porcelain (`#F8F9FA`), Calming Teal (`#00A896`) | Serenity, vitality, clarity, breathability | Soft organic rounded pills (24dp+), high whitespace ratio, muted contrast text. |
| **E-Commerce & Retail** | Warm Amber (`#FFB703`), Midnight Slate (`#1E293B`), Crimson Coral (`#FF4757`) | Urgency, desire, premium tactile quality, clear CTA | High contrast primary buttons, hero product cards, floating sticky buy bars. |
| **SaaS & Productivity** | Deep Indigo (`#4338CA`), Vibrant Iris (`#6366F1`), Warm Gray (`#F3F4F6`) | Focus, structure, density control, efficiency | Bento box grids, dynamic tag chips, compact table layout density. |

---

## 10. UX Micro-Copy, Tone & Onboarding Patterns

### 10.1 Micro-Copy Rules & UX Tone Guidelines
- **Action-Oriented CTAs**: Use explicit action verbs on buttons (e.g. *"Swap Tokens"*, *"Transfer Funds"*, *"Start Free Trial"*) instead of passive text (*"OK"*, *"Submit"*, *"Proceed"*).
- **Error Messages with Clear Recovery**: Always pair error text with a direct fix path.
  - *Bad*: `Error 404: Transaction failed.`
  - *Good*: `Insufficient balance for gas fee. Deposit ETH or adjust slippage.`
- **Zero Jargon**: Translate technical system terminology into plain, clear user language (e.g. use *"Connecting to network"* instead of *"Establishing WebSocket RPC handshake"*).

### 10.2 Progressive Onboarding Flow Patterns
1. **Interactive Carousel / Feature Highlights**: Limit to 3 visual slides maximum with animated page indicators and a persistent "Skip" option.
2. **Contextual In-App Tooltips (Coachmarks)**: Highlight key UI actions progressively when the user visits a feature for the first time rather than dumping all info upfront.
3. **Empty States with Direct CTA**: Never present a blank empty screen. Always show a friendly illustration, explanatory title, short helper text, and a primary action button (e.g. *"No transactions yet. Swap your first token now."*).

---

## 11. UI/UX Anti-Patterns & Visual Audit Checklist

### ❌ Anti-Patterns to Avoid
- 🔴 **Generic Primary Colors**: Avoid standard unrefined primary colors like `#FF0000`, `#0000FF`, or `#00FF00`.
- 🔴 **Shadow Overuse**: Avoid heavy black drop shadows (`rgba(0,0,0,0.5)`). Use surface elevation levels and soft tinted shadows.
- 🔴 **Text Over-Constraining**: Avoid fixed height containers around dynamic text that break when font scale increases.
- 🔴 **Missing Touch Boundaries**: Never create clickable icon buttons smaller than 44×44pt (iOS) or 48×48dp (Android).
- 🔴 **Abrupt State Transitions**: Avoid sudden UI pops without fade or scale micro-animations.

### ✅ Visual Refinement Audit
- [ ] Primary CTAs have scale/press animation feedback and contextual haptics.
- [ ] Text contrast meets WCAG 2.2 AA (4.5:1 for normal text, 3:1 for large text).
- [ ] Numerical prices/metrics use tabular figures (`FontFeature.tabularFigures()`).
- [ ] Dark mode uses adjusted surface layers instead of pure flat `#000000`.
- [ ] Micro-copy is concise, sentence-cased, and action-driven.

---

## 12. Data Visualization, Charts & Motion Choreography

### 12.1 Mobile Data Visualization Rules
- **High-Contrast Line & Sparkline Charts**: Use clean gradient fills (`LinearGradient` under area charts) with distinct data points and high-contrast stroke lines.
- **Interactive Tooltips & Crosshairs**: Touch and hold on charts should reveal a vertical crosshair line with subtle haptic feedback (`HapticFeedback.selectionClick()`) and a floating metric card.
- **Color Semantics for Trends**: Standardize financial & status colors (Green for gain/success, Red for loss/error, Amber for pending) across all charts and stat pills.

### 12.2 Motion Choreography & Staggered Animations
- **Staggered List Entrance**: Animate list items sequentially with a brief delay (e.g. 50ms per item) using `FadeTransition` and `SlideTransition` for a premium entrance effect.
- **Shared Element Morphing**: Use Hero animations (`Hero` widget) for seamless morphing when transitioning from a list card to a detail view.
- **Spring Physics over Linear Easing**: Always prefer spring/overshoot curves (`Curves.fastOutSlowIn`, `Curves.easeOutCubic`, custom spring physics) over rigid linear animations.

### 12.3 Latest 2026+ Animation Trends & Micro-Motion Patterns
- **Morphing Mesh & Fluid Gradient Backgrounds**: Dynamic, continuously moving mesh gradients (`CustomPainter` / shader blur) that react subtly to device orientation and scrolling.
- **Fluid Spatial & Liquid Sheet Transitions**: Sheet presentations with continuous corner morphing, backdrop glass blurs, and rubber-band drag physics.
- **Reactive Haptic Micro-Springs**: Instant physical feedback loops where scale down, rotation tweaks, and haptics trigger concurrently on press-down.
- **Skeleton-to-Content Layout Morphing**: Seamlessly expanding skeleton placeholder frames directly into loaded content layout bounds without screen blinks or redraw flashes (`AnimatedCrossFade` / `ImplicitlyAnimatedWidget`).
- **Kinetic Text & Rolling Counter Animations**: Smoothly rolling numerical digits for price shifts, wallet balances, and percentage tickers using `AnimatedSwitcher` with vertical slide transitions.

```dart
// Rolling Counter Digit Animation Pattern
class RollingCounterText extends StatelessWidget {
  final String value;
  final TextStyle style;

  const RollingCounterText({super.key, required this.value, required this.style});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.4),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: Text(
        value,
        key: ValueKey<String>(value),
        style: style,
      ),
    );
  }
```

### 12.4 Feedback UI & Haptic Choreography Matrix
Provide multi-sensory feedback loops across all key user interactions by pairing haptics, motion, and visual banners:

| User Action / Event | Haptic Intensity Pattern | Visual Feedback Component | Motion & Easing Curve |
|---|---|---|---|
| **Button Press / Touch Down** | `HapticFeedback.lightImpact()` | Touch scale reduction (`0.96x`), brightness tint shift | `Curves.easeOutCubic` (100ms) |
| **Card / Item Swipe Dismiss** | `HapticFeedback.mediumImpact()` | Red background fill reveal with trash morph icon | `Curves.fastOutSlowIn` (200ms) |
| **Successful Action (Swap / Tx)** | `HapticFeedback.vibrate()` / `heavyImpact()` | Animated green checkmark badge + floating glass toast banner | `Curves.elasticOut` spring snap |
| **Error / Validation Failure** | `HapticFeedback.heavyImpact()` | Horizontal card shake / error pulse stroke animation | `Curves.elasticIn` double-shake |
| **Chart Touch & Drag Crosshair** | `HapticFeedback.selectionClick()` | Dynamic floating price tooltip card + vertical guide line | Real-time continuous drag tracking |

```dart
// Multi-Sensory Success Feedback Toast Component
class SuccessFeedbackBanner extends StatelessWidget {
  final String message;

  const SuccessFeedbackBanner({super.key, required this.message});

  static void show(BuildContext context, String message) {
    HapticFeedback.heavyImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        content: SuccessFeedbackBanner(message: message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.4), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
            child: const Icon(Icons.check, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 12.5 Micro-Animation Library & Micro-Interaction Trends
Detailed micro-animation widget recipes for interactive UI states:

#### 1. Live Pulse Status Beacon (Micro-Glow Pulse)
Subtle breathing radial glow animation for live indicators, active connections, or market status:

```dart
class PulseStatusBeacon extends StatefulWidget {
  final Color color;

  const PulseStatusBeacon({super.key, this.color = const Color(0xFF10B981)});

  @override
  State<PulseStatusBeacon> createState() => _PulseStatusBeaconState();
}

class _PulseStatusBeaconState extends State<PulseStatusBeacon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.4 * _controller.value + 0.2),
                blurRadius: 8 * _controller.value + 2,
                spreadRadius: 3 * _controller.value,
              ),
            ],
          ),
        );
      },
    );
  }
}
```

#### 2. Interactive Micro-Heart Like Bounce (Spring Pop)
Elastic scale bounce for favorites, likes, or bookmark toggles:

```dart
class ElasticLikeButton extends StatefulWidget {
  final bool isLiked;
  final ValueChanged<bool> onChanged;

  const ElasticLikeButton({super.key, required this.isLiked, required this.onChanged});

  @override
  State<ElasticLikeButton> createState() => _ElasticLikeButtonState();
}

class _ElasticLikeButtonState extends State<ElasticLikeButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 0.3,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerLike() {
    _controller.forward().then((_) => _controller.reverse());
    HapticFeedback.lightImpact();
    widget.onChanged(!widget.isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _triggerLike,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + _controller.value,
            child: Icon(
              widget.isLiked ? Icons.favorite : Icons.favorite_border,
              color: widget.isLiked ? const Color(0xFFEF4444) : Colors.grey,
              size: 24,
            ),
          );
        },
      ),
    );
  }
}

#### 3. Shimmer Wave Sweep (Gradient Loading Sweep)
Continuous horizontal gradient sweep across loading skeleton surfaces:

```dart
class ShimmerWaveSweep extends StatefulWidget {
  final Widget child;

  const ShimmerWaveSweep({super.key, required this.child});

  @override
  State<ShimmerWaveSweep> createState() => _ShimmerWaveSweepState();
}

class _ShimmerWaveSweepState extends State<ShimmerWaveSweep> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: const [
                Color(0xFFE2E8F0),
                Color(0xFFF8FAFC),
                Color(0xFFE2E8F0),
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment(-1.0 + (_controller.value * 3.0), -0.3),
              end: Alignment(1.0 + (_controller.value * 3.0), 0.3),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}
```

#### 4. 3D Tilt Card Micro-Interaction (Gyro / Drag Touch Angle)
Interactive 3D card tilt effect responding to pan/touch drags for spatial perspective:

```dart
class TiltCardMicroInteraction extends StatefulWidget {
  final Widget child;

  const TiltCardMicroInteraction({super.key, required this.child});

  @override
  State<TiltCardMicroInteraction> createState() => _TiltCardMicroInteractionState();
}

class _TiltCardMicroInteractionState extends State<TiltCardMicroInteraction> {
  Offset _dragOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _dragOffset += details.delta;
        });
      },
      onPanEnd: (_) {
        setState(() {
          _dragOffset = Offset.zero;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective
          ..rotateX(_dragOffset.dy * -0.001)
          ..rotateY(_dragOffset.dx * 0.001),
        transformAlignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}
```

---

## 13. Performance, Render Tree & 60/120 FPS Motion Rules

To guarantee silky smooth 60 FPS / 120 FPS ProMotion performance across mobile devices:

### 13.1 Render Tree & Rebuild Optimization
- **`const` Constructor Enforcements**: Use `const` constructors everywhere possible to prevent rebuilding static widget subtrees during animation ticks.
- **Isolate Expensive Paints with `RepaintBoundary`**: Wrap complex animated subtrees (like custom painted charts, shimmer wave masks, or backdrop filters) in `RepaintBoundary` to prevent invalidating adjacent render layers.
- **Use `AnimatedBuilder` / `ListenableBuilder`**: Pass pre-built static children through the `child` property of `AnimatedBuilder` rather than rebuilding static component trees on every animation frame.

### 13.2 Avoid Performance Pitfalls
- ❌ **Never run `BackdropFilter` inside long scrollable lists** (`ListView.builder`) without item capping or performance testing. Heavy blur filters consume GPU fill rate.
- ❌ **Avoid calling `setState` at 60 FPS inside gesture drag handlers**. Use `ValueNotifier` or `AnimationController` to update target transforms directly.
- ❌ **Avoid Opacity widget for simple fades**: Use `AnimatedOpacity` or `FadeTransition` instead of wrapping large subtrees in `Opacity(opacity: val)` which creates an off-screen buffer layer.

---

## 14. Definitive UI/UX Critical Anti-Patterns & What to Avoid

A comprehensive reference of non-negotiable UI/UX mistakes to avoid across mobile app design and Flutter implementation:

### 14.1 Visual & Layout Anti-Patterns
- 🛑 **Raw Unrefined Colors**: Never use pure primary colors like `#FF0000` (Red), `#0000FF` (Blue), or `#00FF00` (Green). Always use tailored HSL/OKLCH palettes.
- 🛑 **Heavy Black Drop Shadows**: Avoid harsh `rgba(0,0,0,0.5)` drop shadows. Use subtle tinted elevation shadows or specular border outlines.
- 🛑 **Cluttered Non-Bento Layouts**: Avoid unstructured vertical stacks with inconsistent padding and arbitrary margins. Use Bento box grids with consistent tokenized spacing (`AppSpacing.md`, `AppSpacing.lg`).
- 🛑 **Hardcoded Dimensions**: Avoid fixed-width or fixed-height containers that overflow when rendered on different screen sizes or font scaling settings.

### 14.2 Motion & Interaction Anti-Patterns
- 🛑 **Dead Touch Interactions**: Never leave buttons or clickable cards without scale/press animation feedback (`ScaleButton`) and contextual haptics (`HapticFeedback`).
- 🛑 **Abrupt Pop Transitions**: Avoid instant UI state pops or jarring layout jumps. Always smooth state changes with micro-animations (`AnimatedSwitcher`, `AnimatedCrossFade`).
- 🛑 **Linear Animation Curves**: Never use `Curves.linear` for UI element movements. Always use organic spring/overshoot curves (`Curves.fastOutSlowIn`, `Curves.easeOutCubic`).
- 🛑 **Excessive / Jarring Haptics**: Do not trigger heavy vibration on minor hover/touch events. Restrict heavy haptics strictly to major destructive or confirmation actions.

### 14.3 Typography & Micro-Copy Anti-Patterns
- 🛑 **Passive Button Labels**: Avoid generic button text like *"OK"*, *"Submit"*, *"Click Here"*. Use action-oriented micro-copy (*"Swap Tokens"*, *"Transfer Funds"*).
- 🛑 **Technical Jargon in UI**: Never show raw error codes, RPC endpoints, or stack traces directly to end users.
- 🛑 **Numeric Layout Shift**: Never display dynamic counters or live prices using standard variable-width fonts without `FontFeature.tabularFigures()`.

### 14.4 Accessibility & Usability Anti-Patterns
- 🛑 **Sub-Standard Touch Targets**: Never make interactive buttons or icon targets smaller than 48×48dp (Android M3) or 44×44pt (iOS HIG).
- 🛑 **Low Contrast Text**: Avoid light grey text on light backgrounds or dark grey on dark surfaces that fail the WCAG 2.2 AA 4.5:1 ratio.
- 🛑 **Ignoring System Motion Preferences**: Never ignore `MediaQuery.disableAnimationsOf(context)` when users enable reduced motion in system settings.

### 14.5 Technical & Code Architecture Anti-Patterns
- 🛑 **Inline Hardcoded Magic Values**: Avoid hardcoding raw hex colors (`Color(0xFF123456)`) or pixel paddings (`EdgeInsets.all(13.4)`) directly inside widget trees. Centralize in `AppColors` and `AppSpacing`.
- 🛑 **Leaking Data Models into Presentation UI**: Never pass Drift DB entities or raw API response JSON maps directly into widget constructors. Always map to immutable domain entities.

---

## 15. Dark Mode & OLED / Low-Power UX Engineering

### 15.1 Pure Black vs. Tinted Surface Elevation
- **Avoid Flat Pure `#000000` Everywhere**: Pure black causes visual smearing during scrolling on OLED displays. Reserve pure black for background wallpaper layers only.
- **Layered Dark Containers**: Express depth using progressive dark grey/violet container tones (`#121212`, `#1E1B2E`, `#2A273F`) paired with 15% opacity white specular borders.

### 15.2 Reduced Power Consumption Mode
- Automatically adapt visual effects when the device enters low-power battery mode:
  ```dart
  // Reduce blur sigma and disable heavy ambient shaders on low power mode
  final isLowPower = MediaQuery.of(context).platformBrightness == Brightness.dark;
  final blurAmount = isLowPower ? 8.0 : 20.0;
  ```

---

## 16. Internationalization (i18n), RTL & BiDi Layout Adaptation

### 16.1 Right-to-Left (RTL) Layout Adaptation
- **Use Directional Padding**: Always use `EdgeInsetsDirectional.only(start: 16, end: 12)` instead of `EdgeInsets.only(left: 16, right: 12)`.
- **Directional Alignment**: Use `AlignmentDirectional.topStart` and `CrossAxisAlignment.start` so layouts flip gracefully for Arabic, Hebrew, or Persian locales.
- **Directional Icons**: Auto-mirror directional icons (arrows, chevrons, back buttons) using `Transform.flip(flipX: Directionality.of(context) == TextDirection.rtl)`.

### 16.2 Text Expansion Allowance across Languages
- German, French, and Spanish text strings can expand up to 30-40% compared to English.
- Always wrap buttons and chip labels in `Flexible` or `SingleChildScrollView` to prevent pixel overflow errors in non-English locales.

---

## 17. Design System Maintenance, Component Deprecation & Token Migration

### 17.1 Token Migration & Semantic Aliasing
- **Never mutate core token values directly**: When updating a color or typography scale, create semantic alias tokens (e.g. `AppColors.brandPrimaryV2`) while preserving backward-compatible deprecation aliases (`@Deprecated('Use brandPrimaryV2 instead') static const Color primary = ...`).
- **Centralized Deprecation Warnings**: Mark legacy components with `@Deprecated` annotations detailing the replacement component class and target deprecation timeline.

### 17.2 Component Versioning & Refactoring Workflow
1. **Feature-Flag New UI Variants**: Test new UI/UX component iterations under feature flags (`ThemeExtension` variants or Riverpod provider overrides) before replacing global defaults.
2. **Automated Static Analysis Check**: Run `flutter analyze` after every design system token update to guarantee zero breaking changes across all presentation widgets.
