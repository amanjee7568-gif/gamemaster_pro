// ==========================================================
// NOTE FOR AI AGENT
// ==========================================================
// This is a template for integrating Firebase Authentication
// using the Stacked architecture.
// Uncomment this file only if authentication is required.

// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseAuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;


//   // Get current user
//   User? get currentUser => _auth.currentUser;

//   // Stream of auth state changes
//   Stream<User?> get authStateChanges => _auth.authStateChanges();

//   // Sign in with email and password
//   Future<UserCredential> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       return await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } catch (e) {
//       throw _handleAuthError(e);
//     }
//   }

//   // Create account with email and password
//   Future<UserCredential> createAccountWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       return await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } catch (e) {
//       throw _handleAuthError(e);
//     }
//   }

//   // Sign out
//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       throw _handleAuthError(e);
//     }
//   }

//   // Reset password
//   Future<void> resetPassword(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } catch (e) {
//       throw _handleAuthError(e);
//     }
//   }

//   // Update profile
//   Future<void> updateProfile({String? displayName, String? photoURL}) async {
//     try {
//       await _auth.currentUser?.updateDisplayName(displayName);
//       await _auth.currentUser?.updatePhotoURL(photoURL);
//     } catch (e) {
//       throw _handleAuthError(e);
//     }
//   }

//   // Update password
//   Future<void> updatePassword(String newPassword) async {
//     try {
//       await _auth.currentUser?.updatePassword(newPassword);
//     } catch (e) {
//       throw _handleAuthError(e);
//     }
//   }

//   // Delete account
//   Future<void> deleteAccount() async {
//     try {
//       await _auth.currentUser?.delete();
//     } catch (e) {
//       throw _handleAuthError(e);
//     }
//   }

//   // Verify email
//   Future<void> sendEmailVerification() async {
//     try {
//       await _auth.currentUser?.sendEmailVerification();
//     } catch (e) {
//       throw _handleAuthError(e);
//     }
//   }

//   // Re-authenticate user (required for sensitive operations)
//   Future<UserCredential> reauthenticateUser(String password) async {
//     try {
//       final user = _auth.currentUser;
//       if (user == null || user.email == null) throw 'User not found';

//       final credential = EmailAuthProvider.credential(
//         email: user.email!,
//         password: password,
//       );

//       return await user.reauthenticateWithCredential(credential);
//     } catch (e) {
//       throw _handleAuthError(e);
//     }
//   }

//   // Error handling
//   String _handleAuthError(dynamic e) {
//     if (e is FirebaseAuthException) {
//       switch (e.code) {
//         case 'user-not-found':
//           return 'No user found with this email.';
//         case 'wrong-password':
//           return 'Wrong password provided.';
//         case 'user-disabled':
//           return 'This user account has been disabled.';
//         case 'email-already-in-use':
//           return 'An account already exists with this email.';
//         case 'invalid-email':
//           return 'Invalid email address.';
//         case 'weak-password':
//           return 'The password provided is too weak.';
//         case 'operation-not-allowed':
//           return 'This operation is not allowed.';
//         case 'requires-recent-login':
//           return 'Please log in again to perform this operation.';
//         default:
//           return 'Authentication error: ${e.message}';
//       }
//     }
//     return 'An error occurred. Please try again.';
//   }
// }


// // NOTE FOR AI: Usage in a ViewModel:
// /*
// class AuthViewModel extends BaseViewModel {
//   final _authService = locator<FirebaseAuthService>();
  
//   Future<void> login(String email, String password) async {
//     setBusy(true);
//     try {
//       await _authService.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       // Handle successful login...
//     } catch (e) {
//       // Handle error...
//     } finally {
//       setBusy(false);
//     }
//   }

//   // Listen to auth state changes
//   void setupAuthListener() {
//     _authService.authStateChanges.listen((user) {
//       // Handle auth state changes...
//     });
//   }
// }
// */
