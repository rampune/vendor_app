//plugins {
//    id("com.android.application")
//    id("kotlin-android")
//    id("com.google.gms.google-services")
//    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
//    id("dev.flutter.flutter-gradle-plugin")
//}
//
//android {
//    namespace = "com.pubup.new_pubup_partner"
//    compileSdk = flutter.compileSdkVersion
////    ndkVersion = flutter.ndkVersion
//    ndkVersion = "27.0.12077973"
//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_11
//        targetCompatibility = JavaVersion.VERSION_11
//    }
//
//    kotlinOptions {
//        jvmTarget = JavaVersion.VERSION_11.toString()
//    }
//
//    defaultConfig {
//        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//        applicationId = "com.pubup.new_pubup_partner"
//        // You can update the following values to match your application needs.
//        // For more information, see: https://flutter.dev/to/review-gradle-config.
//        minSdkVersion = flutter.minSdkVersion
//        targetSdk = flutter.targetSdkVersion
//        versionCode = flutter.versionCode
//        versionName = flutter.versionName
//    }
//
//    buildTypes {
//        release {
//            // TODO: Add your own signing config for the release build.
//            // Signing with the debug keys for now, so `flutter run --release` works.
//            signingConfig = signingConfigs.getByName("debug")
//        }
//    }
//}
//
//flutter {
//    source = "../.."
//}
//dependencies {
//    implementation(platform("com.google.firebase:firebase-bom:33.16.0"))
//    implementation("com.google.firebase:firebase-analytics")
//}





plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.pubup.new_pubup_partner"
    compileSdk = 36 // Already set to 36 to support other plugins
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.pubup.new_pubup_partner"
        minSdkVersion(24) // Updated to 24 for geolocator_android
        targetSdkVersion(36) // Consistent with compileSdk
        versionCode = findProperty("flutter.versionCode")?.toString()?.toInt() ?: 1
        versionName = findProperty("flutter.versionName")?.toString() ?: "1.0"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.2.0"))
    implementation("com.google.firebase:firebase-analytics")
}