import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtim_test/models/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem(this.product, this.quantity);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    final existingItemIndex = state.indexWhere(
      (item) => item.product == product,
    );
    if (existingItemIndex != -1) {
      state = List.from(state)
        ..[existingItemIndex] = CartItem(
          product,
          state[existingItemIndex].quantity + 1,
        );
    } else {
      state = List.from(state)..add(CartItem(product, 1));
    }
  }

  void removeFromCart(Product product) {
    state = List.from(state)..removeWhere((item) => item.product == product);
  }
}
