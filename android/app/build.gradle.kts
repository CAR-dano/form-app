import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

val keyPropertiesFile = rootProject.file("key.properties")
val keyProperties = Properties()
if (keyPropertiesFile.exists()) {
    //println("SUCCESS: key.properties file found.")
    try {
        keyProperties.load(FileInputStream(keyPropertiesFile))
    } catch (e: Exception) {
        println("ERROR: Failed to load key.properties file: $e")
    }
}
//if (gradle.startParameter.taskNames.any { it.contains("Debug") }) {
//    println("--- Keystore Debug ---")
//    println("Looking for properties file at: ${keyPropertiesFile.absolutePath}")
//    if (keyPropertiesFile.exists()) {
//        println("SUCCESS: key.properties file found.")
//        try {
//            keyProperties.load(FileInputStream(keyPropertiesFile))
//            println("Properties loaded: $keyProperties")
//        } catch (e: Exception) {
//            println("ERROR: Failed to load key.properties file: $e")
//        }
//    } else {
//        println("ERROR: key.properties file does NOT exist at the specified path.")
//    }
//    println("----------------------")
//}

android {
    namespace = "com.cardano.palapainspeksi"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.13113456"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    signingConfigs {
        create("release") {
            keyAlias = keyProperties.getProperty("keyAlias")
            keyPassword = keyProperties.getProperty("keyPassword")
            storePassword = keyProperties.getProperty("storePassword")
            
            val storeFilePath = keyProperties.getProperty("storeFile")
            if (storeFilePath != null) {
                val resolvedStoreFile = rootProject.file(storeFilePath)
                if (gradle.startParameter.taskNames.any { it.contains("Debug") }) {
                    println("--- Keystore File Path Debug ---")
                    //println("Path from properties: '$storeFilePath'")
                    //println("Resolved absolute path: '${resolvedStoreFile.absolutePath}'")
                    println("Does the resolved file exist? ${resolvedStoreFile.exists()}")
                    println("------------------------------")
                }
                storeFile = resolvedStoreFile // Use the resolved file
            }
        }
    }

    defaultConfig {
        // Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.cardano.palapainspeksi"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 29
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // This tells the release build to use your new signing configuration
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
