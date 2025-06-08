import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' as bt;

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  List<bt.BluetoothDevice> devices = [];
  bt.BluetoothConnection? _lastConnection;

  @override
  void initState() {
    super.initState();
    _loadBondedDevices();
  }

  void _loadBondedDevices() async {
    List<bt.BluetoothDevice> bonded = await bt.FlutterBluetoothSerial.instance
        .getBondedDevices();
    setState(() {
      devices = bonded;
    });
  }

  void _connect(bt.BluetoothDevice device) async {
    try {
      final connection = await bt.BluetoothConnection.toAddress(device.address);
      if (!mounted) return;

      setState(() {
        _lastConnection = connection;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('✅ Conectado a ${device.name}')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❌ Error al conectar: $e')));
    }
  }

  void _goToControl() {
    if (_lastConnection != null) {
      Navigator.pushNamed(context, '/control', arguments: _lastConnection);
    } else {
      Navigator.pushNamed(context, '/control', arguments: _lastConnection);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ Primero conecta un dispositivo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/imagenes/Configuracion.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Connect Bluetooth",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: devices.isEmpty
                        ? const Center(
                            child: Text("No hay dispositivos emparejados"),
                          )
                        : ListView.builder(
                            itemCount: devices.length,
                            itemBuilder: (context, index) {
                              final device = devices[index];
                              return ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  child: Icon(
                                    Icons.bluetooth,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  device.name ?? "Dispositivo sin nombre",
                                ),
                                subtitle: Text(device.address),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.link,
                                    color: Colors.purple,
                                  ),
                                  onPressed: () => _connect(device),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToControl,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.play_arrow),
        tooltip: 'Ir a controlar',
      ),
    );
  }
}
