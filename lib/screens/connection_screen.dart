import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' as bt;

class ConnectionScreen extends StatefulWidget {
  final bt.BluetoothConnection? connection;
  const ConnectionScreen({super.key, required this.connection});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  bt.BluetoothConnection? _conn;
  String _rawBuffer = '';
  String angle = 'NA';
  String rpm = 'NA';

  @override
  void initState() {
    super.initState();
    _conn = widget.connection;

    _conn?.input?.listen(
      _onDataReceived,
      onDone: () {
        if (mounted) {
          setState(() {
            angle = 'NA';
            rpm = 'NA';
          });
        }
      },
    );
  }

  void _onDataReceived(Uint8List data) {
    _rawBuffer += ascii.decode(data);
    if (_rawBuffer.contains('\n')) {
      final lines = _rawBuffer.split('\n');
      for (var line in lines) {
        final parts = line.trim().split(',');
        if (parts.length == 2) {
          setState(() {
            angle = parts[0];
            rpm = parts[1];
          });
        }
      }
      _rawBuffer = _rawBuffer.endsWith('\n') ? '' : _rawBuffer.split('\n').last;
    }
  }

  void _sendCommand(String command) {
    if (_conn?.isConnected == true) {
      _conn!.output.add(Uint8List.fromList(ascii.encode(command)));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Bluetooth no conectado')));
    }
  }

  Widget _controlButton(String label, String command) {
    IconData icon;
    switch (label) {
      case '↑':
        icon = Icons.arrow_upward;
        break;
      case '↓':
        icon = Icons.arrow_downward;
        break;
      case '←':
        icon = Icons.arrow_back;
        break;
      case '→':
        icon = Icons.arrow_forward;
        break;
      case '■':
        icon = Icons.stop;
        break;
      default:
        icon = Icons.circle;
    }

    return GestureDetector(
      onTap: () => _sendCommand(command),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Center(child: Icon(icon, color: Colors.white)),
      ),
    );
  }

  @override
  void dispose() {
    _conn?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/imagenes/car.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal[600]?.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ángulo: $angle",
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          "RPM: $rpm",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),

                // Controles centrados
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _controlButton('↑', 'U'),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _controlButton('←', 'L'),
                          const SizedBox(width: 20),
                          _controlButton('■', 'S'),
                          const SizedBox(width: 20),
                          _controlButton('→', 'R'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _controlButton('↓', 'D'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
