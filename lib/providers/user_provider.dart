import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtim_test/models/user.dart';
import 'package:flutter/services.dart' show rootBundle;

final userProvider = FutureProvider((ref) async {
  final jsonString = await rootBundle.loadString('assets/user.json');
  final json = jsonDecode(jsonString);
  return User.fromJson(json);
});
