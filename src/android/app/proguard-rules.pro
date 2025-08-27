# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class io.flutter.plugin.editing.** { *; }

# ======================================================
# Firebase Configuration - Uncomment when using Firebase
# ======================================================
# When enabling Firebase:
# 1. Uncomment the Firebase dependencies in pubspec.yaml
# 2. Uncomment Firebase initialization in bootstrap.dart
# 3. Add google-services.json to android/app/
# 4. Uncomment the Google Services plugin in build.gradle files
# 5. Uncomment the rules below

# # Firebase
# -keep class com.google.firebase.** { *; }
# -keep class com.google.android.gms.** { *; }
# -dontwarn com.google.firebase.**
# -dontwarn com.google.android.gms.**
# 
# # Firestore
# -keep class com.google.cloud.** { *; }
# -keep class com.google.firebase.firestore.** { *; }
# -dontwarn com.google.cloud.**
# -dontwarn com.google.firebase.firestore.**

# Kotlin
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }

# Keep custom model classes
-keep class com.walturn.my_app.my_app.models.** { *; }
