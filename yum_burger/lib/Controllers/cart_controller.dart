import 'package:yum_burger/Models/burger_model.dart';
import 'package:yum_burger/Models/cart_model.dart';
import 'package:yum_burger/Models/user_model.dart';

class CartController {
  CartModel cartModel = new CartModel();
  UserModel userModel = new UserModel();
  BurgerModel burgerModel = new BurgerModel();

  String addToCart(burger) {
    var currentUser = userModel.getCurrentUser();
    if (currentUser != null && burger != null) {
      var users = userModel.getUsers();
      var burgers = burgerModel.getBurgersFromDB();
      try {
        cartModel.addBurgerToCartDB(currentUser.id, burger.id, users, burgers);
      } catch (error) {
        return 'Error while adding to cart!';
      }
      return 'Successfully added item to cart!';
    }

    if (currentUser == null) {
      return 'You must log in to add to cart';
    }

    return 'Error while adding to cart!';
  }
}