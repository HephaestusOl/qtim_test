import 'package:go_router/go_router.dart';
import 'package:qtim_test/pages/cart_page.dart';
import 'package:qtim_test/pages/catalog_page.dart';
import 'package:qtim_test/pages/category_page.dart';
import 'package:qtim_test/pages/profile_page.dart';

final router = GoRouter(
  initialLocation: '/categories',
  routes: [
    GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
    GoRoute(path: '/catalog', builder: (context, state) => CatalogPage()),
    GoRoute(path: '/cart', builder: (context, state) => CartPage()),
    GoRoute(path: '/categories', builder: (context, state) => CategoryPage()),
  ],
);
