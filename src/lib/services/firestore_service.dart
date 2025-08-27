import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User collection
  static const String _usersCollection = 'users';

  // Games collection
  static const String _gamesCollection = 'games';

  // Payments collection
  static const String _paymentsCollection = 'payments';

  // Initialize any additional setup if needed
  Future<void> init() async {
    // Add any initialization logic here
  }

  // User Management Methods
  Future<void> createUser(String uid, Map<String, dynamic> userData) async {
    try {
      await _firestore.collection(_usersCollection).doc(uid).set(userData);
    } catch (e) {
      throw 'Failed to create user. Please try again.';
    }
  }

  Future<Map<String, dynamic>?> getUser(String uid) async {
    try {
      final doc = await _firestore.collection(_usersCollection).doc(uid).get();
      return doc.data();
    } catch (e) {
      throw 'Unable to load user data. Please try again later.';
    }
  }

  Future<void> updateUser(String uid, Map<String, dynamic> userData) async {
    try {
      await _firestore.collection(_usersCollection).doc(uid).update(userData);
    } catch (e) {
      throw 'Failed to update user. Please try again.';
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      await _firestore.collection(_usersCollection).doc(uid).delete();
    } catch (e) {
      throw 'Failed to delete user. Please try again.';
    }
  }

  // Game Management Methods
  Future<List<Map<String, dynamic>>> getGames() async {
    try {
      final snapshot = await _firestore.collection(_gamesCollection).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw 'Unable to load games. Please try again later.';
    }
  }

  Future<void> addGame(Map<String, dynamic> gameData) async {
    try {
      await _firestore.collection(_gamesCollection).add(gameData);
    } catch (e) {
      throw 'Failed to add game. Please try again.';
    }
  }

  Future<void> updateGame(String gameId, Map<String, dynamic> gameData) async {
    try {
      await _firestore
          .collection(_gamesCollection)
          .doc(gameId)
          .update(gameData);
    } catch (e) {
      throw 'Failed to update game. Please try again.';
    }
  }

  Future<void> deleteGame(String gameId) async {
    try {
      await _firestore.collection(_gamesCollection).doc(gameId).delete();
    } catch (e) {
      throw 'Failed to delete game. Please try again.';
    }
  }

  // Payment Methods
  Future<List<Map<String, dynamic>>> getPaymentHistory(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_paymentsCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw 'Unable to load payment history. Please try again later.';
    }
  }

  Future<void> addPayment(Map<String, dynamic> paymentData) async {
    try {
      await _firestore.collection(_paymentsCollection).add(paymentData);
    } catch (e) {
      throw 'Failed to record payment. Please try again.';
    }
  }
}
