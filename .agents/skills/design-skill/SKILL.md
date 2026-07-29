---
name: mobile-design-system
description: Use this skill whenever the user asks to design, style, mock up, prototype, or build UI for a mobile app screen, flow, component, or design system — prioritizing Flutter. Trigger on words like "screen", "UI", "app design", "mockup", "design system", "icon", "onboarding flow", "dark mode", "prototype", or a Stitch link, even if the user doesn't say "design" explicitly. Also trigger when reviewing or critiquing existing UI/UX, choosing a color palette or typography, or preparing assets for handoff to engineering. Covers Flutter specific theming, Android (Material 3 Expressive) and iOS (Liquid Glass / HIG) platform-specific patterns, a unified premium design language, accessibility, motion/haptics, vector asset pipelines, and Stitch by Google prototyping.
---

# Mobile Design System Skill

You are acting as a **senior product designer + UX engineer** producing platform-native, accessible, visually bold mobile app designs, with a strong focus on **premium aesthetics** and **Flutter implementations**. Every deliverable must look like it belongs on today's App Store / Play Store featured page, avoiding generic templates.

Follow this skill top to bottom: **decide platform → apply premium design system rules → implement in Flutter (or native) → validate against the checklist → prototype in Stitch.**

---

## 1. Design Aesthetics & Premium Feel
- **Prioritize Visual Excellence**: Implement designs that WOW the user. Use vibrant, harmonious color palettes (avoid plain colors like pure red or blue).
- **Glassmorphism & Depth**: Use sleek dark modes, subtle gradients, and glassmorphism (especially for floating navigation or overlays) to create a premium feel.
- **Dynamic Interactions**: Interfaces should feel responsive and alive. Use micro-animations, hover/press effects, and smooth transitions for all interactive elements.

## 2. Platform Decision (always ask/branch first)

Before designing anything, determine scope:

| Scope | What to do |
|---|---|
| **Android only** | Apply Material 3 Expressive (vivid color, strong shape containment, bouncy motion). |
| **iOS only** | Apply Liquid Glass / HIG (functional navigation-layer materials, vivid accents on neutral backgrounds). |
| **Flutter / Cross-platform** | Use a **unified premium design system** leveraging Flutter's `ThemeData`, `ColorScheme`, and `TextTheme`. Use platform-adaptive widgets (like `Switch.adaptive`) but maintain a consistent premium brand look across both platforms. |

---

## 3. Unified Premium Design System (Shared Foundation)

### 3.1 Color Palette Rules
- Build the palette as **design tokens** in Flutter `ColorScheme`: primary, secondary, tertiary, surface, error, etc.
- Use curated, harmonious color palettes. E.g., HSL tailored colors. Reserve the most saturated color for the single most important action per screen.
- Ensure **WCAG 2.2 AA** contrast: 4.5:1 for body text, 3:1 for large text and UI boundaries.

### 3.2 Typography
- Use modern typography (e.g., Google Fonts like Inter, Roboto, Outfit, or Poppins).
- Define a single shared **type scale** in Flutter's `TextTheme` (display, headline, title, body, label).
- Minimum body text: 16sp/pt. Line height ≥ 1.4× font size.

### 3.3 Iconography & Assets
- Use consistent icon styles. In Flutter, consider `CupertinoIcons` + `MaterialIcons`, or custom SVG icon sets.
- **Vector Graphics**: Always use `flutter_svg` for scalable vector assets. Avoid raster PNGs for anything that scales.

### 3.4 Reusable Component Library
- Define components once using Flutter widgets. Document states: default, pressed, focused, disabled, loading, error, empty.
- Examples: Cards with increased elevation and subtle borders for visual distinction, buttons with smooth scale animations.
- Use an 8pt/8dp base grid for all margins, padding, and gaps.

---

## 4. Flutter Implementation Guidelines

When implementing the UI in Flutter, apply these technical best practices:

- **Theming**: Centralize all styling in `app_theme.dart` (or similar) using `ThemeData`. Avoid hardcoding colors, text styles, or spacing in individual screens. Use `Theme.of(context)` everywhere.
- **Glassmorphism**: Implement using `BackdropFilter` with `ImageFilter.blur`, wrapping a container with a semi-transparent background color and subtle border.
- **Motion & Feedback**:
  - Use `InkWell` or `GestureDetector` with custom micro-animations (e.g., scaling down on press).
  - Use `HapticFeedback.lightImpact()` (or medium/heavy) on meaningful interactions.
  - Use `Hero` widgets for shared element transitions between screens.
  - Use Flutter's implicit animations (`AnimatedContainer`, `AnimatedOpacity`) for state changes.
- **Responsive & Adaptive Layouts**: Use `LayoutBuilder` and `MediaQuery` or `SafeArea` to handle different screen sizes, notches, and orientations.

---

## 5. Clarity Over Clutter

- Every screen should have **one primary action** — visually dominant (color, size, position). Everything else recedes.
- Progressive disclosure: hide secondary options behind expandable sections or menus.
- Whitespace is a design tool, use it to group and separate content logically.

---

## 6. Accessibility (non-negotiable)

- **Contrast**: 4.5:1 minimum for body text, verified in both Light and Dark modes.
- **Semantics**: Wrap custom interactive elements in `Semantics` widgets in Flutter so screen readers can interpret them correctly.
- **Touch Targets**: Minimum 48×48dp, with adequate spacing.

---

## 7. Dark Mode & Light Mode

- Implement both using Flutter's `theme` and `darkTheme` properties in `MaterialApp`.
- Dark mode should use elevated dark grays (e.g., #121212) rather than true black, and slightly desaturated accent colors to avoid vibrating against dark backgrounds.

---

## 8. Prototyping in Stitch by Google (prioritize this workflow)

For any request to prototype, mock up, or visually iterate on a screen/flow, **default to Stitch** (Google's AI UI design tool):
1. Describe intent: platform, screen purpose, tone/mood (e.g., "Flutter onboarding screen, premium glassmorphism, dark mode").
2. Iterate screen-by-screen, then assemble into a flow.
3. Export and hand off alongside token lists so engineering can implement pixel-accurate components.

---

## 9. Pre-Delivery Checklist

Before presenting any design or UI code as final, verify:
- [ ] Premium aesthetics applied (vivid colors, glassmorphism, modern typography).
- [ ] Flutter theming best practices used (no hardcoded styles).
- [ ] Single unified token set (color/type/icon/spacing) used everywhere.
- [ ] Contrast ratios pass AA in both Light and Dark mode.
- [ ] Touch targets ≥ 48×48dp.
- [ ] Vector assets specified using SVG (`flutter_svg`).
- [ ] Meaningful motion and haptic feedback included.
- [ ] Loading, empty, and error states designed.
