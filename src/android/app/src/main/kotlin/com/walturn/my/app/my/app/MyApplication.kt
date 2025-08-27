package com.walturn.my_app.my_app

import androidx.multidex.MultiDexApplication

/**
 * Custom Application class that extends MultiDexApplication to support multidex.
 * 
 * This is required for applications with a large number of methods (>65K),
 * which is common when using libraries like Firebase.
 * 
 * When enabling Firebase:
 * 1. Make sure to uncomment Firebase dependencies in pubspec.yaml
 * 2. Uncomment Firebase initialization in bootstrap.dart
 * 3. Add google-services.json to android/app/
 * 4. Uncomment the Google Services plugin in build.gradle files
 */
class MyApplication : MultiDexApplication() {
    override fun onCreate() {
        super.onCreate()
        // Initialize any app-wide configurations here if needed
        
        // Firebase-specific initializations would go here when Firebase is enabled
    }
}
