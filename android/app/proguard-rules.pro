# ==============================================================================
# Production ProGuard / R8 Optimization Rules for Impulse DEX
# Tech Stack: Flutter + Drift SQLite (FFI) + Freezed (Dart) + Riverpod + Plugins
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Optimization & Code Shrinking Controls
# ------------------------------------------------------------------------------
-allowaccessmodification

# ------------------------------------------------------------------------------
# 2. Flutter Engine, JNI & Plugin Entrypoints
# ------------------------------------------------------------------------------
# Preserve native C/C++ methods and JNI symbol bindings (including descriptor classes)
-keepclasseswithmembernames,includedescriptorclasses class * {
    native <methods>;
}

# Preserve Flutter plugin entrypoints and MethodChannel handlers
# Keeps only plugin constructors and channel handlers, allowing internal classes/methods
# to be fully optimized, shrunk, and obfuscated by R8.
-keep class * implements io.flutter.embedding.engine.plugins.FlutterPlugin {
    public <init>();
}
-keepclassmembers class * implements io.flutter.plugin.common.MethodChannel$MethodCallHandler {
    public void onMethodCall(io.flutter.plugin.common.MethodCall, io.flutter.plugin.common.MethodChannel$Result);
}
-keepclassmembers class * implements io.flutter.plugin.common.PluginRegistry$Registrar {
    public <init>(io.flutter.plugin.common.PluginRegistry);
    public io.flutter.plugin.common.BinaryMessenger messenger();
    public android.content.Context context();
    public android.app.Activity activity();
}

# Preserve Application & MainActivity entry point
-keep class com.impulseagriscienceltd.impulse_app.MainActivity

# Preserve attributes critical for reflection, annotations, and crash symbolication
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod,Exceptions,SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# ------------------------------------------------------------------------------
# 3. Android Framework & System Integrations
# ------------------------------------------------------------------------------
# Android FileProvider for share_plus
-keep class androidx.core.content.FileProvider

# In-App Update API (Play Core)
-keep class com.google.android.play.core.** { *; }

# Android Lifecycle ViewModels
-keep class * extends androidx.lifecycle.ViewModel

# Preserve Enum values/valueOf for safe reflection
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# ------------------------------------------------------------------------------
# 4. R8 Warning Suppressions
# ------------------------------------------------------------------------------
-dontwarn io.flutter.**
-dontwarn io.flutter.embedding.**
-dontwarn io.flutter.plugin.**
-dontwarn com.google.android.play.core.**
-dontwarn kotlinx.coroutines.**
-dontwarn androidx.annotation.**
-dontwarn androidx.sqlite.**
-dontwarn javax.annotation.**
-dontwarn org.codehaus.mojo.animal_sniffer.**
-dontwarn com.caverock.androidsvg.**
-dontwarn sun.misc.Unsafe


