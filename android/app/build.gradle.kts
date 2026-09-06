import java.io.FileInputStream
import java.util.Properties

val keystoreProperties = Properties()
val keyPropertiesFile = rootProject.file("key.properties")
val appKeyPropertiesFile = file("key.properties")
val keystorePropertiesFile = if (keyPropertiesFile.exists()) keyPropertiesFile else if (appKeyPropertiesFile.exists()) appKeyPropertiesFile else null
if (keystorePropertiesFile != null && keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.impulseagriscienceltd.impulse_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.impulseagriscienceltd.impulse_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    val alias = (keystoreProperties.getProperty("keyAlias") ?: keystoreProperties["keyAlias"] as String?)?.trim()
    val keyPass = (keystoreProperties.getProperty("keyPassword") ?: keystoreProperties["keyPassword"] as String?)?.trim()
    val storePass = (keystoreProperties.getProperty("storePassword") ?: keystoreProperties["storePassword"] as String?)?.trim()
    val storeFileProp = (keystoreProperties.getProperty("storeFile") ?: keystoreProperties["storeFile"] as String?)?.trim()

    val candidateFiles = mutableListOf<java.io.File>()
    if (storeFileProp != null) {
        candidateFiles.add(file(storeFileProp))
        candidateFiles.add(rootProject.file(storeFileProp))
    }
    candidateFiles.add(file("upload-keystore.jks"))
    candidateFiles.add(rootProject.file("upload-keystore.jks"))
    candidateFiles.add(file("key.p12"))
    candidateFiles.add(rootProject.file("key.p12"))

    val sFile = candidateFiles.firstOrNull { it.exists() }
    val hasReleaseSigning = keystorePropertiesFile != null &&
        sFile != null && sFile.exists() &&
        !alias.isNullOrEmpty() &&
        !keyPass.isNullOrEmpty() &&
        !storePass.isNullOrEmpty()

    signingConfigs {
        if (hasReleaseSigning) {
            create("release") {
                keyAlias = alias!!
                keyPassword = keyPass!!
                storeFile = sFile!!
                storePassword = storePass!!
                enableV1Signing = true
                enableV2Signing = true
                enableV3Signing = true
                enableV4Signing = true
            }
        }
    }

    buildTypes {
        release {
            val relSigning = signingConfigs.findByName("release")
            if (relSigning != null) {
                signingConfig = relSigning
            } else {
                throw GradleException(
                    "CRITICAL RELEASE SIGNING FAILURE: Cannot build release binary without valid signing config!\n" +
                    "keystorePropertiesFile: ${keystorePropertiesFile?.absolutePath} (exists: ${keystorePropertiesFile?.exists()})\n" +
                    "keystore candidate resolved: ${sFile?.absolutePath} (exists: ${sFile?.exists()})\n" +
                    "keyAlias present: ${!alias.isNullOrEmpty()}\n" +
                    "keyPassword present: ${!keyPass.isNullOrEmpty()}\n" +
                    "storePassword present: ${!storePass.isNullOrEmpty()}\n" +
                    "keys found in properties: ${keystoreProperties.keys}"
                )
            }
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }

    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
        jniLibs {
            useLegacyPackaging = false
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
