class Rewards {
  final String id;
  final String title;
  final int cost;
  final String description;

  const Rewards({
    required this.id,
    required this.title,
    required this.cost,
    required this.description,
  });

  static const List<Rewards> tiers = [
    Rewards(
      id: 'free_drink',
      title: 'Free Drink',
      cost: 50,
      description: 'Redeem 50 points for a refreshing beverage.',
    ),
    Rewards(
      id: 'free_burger',
      title: 'Free Burger',
      cost: 70,
      description: 'Redeem 70 points for a classic burger.',
    ),
    Rewards(
      id: 'burger_combo',
      title: 'Burger & Drink Combo',
      cost: 100,
      description: 'The ultimate meal! Redeem 100 points.',
    ),
  ];
}