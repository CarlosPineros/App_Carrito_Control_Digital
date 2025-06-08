import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/devices_screen.dart';
import 'screens/connection_screen.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' as bt;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Digital Unillanos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/devices': (context) => const DevicesScreen(),
        '/control': (context) {
          final route = ModalRoute.of(context);
          final args = route?.settings.arguments;

          if (args is bt.BluetoothConnection) {
            return ConnectionScreen(connection: args);
          } else {
            return const ConnectionScreen(connection: null);
          }
        },
      },
    );
  }
}
