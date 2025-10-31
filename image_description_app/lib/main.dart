import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carga las variables de entorno antes de iniciar la app
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}
