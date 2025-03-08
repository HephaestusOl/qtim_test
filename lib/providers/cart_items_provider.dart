import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtim_test/database/database.dart';
import 'package:qtim_test/providers/database_provider.dart';

final cartItemsProvider = FutureProvider<List<CartItem>>((ref) {
  final db = ref.read(databaseProvider);
  return db.getCartItems();
});
