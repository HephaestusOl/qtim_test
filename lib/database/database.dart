import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:drift/native.dart';

part 'database.g.dart'; // Файл, который сгенерирует Drift

// Определяем таблицу для товаров в корзине
class CartItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productName => text()(); // Название товара
  IntColumn get quantity => integer()(); // Количество
  RealColumn get price => real()(); // Цена
  RealColumn get totalPrice => real()(); // Общая цена
}

// Создаю класс базы данных
@DriftDatabase(tables: [CartItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(cartItems, cartItems.totalPrice);
      }
    },
  );

  Future<List<CartItem>> getCartItemsByName(String productName) async {
    return await (select(cartItems)
      ..where((tbl) => tbl.productName.equals(productName))).get();
  }

  // Метод для добавления товара в корзину
  Future<void> addToCart(CartItemsCompanion item) async {
    final existingItems = await getCartItemsByName(item.productName.value);

    if (existingItems.isNotEmpty) {
      // Если товар уже есть, увеличиваю количество и обновляем общую стоимость
      for (var existingItem in existingItems) {
        final newQuantity = existingItem.quantity + 1;
        final newTotalPrice = existingItem.price * newQuantity;
        await (update(cartItems)
          ..where((tbl) => tbl.id.equals(existingItem.id))).write(
          CartItemsCompanion(
            quantity: Value(newQuantity),
            totalPrice: Value(newTotalPrice),
          ),
        );
      }
    } else {
      // Если товара нет, добавляю новый
      final totalPrice = item.price.value * item.quantity.value;
      await into(
        cartItems,
      ).insert(item.copyWith(totalPrice: Value(totalPrice)));
    }
  }

  // Метод для получения всех товаров в корзине
  Future<List<CartItem>> getCartItems() async {
    return await select(cartItems).get();
  }

  // Метод для удаления товара из корзины
  Future<void> removeFromCart(int id) async {
    await (delete(cartItems)..where((tbl) => tbl.id.equals(id))).go();
  }
}

// Функция для открытия соединения с базой данных
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'cart.db'));
    return NativeDatabase.createInBackground(file);
  });
}
