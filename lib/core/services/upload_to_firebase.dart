import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> importItemsToFirestore() async {
  final String data = await rootBundle.loadString('assets/items.json');
  final Map<String, dynamic> jsonData = json.decode(data);
  final Map<String, dynamic> items = jsonData['items'];

  final collection = FirebaseFirestore.instance.collection('items');

  for (var entry in items.entries) {
    await collection.doc(entry.key).set(entry.value);
  }

  print('✅ Items uploaded successfully!');
}
