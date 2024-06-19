// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:gugu/src/utils/app_const.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// class BluetoothPrinterPage extends StatefulWidget {
//   @override
//   _BluetoothPrinterPageState createState() => _BluetoothPrinterPageState();
// }

// class _BluetoothPrinterPageState extends State<BluetoothPrinterPage> {
//   FlutterBlue flutterBlue = FlutterBlue.instance;
//   BluetoothDevice? _connectedDevice;
//   List<BluetoothDevice> _devicesList = [];
//   String? _savedPrinterAddress;

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedPrinter();
//   }

//   void _loadSavedPrinter() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _savedPrinterAddress = prefs.getString('saved_printer');
//     });
//     if (_savedPrinterAddress != null) {
//       _connectToSavedPrinter();
//     }
//   }

//   void _connectToSavedPrinter() async {
//     if (_savedPrinterAddress == null) return;

//     // Discover devices and connect to the saved printer if found
//     await flutterBlue.startScan(timeout: Duration(seconds: 5));
//     flutterBlue.scanResults.listen((results) {
//       for (ScanResult result in results) {
//         if (result.device.id.id == _savedPrinterAddress) {
//           _connectToDevice(result.device);
//           flutterBlue.stopScan();
//           break;
//         }
//       }
//     });
//   }

//   void _connectToDevice(BluetoothDevice device) async {
//     await device.connect();
//     setState(() {
//       _connectedDevice = device;
//     });

//     // Save the device address for future connections
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('saved_printer', device.id.id);
//   }

//   void _scanForDevices() async {
//     _devicesList.clear();
//     await flutterBlue.startScan(timeout: Duration(seconds: 5));
//     flutterBlue.scanResults.listen((results) {
//       setState(() {
//         for (ScanResult result in results) {
//           if (!_devicesList.contains(result.device)) {
//             _devicesList.add(result.device);
//           }
//         }
//       });
//     });
//   }

//   void _print(String data) async {
//     if (_connectedDevice == null) {
//       // No connected device
//       print('No device connected');
//       return;
//     }

//     var services = await _connectedDevice!.discoverServices();
//     for (BluetoothService service in services) {
//       // Check if this service is the one we are looking for
//       if (service.uuid.toString() == "YOUR_PRINTER_SERVICE_UUID") {
//         for (BluetoothCharacteristic characteristic
//             in service.characteristics) {
//           if (characteristic.uuid.toString() ==
//               "YOUR_PRINTER_CHARACTERISTIC_UUID") {
//             _sendPrintData(characteristic, data);
//             return;
//           }
//         }
//       }
//     }
//     print('Printer service or characteristic not found');
//   }

//   void _sendPrintData(
//       BluetoothCharacteristic characteristic, String data) async {
//     await characteristic.write(utf8.encode(data));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppConst.white,
//       appBar: AppBar(
//         title: Text('Bluetooth Printer App'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: _scanForDevices,
//           ),
//         ],
//       ),
//       body: _connectedDevice == null
//           ? ListView.builder(
//               itemCount: _devicesList.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_devicesList[index].name),
//                   subtitle: Text(_devicesList[index].id.id),
//                   onTap: () => _connectToDevice(_devicesList[index]),
//                 );
//               },
//             )
//           : Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Connected to ${_connectedDevice!.name}'),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () =>
//                         _print("Test print data"), // Example print data
//                     child: Text("Print Test Page"),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
