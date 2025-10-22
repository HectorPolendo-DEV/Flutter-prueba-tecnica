import 'package:flutter/material.dart';
import 'app/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'app/app_providers.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(providers: appProviders, child: const MyApp()));
}
