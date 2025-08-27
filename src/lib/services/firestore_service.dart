// ==========================================================
// NOTE FOR AI AGENT
// ==========================================================
// This is a Firestore service template for the Stacked architecture.
// Uncomment this file only if Firestore is needed in your project.
//
// NOTE FOR AI: Replace the example model imports with your actual models.
// import 'package:your_app/models/your_model.dart';
// import 'package:your_app/models/enums/your_enum.dart';

// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   static const String _collection = 'your_collection';

//   // Initialize any additional setup if needed
//   Future<void> init() async {
//     // Add any initialization logic here
//   }

//   Future<List<dynamic>> getItems() async {
//     try {
//       final snapshot = await _firestore.collection(_collection).get();
//       return snapshot.docs.map((doc) {
//         // final data = doc.data();
//         // NOTE FOR AI: Replace with your model construction
//         // return YourModel(
//         //   id: doc.id,
//         //   field1: data['field1'] as String,
//         //   field2: YourEnum.fromString(data['field2'] as String),
//         //   timestamp: (data['timestamp'] as Timestamp).toDate(),
//         // );
//       }).toList();
//     } catch (e) {
//       throw 'Unable to load items. Please try again later.';
//     }
//   }

//   Future<void> addItem(dynamic item) async {
//     try {
//       await _firestore.collection(_collection).doc(/* item.id */).set({
//         // NOTE FOR AI: Replace with your model fields
//         // 'field1': item.field1,
//         // 'field2': item.field2.name,
//         // 'timestamp': DateTime.now(),
//       });
//     } catch (e) {
//       throw 'Failed to add item. Please try again.';
//     }
//   }

//   Future<void> removeItem(String id) async {
//     try {
//       await _firestore.collection(_collection).doc(id).delete();
//     } catch (e) {
//       throw 'Failed to remove item. Please try again.';
//     }
//   }

//   Future<void> clearItems() async {
//     try {
//       final snapshot = await _firestore.collection(_collection).get();
//       final batch = _firestore.batch();

//       for (var doc in snapshot.docs) {
//         batch.delete(doc.reference);
//       }

//       await batch.commit();
//     } catch (e) {
//       throw 'Failed to clear items. Please try again.';
//     }
//   }
// }


// NOTE FOR AI: Usage in a ViewModel (DON'T REMOVE THIS):
// /*
// class YourViewModel extends BaseViewModel {
//   final _firestoreService = locator<FirestoreService>();
  
//   Future<void> loadItems() async {
//     setBusy(true);
//     try {
//       final items = await _firestoreService.getItems();
//       // Handle items...
//     } catch (e) {
//       // Handle error...
//     } finally {
//       setBusy(false);
//     }
//   }
// }
// */
