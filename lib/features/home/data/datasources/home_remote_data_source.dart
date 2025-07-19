import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reco_restaurant/features/home/data/models/item_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ItemModel>> getItems();
}

class FirebaseHomeRemoteDataSource implements HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseHomeRemoteDataSource(this.firestore);

  @override
  Future<List<ItemModel>> getItems() async {
    try {
      final querySnapshot = await firestore.collection('items').get();
      return querySnapshot.docs
          .map((doc) => ItemModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get items: $e');
    }
  }
}
