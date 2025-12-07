import 'package:cloud_firestore/cloud_firestore.dart';

class RewardsController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addPointsAfterCheckout(String userDocId, double checkoutTotal) async {
    int pointsEarned = (checkoutTotal * 0.10).floor();

    if (pointsEarned <= 0) return;

    DocumentReference userRef = _db.collection('Users').doc(userDocId);

    try {
      await userRef.update({
        'currentPoints': FieldValue.increment(pointsEarned),
      });
      print("Added $pointsEarned points to user $userDocId");
    } catch (e) {
      print("Error adding points: $e");
    }
  }

  Future<bool> redeemReward(String userDocId, int cost) async {
    DocumentReference userRef = _db.collection('Users').doc(userDocId);

    try {
      return await _db.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userRef);

        if (!snapshot.exists) {
          throw Exception("User document '$userDocId' does not exist");
        }

        var data = snapshot.data() as Map<String, dynamic>;
        int currentPoints = data['currentPoints'] ?? 0;

        if (currentPoints < cost) {
          return false;
        }

        int newBalance = currentPoints - cost;
        transaction.update(userRef, {'currentPoints': newBalance});

        return true;
      });
    } catch (e) {
      print("Error redeeming reward: $e");
      return false;
    }
  }
}