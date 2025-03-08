import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qtim_test/providers/products_provider.dart';
import 'package:qtim_test/providers/database_provider.dart';
import 'package:qtim_test/database/database.dart';
import 'package:drift/drift.dart';

class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final db = ref.read(databaseProvider); // Получаю экземпляр базы данных

    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go('/categories');
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: products.when(
        data:
            (products) => ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price}'),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      // Добавляю товар в корзину через базу данных
                      await db.addToCart(
                        CartItemsCompanion(
                          productName: Value(product.name), // Название товара
                          quantity: Value(1), // Количество (по умолчанию 1)
                          price: Value(product.price), // Цена товара
                        ),
                      );
                    },
                    child: Icon(Icons.add_shopping_cart_rounded),
                  ),
                  leading: Icon(Icons.polymer_rounded),
                );
              },
            ),
        error: (error, stack) => Text('Error: $error'),
        loading: () => CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/cart');
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
