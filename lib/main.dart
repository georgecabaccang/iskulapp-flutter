import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app_bloc_observer.dart';
import 'app.dart';

void main() async {
  Bloc.observer = const AppBlocObserver();
  await dotenv.load();
  runApp(const App());
}
