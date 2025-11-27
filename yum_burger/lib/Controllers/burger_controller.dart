import 'package:yum_burger/Models/burger_model.dart';
class BurgerController {
  Future<bool> addBurger(String name, String description, double price, String image) async {
    if (image.isEmpty) {
      image = "https://via.placeholder.com/150";
    }

    if (name.isNotEmpty && description.isNotEmpty && price > 0 && image.isNotEmpty) {
      if (await burgerNameExists(name)) {
        return false;
      } else {
        await addBurgerToDB(name, description, price, image);
        return true;
      }
    }

    return false;
  }

  Future<List<Map<String, dynamic>>> getBurgers() async {
    return getBurgersFromDB();
  }

}



// Saving this for later


// final result = await BurgerController().addBurger(
// "Veggie Burger",
// "Delicious burger",
// 10.25,
// "assets/images/hamburger3.jpg",
// );
// if (result) {
// ScaffoldMessenger.of(
// context,
// ).showSnackBar(SnackBar(content: Text('burger added')));
// } else {
// ScaffoldMessenger.of(
// context,
// ).showSnackBar(SnackBar(content: Text('burger not added')));
// }