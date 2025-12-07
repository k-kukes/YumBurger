import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Models/burger_model.dart';
import 'package:yum_burger/Models/cart_model.dart';
import 'package:yum_burger/Models/user_model.dart';

class CartController {
  CartModel cartModel = new CartModel();
  UserModel userModel = new UserModel();
  BurgerModel burgerModel = new BurgerModel();

  Future<String> addToCart(item, itemType) async {
    var currentUser = userModel.getCurrentUser();
    if (currentUser != null && item != null) {
      try {
        bool itemExists = await cartModel.itemExistsInCart(
          currentUser.id,
          item.id,
        );
        if (itemExists) {
          await cartModel.addExitingItemToCart(
            currentUser.id,
            await cartModel.getItemFromCart(currentUser.id, item.id),
          );
        } else {
          await cartModel.addItemToCartDB(currentUser.id, item.id, itemType);
        }
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

  Future<CollectionReference<Object?>?> getUserCartCollection(userId) async {
    CollectionReference<Object?> cart = cartModel.getUserCartFromDB(userId);
    return await isCartEmpty(cart) ? null : cart;
  }

  Future<bool> isCartEmpty(CollectionReference<Object?> cart) async {
    return cartModel.checkEmptyCart(cart);
  }

  Future<int> getCartLength(CollectionReference<Object?> cart) async {
    return cartModel.getCartLength(cart);
  }

  Future<double> getSubtotal(CollectionReference<Object?> cart, userId) async {
    return cartModel.getSubtotal(cart, userId);
  }

  Future<double> getTax(CollectionReference<Object?> cart, userId) async {
    return cartModel.getTax(cart, userId);
  }

  Future<double> getTotal(CollectionReference<Object?> cart, userId) async {
    return cartModel.getTotal(cart, userId);
  }

  Future<void> addQuantityToCartItem(userId, cartId) async {
    await cartModel.addQuantityToItem(userId, cartId);
  }

  Future<void> decreaseQuantityToCartItem(userId, cartId) async {
    await cartModel.decreaseQuantity(userId, cartId);
  }

  Future<void> deleteCartItem(userId, cartId) async {
    await cartModel.deleteCartItem(userId, cartId);
  }

  Future<void> deleteEntireCart(String userId) async {
    if (userModel.getCurrentUser() != null || userId.isNotEmpty) {
      cartModel.deleteEntireCart(userId);
    }
  }
}
