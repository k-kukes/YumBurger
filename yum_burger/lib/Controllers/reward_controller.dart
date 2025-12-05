import 'package:cloud_firestore/cloud_firestore.dart';

class RewardsController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> redeemReward(String userDocId, int cost) async {
    DocumentReference userRef = _db.collection('users').doc(userDocId);

    try {
      return await _db.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userRef);

        if (!snapshot.exists) {
          throw Exception("User document '$userDocId' does not exist");
        }

        // Get current points safely
        var data = snapshot.data() as Map<String, dynamic>;
        int currentPoints = data['currentPoints'] ?? 0;

        if (currentPoints < cost) {
          return false; // Not enough points
        }

        // Deduct points
        int newBalance = currentPoints - cost;
        transaction.update(userRef, {'currentPoints': newBalance});

        return true; // Success
      });
    } catch (e) {
      print("Error redeeming reward: $e");
      return false;
    }
  }
}