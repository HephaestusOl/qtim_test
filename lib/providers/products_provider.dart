import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtim_test/models/product.dart';
import 'package:flutter/services.dart' show rootBundle;

final productsProvider = FutureProvider((ref) async {
  final jsonString = await rootBundle.loadString('assets/products.json');
  final jsonList = jsonDecode(jsonString) as List;
  return jsonList.map((json) => Product.fromJson(json)).toList();
});
