# ==============================================================================
# Comprehensive Production ProGuard / R8 Rules for Impulse DEX
# Tech Stack: Flutter + Drift SQLite + Freezed + Riverpod + Native Plugins
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Flutter Engine & Core Framework Embedding Rules
# ------------------------------------------------------------------------------
-keep class io.flutter.** { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.provider.** { *; }
-keep class io.flutter.plugins.** { *; }

# Preserve native C/C++ methods and JNI symbol bindings
-keepclasseswithmembernames class * {
    native <methods>;
}

# Preserve attributes critical for reflection, annotations, serialization, and crash report symbolication
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod,Exceptions,SourceFile,LineNumberTable

# ------------------------------------------------------------------------------
# 2. SQLite3 Native Libraries & Drift Database Rules
# ------------------------------------------------------------------------------
# Preserve sqlite3 native library bindings & C-entrypoints
-keep class io.simonbinder.sqlite3.** { *; }
-keep class com.simonbinder.sqlite3.** { *; }
-keep class org.sqlite.** { *; }
-keep class sqlite3.** { *; }

# Keep all Drift database models, generated tables, DAOs, and queries
-keep class * extends io.simonbinder.drift.** { *; }
-keep class * extends sqlite3.** { *; }
-keepclassmembers class * extends io.simonbinder.drift.GeneratedDatabase { *; }
-keepclassmembers class * extends io.simonbinder.drift.DatabaseAccessor { *; }

# ------------------------------------------------------------------------------
# 3. Freezed, JSON Serialization & Data Models Rules
# ------------------------------------------------------------------------------
# Keep annotations & serialized field names
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
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
# 4. Flutter Plugins ProGuard Rules
# ------------------------------------------------------------------------------
# flutter_contacts (Android ContactsContract API)
-keep class co.coer.flutter_contacts.** { *; }
-keep class com.coer.flutter_contacts.** { *; }
-keep class android.provider.ContactsContract** { *; }

# url_launcher & intent resolvers
-keep class io.flutter.plugins.urllauncher.** { *; }

# share_plus & Android file sharing providers
-keep class dev.fluttercommunity.plus.share.** { *; }

# path_provider & local storage path resolvers
-keep class io.flutter.plugins.pathprovider.** { *; }

# flutter_native_splash
-keep class net.jonhanson.flutter_native_splash.** { *; }

# ------------------------------------------------------------------------------
# 5. AndroidX & Jetpack Lifecycle Rules
# ------------------------------------------------------------------------------
-keep class * extends androidx.lifecycle.ViewModel { *; }
-keep class * extends androidx.lifecycle.AndroidViewModel { *; }

# ------------------------------------------------------------------------------
# 6. R8 Warning Suppressions for Third-Party Dependencies
# ------------------------------------------------------------------------------
-dontwarn com.google.android.play.core.**
-dontwarn io.flutter.embedding.engine.deferredcomponents.**
-dontwarn io.flutter.embedding.handshake.**
-dontwarn androidx.annotation.**
-dontwarn javax.annotation.**
-dontwarn org.codehaus.mojo.animal_sniffer.**

