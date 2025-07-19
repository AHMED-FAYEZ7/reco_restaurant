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

  Future<Map<String, dynamic>> _getCartDocData(String userId) async {
    final cartDocRef = firestore.collection('cart').doc(userId);
    final cartDoc = await cartDocRef.get();
    return cartDoc.exists ? cartDoc.data() ?? {} : {};
  }

  Map<String, double> _calculateTotals(List<dynamic> items) {
    double totalPrice = 0.0;
    double totalItems = 0.0;
    for (final i in items) {
      totalPrice += (i['price'] ?? 0.0) * (i['quantity_in_cart'] ?? 0);
      totalItems += (i['quantity_in_cart'] ?? 0);
    }
    return {'totalPrice': totalPrice, 'totalItems': totalItems};
  }

  Future<void> _updateCartDoc(String userId, List<dynamic> items) async {
    final totals = _calculateTotals(items);
    await firestore.collection('cart').doc(userId).set({
      'items': items,
      'user_id': userId,
      'totalPrice': totals['totalPrice'],
      'totalItems': totals['totalItems'],
    });
  }

  @override
  Future<void> addItemToCart(ItemModel item, String userId) async {
    try {
      final data = await _getCartDocData(userId);
      List<dynamic> items = List.from(data['items'] ?? []);
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
      await _updateCartDoc(userId, items);
    } catch (e) {
      throw Exception('Failed to add item to cart: $e');
    }
  }

  @override
  Future<void> removeItemFromCart(ItemModel item, String userId) async {
    try {
      final data = await _getCartDocData(userId);
      if (data.isEmpty) return;
      List<dynamic> items = List.from(data['items'] ?? []);
      int index = items.indexWhere((i) => i['id'] == item.id);
      if (index != -1) {
        int currentQuantity = items[index]['quantity_in_cart'] ?? 1;
        if (currentQuantity <= 1) {
          items.removeAt(index);
        } else {
          items[index]['quantity_in_cart'] = currentQuantity - 1;
        }
        await _updateCartDoc(userId, items);
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
      final totals = _calculateTotals(
        cartItems.map((e) => e.toJson()).toList(),
      );
      return CartModel(
        userId: userId,
        items: cartItems,
        totalPrice: totals['totalPrice']!,
        totalItems: totals['totalItems']!,
      );
    } catch (e) {
      throw Exception('Failed to get cart: $e');
    }
  }

  @override
  Future<void> clearItemFromCart(ItemModel item, String userId) async {
    try {
      final data = await _getCartDocData(userId);
      if (data.isEmpty) return;
      List<dynamic> items = List.from(data['items'] ?? []);
      items.removeWhere((i) => i['id'] == item.id);
      await _updateCartDoc(userId, items);
    } catch (e) {
      throw Exception('Failed to clear item from cart: $e');
    }
  }
}
