import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app_forudevs/logic/data/repositories/database_repository.dart';

import 'app/app.dart';

final geti = GetIt.instance;

void main() {
  init();
  runApp(const App());
}

Future<void> init() async {
  geti.registerLazySingleton(() => DatabaseRepository());
}
