import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtim_test/models/category.dart';

final categoriesProvider = FutureProvider((ref) async {
  final jsonString = await rootBundle.loadString('assets/categories.json');
  final jsonList = jsonDecode(jsonString) as List;
  return jsonList.map((json) => Category.fromJson(json)).toList();
});
