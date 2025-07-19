import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reco_restaurant/features/cart/data/models/cart_mode.dart';
import 'package:reco_restaurant/features/home/data/models/item_model.dart';

abstract class CartRemoteDataSource {
  Future<void> addItemToCart(ItemModel item, String userId);
  Future<void> removeItemFromCart(ItemModel item, String userId);
  Future<void> clearItemFromCart(ItemModel item, String userId);
  Future<CartModel> getCart(String userId);
}

class FirebaseCartRemoteDataSource implements CartRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseCartRemoteDataSource(this.firestore);

  @override
  Future<void> addItemToCart(ItemModel item, String userId) async {
    try {
      final cartDocRef = firestore.collection('cart').doc(userId);
      final cartDoc = await cartDocRef.get();
      List<dynamic> items = [];
      if (cartDoc.exists) {
        items = List.from(cartDoc.data()?['items'] ?? []);
      }
      int index = items.indexWhere((i) => i['id'] == item.id);
      if (index != -1) {
        items[index]['quantity_in_cart'] =
            (items[index]['quantity_in_cart'] ?? 1) + 1;
        items[index]['is_in_cart'] = true;
      } else {
        final newItem = {
          ...item.toJson(),
          'quantity_in_cart': 1,
          'is_in_cart': true,
        };
        items.add(newItem);
      }
      double totalPrice = 0.0;
      double totalItems = 0.0;
      for (final i in items) {
        totalPrice += (i['price'] ?? 0.0) * (i['quantity_in_cart'] ?? 0);
        totalItems += (i['quantity_in_cart'] ?? 0);
      }
      await cartDocRef.set({
        'items': items,
        'user_id': userId,
        'totalPrice': totalPrice,
        'totalItems': totalItems,
      });
    } catch (e) {
      throw Exception('Failed to add item to cart: $e');
    }
  }

  @override
  Future<void> removeItemFromCart(ItemModel item, String userId) async {
    try {
      final cartDocRef = firestore.collection('cart').doc(userId);
      final cartDoc = await cartDocRef.get();
      if (!cartDoc.exists) return;
      List<dynamic> items = List.from(cartDoc.data()?['items'] ?? []);
      int index = items.indexWhere((i) => i['id'] == item.id);
      if (index != -1) {
        int currentQuantity = items[index]['quantity_in_cart'] ?? 1;
        if (currentQuantity <= 1) {
          items.removeAt(index);
        } else {
          items[index]['quantity_in_cart'] = currentQuantity - 1;
        }
        double totalPrice = 0.0;
        double totalItems = 0.0;
        for (final i in items) {
          totalPrice += (i['price'] ?? 0.0) * (i['quantity_in_cart'] ?? 0);
          totalItems += (i['quantity_in_cart'] ?? 0);
        }
        await cartDocRef.set({
          'items': items,
          'user_id': userId,
          'totalPrice': totalPrice,
          'totalItems': totalItems,
        });
      }
    } catch (e) {
      throw Exception('Failed to remove item from cart: $e');
    }
  }

  @override
  Future<CartModel> getCart(String userId) async {
    try {
      final cartDoc = await firestore.collection('cart').doc(userId).get();
      List<ItemModel> cartItems = [];
      if (cartDoc.exists) {
        final items = List.from(cartDoc.data()?['items'] ?? []);
        cartItems = items
            .map((data) => ItemModel.fromJson(Map<String, dynamic>.from(data)))
            .toList();
      }
      double totalPrice = 0.0;
      double totalItems = 0.0;
      for (final item in cartItems) {
        totalPrice += item.price * item.quantityInCart;
        totalItems += item.quantityInCart;
      }
      return CartModel(
        userId: userId,
        items: cartItems,
        totalPrice: totalPrice,
        totalItems: totalItems,
      );
    } catch (e) {
      throw Exception('Failed to get cart: $e');
    }
  }

  @override
  Future<void> clearItemFromCart(ItemModel item, String userId) async {
    try {
      final cartDocRef = firestore.collection('cart').doc(userId);
      final cartDoc = await cartDocRef.get();
      if (!cartDoc.exists) return;
      List<dynamic> items = List.from(cartDoc.data()?['items'] ?? []);
      items.removeWhere((i) => i['id'] == item.id);
      double totalPrice = 0.0;
      double totalItems = 0.0;
      for (final i in items) {
        totalPrice += (i['price'] ?? 0.0) * (i['quantity_in_cart'] ?? 0);
        totalItems += (i['quantity_in_cart'] ?? 0);
      }
      await cartDocRef.set({
        'items': items,
        'user_id': userId,
        'totalPrice': totalPrice,
        'totalItems': totalItems,
      });
    } catch (e) {
      throw Exception('Failed to clear item from cart: $e');
    }
  }
}
