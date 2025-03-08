import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qtim_test/providers/category_provider.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.go('/profile');
            },
            icon: Icon(Icons.supervised_user_circle),
          ),
        ],
      ),
      body: categories.when(
        data:
            (categories) => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return InkWell(
                  onTap: () {
                    context.go('/catalog');
                  },
                  child: GridTile(
                    header: Text(
                      category.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    footer: Text(
                      '${category.productCount} products',
                      textAlign: TextAlign.center,
                    ),
                    child: Image.asset(category.imageUrl),
                  ),
                );
              },
            ),
        error: (error, stack) => Text('Something went wrong'),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}
