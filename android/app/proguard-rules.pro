# ==============================================================================
# Comprehensive Production ProGuard / R8 Rules for Impulse DEX
# Tech Stack: Flutter + Drift SQLite + Freezed + Riverpod + Native Plugins
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Optimization & Shrinkage Controls
# ------------------------------------------------------------------------------
# Allow aggressive optimization passes for maximum size reduction
-optimizationpasses 5
-allowaccessmodification

# ------------------------------------------------------------------------------
# 2. Flutter Engine & Core Framework Embedding Rules
# ------------------------------------------------------------------------------
-keep class io.flutter.** { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.provider.** { *; }
-keep class io.flutter.plugins.** { *; }

# Preserve native C/C++ methods and JNI symbol bindings (including descriptor classes)
-keepclasseswithmembernames,includedescriptorclasses class * {
    native <methods>;
}

# Preserve Flutter plugin entrypoints and MethodChannel handlers
-keepclassmembers class * implements io.flutter.plugin.common.MethodChannel$MethodCallHandler { *; }
-keepclassmembers class * implements io.flutter.embedding.engine.plugins.FlutterPlugin { *; }
-keepclassmembers class * implements io.flutter.plugin.common.PluginRegistry$Registrar { *; }
-keep class sun.misc.Unsafe { *; }
-dontwarn sun.misc.Unsafe

# Preserve attributes critical for reflection, annotations, serialization, and crash report symbolication
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod,Exceptions,SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# ------------------------------------------------------------------------------
# 3. SQLite3 Native Libraries & Drift Database Rules
# ------------------------------------------------------------------------------
# Preserve sqlite3 native library bindings, FFI & C-entrypoints
-keep class io.simonbinder.sqlite3.** { *; }
-keep class com.simonbinder.sqlite3.** { *; }
-keep class org.sqlite.** { *; }
-keep class sqlite3.** { *; }
-keep class androidx.sqlite.** { *; }

# Keep all Drift database models, generated tables, DAOs, background isolate messengers, and queries
-keep class * extends io.simonbinder.drift.** { *; }
-keep class * extends sqlite3.** { *; }
-keepclassmembers class * extends io.simonbinder.drift.GeneratedDatabase { *; }
-keepclassmembers class * extends io.simonbinder.drift.DatabaseAccessor { *; }
-keep class io.simonbinder.drift.remote.** { *; }

# ------------------------------------------------------------------------------
# 4. Freezed, JSON Serialization & Data Models Rules
# ------------------------------------------------------------------------------
# Keep serialized field annotations and fields for Jackson/Gson/Moshi/Dart JSON helpers
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
    @com.google.gson.annotations.Expose <fields>;
}

# Preserve Parcelable implementations for Android IPC
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Preserve Enums for JSON serialization & reflection lookup
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# ------------------------------------------------------------------------------
# 5. Flutter Plugins ProGuard Rules
# ------------------------------------------------------------------------------
# flutter_contacts (Android ContactsContract API)
-keep class co.coer.flutter_contacts.** { *; }
-keep class com.coer.flutter_contacts.** { *; }
-keep class android.provider.ContactsContract** { *; }

# url_launcher & intent resolvers
-keep class io.flutter.plugins.urllauncher.** { *; }

# share_plus & Android file sharing providers
-keep class dev.fluttercommunity.plus.share.** { *; }
-keep class androidx.core.content.FileProvider { *; }

# path_provider & local storage path resolvers
-keep class io.flutter.plugins.pathprovider.** { *; }

# flutter_native_splash & splash screen drawables
-keep class net.jonhanson.flutter_native_splash.** { *; }
-keep class com.impulseagriscienceltd.impulse_dex.MainActivity { *; }

# flutter_svg & SVG rendering engine
-keep class com.caverock.androidsvg.** { *; }

# ------------------------------------------------------------------------------
# 6. AndroidX, Jetpack Lifecycle & Kotlin Coroutines Rules
# ------------------------------------------------------------------------------
-keep class * extends androidx.lifecycle.ViewModel { *; }
-keep class * extends androidx.lifecycle.AndroidViewModel { *; }
-keep class kotlinx.coroutines.** { *; }

# ------------------------------------------------------------------------------
# 7. R8 Warning Suppressions & Optimization Exceptions
# ------------------------------------------------------------------------------
-dontwarn com.google.android.play.core.**
-dontwarn io.flutter.embedding.engine.deferredcomponents.**
-dontwarn io.flutter.embedding.handshake.**
-dontwarn io.flutter.**
-dontwarn androidx.annotation.**
-dontwarn javax.annotation.**
-dontwarn org.codehaus.mojo.animal_sniffer.**
-dontwarn kotlinx.coroutines.**
-dontwarn androidx.sqlite.**
-dontwarn com.caverock.androidsvg.**

# ------------------------------------------------------------------------------
# 8. Java Security & Cryptography / Keystore Provider Rules
# ------------------------------------------------------------------------------
# Preserve Java Security Providers and KeyStore factories for 256-bit EC (P-256)
-keep class java.security.** { *; }
-keep class javax.crypto.** { *; }
-keep class sun.security.** { *; }
-keep class org.bouncycastle.** { *; }

