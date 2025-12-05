import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Controllers/user_controller.dart';
import '../models/reward_model.dart';
import '../controllers/reward_controller.dart';

class RewardsView extends StatelessWidget {
  final RewardsController _controller = RewardsController();
  final UserController _userController = UserController();

  RewardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = _userController.getCurrentUser();

    if (user == null) {
      return const Center(
        child: Text("Please log in to view your rewards."),
      );
    }

    final String username = user.id;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').doc(username).snapshots(),
      builder: (context, snapshot) {

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text("User data not found."));
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>?;

        int currentPoints = userData != null && userData.containsKey('currentPoints')
            ? userData['currentPoints']
            : 0;

        Rewards nextTier = Rewards.tiers.firstWhere(
              (tier) => tier.cost > currentPoints,
          orElse: () => Rewards.tiers.last,
        );

        double progress = (currentPoints / nextTier.cost).clamp(0.0, 1.0);

        if (currentPoints >= Rewards.tiers.last.cost) {
          progress = 1.0;
        }

        return Card(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Rewards",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                    "Current Points: $currentPoints",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                    )
                ),
                const SizedBox(height: 10),
                Text("Next Reward: ${nextTier.title} (${nextTier.cost} pts)"),
                const SizedBox(height: 5),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.blue,
                  minHeight: 10,
                ),
                const SizedBox(height: 5),
                Text(
                  currentPoints >= nextTier.cost
                      ? "You have enough points!"
                      : "Spend \$${(nextTier.cost - currentPoints) * 10} more to unlock!",
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
                const SizedBox(height: 20),
                if (currentPoints >= 50)
                  ElevatedButton(
                    onPressed: () async {
                      bool success = await _controller.redeemReward(username, 50);
                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Reward Redeemed!")),
                        );
                      } else if (!success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Not enough points or error occurred.")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Redeem Free Drink (50 pts)"),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}